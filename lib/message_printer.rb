module MessagePrinter
  
  SCREEN_SIZE = 80
  POUND = "#"
  COLOR = "\e[36m"
  
  def print_message(message, options = {})
    puts format_message(message, options)
  end
  
  def format_message(message, options = {})
    
    message_size = message.size + 2
    color = options.fetch(:color, COLOR)
    pounds_count = ((SCREEN_SIZE - message_size ) / 2)
    pounds = options.fetch(:pound, POUND) * pounds_count
    
    pre = "\n\n\e[1m#{color}\e[7m#{pounds}#{message.size.odd? ? POUND : ''}"
    post = "#{pounds}\e[m\e[m\e[m"
    
    "#{pre} #{message} #{post}"
  end
  
end