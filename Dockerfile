# Use a lightweight Python image
FROM python:3.11-slim

# Set the timezone
ENV TZ=Asia/Tokyo

# Install required packages including git and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Add Poetry to the PATH
ENV PATH="/root/.local/bin:$PATH"

# Create a cache directory for Poetry
RUN mkdir -p /work/.cache/poetry

# Clone the specified GitHub repository for Human-Activity-Recognition
RUN git clone https://github.com/kyk-131/Human-Activity-Recognition.git /work/Human-Activity-Recognition

# Change working directory to the cloned repository
WORKDIR /work/Human-Activity-Recognition

# Install the project dependencies with Poetry
RUN poetry config virtualenvs.in-project true && \
    poetry install

# Start the container with a bash shell
CMD ["bash"]
