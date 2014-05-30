module app;

import std.stdio;
import plugin;
import iface;


void main() {
	auto p = new Plugin("./plugin/hello.so", "Hello");
	writeln("Plugin loaded");

	p.Call!void("SayHello");

	p.Call!void("SayHelloTo", "Thibaut", "Thomas");

	string s = p.Call!string("GetHello");
	writeln(s);

	writeln("================================");

	auto ip = new InterfacePlugin!IFace("./plugin/ifaceplugin.so", "IfacePlugin");
	writeln("Double(5) = ",ip.opDispatch!(int, "Double")(5));
	ip.Test();
}