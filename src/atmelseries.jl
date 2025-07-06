"""
Contains paths to Microship's provided device definition files (lazily downloaded as artifacts).
"""
module AtmelLibrary
using Pkg.Artifacts

import ..AtmelToolsDeviceFilePath
import ..devicefilepath

function ATtinySeries(s::String)
    artifactpath = artifact"ATtinySeries"
    return AtmelToolsDeviceFilePath(joinpath(artifactpath, s))
end
const TINIES = [
    "ATtiny102", "ATtiny104", "ATtiny10", "ATtiny11", "ATtiny12", "ATtiny13A",
    "ATtiny13", "ATtiny15", "ATtiny1604", "ATtiny1606", "ATtiny1607", "ATtiny1614",
    "ATtiny1616", "ATtiny1617", "ATtiny1624", "ATtiny1626", "ATtiny1627", "ATtiny1634",
    "ATtiny167", "ATtiny202", "ATtiny204", "ATtiny20", "ATtiny212", "ATtiny214",
    "ATtiny2313A", "ATtiny2313", "ATtiny24A", "ATtiny24", "ATtiny25", "ATtiny261A",
    "ATtiny261", "ATtiny26", "ATtiny3216", "ATtiny3217", "ATtiny3224", "ATtiny3226",
    "ATtiny3227", "ATtiny402", "ATtiny404", "ATtiny406", "ATtiny40", "ATtiny412",
    "ATtiny414", "ATtiny416", "ATtiny417", "ATtiny424", "ATtiny426", "ATtiny427",
    "ATtiny4313", "ATtiny43U", "ATtiny441", "ATtiny44A", "ATtiny44", "ATtiny45",
    "ATtiny461A", "ATtiny461", "ATtiny48", "ATtiny4", "ATtiny5", "ATtiny804",
    "ATtiny806", "ATtiny807", "ATtiny814", "ATtiny816", "ATtiny817", "ATtiny824",
    "ATtiny826", "ATtiny827", "ATtiny828", "ATtiny841", "ATtiny84A", "ATtiny84",
    "ATtiny85", "ATtiny861A", "ATtiny861", "ATtiny87", "ATtiny88", "ATtiny9",
]
for tiny in TINIES
    fname = Symbol(tiny)
    docstr = "The path of the $tiny file definition."
    fpath = "$tiny.atdf"
    @eval begin
        @doc $docstr
        function $fname()
            return ATtinySeries($fpath)
        end
    end
    eval(Expr(:public, fname))
end

function ATmegaSeries(s::String)
    artifactpath = artifact"ATmegaSeries"
    return AtmelToolsDeviceFilePath(joinpath(artifactpath, s))
end
const MEGAS = [
    "AT90CAN128", "AT90CAN32", "AT90CAN64", "AT90PWM161", "AT90PWM1", "AT90PWM216",
    "AT90PWM2B", "AT90PWM316", "AT90PWM3", "AT90PWM3B", "AT90PWM81", "AT90USB1286",
    "AT90USB1287", "AT90USB162", "AT90USB646", "AT90USB647", "AT90USB82", "ATmega1280",
    "ATmega1281", "ATmega1284", "ATmega1284P", "ATmega1284RFR2", "ATmega128A",
    "ATmega128", "ATmega128RFA1", "ATmega128RFR2", "ATmega1608", "ATmega1609",
    "ATmega162", "ATmega164A", "ATmega164PA", "ATmega164P", "ATmega165A", "ATmega165PA",
    "ATmega165P", "ATmega168A", "ATmega168", "ATmega168PA", "ATmega168P", "ATmega168PB",
    "ATmega169A", "ATmega169PA", "ATmega169P", "ATmega16A", "ATmega16", "ATmega16HVA",
    "ATmega16HVB", "ATmega16HVBrevB", "ATmega16M1", "ATmega16U2", "ATmega16U4",
    "ATmega2560", "ATmega2561", "ATmega2564RFR2", "ATmega256RFR2", "ATmega3208",
    "ATmega3209", "ATmega324A", "ATmega324PA", "ATmega324P", "ATmega324PB", "ATmega3250A",
    "ATmega3250", "ATmega3250PA", "ATmega3250P", "ATmega325A", "ATmega325", "ATmega325PA",
    "ATmega325P", "ATmega328", "ATmega328P", "ATmega328PB", "ATmega3290A", "ATmega3290",
    "ATmega3290PA", "ATmega3290P", "ATmega329A", "ATmega329", "ATmega329PA", "ATmega329P",
    "ATmega32A", "ATmega32", "ATmega32C1", "ATmega32HVB", "ATmega32HVBrevB",
    "ATmega32M1", "ATmega32U2", "ATmega32U4", "ATmega406", "ATmega4808", "ATmega4809",
    "ATmega48A", "ATmega48", "ATmega48PA", "ATmega48P", "ATmega48PB", "ATmega640",
    "ATmega644A", "ATmega644", "ATmega644PA", "ATmega644P", "ATmega644RFR2",
    "ATmega6450A", "ATmega6450", "ATmega6450P", "ATmega645A", "ATmega645", "ATmega645P",
    "ATmega6490A", "ATmega6490", "ATmega6490P", "ATmega649A", "ATmega649", "ATmega649P",
    "ATmega64A", "ATmega64", "ATmega64C1", "ATmega64HVE2", "ATmega64M1", "ATmega64RFR2",
    "ATmega808", "ATmega809", "ATmega8515", "ATmega8535", "ATmega88A", "ATmega88",
    "ATmega88PA", "ATmega88P", "ATmega88PB", "ATmega8A", "ATmega8", "ATmega8HVA",
    "ATmega8U2",
]
for mega in MEGAS
    fname = Symbol(mega)
    docstr = "The path of the $mega file definition."
    fpath = "$mega.atdf"
    @eval begin
        @doc $docstr
        function $fname()
            return ATmegaSeries($fpath)
        end
    end
    eval(Expr(:public, fname))
end
end
