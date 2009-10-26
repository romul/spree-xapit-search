# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class XapitSearchExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/xapit_search"

  # Please use xapit_search/config/routes.rb instead for extension routes.

  def self.require_gems(config)
    config.gem 'xapit'
  end
  
  def activate
    require 'xapit'
    
    Product.class_eval do
      xapit do |index|
        index.text :name, :description
      end
    end
    
    Spree::Config.searcher = Spree::Search::Xapit.new
    
  end
end
