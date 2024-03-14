# Start from a base image containing the Go runtime
FROM golang:1.20-alpine AS build

# Set the current working directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o server .

# Start a new stage from scratch
FROM alpine:latest  

# Copy the Pre-built binary file from the previous stage
COPY --from=build /app/server /app/server  

# Expose port 8080 to the outside world
EXPOSE 8080  

# Command to run the executable
CMD ["./app/server"]
