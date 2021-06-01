require 'bunny'

connection = Bunny.new(host: "172.17.0.2")
connection.start

channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)

channel.prefetch(1)
puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts " [x] Received #{body}"
    # imitate some work
    sleep body.count('.').to_i
    puts ' [x] Done'
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close

  exit(0)
end