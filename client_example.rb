require "./client"

client = Boo::Client.new('127.0.0.1', 9292)

p client.get('/storages')
p client.put('/some_file', 'ssdadadas')
p client.delete('/some_file')
p client.size_of('/boo.rb')