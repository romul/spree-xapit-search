module Spree::Search
 class Xapit
   # method should return hash with conditions {:conditions=> "..."} for Product model
   def get_products_conditions_for(query)
     ids = Product.search(query).map { |p| p.id }
     {:conditions=> ["products.id IN (?)", ids]}
   end  
 end
end
