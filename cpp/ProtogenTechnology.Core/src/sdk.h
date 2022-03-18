#ifndef ProtogenTechnologyCore_H
#define ProtogenTechnologyCore_H

#include <algorithm>
#include <array>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <Godot.hpp>
#include <Node.hpp>
#include <OS.hpp>
#include <Engine.hpp>
// #include "reference.h"

namespace godot {

class ProtogenTechnologyCore : public Node {
    GODOT_CLASS(ProtogenTechnologyCore, Node)

private:
    template<typename T>
    std::string itos(T i);

    godot::String changelog = "Made for protogens, Rawr!";
    godot::String version_string = "1.2.2";
    int version = 121;
    float time_passed;
    bool initialized = false;
    bool debugger_initialized = false;
    godot::String dt = "ProtogenTechnology.Core";
    godot::String error_message = "[" + dt + ".Debugger] Error at: ";
    godot::String crash_message = "[" + dt + ".Debugger] Crash at: ";
    godot::String warning_message = "[" + dt + ".Debugger] Warning at: ";
    godot::String init_debugger();
    bool init_checks();
    bool init_debugger_checks();
    void deinit_debugger();
    void throw_error(godot::String where, godot::String what);
    void throw_warning(godot::String where, godot::String what);
    void throw_crash(godot::String where, godot::String what);

public:
    const int INIT_FLAG_NORMAL = 0;
    const int INIT_FLAG_DEBUG = 1;
    static void _register_methods();

    ProtogenTechnologyCore();
    ~ProtogenTechnologyCore();

    void _init(); // our initializer called by Godot
    godot::String void init_sdk(int init_flag);
    void deinit_sdk();
    godot::String get_changelog();
    int get_version();
    godot::String get_version_string();
    };

}

#endif
