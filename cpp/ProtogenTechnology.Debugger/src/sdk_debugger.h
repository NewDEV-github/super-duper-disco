#ifndef ProtogenTechnologyDebugger_H
#define ProtogenTechnologyDebugger_H

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

class ProtogenTechnologyDebugger : public Node {
    GODOT_CLASS(ProtogenTechnologyDebugger, Node)

private:
    template<typename T>
    std::string itos(T i);

    godot::String debugger_changelog = "Made for protogens, Rawr!";
    godot::String debugger_version_string = "1.2.2";
    int debugger_version = 121;
    float time_passed;
    bool debugger_initialized = false;
    godot::String dt = "ProtogenTechnology";
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

    ProtogenTechnologyDebugger();
    ~ProtogenTechnologyDebugger();

    void _init(); // our initializer called by Godot
    godot::String init_sdk(int init_flag);
    void deinit_sdk();
    godot::String get_changelog();
    int get_version();
    godot::String get_version_string();
    };

}

#endif
