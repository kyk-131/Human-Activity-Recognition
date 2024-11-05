FROM python:3.11-slim

# Set the timezone
ENV TZ=Asia/Tokyo

# Install required packages including git and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone the specified GitHub repository
RUN git clone https://github.com/kyk-131/Human-Activity.git

# Set up Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/share/pypoetry/bin:$PATH"

# Configure Poetry cache
ENV POETRY_CACHE="/work/.cache/poetry"
ENV PIP_CACHE_DIR="/work/.cache/pip"
RUN mkdir -p $POETRY_CACHE && poetry config virtualenvs.path $POETRY_CACHE

# Start the container with a bash shell
CMD ["bash", "-l"]
