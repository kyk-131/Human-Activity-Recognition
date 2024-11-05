FROM python:3.11-slim

# Set the timezone
ENV TZ=Asia/Tokyo

# Install required packages including git and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set up environment variables for Poetry
ENV POETRY_HOME="/root/.local"
ENV PATH="$POETRY_HOME/bin:$PATH"

# Create a cache directory for Poetry
RUN mkdir -p /work/.cache/poetry && \
    poetry config virtualenvs.path /work/.cache/poetry

# Clone the specified GitHub repository
RUN git clone https://github.com/kyk-131/Human-Activity.git /work/Human-Activity

# Start the container with a bash shell
CMD ["bash", "-l"]
