[![Build Status](https://travis-ci.org/SPBTV/allowed_params.svg?branch=master)](https://travis-ci.org/SPBTV/allowed_params)

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

## Contributing

1. Fork it ( https://github.com/SPBTV/allowed_params )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

##License

Copyright 2014 SPB TV AG

Licensed under the Apache License, Version 2.0 (the ["License"](LICENSE)); you may not use this file except in compliance with the License.

You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 

See the License for the specific language governing permissions and limitations under the License.
