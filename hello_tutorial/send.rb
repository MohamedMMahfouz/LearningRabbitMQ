require 'bunny'

connection = Bunny.new(host: "172.17.0.2")
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

channel.default_exchange.publish('Hello World!', routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

connection.close