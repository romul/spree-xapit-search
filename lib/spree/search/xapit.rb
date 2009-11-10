module Spree::Search
  class Xapit < Base
    # method should return hash with conditions {:conditions=> "..."} for Product model
    def get_products_conditions_for(query)
      conditions = {:individual_sale => true, :deleted_at => nil,
                    :available_on => 5.years.ago..Time.zone.now }
      conditions.merge!(:taxon_ids => [taxon_id]) if taxon_id && taxon_id > 0

      products = Product.search(query, 
        :conditions => conditions,
        :facets => @properties[:facets_hash])

      @properties[:spelling_suggestion] = products.spelling_suggestion
      @properties[:facets] = products.facets

      {:conditions=> ["products.id IN (?)", products.map(&:id)]}
    end

    def prepare(params)
      @properties[:facets_hash] = params[:facets]
      @properties[:taxon_id] = params[:taxon].to_i
    end
  end
end
