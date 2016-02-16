# Bulutfon Ruby SDK

[![Gem Version](https://badge.fury.io/rb/bulutfon_sdk.svg)](https://badge.fury.io/rb/bulutfon_sdk)

* [API Dokümantasyonu](https://github.com/bulutfon/documents/tree/master/API)
* [Örnek Kodlar](https://github.com/bulutfon/ruby-sdk/tree/master/examples)

## Kullanım

### Kurulum

Gemfile dosyanıza şu satırı ekleyiniz

```  ruby
gem 'bulutfon_sdk'
```
	
Bu satırı ekledikten sonra,

```  bash
bundle install
```
komutunu koşarak gerekli paketleri yükledikten sonra BulutfonSDK'yı kullanmaya başlayabilirsiniz.

### Master Token ile

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
# Santral listesine erişir
puts bulutfon.dids.all    
# Id'si verilen santral detayını döndürür
puts bulutfon.dids.get(1)  
```

methodlarını kullanabilirsiniz.

### Dahililere ve dahili detaylarına erişme, dahili oluşturma, güncelleme ve silme

Bunun için;

```ruby
# Dahili listesine erişir
puts bulutfon.extensions.all     
# Id'si verilen dahili detayını döndürür
puts bulutfon.extensions.get(1)  
# Verilen parametrelere göre yeni dahili oluşturur.
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
puts bulutfon.extensions.create(params)    
# Verilen parametrelere göre dahiliyi günceller
params = {
    full_name: 'Deneme Deneme',
    'acl[]' => [ 'domestic', 'gsm']
}
puts bulutfon.extensions.update(1, params)  
# Dahiliyi siler
puts bulutfon.extensions.delete(1)              
```

methodlarını kullanabilirsiniz.

### Gruplara ve grup detaylarına erişme

Bunun için;

```ruby
# Grup listesine erişir
puts bulutfon.groups.all     
# Id'si verilen grup detayını döndürür 
puts bulutfon.groups.get(1)  
```

methodlarını kullanabilirsiniz.

### Arama kayıtlarına ve arama detaylarına erişme ve ses kayıtlarını indirme

Bunun için;

```ruby
# Cdr listesine erişir
puts bulutfon.cdrs.all                      
# Cdr listesine sayfalama yaparak erişir
puts bulutfon.cdrs.all({page: 1, limit: 3}) 
# Uuid'si verilen cdr detayını döndürür 
puts bulutfon.cdrs.get('uuid')              
# Uuid'si verilen arama kaydinin detaylarini getir 
puts bulutfon.call_records.get('uuid')         
# Uuid'si verilen ses kaydını indir
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_uuid.ogg"
puts bulutfon.call_records.save('uuid', save_path)
```

methodlarını kullanabilirsiniz.

### Gelen fakslara erişme ve faks dosyasını indirme

Bunun için;

```ruby
# Gelen faksları listeler
puts bulutfon.incoming_faxes.all  
# Uuid'si verilen gelen faksın detayları
puts  bulutfon.incoming_faxes.get('uuid')
# Uuid'si verilen gelen faksı indir
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_uuid.tiff"
puts  bulutfon.incoming_faxes.save('uuid', save_path)
```

methodlarını kullanabilirsiniz.

### Giden fakslara erişme ve faks gönderme

Bunun için;

```ruby
# Giden faksları listeler 
puts bulutfon.outgoing_faxes.all
# Id'si verilen giden faks detayları
puts bulutfon.outgoing_faxes.get(1)
# Faks gönderme işlemi
file = "#{File.expand_path(File.dirname(__FILE__))}/pdf-sample.pdf"
params = {
    title: 'Deneme',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx', 
    attachment: file
}
puts bulutfon.outgoing_faxes.create(params)
```

methodlarını kullanabilirsiniz.
    
### Ses Dosyalarını listeleme ve indirme, oluşturma ve silme

Bunun için;

```ruby
# Ses Dosyalarını listeler 
puts bulutfon.announcements.all 
# Id'si verilen ses dosyasının detayları
puts bulutfon.announcements.get(1)
# Ses dosyası oluşturma
file = "#{File.expand_path(File.dirname(__FILE__))}/test.wav"
params = {
    name: 'Deneme',
    announcement: file
}
puts bulutfon.announcements.create(params)
# Id'si verilen ses dosyasını indirme işlemi
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_test.wav"
puts bulutfon.announcements.save(1, save_path)
# Id'si verilen ses dosyasını silme
puts bulutfon.announcements.delete(1)
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
# Zaman planlı automatic call oluşturulur ve oluşturmadan sonra receivers numaraları 
# perşembe günü saat 10:15 ile 12:00 arasında aranır
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
# Panelden oluşturduğunuz sms başlıklarını listeler
puts bulutfon.message_titles.all 
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

## Hash cevapları OpenStruct objesine dönüştürme

### Hesap
```ruby
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
# Hesap detaylarını hash olarak gösterir
puts bulutfon.details
# Örnek bir hesap detayları sonucu
details = {
    'user' =>{
        'email' => 'test@bulutfon.com', 'name' => 'BULUTFON', 'gsm' => 'XXXXXXXXXXXX'
    },
    'pbx' =>{
        'name' => 'test', 'url' => 'test.com', 'state' => 'CONFIRMED', 'package' => 'ENTERPRISE', 'customer_type' => 'CORPORATE'
    },
    'credit' =>{
        'balance' => '10.00', 'sms_credit' => 0
    }
}
# to_obj bizim hash sonuçları için tanımladığımız yardımcı metodumuz 
detail_object = bulutfon.details.to_obj
puts detail_object
# Object örneği
=begin
#<OpenStruct
  user=#<OpenStruct email="test@bulutfon.com", name="BULUTFON", gsm="XXXXXXXXXXXX">,
  pbx=#<OpenStruct name="test", url="test.com", state="CONFIRMED", package="ENTERPRISE", customer_type="CORPORATE">,
  credit=#<OpenStruct balance="10.00", sms_credit=0>>
=end
# Obje üzerinden alanlara şu şekilde ulaşabilirsiniz
puts detail_object.user.email
puts detail_object.user.name
puts detail_object.pbx.name
puts detail_object.pbx.url
puts detail_object.credit.balance
puts detail_object.credit.sms_credit
```

## Gruplar için örnek
```ruby
group_sdk   = BulutfonSDK::REST::Group.new(token)
obj_result  = group_sdk.all.to_obj
=begin
#<OpenStruct
  groups=[
    #<OpenStruct id=1, number=11, name="Ofis - İstanbul", timeout=30>,
    #<OpenStruct id=2, number=22, name="Ofis - Denizli", timeout=30>,
    #<OpenStruct id=3, number=33, name="İngilizce", timeout=30>
  ]>
=end
obj_result.groups.each do |group|
  puts group.name
end
```

### Credits
* ruby_sdk is maintained by [Lab2023](http://lab2023.com/) & [Bulutfon](https://www.bulutfon.com/)
* Thank you to all the contributors!
* The names and logos for Bulutfon are trademarks of Bulutfon
