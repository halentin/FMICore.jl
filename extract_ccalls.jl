#!/usr/bin/env julia

"""
Script to extract ccall signatures from FMI2/cfunc.jl

This script parses the cfunc.jl file and extracts the C function signatures
from all ccall statements, showing the function name, return type, and parameter types.
"""

using Printf
using Dates

function extract_ccall_signatures(file_path::String)
    content = read(file_path, String)
    lines = split(content, '\n')
    
    ccall_signatures = []
    current_ccall = nothing
    in_ccall = false
    ccall_lines = String[]
    
    for (line_num, line) in enumerate(lines)
        line = strip(line)
        
        # Start of a ccall
        if occursin(r"ccall\s*\(", line)
            in_ccall = true
            ccall_lines = [line]
            current_ccall = Dict(
                "line_start" => line_num,
                "function_name" => "",
                "return_type" => "",
                "param_types" => [],
                "param_names" => [],
                "raw_lines" => []
            )
        elseif in_ccall
            push!(ccall_lines, line)
            
            # Check if this line closes the ccall
            if occursin(r"\)\s*$", line) || occursin(r"\)::", line)
                # Parse the complete ccall
                ccall_text = join(ccall_lines, " ")
                current_ccall["raw_lines"] = copy(ccall_lines)
                
                # Extract function name and parameter names from the function definition
                func_name, param_names = extract_function_signature(lines, line_num - length(ccall_lines) + 1)
                current_ccall["function_name"] = func_name
                current_ccall["param_names"] = param_names
                
                # Parse ccall components
                parse_ccall_components!(current_ccall, ccall_text)
                
                push!(ccall_signatures, current_ccall)
                in_ccall = false
                ccall_lines = String[]
            end
        end
    end
    
    return ccall_signatures
end

function extract_function_signature(lines::Vector{SubString{String}}, start_line::Int)
    # Look backwards from the ccall to find the function definition
    for i in start_line:-1:max(1, start_line-30)
        line = strip(lines[i])
        if occursin(r"^function\s+(\w+)", line)
            # Found function definition, now extract parameter names
            func_match = match(r"^function\s+(\w+)", line)
            func_name = func_match.captures[1]
            
            # Collect the full function signature (may span multiple lines)
            signature_lines = [line]
            j = i + 1
            while j <= length(lines) && !occursin(r"\)$", strip(lines[j]))
                push!(signature_lines, strip(lines[j]))
                j += 1
            end
            if j <= length(lines)
                push!(signature_lines, strip(lines[j]))
            end
            
            # Parse parameter names from the signature
            full_signature = join(signature_lines, " ")
            param_names = extract_parameter_names(full_signature)
            
            return func_name, param_names
        end
    end
    return "unknown", String[]
end

function extract_parameter_names(signature::String)
    param_names = String[]
    
    # Find the parameter list between parentheses
    param_match = match(r"\((.*)\)", signature)
    if param_match !== nothing
        params_str = param_match.captures[1]
        
        # Handle balanced parentheses and commas properly
        param_parts = []
        current_param = ""
        paren_depth = 0
        brace_depth = 0
        
        for char in params_str
            if char == '('
                paren_depth += 1
            elseif char == ')'
                paren_depth -= 1
            elseif char == '{'
                brace_depth += 1
            elseif char == '}'
                brace_depth -= 1
            elseif char == ',' && paren_depth == 0 && brace_depth == 0
                push!(param_parts, strip(current_param))
                current_param = ""
                continue
            end
            current_param *= char
        end
        if !isempty(strip(current_param))
            push!(param_parts, strip(current_param))
        end
        
        # Extract parameter names from each part
        for param in param_parts
            param = strip(param)
            if !isempty(param)
                # Extract just the parameter name (before ::)
                # Look for the first word before ::, handling Union types
                name_match = match(r"^(\w+)\s*::", param)
                if name_match !== nothing
                    param_name = name_match.captures[1]
                    # Skip obviously non-parameter names
                    if param_name ∉ ["Union", "AbstractArray", "Ptr", "Ref"]
                        push!(param_names, param_name)
                    end
                else
                    # Fallback: try to extract just the first word if it looks like a parameter
                    simple_match = match(r"^(\w+)", param)
                    if simple_match !== nothing
                        param_name = simple_match.captures[1]
                        # Skip obviously non-parameter names
                        if param_name ∉ ["Union", "AbstractArray", "Ptr", "Ref"]
                            push!(param_names, param_name)
                        end
                    end
                end
            end
        end
    end
    
    return param_names
end

function parse_ccall_components!(ccall_dict::Dict, ccall_text::String)
    # Remove whitespace and newlines for easier parsing
    ccall_text = replace(ccall_text, r"\s+" => " ")
    
    # ccall structure: ccall(cfunc, return_type, (param_types...), args...)
    
    # Extract return type (second argument to ccall)
    # Pattern: ccall( first_arg, return_type, ...
    m = match(r"ccall\s*\(\s*[^,]+,\s*([^,\(]+)", ccall_text)
    if m !== nothing
        ccall_dict["return_type"] = strip(m.captures[1])
    end
    
    # Extract parameter types tuple - look for the first complete parentheses group
    # after the return type that contains parameter types
    param_match = match(r"ccall\s*\([^,]+,\s*[^,\(]+,\s*\(([^)]*)\)", ccall_text)
    if param_match !== nothing
        param_str = param_match.captures[1]
        if !isempty(strip(param_str))
            # Split by comma and clean up
            params = [strip(p) for p in split(param_str, ',') if !isempty(strip(p))]
            ccall_dict["param_types"] = params
        end
    end
end

function print_signatures(signatures::Vector)
    println("Extracted C Function Signatures from FMI2/cfunc.jl")
    println("=" ^ 60)
    
    for (i, sig) in enumerate(signatures)
        println("\n$(i). Function: $(sig["function_name"]) (line $(sig["line_start"]))")
        println("   Return Type: $(sig["return_type"])")
        
        if !isempty(sig["param_types"])
            println("   Parameters:")
            for (j, param) in enumerate(sig["param_types"])
                # Skip cfunc parameter when showing names (j+1 to account for cfunc being first)
                param_name = if (j + 1) <= length(sig["param_names"]) && !isempty(sig["param_names"][j + 1])
                    sig["param_names"][j + 1]
                else
                    "arg$j"
                end
                println("     $j. $param_name :: $param")
            end
            
            # Also show all extracted parameter names for debugging
            if !isempty(sig["param_names"])
                println("   All extracted parameter names: $(join(sig["param_names"], ", "))")
            end
        else
            println("   Parameters: (none)")
        end
        
        println("   Raw ccall:")
        for line in sig["raw_lines"]
            println("     $line")
        end
    end
    
    println("\n" * "=" ^ 60)
    println("Total ccalls found: $(length(signatures))")
end

function get_julia_parameter_type(param_names::Vector, param_name::String, ccall_type::AbstractString)
    # For Union types with Array/Ptr, prefer the array type
    if occursin("Ptr{", ccall_type)
        # Extract the inner type from Ptr{T}
        inner_type_match = match(r"Ptr{(.+)}", ccall_type)
        if inner_type_match !== nothing
            inner_type = inner_type_match.captures[1]
            # Return as AbstractArray instead of Ptr for better Julia interface
            return "AbstractArray{$(inner_type)}"
        end
    end
    
    # For non-pointer types, use as-is
    return String(ccall_type)
end

function generate_julia_prototypes(signatures::Vector)
    prototypes = String[]
    
    for sig in signatures
        func_name = sig["function_name"]
        return_type = sig["return_type"]
        param_types = sig["param_types"]
        param_names = sig["param_names"]
        
        if isempty(param_types)
            # Function with no parameters
            prototype = "$(func_name)() = ccall((:$(func_name), __LIB__), $(return_type), ())"
        else
            # Generate Julia parameter names and types using extracted parameter names
            julia_params = String[]
            ccall_param_types = String[]
            ccall_args = String[]
            
            for (i, param_type) in enumerate(param_types)
                # Use extracted parameter name if available, skipping the first parameter (cfunc)
                # The mapping is: param_names[1] = cfunc (skip), param_names[2] = first C param, etc.
                param_name = if (i + 1) <= length(param_names) && !isempty(param_names[i + 1])
                    param_names[i + 1]  # Skip cfunc parameter
                else
                    "arg$(i)"  # Fallback name
                end
                
                # Look up the original Julia parameter type to see if it's a Union
                julia_param_type = get_julia_parameter_type(param_names, param_name, param_type)
                
                # Use the types as they are from the cfunc file
                push!(julia_params, "$(param_name)::$(julia_param_type)")
                push!(ccall_param_types, param_type)
                push!(ccall_args, param_name)
            end
            
            julia_params_str = join(julia_params, ", ")
            ccall_types_str = join(ccall_param_types, ", ")
            ccall_args_str = join(ccall_args, ", ")
            
            prototype = "$(func_name)($(julia_params_str)) = ccall((:$(func_name), __LIB__), $(return_type), ($(ccall_types_str),), $(ccall_args_str))"
        end
        
        push!(prototypes, prototype)
    end
    
    return prototypes
end

function main()
    file_path = "/home/valentin/.julia/dev/FMICore/src/FMI2/cfunc.jl"
    
    if !isfile(file_path)
        println("Error: File not found: $file_path")
        return
    end
    
    println("Analyzing ccalls in: $file_path")
    signatures = extract_ccall_signatures(file_path)
    print_signatures(signatures)
    
    # Generate Julia prototypes
    prototypes = generate_julia_prototypes(signatures)
    
    # Generate a Julia module file for easy inclusion in FMICore
    module_output_file = "functions.jl"
    function_names = [sig["function_name"] for sig in signatures]
    
    open(module_output_file, "w") do f
        println(f, "# Generated FMI2 function prototypes for FMICore package")
        println(f, "# Generated on: $(now())")
        println(f, "")
        println(f, "# Dictionary mapping function names to their prototype strings")
        println(f, "const FMI2_FUNCTION_PROTOTYPES = Dict(")
        for (i, prototype) in enumerate(prototypes)
            func_name = function_names[i]
            println(f, "    :$(func_name) => \"$(prototype)\",")
        end
        println(f, ")")
        println(f, "")
        println(f, "# Helper function to generate functions for a specific library")
        println(f, "function generate_fmi2_functions!(lib)")
        println(f, "    for (name, prototype_str) in FMI2_FUNCTION_PROTOTYPES")
        println(f, "        # Replace __LIB__ with the actual library handle")
        println(f, "        code = replace(prototype_str, \"__LIB__\" => \"lib\")")
        println(f, "        # Parse and evaluate the function definition")
        println(f, "        expr = Meta.parse(code)")
        println(f, "        eval(expr)")
        println(f, "    end")
        println(f, "end")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end