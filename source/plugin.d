module plugin;

import std.conv;
import core.sys.posix.dlfcn;

/**
	Runtime plugin from precompiled library object
*/
class Plugin {
	this(in string path, in string name=""){
		m_path = path;
		m_name = name!="" ? name : path;

		m_libhdl = dlopen(m_path.ptr, RTLD_LAZY);
		if(!m_libhdl){
			throw new Exception("Plugin '"~m_name~"' failed to load: "~to!string(dlerror()));
		}
	}
	~this(){
		dlclose(m_libhdl);
	}


	T Call(T, VT...)(in string func, VT args){
		T function(VT) fn = cast(T function(VT)) dlsym(m_libhdl, func.ptr);

		if(char* e = dlerror()){
			throw new Exception("Function call error in plugin '"~m_name~"': "~to!string(e));
		}

		return fn(args);
	}


protected:
	string m_path;
	string m_name;

	void* m_libhdl;
}


/**
	Plugin folowing an interface implementation
*/
class InterfacePlugin(I) : Plugin{

	this(in string path, in string name=""){
		static if(!is(C == interface))
			static assert("InterfacePlugin template must be an interface");

		super(path, name);

		auto funcs = __traits(allMembers, I);
		std.stdio.writeln(funcs);

		foreach(f ; funcs){
			m_fun[f] = dlsym(m_libhdl, f.ptr);
			if(char* e = dlerror()){
				throw new Exception("Method check error in plugin '"~m_name~"': "~to!string(e));
			}
		}
	}

	void opDispatch(string fun, VT...)(VT args) {
		opDispatch!(void, fun)(args);
	}

	T opDispatch(T, string fun, VT...)(VT args) {
		if(fun in m_fun)
		{
			auto fn = cast(T function(VT))(m_fun[fun]);
			return fn(args);
		}
		throw new Exception("Unknown function call in plugin '"~m_name~"'");
	}

private:
	void*[string] m_fun;
}