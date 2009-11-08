module Spree::Search
 class Xapit
   # method should return hash with conditions {:conditions=> "..."} for Product model
   def get_products_conditions_for(query)
     products = Product.search(query)
     @suggestion = products.spelling_suggestion
     ids = products.map { |p| p.id }
     {:conditions=> ["products.id IN (?)", ids]}
   end
   
   def spelling_suggestion
     @suggestion
   end   
 end
end
