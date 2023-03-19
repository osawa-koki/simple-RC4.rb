require 'base64'

def ksa(key)
  s = (0..255).to_a
  j = 0
  256.times do |i|
    j = (j + s[i] + key[i % key.length]) % 256
    s[i], s[j] = s[j], s[i]
  end
  s
end

def prga(s)
  k = []
  i = 0
  j = 0
  while k.length < 256
    i = (i + 1) % 256
    j = (j + s[i]) % 256
    s[i], s[j] = s[j], s[i]
    k << s[(s[i] + s[j]) % 256]
  end
  k
end

def encrypt(data, key)
  _data = data.encode('utf-8').bytes
  _key = key.encode('utf-8').bytes
  s = ksa(_key)
  gen = prga(s)
  result = Array.new(_data.length)
  _data.each_with_index do |byte, i|
    result[i] = byte ^ gen[i]
  end
  Base64.strict_encode64(result.pack('C*'))
end

def decrypt(data, key)
  _data = Base64.decode64(data).bytes
  _key = key.encode('utf-8').bytes
  s = ksa(_key)
  gen = prga(s)
  result = Array.new(_data.length)
  _data.each_with_index do |byte, i|
    result[i] = byte ^ gen[i]
  end
  result.pack('C*').force_encoding('utf-8')
end
