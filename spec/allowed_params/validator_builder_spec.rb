require 'rails_helper'

describe AllowedParams::ValidatorBuilder do
  let(:controller) { double(name: 'TheController') }
  before do
    @builder = AllowedParams::ValidatorBuilder.new controller
    @builder.validates :foo, presence: true
  end

  it 'should be valid' do
    validator = @builder.validator.new(foo: 1)
    puts ">> #{@builder.validator.lookup_ancestors.inspect}"
    expect(validator).to be_valid
  end

  it 'should not be valid' do
    validator = @builder.validator.new(foo: nil)

    expect(validator).not_to be_valid
  end

  it 'should render validation message' do
    validator = @builder.validator.new(foo: nil)
    validator.valid?

    expect(validator.errors.full_messages).to contain_exactly "Foo can't be blank"
  end

  it 'returns not white listed params' do
    validator = @builder.validator.new(foo: 2, bar: 2)
    expect(validator.not_white_listed).to contain_exactly "bar"
  end


end
