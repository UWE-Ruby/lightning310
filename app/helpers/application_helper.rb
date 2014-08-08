module ApplicationHelper

  def sort_link options = {}
    header_text = options[:header_text]
    return header_text if options[:sort_column].to_s.include? "no_link"
    sort_order, header_text = get_sort_order_from header_text
    link = link_to header_text, {sort_column: options[:sort_column], sort_order: sort_order}
    link + get_arrow(sort_order)
  end

  def get_sort_order_from header_text
    header_and_sort = header_text.split("*")
    header_text = header_and_sort.first
    sort_order = header_and_sort[1]
    sort_order ||= "down"
    [sort_order, header_text]
  end

  def get_arrow sort_order
    glyph(:"chevron_#{sort_order}")
  end
end
