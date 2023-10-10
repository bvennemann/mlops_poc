# This Dockerfile defines a Docker image that is used as execution environment
# for the Jenkins agent. It includes all dependencies that are needed for the
# CI/CD workflow.

# Start from a python base image
FROM python:3.11

# Install curl
RUN apt-get update && apt-get install -y curl

# Install the Databricks CLI
RUN curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh

# Install dependencies
#COPY test-requirements.txt test-requirements.txt
#COPY ./mlops_poc/requirements.txt requirements.txt
#RUN python -m pip install --upgrade pip
#RUN pip install -r test-requirements.txt
#RUN pip install -r requirements.txt