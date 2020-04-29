.PHONY : install beautify up down test-unit test-integration merge-coverage debug-test-integration
.DEFAULT : install

install:
	composer install -o
beautify:
	vendor/bin/phpcbf --standard=PSR2 src tests
up:
	docker-compose up -d --build
down:
	docker-compose down --remove-orphans
test-unit:
	vendor/bin/phpunit --testdox --verbose --color
test-integration: up
	sleep 20
	@-vendor/bin/phpunit --no-coverage --color --testdox --verbose -c phpunit-integration.xml.dist
	make down
test-group-integration:
	php vendor/bin/phpunit --no-coverage --color --testdox --group debug -c phpunit-integration.xml.dist