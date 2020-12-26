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

  def layout_value(key, options = {})
    options = {
      default_value_key: "#{controller.controller_name}.#{controller.action_name}.#{key}",
      decorator_key: "layout.#{key}.format",
      default_decorator_key: "layout.#{key}.default",
    }.merge(options)

    # Read the value
    value = if content_for?(key)
              content_for(key)
            else
              t(options[:default_value_key], default: "")
            end

    # Decorate
    value = if value.present?
              t(options[:decorator_key], key.to_sym => value, default: value)
            else
              t(options[:default_decorator_key], default: value)
            end

    # Translation helpers tend to add HTML
    sanitize value
  end
end
