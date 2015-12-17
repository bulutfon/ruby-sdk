# Bulutfon Ruby SDK

* [API Dokümantasyonu](https://github.com/bulutfon/documents/tree/master/API)
* [Örnek Kodlar](https://github.com/bulutfon/ruby-sdk/tree/master/examples)

## Kullanım

### Master Token ile

Gemfile dosyanıza şu satırı ekleyiniz

```  ruby
gem 'bulutfon_sdk', '~> 1.0.0'
```

	
Bu satırı ekledikten sonra,

```  bash
bundle install
```
komutunu koşarak gerekli paketleri yükledikten sonra BulutfonSDK'yı kullanmaya başlayabilirsiniz.

```ruby
require 'bulutfon_sdk'

token = 'your_token'
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
```

## İşlevler

### Kullanıcı bilgilerine erişme

SDK ile Kullanıcı bilgileriniz, panel bilgileriniz ve kalan kredinize erişebilirsiniz.
Bunun için 

``` ruby
puts bulutfon.details
```

methodunu kullanabilirsiniz.

### Telefon numaraları ve telefon numara detaylarına erişme

Bunun için;

```ruby
puts bulutfon.dids.all     # Santral listesine erişir
puts bulutfon.dids.get(1)  # Id'si verilen santral detayını döndürür 
```

methodlarını kullanabilirsiniz.

### Dahililere ve dahili detaylarına erişme, dahili oluşturma, güncelleme ve silme

Bunun için;

```ruby
puts bulutfon.extensions.all     # Dahili listesine erişir
puts bulutfon.extensions.get(1)  # Id'si verilen dahili detayını döndürür
params = {
    full_name: 'Deneme',
    email: 'deneme@deneme.com',
    did: '905xxxxxxxxx',
    number: 9999,
    redirection_type: 'NONE',
    destination_type: 'EXTENSION',
    destination_number: '905xxxxxxxxx',
    'acl[]' => [ 'domestic', 'gsm', 'international']
}
puts bulutfon.extensions.create(params)     # Verilen parametrelere göre yeni dahili oluşturur.
puts bulutfon.extensions.update(1, params)  # Verilen parametrelere göre dahiliyi günceller
puts bulutfon.extensions.delete(1)          # Dahiliyi siler    
```

methodlarını kullanabilirsiniz.

### Gruplara ve grup detaylarına erişme

Bunun için;

```ruby
puts bulutfon.groups.all     # Grup listesine erişir
puts bulutfon.groups.get(1)  # Id'si verilen grup detayını döndürür 
```

methodlarını kullanabilirsiniz.

### Arama kayıtlarına ve arama detaylarına erişme ve ses kayıtlarını indirme

Bunun için;

```ruby
puts bulutfon.cdrs.all                      # Cdr listesine erişir
puts bulutfon.cdrs.all({page: 1, limit: 3}) # Cdr listesine sayfalama yaparak erişir
puts bulutfon.cdrs.get('uuid')              # Uuid'si verilen cdr detayını döndürür 
```

methodlarını kullanabilirsiniz.

### Gelen fakslara erişme ve faks dosyasını indirme

Bunun için;

```ruby
puts bulutfon.incoming_faxes.all # Gelen faksları listeler 
```

methodlarını kullanabilirsiniz.

### Giden fakslara erişme ve faks gönderme

Bunun için;

```ruby
puts bulutfon.outgoing_faxes.all # Giden faksları listeler 
```

methodlarını kullanabilirsiniz.
    
### Ses Dosyalarını listeleme ve indirme, oluşturma ve silme

Bunun için;

```ruby
puts bulutfon.announcements.all # Ses Dosyalarını listeler 
```

methodlarını kullanabilirsiniz.

### Otomatik Aramaları listeleme ve oluşturma

Bunun için;

```ruby
puts bulutfon.automatic_calls.all    # Otomatik aramaları listeler
puts bulutfon.automatic_calls.get(1) # Id'si verien otomatik arama detaylarını görüntüler 
# Automatic call oluşturur ve oluşturmadan sonra receivers numaraları aranır
params = {
    title: 'Automatic call after creation',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx',
    announcement_id: 1
}
puts bulutfon.automatic_calls.create(params)
# Zaman planlı automatic call oluşturulur ve oluşturmadan sonra receivers numaraları perşembe günü saat 10:15 ile 12:00 arasında aranır
params = {
    title: 'Time planned call',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx',
    announcement_id: 1,
    mon_active: false,
    tue_active: false,
    wed_active: false,
    thu_active: true,
    thu_start: '10:15',
    thu_finish: '12:00',
    fri_active: false,
    sat_active: false,
    sun_active: false,
    hours_active: true
}
puts bulutfon.automatic_calls.create(params)
```

methodlarını kullanabilirsiniz.

### Sms Başlıklarını Listeleme

Bunun için;

```ruby
puts bulutfon.message_titles.all # Panelden oluşturduğunuz sms başlıklarını listeler
```

methodlarını kullanabilirsiniz.

### Mesajları Listeleme ve Mesaj Gönderme

Bunun için;

```ruby
# Gönderilen mesajları listeler
puts bulutfon.messages.all 
# Gönderilen mesajları sayfalama yaparak listeler 
puts bulutfon.messages.all({page: 1, limit: 3 })
# Id'si verilen mesaj detaylarını döndürür
puts bulutfon.messages.get(1)
# Yeni mesaj gönderme işlemi
params = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Test Message',
    receivers: '905xxxxxxxxx'
}
puts bulutfon.messages.create(params)
# Çoklu alıcılı mesaj gönderme işlemi
params_multiple = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Multiple Message',
    receivers: '905xxxxxxxxx,905xxxxxxxxx'
}
puts bulutfon.messages.create(params_multiple)
# Zaman planlı mesaj gönderme işlemi
params = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Planned message example',
    receivers: '905xxxxxxxxx',
    is_future_sms: true,
    send_date: '16/12/2015 10:00'
}
puts bulutfon.messages.create(params)
```

methodlarını kullanabilirsiniz.

Örnek kullanımları görmek için ve erişebileceğiniz değişkenler için [örnek kodlarımızı](https://github.com/bulutfon/ruby-sdk/tree/master/examples) inceleyebilirsiniz.
    
