# Use the latest stable version of Python
FROM python:3.11-slim

# Set the timezone
ENV TZ=Asia/Tokyo

# Install curl and other required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry using the recommended installation script
RUN curl -sSL https://install.python-poetry.org | python3 -

# Set the Poetry environment variables
ENV POETRY_HOME="/root/.local/share/pypoetry"
ENV PATH="$POETRY_HOME/bin:$PATH"

# Configure Poetry to use a cache directory
ENV POETRY_CACHE="/work/.cache/poetry"
ENV PIP_CACHE_DIR="/work/.cache/pip"

# Create a cache directory for Poetry
RUN mkdir -p $POETRY_CACHE && \
    poetry config virtualenvs.path $POETRY_CACHE

# Start the container with a bash shell
CMD ["bash", "-l"]
