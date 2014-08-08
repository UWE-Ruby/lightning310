module ApplicationHelper

  def sort_link options = {}
    return options[:header_text] if options[:sort_column].to_s.include? "no_link"
    link_to options[:header_text], {sort_column: options[:sort_column]}
  end
end
