#include "sdk.h"
#include <algorithm>
#include <array>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
using namespace godot;

void ProtogenTechnologyCore::_register_methods() {
    register_method("init_sdk", &ProtogenTechnologyCore::init_sdk);
    register_method("deinit_sdk", &ProtogenTechnologyCore::deinit_sdk);
    register_method("get_changelog", &ProtogenTechnologyCore::get_changelog);
    register_method("get_version", &ProtogenTechnologyCore::get_version);
    register_method("get_version_string", &ProtogenTechnologyCore::get_version_string);
}

template<typename T>
std::string ProtogenTechnologyCore::itos(T i) {
    std::stringstream s;
    s << i;
    return s.str();
}

ProtogenTechnologyCore::ProtogenTechnologyCore() {

}
ProtogenTechnologyCore::~ProtogenTechnologyCore() {
    // add your cleanup here
}

void ProtogenTechnologyCore::deinit_sdk() {
    godot::Godot::print("De-initializing Protogen Technology SDK...");
    initialized = false;
    godot::Godot::print("Protogen Technology SDK de-initialized!");
    if (debugger_initialized == true) {
        ProtogenTechnologyCore::deinit_debugger();
    }
}

void ProtogenTechnologyCore::deinit_debugger() {
    godot::Godot::print("De-initializing Protogen Technology SDK Debugger...");
    debugger_initialized = false;
    godot::Godot::print("Protogen Technology SDK Debugger de-initialized!");
}
void ProtogenTechnologyCore::_init() {
    godot::String text_1 = "Loaded Protogen Technology SDK, version: ";
    godot::String text_2 = ", ";
    godot::String godot_string_version = ProtogenTechnologyCore::itos(version).c_str();
    godot::Godot::print(text_1 + godot_string_version + text_2 + version_string);
    initialized = false;
    debugger_initialized = false;
}

godot::String ProtogenTechnologyCore::init_sdk(int init_flag) {
    godot::String message = "";
    godot::Godot::print("Initializing Protogen Technology SDK...");
    if (init_flag == 0) {
      if (ProtogenTechnologyCore::init_checks() == true) {
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
      if (ProtogenTechnologyCore::init_checks() == true) {
        initialized = true;
        godot::Godot::print("Protogen Technology SDK Initialized!");
        message = ProtogenTechnologyCore::init_debugger();
        return message;
      }
      else {
        godot::Godot::print("Can not initialize Protogen Technology SDK");
        message = "not_init_d";
        return message;
      }
    }
}
godot::String ProtogenTechnologyCore::init_debugger() {
    godot::String message = "";
    godot::Godot::print("Initializing Protogen Technology SDK Debugger...");
    if (ProtogenTechnologyCore::init_debugger_checks() == true) {     
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
bool ProtogenTechnologyCore::init_checks() {
    return true; //no checks needed for now
}
bool ProtogenTechnologyCore::init_debugger_checks() {
    return true; //no checks needed for now
}
void ProtogenTechnologyCore::throw_error(godot::String where, godot::String what) {
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
void ProtogenTechnologyCore::throw_warning(godot::String where, godot::String what) {
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
void ProtogenTechnologyCore::throw_crash(godot::String where, godot::String what) {
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
godot::String ProtogenTechnologyCore::get_changelog() {
    return changelog;
}
int ProtogenTechnologyCore::get_version() {
    return version;
}
godot::String ProtogenTechnologyCore::get_version_string() {
    return version_string;
}
