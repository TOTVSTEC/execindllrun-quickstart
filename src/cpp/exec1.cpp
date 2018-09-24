#include "exec.h"
#include <string.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

// Fonte de exemplo c++
// Deve ser compilado gerando uma DLL 32 bits, chamada "tstdll.dll"
// para ser usada no exemplo em AdvPL. Esta DLL deve ser copiada para a pasta do
// SmartClient.EXE
DLLExport void ExecInClientDLL(int index, char* inputBuffer, char* outputBuffer, int outputSize) {
	if (index == 1) {
		sprintf(outputBuffer, "ExecInDllRun - Retorno 01");
		//strcpy(outputBuffer, "ExecInDllRun - Retorno 01");
	}
	else if (index == 2) {
		strcpy(outputBuffer, "ExecInDllRun - Retorno 02");
	}
}

#ifdef __cplusplus
}
#endif
