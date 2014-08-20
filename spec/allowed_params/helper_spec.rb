require 'rails_helper'
AllowedParams.config.allowed_params = [:format]

describe AllowedParams::Helper, type: :controller do

  context :params_with_whitelist do
    controller ActionController::Base do
      include AllowedParams::Helper

      params whitelist: true do
        validates :name, presence: true
        validates :age
      end

      def index
        render text: 'ok'
      end
    end

    it 'raise error if required params are not present' do
      expect {
        get :index
      }.to raise_error(AllowedParams::ValidationError)
    end

    it 'do not raise error if params are valid' do
      expect {
        get :index, name: 'John'
      }.not_to raise_error
      expect {
        get :index, name: 'John', age: 15
      }.not_to raise_error
    end

    it 'raise error if not white listed params passed' do
      expect {
        get :index, name: 'John', age: 15, surname: 'Doe'
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

  context :params_without_whitelist do
    controller ActionController::Base do
      include AllowedParams::Helper

      params do
        validates :name, presence: true
        validates :position, inclusion: { in: %w(manager developer) }
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

    it 'do not raise error if params are valid' do
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
