# AllowedParams

This gem provides filtering and validations of params
 
```ruby

    class DogsController < ApplicationController
        include AllowedParams::Helper
        
        params do
            allow :name, presence: true
            allow :age
        end
        def update
            # do the job
        end 
    end
    
```

This will validate `params[:name]` and raise `AllowedParams::ValidationError` in case of invalid value.
`age` param is allowed and not validated. All other params is not allowed.

To allow params on all controllers:
 
```ruby 

    AllowedParams.config.allowed_params = [:format]

```

This project rocks and uses MIT-LICENSE.

