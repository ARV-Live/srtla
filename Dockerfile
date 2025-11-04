FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libspdlog-dev \
    python3 \
    git

# Set the working directory \
WORKDIR /app

# Install argparse
RUN git clone https://github.com/p-ranav/argparse
RUN cd argparse && mkdir build && cd build && cmake .. && make install
RUN cd ../..

# Copy the source code into the container
COPY . .

# Build the application
RUN mkdir build && cd build && \
    cmake .. && \
    make

EXPOSE 5000

# Set the entry point for the container
ENTRYPOINT ["./build/srtla_rec"]