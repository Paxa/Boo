require "./client"

client = Boo::Client.new('127.0.0.1', 9292)

p client.get('/storages')
p client.put('/some_file', 'ssdadadas')
p client.delete('/some_file')
p client.get('/some_file')


p client.put('/some_file2', '12345' * 1000)
p client.size_of('/some_file2')
p client.stat('/some_file2')
p client.delete('/some_file2')


p client.put('/tmp/stuff', '12345' * 1000)
p client.size_of('/tmp/stuff')
p client.stat('/tmp/stuff')
#p client.delete('/tmp/stuff')

p client.put('/base/stuff', '12345' * 1000)
p client.size_of('/base/stuff')
p client.stat('/base/stuff')

p client.put('/cache/stuff', '12345' * 1000)
p client.size_of('/cache/stuff')
p client.stat('/cache/stuff')
