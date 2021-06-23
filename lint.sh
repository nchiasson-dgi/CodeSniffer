#!/usr/bin/env bash

set -e #Exit entire script if any command fails

# Download dependencies
echo "Downloading dependencies ..."
composer -q global require drupal/coder
curl -OLsS https://github.com/phpstan/phpstan/raw/master/phpstan.phar
composer -q global require dealerdirect/phpcodesniffer-composer-installer

# Register sniffs
echo "Registering sniffs ..."
~/.composer/vendor/bin/phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer/

# Run linting and static analysis
echo "Running PHPCS for Drupal standards ..."
~/.composer/vendor/bin/phpcs --standard=Drupal --extensions=$ACTION_EXTENSIONS $ACTION_PATH

echo "Running PHPCS for Drupal best practices ..."
~/.composer/vendor/bin/phpcs --standard=DrupalPractice --extensions=$ACTION_EXTENSIONS $ACTION_PATH
  
echo "Running PHPStan ..."
php ./phpstan.phar analyse $ACTION_PATH