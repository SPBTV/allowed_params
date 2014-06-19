require 'rails_helper'

describe AllowedParams::ValidatorBuilder do
  let(:controller) { double(name: 'TheController') }
  before do
    @builder = AllowedParams::ValidatorBuilder.new controller
    @builder.validate :foo, presence: true
  end

  it 'should be valid' do
    validator = @builder.validator.new(foo: 1)

    expect(validator).to be_valid
  end

  it 'should not be valid' do
    validator = @builder.validator.new(foo: nil)

    expect(validator).not_to be_valid
  end

  it 'should render validation message' do
    validator = @builder.validator.new(foo: nil)
    validator.valid?

    expect(validator.errors.full_messages).to contain_exactly 'Foo field is required.'
  end

end
