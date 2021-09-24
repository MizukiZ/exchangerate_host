# ExchangerateHost

ExchangerateHost is a very simple gem to integrate your ruby application with [exchangerate.host](https://exchangerate.host) 🚀  
[exchangerate.host](https://exchangerate.host) is a great service that provide us completely free curreny exhange rates APIs (you don't even need to make an account & api key!! Really easy to get started 🙂 ).  
  
Let's [support](https://exchangerate.host/#/donate) their mission if you're happy with the service and willing to donate 👼

## Installation
Install with the following command:

    $ gem install exchangerate_host

For rails appliactions, add this line to your application's Gemfile:

```ruby
gem 'exchangerate_host'
```

And then execute:

    $ bundle install
    
## Supported services
| Service | Descriptoin | Supported |
| ------------- | ------ |:-------------:|
| Latest rates | The latest exchage rate data updated on daily basis | ✔️ |
| Convert currency | Convert any amount from one currency to another | ✔️ |
| Historical rates | Currency rates histrical data all the way back to the year of `1999` | ✔️ |
| Time-Series data | Historical rates between two dates of your choic. (maximum time frame of `366 days`) | ✔️ |
| Fluctuation data | Historical data about how currencies fluctuate on a day-to-day basis (maximum time frame of `366 days`) | ✔️ |
| Supported symbols | All available currencies | ✔️ |
| EU VAT Rates | Request a single by country code or entire set EU VAT rates | WIP |

You can find details about services in [here](https://exchangerate.host/#/#our-services)
## Parameters
| Parameter | Description | Example | Note |
| ------------- |:-------------:| :---: | :-----: |
| base | Your preferred base currency | JPY | non case sensitive |
| symbols | Currency codes to limit output currencies | [:JPY, :AUD, :USD] | non case sensitive |
| amount | The amount to be converted | 123.45 | - |
| places | Decimal places | 2 | - |
| format | Output format | CSV | CSV, TSV or XML |
| from | The currecny you would like to convert from | JPY | non case sensitive |
| to | The currecny you would like to convert to | AUD | non case sensitive |
| date | Historical exchange rate date | 2020-12-21 | format YYYY-MM-DD |
| start_date | The start date of your preferred timeframe | 2020-12-21 | format YYYY-MM-DD |
| end_date | The end date of your preferred timeframe | 2020-12-21 | format YYYY-MM-DD |

## Service Paramters 
🟢 _optional_  🔴 _required_
| Service | base | symbols | amount | places | format | from | to | date | start_date | end_date |
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| Latest rates | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - | - | - |
| Convert currency | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🔴 | 🔴 | 🟢 | - | - |
| Historical rates | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | 🔴 | - | - |
| Time-Series data | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - | 🔴 | 🔴 |
| Fluctuation data | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - | 🔴 | 🔴 |
| Supported symbols | - | - | - | - | 🟢 | - | - | - | - | - |
  
  
If `base` option is not given, `EUR` will be assigned  
If `amount` option is not given, `1` will be assigned  
  
## Usage
You can make call supporetd survices with following APIs
| Service | method | arguments |
| ------------- |:-------------:| :-------------:|
| Latest rates | ExchangerateHost.latest_rates(options) | options: Hash |
| Convert currency | ExchangerateHost.convert_currency(options) | options: Hash |
| Historical rates | ExchangerateHost.historical_rates(options) | options: Hash |
| Time-Series data | ExchangerateHost.time_series(options) | options: Hash |
| Fluctuation data | ExchangerateHost.fluctuation(options) | options: Hash |
| Supported symbols |ExchangerateHost.supported_symbols(options) | options: Hash |
   
  
  
_exmaples_
```ruby
  # Decimal place 2
  ExchangerateHost.configurations.places = 2

  # How much is 1000 yen in AUD and USD with the latest currency rates
  res = ExchangerateHost.latest_rates({ base: :JPY, amount: 1000, symbols: [:AUD, :USD] })
  res['rates'] #=> {"AUD"=>12.59, "USD"=>9.1}
    
  # How much is 150 AUD in JPY on 2015 December 21st
  res = ExchangerateHost.convert_currency({ from: :AUD, to: :JPY, date: '2015-12-21', amount: 150 })
  res['result'] #=> 13038.47
    
  # What were the all supported currency rates for 1 AUD on 2020 December 21st
  res = ExchangerateHost.historical_rates({date: '2020-12-21', base: :AUD })
  res['rates'] #=> { "AED"=>3.69, "AFN"=>77.4, "ALL"=>101.52... }
    
  # What were the JPY and USD rates based on 1 AUD between 2021 January 1st ~ 2021 Febrary 1st
  res = ExchangerateHost.time_series({ base: :AUD, symbols: [:JPY, :USD], start_date: '2021-01-01', end_date: '2021-02-01' })
  res['rates'] #=> {"2021-01-01"=>{"JPY"=>79.56, "USD"=>0.77}, "2021-01-02"=>{"JPY"=>79.29, "USD"=>0.77}, "2021-01-03"=>{"JPY"=>79.42, "USD"=>0.77},... }
    
  # How much JPY and USD rates based on 1 AUD fluctuated between 2020 January 1st ~ 2020 October 1st
  res = ExchangerateHost.fluctuation({ base: :AUD, symbols: [:JPY, :USD], start_date: '2020-01-01', end_date: '2020-10-01' })
  res['rates'] #=> {"USD"=>{"start_rate"=>0.7, "end_rate"=>0.72, "change"=>-0.02, "change_pct"=>-0.03}, "JPY"=>{... }
    
  # What are the suported currencies
  res = ExchangerateHost.supported_symbols
  res['symbols'] #=> {"AED"=>{"description"=>"United Arab Emirates Dirham", "code"=>"AED"}, "AFN"=>{"description"=>"Afghan Afghani", "code"=>"AFN"}... }
```

## Setup default parameter options
You can set default parameter options so that you don't need to pass the same options everytime.  
```ruby
  ExchangerateHost.configure do |conf|
    conf.base = :JPY
    conf.symbols = [:AUD, :USD]
  end
  # or
  ExchangerateHost.configurations.base = :JPY
    
  # print currernt configuratoins
  ExchangerateHost.configurations.to_options_hash #=> {:base=>:JPY, :symbols=>[:AUD, :USD]}
      
  # reset configurations
  ExchangerateHost.reset_configurations
  ExchangerateHost.configurations.to_options_hash #=> {}
    
  # default options will be overwritten by the passed option value
  ExchangerateHost.configurations.base = :JPY
  
  ExchangerateHost.latest_rates #=> the base option for the request is JPY
  ExchangerateHost.latest_rates({ base: :AUD }) #=> the base option for the request is now AUD
```



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MizukiZ/exchangerate_host. 🙏

