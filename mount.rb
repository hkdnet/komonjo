# https://gist.github.com/jamiehodge/2351768
# thanks @jamiehodge
module Sinatra
  # routing to other class
  module Mount
    def mount(app, route = "/#{app.name.downcase}")
      %w(get post put delete patch options).each do |method|
        send method.to_sym, "#{route}*" do
          app.call(
            env.merge!(
              'SCRIPT_NAME' => route.split('/').last,
              'PATH_INFO'   => params.delete('splat').join('/')
            )
          )
        end
      end
    end
  end
  register Mount
end
