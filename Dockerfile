# Use the latest CUDA base image with cuDNN
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Install system dependencies (include git)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    curl \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    vim \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ Asia/Tokyo

# Set the working directory
WORKDIR /app

# Clone the specified GitHub repository
RUN git clone https://github.com/kyk-131/Human-Activity-Recognition.git /app/Human-Activity-Recognition

# Change to the cloned repository's directory
WORKDIR /app/Human-Activity-Recognition

# Install Python (latest version as of now is 3.11.x)
RUN wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz \
    && tar xvf Python-3.11.4.tgz \
    && cd Python-3.11.4 \
    && ./configure --enable-optimizations \
    && make install \
    && cd .. \
    && rm -rf Python-3.11.4.tgz Python-3.11.4

# Create a symbolic link for python
RUN ln -fs /usr/local/bin/python3 /usr/bin/python

# Install pip
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Ensure poetry is added to the PATH
ENV PATH="/root/.local/bin:$PATH"


# Set Poetry and pip cache directories
ENV POETRY_CACHE /work/.cache/poetry
ENV PIP_CACHE_DIR /work/.cache/pip

# Configure Poetry to use the cache directory
RUN /root/.local/bin/poetry config virtualenvs.path $POETRY_CACHE

# Update PATH to include Poetry
ENV PATH ${PATH}:/root/.local/bin:/bin:/usr/local/bin:/usr/bin

# Default command
CMD ["bash", "-l"]
