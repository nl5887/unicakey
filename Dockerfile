FROM ubuntu:18.10
MAINTAINER Remco Verhoef <remco@verhoef.name>

# Prepare deps
RUN apt-get update -y && apt-get install -y \
            python-dev \
            python-pip \
            python3-dev \
            python3-pip \
            libglib2.0-dev \
            git \
            wget \
            less \
            cmake \
            vim && rm -rf /var/lib/apt/lists/*

# Get the Unicorn-Engine sources
WORKDIR /usr/src
RUN git clone --depth=1 https://github.com/aquynh/capstone

WORKDIR /usr/src/capstone
RUN ./make.sh && ./make.sh install 

# Build the Python bindings
WORKDIR /usr/src/capstone/bindings/python
RUN make install && make install3

WORKDIR /usr/src
RUN git clone --depth=1 https://github.com/unicorn-engine/unicorn

WORKDIR /usr/src/unicorn
RUN ./make.sh && ./make.sh install 

WORKDIR /usr/src/unicorn/bindings/python
RUN make install && make install3

WORKDIR /usr/src
RUN git clone --depth=1 https://github.com/keystone-engine/keystone

WORKDIR /usr/src/keystone
RUN mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_LIBS_ONLY=1 -DLLVM_BUILD_32_BITS=0 -DCMAKE_BUILD_TYPE=release -DBUILD_SHARED_LIBS=ON -DLLVM_TARGETS_TO_BUILD="all" -G "Unix Makefiles" .. && make install 

WORKDIR /usr/src/keystone/bindings/python
RUN make install && make install3

RUN pip install hexdump && pip3 install hexdump

# Cleanup
RUN rm -rf /usr/src/*

WORKDIR /data

