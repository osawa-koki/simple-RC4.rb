require_relative '../app/RC4'

def generate_random_string(length)
  charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  result = ''
  length.times do
    result += charset[rand(charset.length)]
  end
  result
end

RSpec.describe "RC4 Encrypt Decrypt Test" do
  describe '#encrypt and #decrypt' do
    it 'should encrypt and decrypt message with the same key' do
      100.times do
        message = generate_random_string(20)
        key = generate_random_string(10)
        encrypted_message = encrypt(message, key)
        decrypted_message = decrypt(encrypted_message, key)

        expect(decrypted_message).to eq(message)
      end
    end

    it 'should not decrypt message with a different key' do
      100.times do
        message = generate_random_string(20)
        key = generate_random_string(10)
        encrypted_message = encrypt(message, key)
        different_key = generate_random_string(10)
        next if different_key == key
        decrypted_message = decrypt(encrypted_message, different_key)

        expect(decrypted_message).not_to eq(message)
      end
    end
  end
end
