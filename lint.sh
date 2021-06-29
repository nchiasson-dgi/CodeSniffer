#!/usr/bin/env bash

set -e #Exit entire script if any command fails

# Download dependencies
echo "Downloading dependencies ..."
composer -q global require drupal/coder
composer -q global require dealerdirect/phpcodesniffer-composer-installer
curl -OLsS https://github.com/phpstan/phpstan/raw/master/phpstan.phar

# Register sniffs
echo "Registering sniffs ..."
~/.composer/vendor/bin/phpcs -q --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer/

echo "Running PHPCPD for Drupal version ..."
~/.composer/vendor/bin/phpcpd --version

# Run linting and static analysis
echo "Running PHPCS for Drupal standards ..."
~/.composer/vendor/bin/phpcs --standard=Drupal --extensions=$ACTION_EXTENSIONS $ACTION_PATH

echo "Running PHPCS for Drupal best practices ..."
~/.composer/vendor/bin/phpcs --standard=DrupalPractice --extensions=$ACTION_EXTENSIONS $ACTION_PATH

echo "Running PHPCPD for copy/paste detection ..."
~/.composer/vendor/bin/phpcpd --names=*.php,*.module,*.inc,*.install,*.test,*.profile,*.theme,*.js,*.css,*.info --extensions=$ACTION_EXTENSIONS $ACTION_PATH

# Throwing Reflection errors, need to specify core directories.
#echo "Running PHPStan ..."
#php ./phpstan.phar analyse $ACTION_PATH
