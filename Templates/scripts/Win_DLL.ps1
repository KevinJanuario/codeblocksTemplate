param (
    [Parameter(Mandatory=$true)]
    [ValidateSet(32,64)]
    [int]$Version
)

# Definir o caminho base para a pasta mingw
$mingwBasePath = "C:\Compiladores\mingw"
 
# Remover a pasta C:\Compiladores\mingw se ela existir
if (Test-Path $mingwBasePath) {
    Remove-Item $mingwBasePath -Recurse -Force
    Write-Host "Pasta antiga $mingwBasePath removida."
}
 
# Definir o caminho do compilador com base no parâmetro
$mingwPath = "C:\Compiladores\mingw$Version"
 
# Verificar se o caminho do compilador existe
if (-not (Test-Path $mingwPath)) {
    Write-Host "Caminho do compilador não encontrado: $mingwPath"
    exit
}
 
# Renomear a pasta do compilador para C:\Compiladores\mingw
Copy-Item -Recurse $mingwPath $mingwBasePath
Write-Host "Pasta do compilador renomeada para $mingwBasePath"
 
# Executar comandos no CodeBlocks se a versão for 64
# Caminho para o executável do CodeBlocks
$codeBlocksPath = "C:\Program Files\CodeBlocks\codeblocks.exe"
$projectFile = "API_PertoCoinAcceptor.cbp"
$projectPath = "C:\Users\KevinJanuariodaSilva\Documents\PERTO\API_CoinAcceptor\Trunk\C-Fontes\"

# Executar comandos no CodeBlocks
Push-Location $projectPath
& $codeBlocksPath --clean $projectFile
Start-Sleep -Seconds 15
if ($Version -eq 64) {
    Write-Host "Versão 64 bits selecionada"
    & $codeBlocksPath --build $projectFile --target "DLL x64"
    #Rename-Item $mingwBasePath $mingwPath
    Pop-Location
} else {
    Write-Host "Versão 32 bits selecionada"
    & $codeBlocksPath --build $projectFile --target "DLL x86"
    #Rename-Item $mingwBasePath $mingwPath
    Pop-Location
}
