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
        index.field :individual_sale, :deleted_at, :available_on, :count_on_hand, :taxon_ids
        index.facet :gender_property, "Gender"
        index.facet :brand_property, "Brand"
        index.facet :price_range, "Price"
        index.facet :taxon_names, "Taxon"
      end
      
      def taxon_ids
        taxons.map(&:id)
      end
      
      private
      
      def gender_property
        gender = product_properties.detect {|pp| pp.property.name == "gender"}
        gender ? gender.value : ""
      end
      
      def brand_property
        brand = product_properties.detect {|pp| pp.property.name == "brand"}
        brand ? brand.value : ""
      end
      
      def taxon_names
        taxons.map(&:name)
      end
      
      def price_range
        case price
          when 0..25
            "Under $25"
          when 25..50
            "$25 to $50"
          when 50..100
            "$50 to $100"
          when 100..200
            "$100 to $200"
          else
            "$200 & Above"
        end
      end
    end
    
    Spree::Config.searcher = Spree::Search::Xapit.new
    
  end
end
