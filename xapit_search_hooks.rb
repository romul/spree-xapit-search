class XapitSearchHooks < Spree::ThemeSupport::HookListener
  insert_before :search_results, 'shared/suggestion'
end


