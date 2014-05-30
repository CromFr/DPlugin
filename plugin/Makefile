all: hello.d ifaceplugin.d
	dmd -c hello.d -fPIC
	dmd -ofhello.so hello.o -shared -defaultlib=libphobos2.so

	dmd -c ifaceplugin.d -fPIC
	dmd -ofifaceplugin.so ifaceplugin.o -shared -defaultlib=libphobos2.so
