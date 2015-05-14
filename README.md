# Bulutfon Ruby Sdk

Bulutfon API'ye erişmek için ruby oauth2-client providerı

## Rails İçin Kullanımı

Yaptığı işlem; oauth2 ile bulutfondan yetki alıp ilgili endpointlere get isteği yapmaktır.

Gemfile dosyasınıza aşağıdaki satırları ekleyip `bundle install` yapınız.

```
gem 'omniauth'
gem 'bulutfon-sdk', git: 'git@github.com:bulutfon/ruby-sdk.git'
```

`config/omniauth.rb` dosyasını aşağıdaki gibi düzenleyin. Bu ayarlarda varsayılan olarak ssl kapalı ve `cdr` için yetki istenmektedir.

```ruby
#config/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :bulutfon, 'api_key', 'secret_key', :client_options => {ssl: { verify: false }, provider_ignores_state: true}, scope: 'cdr'
end

OmniAuth.config.logger = Rails.logger
```

Rails routing ayarlarını ayarlayın. Bu path yetkilendirmeden sonra bulutfonun sizi hangi url'ye yönlendireceğini söylediğiniz url dir.

```ruby
#config/routes.rb
get '/auth/:provider/callback', to: 'sessions#create'
```

Burası bulutfonun sizi yetki verdikten sonra yönlendirdiği yerdir. Credentials token ve refresh_token'ı session'a yazalım. Bunu kullanıcı bazlı veritabanınada yazabilirsiniz.

```ruby
#sessions_controller.rb
def create
    response = request.env['omniauth.auth']

    session['access_token'] = response['credentials']['token']
    session['refresh_token'] = response['credentials']['refresh_token']

    redirect_to dashboard_index_path # istediğiniz yere yönlendirme yapabilirsiniz
end
```

Aşağıdaki örnekle ilgili end pointlere istek yapabilirsiniz.

```ruby
  @bulutfon = Bulutfon.new(session['access_token'], session['refresh_token'])
  @dids = @bulutfon.dids
  @cdr = @bulutfon.cdrs(id: 2) # Bir cdr kaydının detayını alma
  @cdrs = @bulutfon.cdrs # sayfalama var ise ilk syafa gelir.
  @cdrs = @bulutfon.cdrs(page: 2) # sayfa 2 yi alma
  @extensions = @bulutfon.extensions
  @groups = @bulutfon.groups
```

## Scopes
https://github.com/bulutfon/documents/tree/master/API#endpointler
