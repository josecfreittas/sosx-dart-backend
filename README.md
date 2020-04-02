# Backend da Semana OmniStack 10, feito em Dart

## A ideia e a motivação

Como a Semana OmniStack aborda o desenvolvimento de um sistema simples, e como já considero ter um conhecimento satisfatório da stack Javascript (pelo menos para o que a SOS propõe), decidi experimentar trocar para uma stack completa em Dart para melhorar minhas skills com a linguagem (que já venho usando por conta do flutter).


### Todos os repositórios:

  * [Backend](https://github.com/josecfreittas/sosx-dart-backend) ([Aqueduct](https://github.com/stablekernel/aqueduct) e [PostgreSQL](https://www.postgresql.org))
  * Web ([Flutter web](https://flutter.dev/web)) // ainda não iniciado
  * Mobile ([Flutter](https://flutter.dev/)) // ainda não iniciado

# Aqueduct:

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).
