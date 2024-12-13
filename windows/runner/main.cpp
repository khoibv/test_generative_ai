#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  // Win32Window::Point origin(10, 10);
  // Win32Window::Size size(1280, 720);

// Get the size of the primary monitor
HMONITOR primaryMonitor = ::MonitorFromWindow(nullptr, MONITOR_DEFAULTTOPRIMARY);
MONITORINFO monitorInfo;
monitorInfo.cbSize = sizeof(MONITORINFO);
::GetMonitorInfo(primaryMonitor, &monitorInfo);
int screenWidth = monitorInfo.rcMonitor.right - monitorInfo.rcMonitor.left;
int screenHeight = monitorInfo.rcMonitor.bottom - monitorInfo.rcMonitor.top;
// Win32Window::Point origin(10, 10);

// tablet size
// int windowWidth = 768;
// int windowHeight = 1024;

// iPhone 16 Pro Max
int windowWidth = 440;
int windowHeight = 956;

Win32Window::Point origin((screenWidth - windowWidth)/2, (screenHeight - windowHeight) / 2);
Win32Window::Size size(windowWidth, windowHeight);

  if (!window.Create(L"test_ai", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
