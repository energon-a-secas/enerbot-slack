VERSION_FILE := 1.1.0

deploy:
	gem build enerbot-slack.gemspec
	gem install ./enerbot-slack-$(VERSION_FILE).gem

push:
	gem push enerbot-slack-$(VERSION_FILE).gem

shell:
	docker-compose run --rm --name=ruby-cli shell

clean:
	gem uninstall enerbot_slack

test:
	cd test && ruby client.rb
