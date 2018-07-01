require 'rulers/version'
require 'rulers/array'
require 'rulers/routing'
# main gem module
module Rulers
  # app class
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      if controller.respond_to?(act)
        text = controller.send(act)
        [200, { 'Content-Type' => 'text/html' }, [text]]
      else
        [404, { 'Content-Type' => 'text/html' }, ['page missing']]
      end
    end
  end

  # basic controller
  class Controller
    attr_reader :env
    def initialize(env)
      @env = env
    end
  end
end
