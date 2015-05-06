# Bulutfon Ruby Sdk



## Basic Usage

* `gem 'omniauth'`
* `gem 'bulutfon-sdk'`
* `bundle install`

```ruby
#config/omniuth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :bulutfon, 'api_key', 'api_secret',
           { :client_options => {ssl: { verify: false }},
                               provider_ignores_state: true,
                           }
end

OmniAuth.config.logger = Rails.logger
```

```ruby
#config/routes.rb
get '/auth/:provider/callback', to: 'sessions#create'
```

```ruby
#sessions_controller.rb
def create
    response = request.env['omniauth.auth']

    session['access_token'] = response['credentials']['token']
    session['refresh_token'] = response['credentials']['refresh_token']

    redirect_to dashboard_index_path
end
```

```ruby
#dashboard_controller.rb
def index
    @bulutfon = Bulutfon.new(session['access_token'], session['refresh_token'])
    @dids = @bulutfon.dids
    @cdr = @bulutfon.cdrs(3)
    @extensions = @bulutfon.extensions
    @groups = @bulutfon.groups
end
```

## Scopes


## License
