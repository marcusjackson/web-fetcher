# web-fetcher

Simple ruby program to fetch the HTML of specified web pages.

### Executing the program

Navigate to fetch directory.

First time

```
docker build -t fetch .
```

Command itself

```
docker run -v ~:/fetch/temp fetch https://www.google.com https://autify.com <...>
```

### Other

Navigate to parent directory.

Run rubocop

```
docker-compose run --rm fetch bundle exec rubocop
```

Run bundle

```
docker-compose run --rm fetch bundle
```
