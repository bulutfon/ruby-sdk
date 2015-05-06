# Bulutfon Ruby Sdk

Bulutfon API'ye erişmek için ruby oauth2-client providerı

## Rails İçin Kullanımı

Gemfile dosyasınıza aşağıdaki satırları ekleyip `bundle install` yapınız.

```
gem 'omniauth'
gem 'bulutfon-sdk', git: 'git@github.com:bulutfon/ruby-sdk.git'
```

`config/omniauth.rb` dosyasını aşağıdaki gibi düzenleyin. Bu ayarlarda varsayılan olarak ssl kapalı ve `cdr, call_record` için yetki istenmektedir.

```ruby
#config/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :bulutfon, 'api_key', 'api_secret',
           { :client_options => {ssl: { verify: false }},
                               provider_ignores_state: true,
                           }, scope: 'cdr, call_record'
end

OmniAuth.config.logger = Rails.logger
```

Rails routing ayarlarını ayarlayın.

```ruby
#config/routes.rb
get '/auth/:provider/callback', to: 'sessions#create'
```

Credentials token ve refresh_token'ı session'a yazalım.

```ruby
#sessions_controller.rb
def create
    response = request.env['omniauth.auth']

    session['access_token'] = response['credentials']['token']
    session['refresh_token'] = response['credentials']['refresh_token']

    redirect_to dashboard_index_path
end
```

Aşağıdaki örnekle ilgili end pointlere istek yapabilirsiniz.

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
https://github.com/bulutfon/documents/tree/master/API#endpointler
