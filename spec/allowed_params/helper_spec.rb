require 'rails_helper'
AllowedParams.config.allowed_params = [:format]
describe AllowedParams::Helper, type: :controller do
  context :allowed_params do
    controller ApplicationController do
      include AllowedParams::Helper

      allowed_params do
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

  context :validated_params do
    controller ApplicationController do
      include AllowedParams::Helper

      validated_params do
        validate :name, presence: true
        validate :position, inclusion: { in: %w(manager developer) }
      end

      def index
        render text: 'ok'
      end
    end

    it 'raise error if param is invalid' do
      expect {
        get :index
      }.to raise_error(AllowedParams::ValidationError)
      expect {
        get :index, name: 'John', position: 'tester'
      }.to raise_error(AllowedParams::ValidationError)
    end

    it 'do not raise error if param is valid' do
      expect {
        get :index, name: 'John', position: 'developer'
      }.not_to raise_error
    end

    it 'not raise error for not validated params' do
      expect {
        get :index, name: 'John', surname: 'Doe', position: 'manager'
      }.not_to raise_error
    end
  end
end
