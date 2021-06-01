require 'bunny'

connection = Bunny.new(host: "172.17.0.2")
connection.start

channel = connection.create_channel

queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

channel.default_exchange.publish(message, routing_key: queue.name, persistent: true)
puts " [x] Sent 'Hello World!'"

connection.close