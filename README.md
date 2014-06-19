# AllowedParams

This gem provides filtering and validations of params

## Allowed params
 
```ruby

    class DogsController < ApplicationController
        include AllowedParams::Helper
        
        allowed_params do
            allow :name, presence: true
            allow :age
            allow :id
        end
        def update
            # do the job
        end        
    end
    
```
 
This will validate `params[:name]` and raise `AllowedParams::ValidationError` in case of invalid value.
`age` param is allowed and not validated. All other params is not allowed, and `AllowedParams::NotAllowedError`
will be raised if present.

To allow params on all controllers:
 
```ruby 

    AllowedParams.config.allowed_params = [:format]

```   

## Validated params   
   
```ruby    
    class CatsController < ApplicationController
        include AllowedParams::Helper
        
        validated_params do
            validates :name, presence: true
            validates :kind, inclusion: { in: %w(fluffy bald) }
        end
        def update
            # do the job
        end        
    end
    
```

This will validate `params[:name], params[:kind]` and raise `AllowedParams::ValidationError` in case of invalid value.

This project rocks and uses MIT-LICENSE.

