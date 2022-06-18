#include "sdk_debugger.h"
#include <algorithm>
#include <array>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
using namespace godot;

void ProtogenTechnologyDebugger::_register_methods() {
    register_method("init_sdk", &ProtogenTechnologyDebugger::init_sdk);
    register_method("deinit_sdk", &ProtogenTechnologyDebugger::deinit_sdk);
    register_method("get_changelog", &ProtogenTechnologyDebugger::get_changelog);
    register_method("get_version", &ProtogenTechnologyDebugger::get_version);
    register_method("get_version_string", &ProtogenTechnologyDebugger::get_version_string);
}

template<typename T>
std::string ProtogenTechnologyDebugger::itos(T i) {
    std::stringstream s;
    s << i;
    return s.str();
}

ProtogenTechnologyDebugger::ProtogenTechnologyDebugger() {

}
ProtogenTechnologyDebugger::~ProtogenTechnologyDebugger() {
    // add your cleanup here
}

void ProtogenTechnologyDebugger::deinit_sdk() {
    godot::Godot::print("De-initializing Protogen Technology SDK...");
    initialized = false;
    godot::Godot::print("Protogen Technology SDK de-initialized!");
    if (debugger_initialized == true) {
        ProtogenTechnologyDebugger::deinit_debugger();
    }
}

void ProtogenTechnologyDebugger::deinit_debugger() {
    godot::Godot::print("De-initializing Protogen Technology SDK Debugger...");
    debugger_initialized = false;
    godot::Godot::print("Protogen Technology SDK Debugger de-initialized!");
}
void ProtogenTechnologyDebugger::_init() {
    godot::String text_1 = "Loaded Protogen Technology SDK, version: ";
    godot::String text_2 = ", ";
    godot::String godot_string_version = ProtogenTechnologyDebugger::itos(version).c_str();
    godot::Godot::print(text_1 + godot_string_version + text_2 + version_string);
    initialized = false;
    debugger_initialized = false;
}

godot::String ProtogenTechnologyDebugger::init_sdk(int init_flag) {
    godot::String message = "";
    godot::Godot::print("Initializing Protogen Technology SDK...");
    if (init_flag == 0) {
      if (ProtogenTechnologyDebugger::init_checks() == true) {
        initialized = true;
        godot::Godot::print("Protogen Technology SDK Initialized!");
        message = "init";
        return message;
      }
      else {
        godot::Godot::print("Can not initialize Protogen Technology SDK");
        message = "not_init";
        return message;
      }
    }
    if (init_flag == 1) {
      if (ProtogenTechnologyDebugger::init_checks() == true) {
        initialized = true;
        godot::Godot::print("Protogen Technology SDK Initialized!");
        message = ProtogenTechnologyDebugger::init_debugger();
        return message;
      }
      else {
        godot::Godot::print("Can not initialize Protogen Technology SDK");
        message = "not_init_d";
        return message;
      }
    }
}
godot::String ProtogenTechnologyDebugger::init_debugger() {
    godot::String message = "";
    godot::Godot::print("Initializing Protogen Technology SDK Debugger...");
    if (ProtogenTechnologyDebugger::init_debugger_checks() == true) {     
        debugger_initialized = true;
        godot::Godot::print("Protogen Technology SDK Debugger Initialized!");
        message = "init_d";
        return message;
    }
    else {
        godot::Godot::print("Can not initialize Protogen Technology SDK Debugger");
        message = "not_init_d";
        return message;
    }
}
bool ProtogenTechnologyDebugger::init_checks() {
    return true; //no checks needed for now
}
bool ProtogenTechnologyDebugger::init_debugger_checks() {
    return true; //no checks needed for now
}
void ProtogenTechnologyDebugger::throw_error(godot::String where, godot::String what) {
    if (initialized == true) {
        if (debugger_initialized == true) {
            godot::String com = " - ";
            godot::Godot::print(error_message + where + com + what);
        }
    }
    else {
        godot::Godot::print("SDK not initialized - function won't work");
    }
}
void ProtogenTechnologyDebugger::throw_warning(godot::String where, godot::String what) {
    if (initialized == true) {
        if (debugger_initialized == true) {
            godot::String com = " - ";
            godot::Godot::print(warning_message + where + com + what);
        }
    }
    else {
        godot::Godot::print("SDK not initialized - function won't work");
    }
}
void ProtogenTechnologyDebugger::throw_crash(godot::String where, godot::String what) {
    if (initialized == true) {
        if (debugger_initialized == true) {
            godot::String com = " - ";
            godot::Godot::print(crash_message + where + com + what);
        }
    }
    else {
        godot::Godot::print("SDK not initialized - function won't work");
    }
}
godot::String ProtogenTechnologyDebugger::get_changelog() {
    return changelog;
}
int ProtogenTechnologyDebugger::get_version() {
    return version;
}
godot::String ProtogenTechnologyDebugger::get_version_string() {
    return version_string;
}
