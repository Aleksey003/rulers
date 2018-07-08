require 'rulers/version'
require 'rulers/array'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'

# main gem module
module Rulers
  # app class
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      return render_missing_response unless klass
      controller = klass.new(env)
      render_controller_action(controller, act)
    rescue NameError
      render_missing_response
    end

    def render_controller_action(controller, act)
      if controller.respond_to?(act)
        text = controller.send(act)
        render_response(text)
      else
        render_missing_response
      end
    end

    def render_missing_response
      [404, { 'Content-Type' => 'text/html' }, ['page missing']]
    end

    def render_response(text)
      [200, { 'Content-Type' => 'text/html' }, [text]]
    end
  end
end
