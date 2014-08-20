# AllowedParams

## Installation

This project uses [semantic versioning](http://semver.org/spec/v2.0.0.html).

Add it to your Gemfile:

```ruby
gem 'allowed_params'
```

And then execute:

```sh
$ bundle
```

Or install it yourself with:

```sh
$ gem install allowed_params
```


## Usage

This gem provides filtering and validations of params

## Params validation with whitelist
 
```ruby

    class EmployersController < ApplicationController
        include AllowedParams::Helper
        
        params whitelist: true do
            validates :id, presence: true
            validates :name, presence: true
            validates :position, inclusion: { in: %w(manager developer) }
        end
        def update
            # do the job
        end        
    end
    
```
 
This will validate listed params and raise `AllowedParams::ValidationError` in case of invalid value.
All other params are not allowed, and `AllowedParams::NotAllowedError` will be raised if present.
You can use any of [ActiveModel::Validations](http://api.rubyonrails.org/classes/ActiveModel/Validations.html)' validators.

To allow params on all controllers:
 
```ruby 

    AllowedParams.config.allowed_params = [:format]

```   

## Just validation   
   
```ruby    
    class CatsController < ApplicationController
        include AllowedParams::Helper
        
        params do
            validates :name, presence: true
            validates :kind, inclusion: { in: %w(fluffy bald) }
        end
        def update
            # do the job
        end        
    end
    
```

This will validate `params[:name], params[:kind]` and raise `AllowedParams::ValidationError` in case of invalid value.
All other params will just go through without any checks.

This project rocks and uses MIT-LICENSE.
