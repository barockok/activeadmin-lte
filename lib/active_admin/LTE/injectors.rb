module ActiveAdmin
  module LTE
    module Injectors
      Dir[File.expand_path('../injectors', __FILE__) + "/**/*.rb"].sort.each{ |f| require f }
    end
  end
end
