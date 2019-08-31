CC         := /usr/bin/g++

VERSION    := 2.4.1
LBLAS      := -lopenblas # alternatively -llapack (just need sgemm_)
LZLIB      := -lz

HTSLIB_INCLUDE_DIR := /opt/hall-lab/htslib-1.9/include
HTSLIB_LIB_DIR     := /opt/hall-lab/htslib-1.9/lib
LHTSLIB            := -lhts
LCURL              := -lcurl

ifeq (${debug},true)
	CFLAGS += -g
else
	CFLAGS += -O2
endif
ifeq (${prof},true)
	CFLAGS += -g -pg
	LFLAGS += -pg
endif

CPATHS = -I${HTSLIB_INCLUDE_DIR}
CFLAGS += -std=c++0x -msse -msse2 -fopenmp -Wall
LFLAGS += -fopenmp -L${HTSLIB_LIB_DIR}


## add Boost include and lib paths
#ifneq ($(strip ${BOOST_INSTALL_DIR}),)
#	CPATHS += -I${BOOST_INSTALL_DIR}/include
#	LPATHS += -L${BOOST_INSTALL_DIR}/lib
#	ifeq (${linking},dynamic)
#		LPATHS += -Wl,-rpath,${BOOST_INSTALL_DIR}/lib
#	endif
#endif

# add htslib include and lib paths
ifneq ($(strip ${HTSLIB_DIR}),)
	CPATHS += -I${HTSLIB_INCLUDE_DIR}
	LPATHS += -L${HTSLIB_LIB_DIR}
	ifeq (${linking},dynamic)
		LPATHS += -Wl,-rpath,${HTSLIB_LIB_DIR}
	endif
endif

## add zlib.a path for static linking on Orchestra
#ifneq ($(strip ${ZLIB_STATIC_DIR}),)
#	ifneq (${linking},dynamic)
#		LPATHS += -L${ZLIB_STATIC_DIR}
#	endif
#endif

## add flags for static linking; build LAPACK/MKL component of link line
#ifeq (${linking},static)
#	LFLAGS += -static
#	LPATHS += -L${GLIBC_STATIC_DIR}
#else ifeq (${linking},static-except-glibc)
#	LFLAGS += -static-libgcc -static-libstdc++
#endif

# build link line (minus flags)
LLIBS = -lboost_program_options -lboost_iostreams -lz ${LBLAS} ${LHTSLIB}
L = ${LPATHS} ${LLIBS} -lpthread -lm
#ifeq (${linking},static-except-glibc)
#	L = -L${LIBSTDCXX_STATIC_DIR} ${LPATHS} -Wl,--wrap=memcpy -Wl,-Bstatic ${LLIBS} -Wl,-Bdynamic -lpthread -lm
#else
#	L = ${LPATHS} ${LLIBS} -lpthread -lm
#endif


T = eagle-${VERSION}
O = DipTreePBWT.o Eagle.o EagleImpMiss.o EagleParams.o EaglePBWT.o FileUtils.o GenoData.o HapHedge.o MapInterpolater.o MemoryUtils.o NumericUtils.o StaticMultimap.o StringUtils.o SyncedVcfData.o Timer.o memcpy.o
OMAIN = EagleMain.o $O

.PHONY: clean

$T: ${OMAIN}
	${CC} ${LFLAGS} -o $T ${OMAIN} $L

%.o: %.cpp
	${CC} ${CFLAGS} ${CPATHS} -o $@ -c $<
EagleMain.o: Version.hpp
Eagle.o: Version.hpp

all: $T

clean:
	rm -f *.o
	rm -f $T
