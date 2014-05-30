import std.stdio;

extern(C){

	void Test(){
		writeln("This is a test !");
	}

	int Double(int a){
		return a*2;
	}
}