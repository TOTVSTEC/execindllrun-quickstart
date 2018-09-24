# execindllrun-quickstart

Exemplo de codigo AdvPL/C++ utilizando ExecInDllOpen, ExecInDLLClose, ExecInDLLRun, ExeDLLRun2 e ExeDLLRun3.

## Geração das dll's

Após clonar o repositorio e instalar as dependencias do npm, utilize o comando para gerar as dll's:

```bash
npm run build
```

Elas serao geradas na pasta `target`

## Codigo C++

Na pasta `/src/cpp` estao os codigos para as dll's, cada um com a assinatura da função correspondente com as chamadas dos metodos em AdvPL:


Metodo | Arquivo
-------|--------
ExecInDLLRun | exec1.cpp
ExeDLLRun2 | exec2.cpp
ExeDLLRun3 | exec3.cpp


## Codigo Advpl

No arquivo `/src/advpl/testDLL.prw` existe um exemplo com as chamadas para as dll's geradas.
Para maiores informações, consultar a documentacao no TDN.

- http://tdn.totvs.com/display/tec/ExecInDLLOpen
- http://tdn.totvs.com/display/tec/ExecInDLLRun
- http://tdn.totvs.com/display/tec/ExeDLLRun2
- http://tdn.totvs.com/display/tec/ExeDLLRun3
- http://tdn.totvs.com/display/tec/ExecInDLLClose

## Gerador utilizado pelo CMake

No arquivo `package.json` esta a definicao dos generators utilizado pelo CMake para o projeto. Caso necessite, altere conforme a lista disponivel na documentacao oficial (https://cmake.org/cmake/help/v3.9/manual/cmake-generators.7.html).

```json
  ...
  "generators": {
    "windows": "Visual Studio 15 2017",
    "linux": "Unix Makefiles"
  }
```

