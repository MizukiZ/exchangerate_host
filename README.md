# ExchangerateHost

ExchangerateHost is a very simple gem to integrate your ruby application with [exchangerate.host](https://exchangerate.host).

## Installation
Install with the following command:

    $ gem install exchangerate_host

For rails appliactions, add this line to your application's Gemfile:

```ruby
gem 'exchangerate_host'
```

And then execute:

    $ bundle install
    
## Supported API endpoints
| Service | Supported |
| ------------- |:-------------:|
| Latest rates | ✔️ |
| Convert currency | ✔️ |
| Historical rates | ✔️ |
| Time-Series data | ✔️ |
| Fluctuation data | ✔️ |
| Supported symbols | ✔️ |
| EU VAT Rates | WIP |

You can find details about services in here https://exchangerate.host/#/#our-services
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
| Convert currency | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - |
| Convert currency | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🔴 | - | - |
| Time-Series data | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - | 🔴 | 🔴 |
| Fluctuation data | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | - | - | - | 🔴 | 🔴 |
| Supported symbols | - | - | - | - | 🟢 | - | - | - | - | - |

## Setup default parameter options




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/exchangerate_host.

