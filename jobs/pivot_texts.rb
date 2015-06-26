offices_yaml = File.read('offices.yml')
offices = Offices.load(offices_yaml)

text_message_fetcher = TextMessageFetcher.new(
  ENV['PIVOTS_TEXTS_URL'],
  ENV['PIVOTS_TEXTS_BASIC_USERNAME'],
  ENV['PIVOTS_TEXTS_BASIC_PASSWORD']
)

SCHEDULER.every '1m', first_in: 0 do
  pivot_texts_by_location = text_message_fetcher.get.group_by { |pt| pt["pivotLocation"] }

  offices.each do |office|
    messages = pivot_texts_by_location[office.config["name"]]

    send_event("pivot_texts_#{office.code}", { pivot_texts: messages, phone_number_for_text_messages: ENV['PIVOTS_TEXTS_PHONE_NUMBER'] })
  end
end
