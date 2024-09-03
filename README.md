# Andrey Rojas Details about the task:

## Requirement 1: 
- Text file: `build-image-info.txt` contains the following: 
    ```
    BASE_IMAGE=node
    BASE_IMAGE_TAG=22-alpine3.19
    ```
*Note:* Image tag can be updated by user to any available Node tag in Docker Hub.

- Shell script: `build-image.sh` script which basically takes the above TXT file location as parameter, extracts the `$BASE_IMAGE` and the `$BASE_IMAGE_TAG` and builds the Dockerfile by passing these two values as ARGs (Arguments).

### Enhancements to Dockerfile:
- Add a *HEALTHCHECK* instruction to monitor the health of the application inside the container.
- In case more stuff and complexity is added to the app, we can eventually consider using Multi-Stage builds.
- We could copy just the NPM packages we need in order to reduce Image Size, e.g: `RUN npm ci --only=production`.

## Requirement 2: 
I proposed the solution in two ways: 

1- Generated Helm chart and edited default values accordingly (andrey-node chart). 

2- Created directory `manifests` to add future k8s manifests files (if needed). Inside it, included file called `app-deployment.yml` which contains the basic k8s deployment flow (Service, Deployment and Ingress)

### Details about requirement 2: 
- Service created as *LoadBalancer* since it will be exposed as NGINX ingress in next requirement. 
- Given label called *node-app* across the entire manifest file to match all objects. 
- Added *securityContext* once pod starts executing container (Disable root user and make the storage read-only)
- Used ingressClass `rf-nginx` for NGINX Ingress. 

### Points to take into consideration: 
Despite StorageClass exists (rf-storage-rw) the requirement 2c is clear that *ephemerals storage* is required. Therefore, in order to use that existing StorageClass, We would need to add a new object called `PersistentVolumeClaim` then point out the container volumes to the PVC object, because just by specifying the StorageClass in Deployment manifest object won't work. Besides that, the stronger reason why not using PVC is that it is Persistent storage rather than ephemeral.
