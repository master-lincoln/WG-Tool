module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end
  
  def euro(price)
  	raw ( "%05.2f &euro;" % price )
  end
end
