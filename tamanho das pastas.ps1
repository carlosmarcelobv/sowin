#script em powershell que traz uma lista de pastas com seus tamanhos totais

#cm 11/23 - v01 - #versão inicial - www.familiaquadrada.com

$root = 'C:\'    #pasta inicial para varredura
$depthLimit = 3  #profundidade de subpastas (c:\pasta-1\pasta-1a\pasta-1a1)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "executando... $timestamp" 
Get-ChildItem -Path $root -Recurse -Directory | Where-Object {
    (($_.FullName.Split([IO.Path]::DirectorySeparatorChar).Count - $root.Split([IO.Path]::DirectorySeparatorChar).Count) -le $depthLimit)
} | ForEach-Object {
    $path = $_.FullName
    if ($path.Length -gt 77) {
        $path = $path.Substring(0, 77) + '(...)'
    } else {
        $path = $_.FullName
    }
    $size = (Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1MB
    [PSCustomObject]@{
        'Directory' = $path
        'Size(MB)'  = [Math]::Round($size, 2)
    }
} | Sort-Object -Property 'Size(MB)' -Descending | Format-Table -AutoSize | Out-File -FilePath 'C:\Users\carlo\Desktop\listao.txt' #envia o resultado para um arquivo
