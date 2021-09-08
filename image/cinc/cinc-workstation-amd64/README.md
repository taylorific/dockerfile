## doctl - command line interface for DigitalOcean

### Using doctl with Docker

When using doctl with Docker, you must set the `DIGITALOCEAN_ACCESS_TOKEN` environment variable inside the container. Many commands require user input, so it is recommended to pass the `--interactive` and `--tty` flags as well. For example:

```
docker container run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN=${DIGITALOCEAN_ACCESS_TOKEN} \
  taylorific/doctl-amd64 image list
```

Some commands may require additional arguments, including:

#### doctl compute ssh

doctl allows you to connect to a Droplet over SSH without knowing its IP address by providing its ID. In order to use this feature with Docker, you must mount your SSH private key from your local file system into the container. For example:

```
docker container run --rm --interactive --tty \
  --env=DIGITALOCEAN_ACCESS_TOKEN=${DIGITALOCEAN_ACCESS_TOKEN} \
  -v $HOME/.ssh/id_ed25519:/root/.ssh/id_ed25519 \
  taylorific/doctl-amd64 compute ssh <DROPLET-ID>
```

For more information about doctl refer to:
[How To Use Doctl, the Official DigitalOcean Command-Line Client](https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client)
