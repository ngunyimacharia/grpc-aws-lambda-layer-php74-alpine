# GRPC AWS Lambda layer - php74 (Alpine Linux)

### Description

Building the Dockerfile contained herein will:
- Setup `php:7.4-fpm-alpine` environment
- Install `grpc` for PHP
- Zip the compiled extension and php.ini files
- Publish an AWS Lambda layer using the generated zip file

### How to run

Run the following command on the terminal when in the root folder

Remember to input your own default region, access key id and secret access key

```
docker build -t grpc:latest . \
--build-arg AWS_DEFAULT_REGION=af-south-1 \
--build-arg AWS_ACCESS_KEY_ID=asdfghjkl \
--build-arg AWS_SECRET_ACCESS_KEY=asdfghjkl
```

### Usage

Depending on the configuration you are using, simply include the generated AWS Lambda layer into your project / lambda function.

If you are using Laravel Vapor, how to use the layer is documented here: https://docs.vapor.build/1.0/projects/environments.html#layers

If you are using Bref PHP, usage of the Lambda Layer is documented here: https://bref.sh/docs/runtimes/index.html#lambda-layers-in-details

### Resources

- https://github.com/brefphp/extra-php-extensions
- https://github.com/lon9/docker-alpine-grpc
- https://cloud.google.com/php/grpc
- https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html

### How to contribute

Welcome one, welcome all. Create an issue or even better, a pull request.