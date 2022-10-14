Bootstrap: docker
FROM: ubuntu:20.04

%post
    #Install packages
    apt-get update
    apt-get install -y tar wget make gcc libz-dev build-essential

    #Download tools
    wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz
    tar -xzf 2.7.10a.tar.gz
    cd STAR-2.7.10a/source
    make STAR
    # For processors that do not support AVX extensions, specify the target SIMD architecture, e.g.
    # make STAR CXXFLAGS_SIMD=sse 

    #Keep STAR in path
    cd ../bin/Linux_x86_64
    export CHEMIN=$(pwd)
    export PATH=$PATH:$(CHEMIN)/

    
%environment
    export PATH=/STAR-2.7.10a/bin/Linux_x86_64/:$PATH

%runscript