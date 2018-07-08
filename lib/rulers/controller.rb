require 'erubis'

module Rulers
  # basic controller
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      view_file = File.join('app', 'views', controller_name,
                            "#{view_name}.html.erb")
      template = File.read(view_file)
      Erubis::Eruby.new(template).result(locals.merge(env: env))
    end

    def controller_name
      klass = self.class.name.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end
  end
end
