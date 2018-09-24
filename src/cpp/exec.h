#pragma once

#if defined(_WIN32)
#	define DLLExport __declspec(dllexport)
#else
#	define DLLExport
#endif
