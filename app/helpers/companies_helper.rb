module CompaniesHelper

  #Function to render collapse class
  def collapse_class(index)
  	index == 0 ? "collapse in" : "collapse"
  end
end
