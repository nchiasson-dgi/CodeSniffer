# dgi_code_sniffer

A GitHub action for performing static analysis on Drupal code. It runs PHPCS and PHPStan on the directory you give it.

 
## Inputs
**path:** The path (or paths) to run the analysis on (required).
**extensions:** A comma separated list of file extensions to test (optional).

## Outputs
This action does not output any artifacts.

## Secrets
This action does not use any secrets.

## Usage
Learn more about GitHub Actions in general [here](https://docs.github.com/en/actions/quickstart). 

To use this action in your repo, follow these steps:

 1. Create a YAML file in the `.github/workflows/` directory of your repo.
 2.  Copy the following into the YAML file:
```yaml
name: Code Lint
on: [push]
jobs:
  Lint:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v2
      
      - name: Run dgi_code_sniffer
        uses: discoverygarden/dgi_code_sniffer@v1
        with:
          path: ./
```
This will run the sniffer each code is pushed to the repo. You should replace the `path` with your `src` directory (or whatever you want to run the sniffer on).