# Makefile

# Target to build the Docker image
build-gpu:
	@echo "Building Dockerfile"
	docker build -t human-activity-recognition -f Dockerfile_gpu .

# Target to start the container
start-gpu: build-gpu
	@echo "Starting GPU-enabled container"
	docker run --gpus all -it human-activity-recognition
