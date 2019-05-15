sum(flask_http_request_duration_seconds_count) by (path)

## About
mb-test deploy a k8s cluster in gcp and after deploy a flask app and prometheus on it
## Requirements
1. a GCP account
2. kubectl installed
3. terraform 0.11.10 installed
4. GCP SDK i.e. gcloud
## Usage
Run build.sh [project-name] to deploy everything when doen 3 browser tabs will be open.
please use this query ```sum(flask_http_request_duration_seconds_count) by (path)``` to view theTotal number of requests per route
## Cleanup
Run clean.sh to delete everything