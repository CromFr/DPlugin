import std.stdio;

extern(C){



	void SayHello(){
		writeln(__FUNCTION__,": Hello world !");
	}

	void SayHelloTo(in string somebody, in string somebodyelse){
		writeln(__FUNCTION__,": Hello ",somebody," !");
		if(somebodyelse!="")
			writeln(__FUNCTION__,":     And hello ",somebodyelse," !");
	}

	string GetHello(){
		return __FUNCTION__~": Hello world !";
	}
}
