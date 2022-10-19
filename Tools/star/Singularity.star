Bootstrap: docker
FROM: ubuntu:22.04

%post

    # Install Dependancies
    apt-get update
    apt-get install -y tar wget make gcc libz-dev build-essential

    # STAR
    wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz 
    tar -xzvf 2.7.10a.tar.gz  -C /usr/local 
    rm 2.7.10a.tar.gz
    mv /usr/local/STAR-2.7.10a /usr/local/STAR
    make STAR -C /usr/local/STAR/source

    # Cleaning
    apt-get autoremove -y && apt-get clean
    
%environment
    export PATH=:$PATH:/usr/local/STAR/bin/Linux_x86_64