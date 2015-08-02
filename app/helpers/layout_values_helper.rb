# for #present?
require "active_support/core_ext/string"

module LayoutValuesHelper
  %i(title meta_description meta_keywords).each do |method|
    define_method method do |value = nil|
      if value.present?
        content_for method, value.html_safe.to_s
        value
      else
        layout_value(method)
      end
    end
  end


  private
  def layout_value(key)
    # Read
    if content_for?(key)
      value = content_for(key)
    else
      value = t("#{controller.controller_name}.#{controller.action_name}.#{key}", default: "")
    end

    # Decorate
    if value.present?
      value = t("layout.#{key}.format", key.to_sym => value, default: value)
    else
      value = t("layout.#{key}.default", default: value)
    end

    # Translation helpers tend to add HTML
    strip_tags value
  end

end
