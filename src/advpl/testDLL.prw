#include "TOTVS.CH"

// Importante:
//  -Caso esteja rodando em Linux sera necessario copiar a DLL para o /TMP
//    pois mesmo dando chmod 777 no diretorio do smartclient o SO não permite executar
//  -Nao eh necessário colocar o "lib"dllProtheus.so em Linux, a ExecInDLLOpen resolve isso
//  -Pode ser necessario executar o SmartClient como SU exemplo: sudo ./smartclient
function U_testDLL()
	Local isLinux := (GetRemoteType() == 2)
	Local dir:= IIF(isLinux, GetTempPath(), "")
	Local bits := IIF(IsRmt64(), "64", "32")
	Local dllName
	Local dllHandle
	Local i
	Local j
	Local message

	for i := 1 To 3
		dllName := dir + "exec" + AllTrim(Str(i)) + "-" + bits + iif(isLinux, ".so", ".dll")
		dllHandle := ExecInDLLOpen(dllName)

		if (dllHandle < 0)
			MsgStop("Erro na carga! (" + dllName + ") " + AllTrim(Str(dllHandle)))
			return
		endif

		message:= "Testando dll. Funcao " + GetMethod(i) + CRLF + CRLF

		for j := 1 To 2
			CONOUT("J:" + AllTrim(Str(j)))

			message += Exec(dllHandle, i, j)
		next

		msgAlert(message)
	next
return

static function Exec(dllHandle, dllIndex, methodIndex)
	Local msg:= ""
	Local methodName := GetMethod(dllIndex)
	Local buffer:= Space(255)
	Local result
	Local macro:= methodName + "(" + AllTrim(Str(dllHandle)) + ", " + AllTrim(Str(methodIndex)) + ", buffer)"

	if (dllIndex != 1)
		macro:= "result:= " + macro
	endif

	ConOut(macro)

	&(macro)

	ConOut("Executed!")

	msg:= "Retorno: (" + ValType(result) + ")

	if (ValType(result) == "N")
		msg += AllTrim(Str(result))
	endif

	result:= At(Chr(0), buffer)
	if (result > 0)
		buffer:= SubStr(buffer, 1, result -1)
	endif

	msg += CRLF
	msg += "Buffer (char): '" + buffer + "'"
	msg += CRLF + CRLF

	return msg
return

static function GetMethod(index)
	DO CASE
		CASE (index == 1)
			return "ExecInDllRun"
		CASE (index == 2)
			return "ExeDLLRun2"
		CASE (index == 3)
			return "ExeDLLRun3"
	ENDCASE
return

