module Fcoin
  class Client
    include Fcoin::Request
    def initialize(key, sign)
      configuration(key, sign)
    end

    #传入参数: symbol为交易对, 例如 usdtbtc
    #返回参数中数组依次对应:
    #   "最新成交价",
    #   "最近一笔成交的成交量",
    #   "最大买一价",
    #   "最大买一量",
    #   "最小卖一价",
    #   "最小卖一量",
    #   "24小时前成交价",
    #   "24小时内最高价",
    #   "24小时内最低价",
    #   "24小时内基准货币成交量, 如 btcusdt 中 btc 的量",
    #   "24小时内计价货币成交量, 如 btcusdt 中 usdt 的量"
    def get_ticker(symbol)
      get("market/ticker/#{symbol}")
    end

    #传入参数:
    # level L20	20档行情深度.
    #       L100	100 档行情深度.
    #       full	全量的行情深度, 不做时间保证和推送保证.
    def get_depth(level, symbol)
      get("market/depth/#{level}/#{symbol}")
    end

    #返回历史成交
    def get_last(symbol)
      get "market/trades/#{symbol}"
    end

    # resolution:
    # M1:	1 分钟, M3:	3 分钟, M5:	5 分钟, M15:	15 分钟 M30	30 分钟 H1	1 小时 H4	4 小时 H6	6 小时 D1	1 日 W1	1 周 MN	1 月
    def get_candle(resolution, symbol)
      get "market/candles/#{resolution}/#{symbol}"
    end

    def get_balance
      get('accounts/balance')
    end

    #获取订单
    # states:
    # submitted	已提交
    # partial_filled	部分成交
    # partial_canceled	部分成交已撤销
    # filled	完全成交
    # canceled	已撤销
    # pending_cancel	撤销已提交
    def get_orders(symbol, states='submitted,filled', limit=100, before=nil, after=nil)
      get('orders', {
        symbol: symbol, states: states, limit: limit, before: before, after: after
        })
    end

    # symbol	交易对
    # side	交易方向 (buy, sell）
    # type	订单类型 (limit，market）
    # amount	下单量
    # price	价格
    def create_order(symbol, side, type, amount, price=nil)
      if type == "limit"
        post("orders", {
          symbol: symbol, side: side, type: type, price: price, amount: amount
          })
      elsif type == "market"
        post("orders", {
          symbol: symbol, side: side, type: type, amount: amount, price: 0
          })
      end
    end

    def cancel_order(order_id)
      post("orders/#{order_id}/submit-cancel")
    end

    def get_order_detail(order_id)
      get("orders/#{order_id}")
    end

    #查询指定订单的成交记录
    def get_order_results(order_id)
      get("orders/#{order_id}/match-results")
    end
  end
end  
