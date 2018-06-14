# Fcoin

Ruby wrapper for huobi api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fcoin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fcoin

## Usage
FCoin Api Document:   https://developer.fcoin.com/zh.html
```ruby
client = Fcoin::Client.new("8fd4dxxxxxxxxxx9e13d7bdffc0d", "0a14a91e7axxxxxxxxxxaa1d5b8befa")
# p client.get_balance
# p client.get_depth("L20", 'btcusdt')
# p client.get_last('btcusdt')
# p client.get_ticker('btcusdt')
# p client.get_candle("M1", "btcusdt")
# p client.get_last("fteth")
# p client.create_order('ftusdt', 'buy', 'limit', 10, 0.891)
# p client.get_orders("ftusdt")
# p client.cancel_order("3i06mrxxxxxxxxxxqF5wgKUOYK3ceru-w4RhMqU=")
# p client.get_order_detail("3i06xxxxxxxxxxt_0xqF5wgKUOYK3ceru-w4RhMqU=")
# p client.get_order_results("TqUfakhxxxxxxxxxxyZq9OQOMXO_zCFsT7G74_Lk1DJ2A=")
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fcoin/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
