# Spinnaker::Sidekiq

API to implement a webhook stage for spinnaker to stop sidekiq workers gracefully.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'spinnaker-sidekiq'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install spinnaker-sidekiq
```

## Usage

Mount the engine in your rails application.

``` ruby
mount Spinnaker::Sidekiq::Engine, at: "/spinnaker/sidekiq"
```

API token can be specified by environment variable `SPINNAKER_SIDEKIQ_API_TOKEN` or doing:

``` ruby
Spinnaker::Sidekiq.api_token = 'SECRET_VALUE'
```

In spinnaker, create a webhook stage with the following configuration:

- Webhook URL: `https://example.com/spinnaker/sidekiq/quiet_all`
- Method: `POST`
- Payload `{}`
- Custom Headers:
    `Authorization` value `Token SPINNAKER_API_TOKEN`
- Status JsonPath: `$.status`
- Progress location: `$.progress`
- SUCCESS status mapping: `quiet`


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
