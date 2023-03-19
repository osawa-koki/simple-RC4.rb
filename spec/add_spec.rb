
require_relative '../app/add'

RSpec.describe 'add' do
  it 'returns the sum of arguments' do
    expect(add(1, 2)).to eq(3)
    expect(add(-5, 5)).to eq(0)
  end
end
