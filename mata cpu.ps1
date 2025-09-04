# Defina o número de threads com base nos núcleos/hyperthreads da sua CPU
$NumThreads = [Environment]::ProcessorCount

ForEach ($loop in 1..$NumThreads) {
    Start-Job -ScriptBlock {
        [float]$result = 1
        while ($true) {
            [float]$x = Get-Random -Minimum 1 -Maximum 999999999
            $result = $result * $x
        }
    }
}
