module Spree::Search
  class Xapit < Spree::Search::Base
    # method should return hash with conditions {:conditions=> "..."} for Product model
    def get_products_conditions_for(query)
      conditions = {:deleted_at => nil, :available_on => 5.years.ago..Time.zone.now }
      conditions.merge!(:individual_sale => true) if Product.column_names.include?("individual_sale")
      conditions.merge!(:taxon_ids => taxon.self_and_descendants.map(&:id)) if taxon

      not_conditions = Spree::Config[:allow_backorders] ? {} : { :count_on_hand => 0 }

      search_options = {:conditions => conditions,
                        :not_conditions => not_conditions,
                        :per_page => per_page,
                        :page => page,
                        :facets => @properties[:facets_hash]}
      if order_by_price
        search_options.merge!(:order => [:price], :descending => order_by_price == 'descend')
      end
      products = Product.search(query, search_options)

      @properties[:products] = products
      @properties[:spelling_suggestion] = products.spelling_suggestion
      @properties[:facets] = products.facets

      {:conditions=> ["products.id IN (?)", products.map(&:id)]}
    end

    def prepare(params)
      @properties[:facets_hash] = params[:facets]
      @properties[:taxon] = params[:taxon].blank? ? nil : Taxon.find(params[:taxon])
      @properties[:per_page] = params[:per_page]
      @properties[:page] = params[:page]
      @properties[:manage_pagination] = true
      @properties[:order_by_price] = params[:order_by_price]
    end
  end
end
