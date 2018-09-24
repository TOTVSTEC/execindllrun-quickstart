#include "exec.h"
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

// Fonte de exemplo c++
// Deve ser compilado gerando uma DLL 32 bits, chamada "tstdll.dll"
// para ser usada no exemplo em AdvPL. Esta DLL deve ser copiada para a pasta do
// SmartClient.EXE
DLLExport int ExecInClientDLL(int ID, char* inputBuffer, int inputSize, char* outputBuffer, int outputSize) {
	if (ID == 1) {
		strcpy(outputBuffer, "ExeDLLRun3 - Retorno 01");
		
		return 1;
	}
	else if (ID == 2) {
		strcpy(outputBuffer, "ExeDLLRun3 - Retorno 02");
		
		return 2;
	}

	return -1;
}

#ifdef __cplusplus
}
#endif
