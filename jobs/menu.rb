require 'kramdown'

markdown = <<MD
## Main

- Phish Tacos
- Everlasting Gobstoppers
- Something Else

## Accompaniments

- Soylent Green
- This is fake data
- Blue Cheese Wedge Salad, Side Bacon Bits + Shiitake Bacon Bits

## Dessert

- The cake is a lie
- So much dessert!

MD

html = Kramdown::Document.new(markdown).to_html

SCHEDULER.every '15s', :first_in => 0 do
  send_event('menu-nyc', { text: html })
end
