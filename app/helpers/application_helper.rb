module ApplicationHelper

  # def svg_embed(filename, options = {})
  #   assets = Rails.application.assets
  #   file = assets.find_asset(filename).source.force_encoding("UTF-8")
  #   doc = Nokogiri::HTML::DocumentFragment.parse file
  #   svg = doc.at_css "svg"
  #   if options[:class].present?
  #     svg["class"] = options[:class]
  #   end
  #   raw doc
  # end
  #
  #
  # def inline_svg(path)
    # raw Rails.application.assets.find_asset(path + '.svg').to_s
    # raw Rails.application.assets.find_asset(path).to_s
  # end

  #
  # def svg_embed filename, options={}
  #   file = File.read(Rails.root.join('app', 'assets', 'images', filename))
  #   doc = Nokogiri::HTML::DocumentFragment.parse file
  #   svg = doc.at_css 'svg'
  #   if options[:class].present?
  #     svg['class'] = options[:class]
  #   end
  #   doc.to_html.html_safe
  # end

  def imghelper ripeness
    if ripeness == 0
      # inline_svg "banana-green.svg"
      image_tag "green.png"
    elsif ripeness ==1
      # inline_svg "banana-yellowgreen2.svg"
      image_tag "yellowgreen.png"
    elsif ripeness == 2
      # inline_svg "banana.svg"
      image_tag "yellow.png"
    end
  end
end
