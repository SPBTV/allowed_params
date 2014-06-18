require 'rails_helper'
AllowedParams.config.allowed_params = [:format]
describe AllowedParams::Helper, type: :controller do
  controller ApplicationController do
    include AllowedParams::Helper

    params do
      allow :name, presence: true
      allow :age
    end
    def index
      render text: 'ok'
    end
  end

  it 'raise error if param is invalid' do
    expect {
      get :index
    }.to raise_error(AllowedParams::ValidationError)
  end

  it 'do not raise error if param is valid' do
    expect {
      get :index, name: 'John'
    }.not_to raise_error
  end

  it 'raise error if param is not allowed' do
    expect {
      get :index, name: 'John', surname: 'Doe'
    }.to raise_error(AllowedParams::NotAllowedError)
  end

  it 'read ignored params from config' do
    expect {
      get :index, name: 'John', format: 'json'
    }.not_to raise_error
  end

  it 'allow param without validation' do
    expect {
      get :index, name: 'John', age: 18
    }.not_to raise_error
  end
end
