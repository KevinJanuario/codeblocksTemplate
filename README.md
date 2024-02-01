Parametros enviados na pipeline por padrão:
```
  - name: enableSonar
    default: true
  - name: enableGitLeaks
    default: true
  - name: buildType
    default: 'c'
  - name: agentPool
    default: Dev
  - name: sourcePath
    default: '.'
  - name: dotNetProjects
    default: 'csproj'
```
Se o seu projeto esta no padrão de APIs com os arquivos fontes em C no diretorio `C-Fontes`, e o artefato do seu projeto é gerar bibliotecas x86 e x64, basta importar o seguinte template:

```
#azure-pipelines.yml
---
resources:
  repositories:
    - repository: templates
      type: git
      name: APIs/DevOps-Yaman

trigger:
  - 'main'

variables:
  - group: Nexus

stages:
  - template: template-pipeline.yaml@templates

```

# Esse template irá compilar, passar o repositorio no Sonar e enviar o artefato para o Nexus (http://10.3.5.117:8081)
 Os repositorios para Libs é o `perto-c`

# Se seu projeto é dotnet, pode utilizar o template da seguinte forma:
```
---
resources:
  repositories:
    - repository: templates
      type: git
      name: APIs/DevOps-Yaman

trigger:
  - 'main'

variables:
  - group: Nexus

stages:
  - template: template-pipeline.yaml@templates
    parameters:
      buildType: 'dotnet'
```

# O mesmo processo será realizado, porem realizando o build em dotnet
 Caso o seus arquivos de projetos não sejam o padrão `.csproj`, basta adicionar o parametro `dotNetProjects`
```
  - template: template-pipeline.yaml@templates
    parameters:
      buildType: 'dotnet'
      dotNetProjects: 'foo'
```

# Caso o build seja de c sharp, ajustar os seguintes parametros:
```
  - template: template-pipeline.yaml@templates
    parameters:
      buildType: csharp
      vcxprojPath: 'Trunk/C-Fontes/VisualStudio/SensorBoard/SensorBoard/SensorBoard.vcxproj'
      # o vcxprojPath precisa apontar para o arquivo do projeto que será compilado
```
# É importante mencionar que a Pipeline se autentica com o Nexus pelo grupo de variaveis chamado `Nexus` que esta na Library do projeto Azure Devops.

