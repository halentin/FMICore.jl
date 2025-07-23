# Generated FMI2 function prototypes for FMICore package
# Generated on: 2025-07-23T08:34:41.138

# Dictionary mapping function names to their prototype strings
const FMI2_FUNCTION_PROTOTYPES = Dict(
    :fmi2Instantiate => "fmi2Instantiate(instanceName::fmi2String, fmuType::fmi2Type, fmuGUID::fmi2String, fmuResourceLocation::fmi2String, functions::Ptr{Cvoid}, visible::fmi2Boolean, loggingOn::fmi2Boolean) = ccall((:fmi2Instantiate, __LIB__), fmi2Component, (fmi2String, fmi2Type, fmi2String, fmi2String, Ptr{Cvoid}, fmi2Boolean, fmi2Boolean,), instanceName, fmuType, fmuGUID, fmuResourceLocation, functions, visible, loggingOn)",
    :fmi2FreeInstance => "fmi2FreeInstance(c::fmi2Component) = ccall((:fmi2FreeInstance, __LIB__), Cvoid, (fmi2Component,), c)",
    :fmi2GetTypesPlatform => "fmi2GetTypesPlatform() = ccall((:fmi2GetTypesPlatform, __LIB__), fmi2String, ())",
    :fmi2GetVersion => "fmi2GetVersion() = ccall((:fmi2GetVersion, __LIB__), fmi2String, ())",
    :fmi2SetDebugLogging => "fmi2SetDebugLogging(c::fmi2Component, loggingOn::fmi2Boolean, nCategories::Csize_t, categories::Ptr{fmi2String}) = ccall((:fmi2SetDebugLogging, __LIB__), fmi2Status, (fmi2Component, fmi2Boolean, Csize_t, Ptr{fmi2String},), c, loggingOn, nCategories, categories)",
    :fmi2SetupExperiment => "fmi2SetupExperiment(c::fmi2Component, toleranceDefined::fmi2Boolean, tolerance::fmi2Real, startTime::fmi2Real, stopTimeDefined::fmi2Boolean, stopTime::fmi2Real) = ccall((:fmi2SetupExperiment, __LIB__), fmi2Status, (fmi2Component, fmi2Boolean, fmi2Real, fmi2Real, fmi2Boolean, fmi2Real,), c, toleranceDefined, tolerance, startTime, stopTimeDefined, stopTime)",
    :fmi2EnterInitializationMode => "fmi2EnterInitializationMode(c::fmi2Component) = ccall((:fmi2EnterInitializationMode, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2ExitInitializationMode => "fmi2ExitInitializationMode(c::fmi2Component) = ccall((:fmi2ExitInitializationMode, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2Terminate => "fmi2Terminate(c::fmi2Component) = ccall((:fmi2Terminate, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2Reset => "fmi2Reset(c::fmi2Component) = ccall((:fmi2Reset, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2GetReal => "fmi2GetReal(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Real}) = ccall((:fmi2GetReal, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Real},), c, vr, Ptr, nvr)",
    :fmi2SetReal => "fmi2SetReal(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Real}) = ccall((:fmi2SetReal, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Real},), c, vr, Ptr, nvr)",
    :fmi2GetInteger => "fmi2GetInteger(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Integer}) = ccall((:fmi2GetInteger, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Integer},), c, vr, Ptr, nvr)",
    :fmi2SetInteger => "fmi2SetInteger(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Integer}) = ccall((:fmi2SetInteger, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Integer},), c, vr, Ptr, nvr)",
    :fmi2GetBoolean => "fmi2GetBoolean(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Boolean}) = ccall((:fmi2GetBoolean, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Boolean},), c, vr, Ptr, nvr)",
    :fmi2SetBoolean => "fmi2SetBoolean(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2Boolean}) = ccall((:fmi2SetBoolean, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Boolean},), c, vr, Ptr, nvr)",
    :fmi2GetString => "fmi2GetString(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2String}) = ccall((:fmi2GetString, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2String},), c, vr, Ptr, nvr)",
    :fmi2SetString => "fmi2SetString(c::fmi2Component, vr::Ptr{fmi2ValueReference}, Ptr::Csize_t, nvr::Ptr{fmi2String}) = ccall((:fmi2SetString, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2String},), c, vr, Ptr, nvr)",
    :fmi2GetFMUstate => "fmi2GetFMUstate(c::fmi2Component, FMUstate::Ptr{fmi2FMUstate}) = ccall((:fmi2GetFMUstate, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2FMUstate},), c, FMUstate)",
    :fmi2SetFMUstate => "fmi2SetFMUstate(c::fmi2Component, FMUstate::fmi2FMUstate) = ccall((:fmi2SetFMUstate, __LIB__), fmi2Status, (fmi2Component, fmi2FMUstate,), c, FMUstate)",
    :fmi2FreeFMUstate => "fmi2FreeFMUstate(c::fmi2Component, FMUstate::Ptr{fmi2FMUstate}) = ccall((:fmi2FreeFMUstate, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2FMUstate},), c, FMUstate)",
    :fmi2SerializedFMUstateSize => "fmi2SerializedFMUstateSize(c::fmi2Component, FMUstate::fmi2FMUstate, size::Ptr{Csize_t}) = ccall((:fmi2SerializedFMUstateSize, __LIB__), fmi2Status, (fmi2Component, fmi2FMUstate, Ptr{Csize_t},), c, FMUstate, size)",
    :fmi2SerializeFMUstate => "fmi2SerializeFMUstate(c::fmi2Component, FMUstate::fmi2FMUstate, serialzedState::Ptr{fmi2Byte}, size::Csize_t) = ccall((:fmi2SerializeFMUstate, __LIB__), fmi2Status, (fmi2Component, fmi2FMUstate, Ptr{fmi2Byte}, Csize_t,), c, FMUstate, serialzedState, size)",
    :fmi2DeSerializeFMUstate => "fmi2DeSerializeFMUstate(c::fmi2Component, serializedState::Ptr{fmi2Byte}, size::Csize_t, FMUstate::Ptr{fmi2FMUstate}) = ccall((:fmi2DeSerializeFMUstate, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2Byte}, Csize_t, Ptr{fmi2FMUstate},), c, serializedState, size, FMUstate)",
    :fmi2GetDirectionalDerivative => "fmi2GetDirectionalDerivative(c::fmi2Component, vUnknown_ref::Ptr{fmi2ValueReference}, nUnknown::Csize_t, vKnown_ref::Ptr{fmi2ValueReference}, nKnown::Csize_t, ΔvKnown::Ptr{fmi2Real}, ΔvUnknown::Ptr{fmi2Real}) = ccall((:fmi2GetDirectionalDerivative, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Real}, Ptr{fmi2Real},), c, vUnknown_ref, nUnknown, vKnown_ref, nKnown, ΔvKnown, ΔvUnknown)",
    :fmi2SetRealInputDerivatives => "fmi2SetRealInputDerivatives(c::fmi2Component, vr::Ptr{fmi2ValueReference}, nvr::Csize_t, order::Ptr{fmi2Integer}, value::Ptr{fmi2Real}) = ccall((:fmi2SetRealInputDerivatives, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Integer}, Ptr{fmi2Real},), c, vr, nvr, order, value)",
    :fmi2GetRealOutputDerivatives => "fmi2GetRealOutputDerivatives(c::fmi2Component, vr::Ptr{fmi2ValueReference}, nvr::Csize_t, order::Ptr{fmi2Integer}, value::Ptr{fmi2Real}) = ccall((:fmi2GetRealOutputDerivatives, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2ValueReference}, Csize_t, Ptr{fmi2Integer}, Ptr{fmi2Real},), c, vr, nvr, order, value)",
    :fmi2DoStep => "fmi2DoStep(c::fmi2Component, currentCommunicationPoint::fmi2Real, communicationStepSize::fmi2Real, noSetFMUStatePriorToCurrentPoint::fmi2Boolean) = ccall((:fmi2DoStep, __LIB__), fmi2Status, (fmi2Component, fmi2Real, fmi2Real, fmi2Boolean,), c, currentCommunicationPoint, communicationStepSize, noSetFMUStatePriorToCurrentPoint)",
    :fmi2CancelStep => "fmi2CancelStep(c::fmi2Component) = ccall((:fmi2CancelStep, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2GetStatus => "fmi2GetStatus(c::fmi2Component, s::fmi2StatusKind, value::Ptr{fmi2Status}) = ccall((:fmi2GetStatus, __LIB__), fmi2Status, (fmi2Component, fmi2StatusKind, Ptr{fmi2Status},), c, s, value)",
    :fmi2GetRealStatus => "fmi2GetRealStatus(c::fmi2Component, s::fmi2StatusKind, value::Ptr{fmi2Real}) = ccall((:fmi2GetRealStatus, __LIB__), fmi2Status, (fmi2Component, fmi2StatusKind, Ptr{fmi2Real},), c, s, value)",
    :fmi2GetIntegerStatus => "fmi2GetIntegerStatus(c::fmi2Component, s::fmi2StatusKind, value::Ptr{fmi2Integer}) = ccall((:fmi2GetIntegerStatus, __LIB__), fmi2Status, (fmi2Component, fmi2StatusKind, Ptr{fmi2Integer},), c, s, value)",
    :fmi2GetBooleanStatus => "fmi2GetBooleanStatus(c::fmi2Component, s::fmi2StatusKind, value::Ptr{fmi2Boolean}) = ccall((:fmi2GetBooleanStatus, __LIB__), fmi2Status, (fmi2Component, fmi2StatusKind, Ptr{fmi2Boolean},), c, s, value)",
    :fmi2GetStringStatus => "fmi2GetStringStatus(c::fmi2Component, s::fmi2StatusKind, value::Ptr{fmi2String}) = ccall((:fmi2GetStringStatus, __LIB__), fmi2Status, (fmi2Component, fmi2StatusKind, Ptr{fmi2String},), c, s, value)",
    :fmi2SetTime => "fmi2SetTime(c::fmi2Component, time::fmi2Real) = ccall((:fmi2SetTime, __LIB__), fmi2Status, (fmi2Component, fmi2Real,), c, time)",
    :fmi2SetContinuousStates => "fmi2SetContinuousStates(c::fmi2Component, x::Ptr{fmi2Real}, Ptr::Csize_t) = ccall((:fmi2SetContinuousStates, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2Real}, Csize_t,), c, x, Ptr)",
    :fmi2EnterEventMode => "fmi2EnterEventMode(c::fmi2Component) = ccall((:fmi2EnterEventMode, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2NewDiscreteStates => "fmi2NewDiscreteStates(c::fmi2Component, eventInfo::Ptr{fmi2EventInfo}) = ccall((:fmi2NewDiscreteStates, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2EventInfo},), c, eventInfo)",
    :fmi2EnterContinuousTimeMode => "fmi2EnterContinuousTimeMode(c::fmi2Component) = ccall((:fmi2EnterContinuousTimeMode, __LIB__), fmi2Status, (fmi2Component,), c)",
    :fmi2CompletedIntegratorStep => "fmi2CompletedIntegratorStep(c::fmi2Component, noSetFMUStatePriorToCurrentPoint::fmi2Boolean, enterEventMode::Ptr{fmi2Boolean}, terminateSimulation::Ptr{fmi2Boolean}) = ccall((:fmi2CompletedIntegratorStep, __LIB__), fmi2Status, (fmi2Component, fmi2Boolean, Ptr{fmi2Boolean}, Ptr{fmi2Boolean},), c, noSetFMUStatePriorToCurrentPoint, enterEventMode, terminateSimulation)",
    :fmi2GetDerivatives => "fmi2GetDerivatives(c::fmi2Component, derivatives::Ptr{fmi2Real}, Ptr::Csize_t) = ccall((:fmi2GetDerivatives, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2Real}, Csize_t,), c, derivatives, Ptr)",
    :fmi2GetEventIndicators => "fmi2GetEventIndicators(c::fmi2Component, eventIndicators::Ptr{fmi2Real}, Ptr::Csize_t) = ccall((:fmi2GetEventIndicators, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2Real}, Csize_t,), c, eventIndicators, Ptr)",
    :fmi2GetContinuousStates => "fmi2GetContinuousStates(c::fmi2Component, x::Ptr{fmi2Real}, Ptr::Csize_t) = ccall((:fmi2GetContinuousStates, __LIB__), fmi2Status, (fmi2Component, Ptr{fmi2Real}, Csize_t,), c, x, Ptr)",
)

# Helper function to generate functions for a specific library
function generate_fmi2_functions!(lib)
    for (name, prototype_str) in FMI2_FUNCTION_PROTOTYPES
        # Replace __LIB__ with the actual library handle
        code = replace(prototype_str, "__LIB__" => "lib")
        # Parse and evaluate the function definition
        expr = Meta.parse(code)
        eval(expr)
    end
end
