require 'rails_helper'

describe AllowedParams::AllowerBuilder do
  let(:controller) { double(name: 'TheController') }
  before do
    @builder = AllowedParams::AllowerBuilder.new controller
    @builder.allow :foo, presence: true
  end

  it 'should be valid' do
    allower = @builder.allower.new(foo: 1)

    expect(allower).to be_valid
  end

  it 'should not be valid' do
    allower = @builder.allower.new(foo: nil)

    expect(allower).not_to be_valid
  end

  it 'should render validation message' do
    allower = @builder.allower.new(foo: nil)
    allower.valid?

    expect(allower.errors.full_messages).to contain_exactly 'Foo field is required.'
  end

  it 'returns not allowed params' do
    allower = @builder.allower.new(foo: 2, bar: 2)
    expect(allower.not_allowed).to contain_exactly "bar"
  end
end
