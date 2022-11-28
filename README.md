# nginx-basic-multi-auth-proxy
Docker image of Nginx Proxy with Basic Auth for multiple users

## Run

```bash
$ docker run \
    --rm \
    --name nginx-basic-auth-proxy \
    -p 8080:80 \
    -e BASIC_AUTH_USERNAME=username \
    -e BASIC_AUTH_PASSWORD=password \
    -e PROXY_PASS=https://www.google.com \
    -e PORT=80 \
    mumg/basic-auth:latest
```
## Environment variables

### Required

|Key| Description                                                                                  |
|---|----------------------------------------------------------------------------------------------|
|`BASIC_AUTH`| Basic auth usernames and passwords list in the following format USER:PASSWORD delimited by ; |
|`PROXY_PASS`| Proxy destination URL                                                                        |

### Optional

|Key|Description|Default|
|---|---|---|
|`SERVER_NAME`|Value for `server_name` directive|`example.com`|
|`PORT`|Value for `listen` directive|`80`|
|`CLIENT_MAX_BODY_SIZE`|Value for `client_max_body_size` directive|`1m`|
|`PROXY_READ_TIMEOUT`|Value for `proxy_read_timeout` directive|`60s`|
|`WORKER_PROCESSES`|Value for `worker_processes` directive|`auto`|
