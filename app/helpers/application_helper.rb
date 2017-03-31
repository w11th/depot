module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    attributes['style'] = "display: none" if condition
    content_tag('div', attributes, &block)
  end

  CURRENCY_EXCHANGE_RATE = Hash.new(1)
  CURRENCY_EXCHANGE_RATE['es'] = 1.3
  def currency_to_locale(price)
    price *= CURRENCY_EXCHANGE_RATE[I18n.locale.to_s]
    number_to_currency price
  end
end
