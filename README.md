# megasync

Run [mega-sync](https://mega.nz/sync) as a Docker image

## Features

* Keeps your MEGASync directory in your Mega account in sync with the `/home/mega` directory in the container

## Usage

```
docker run -d \
  -e EMAIL=YOUR_MEGA_ACCOUNT_EMAIL \
  -e PASSWORD=YOUR_MEGA_PASSWORD \
  -v /path/to/sync:/home/mega \
  docker.cluster.fun/averagemarcus/megasync
```

## Building from source

With Docker:

```sh
make docker-build
```

Standalone:

```sh
make build
```

## Resources

* [mega-sync](https://mega.nz/sync)
* [MEGAcmd](https://github.com/meganz/MEGAcmd)

## Contributing

If you find a bug or have an idea for a new feature please [raise an issue](/AverageMarcus/megasync/issues/new) to discuss it.

Pull requests are welcomed but please try and follow similar code style as the rest of the project and ensure all tests and code checkers are passing.

Thank you 💛

## License

See [LICENSE](LICENSE)
