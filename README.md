# How to deploy a sample laravel application using nginx mysql and Helm Charts

This project will help you to deploy a sample laravel application using Helm Charts

## Create a project using below command and run it locally

- `composer create-project  laravel/laravel`
- When you create a project it generates a `.env` file which has the API key and all the db details you can provide here

Install dependencies
- `docker run --rm -v $(pwd):/app composer install`
- If you don't have docker installed then just run `composer install`
- `php artisan serve` ( Run it locally and test it if the application is coming up)

For this demo, I have placed all the code under `src` folder



## How to Build

```
docker build -t lavarel-app .
docker tag lavarel-app:latest gcr.io/yourgcr/lavarel-app
docker push gcr.io/yourgcr/lavarel-app:latest

To update the dependency
cd helm-charts/
helm dep build
helm dependency update
helm install test-lavarel-app -f ./deploy/values-dev.yaml ./helm-charts

```

