
        ##note: -fpic flag allows for a shared library to be created.
	CFLAGS = -pthread -Wall -Wextra
	LFLAGS = -lrt -lX11 -lGLU -lGL -pthread -lm #-lXrandr
	##MYLIB  = ./libggfonts.so

##--------------------------------------------------------
## to build a static library
##
## $ ar -cvq libggfonts.a fonts.o fonttex.o
##
## then when compiling, put libggfonts.a on compile line
##--------------------------------------------------------

all: fonts.o fonttex.o staticLib ggtest

fonts.o: fonts.cpp fonts.h defs.h
		g++ -c -Wall -Wextra fonts.cpp

fonttex.o: fonttex.cpp
		g++ -c -Wall -Wextra fonttex.cpp

##makelib: fonts.o fonttex.o fonts.h
##	g++ -shared -o $(MYLIB) fonts.o fonttex.o


## Creating static library twice?
## If you build the file while it already exists, it grows larger.
## But, you cannot remove the file if it is not there.
## So, create it, remove it, then create it.
staticLib: fonts.o fonttex.o
		ar -cvq libggfonts.a fonts.o fonttex.o
		rm libggfonts.a
		ar -cvq libggfonts.a fonts.o fonttex.o

hw1: hw1.cpp fonts.h log.cpp defs.h
		g++ $(CFLAGS) hw1.cpp log.cpp $(LFLAGS) -o hw1

clean:
		rm -f hw1
		rm -f *.o
		rm -f *.so
		rm -f *.o

