require "capybara-select2/version"
require 'rspec/core'

module Capybara
  module Select2
    def select2(value, options = {})
      raise "Must pass a hash containing 'from'" if not options.is_a?(Hash) or not options.has_key?(:from)
      select_name = options[:from]


      select2_container = find(".select2-choice", text: select_name).click

      find(".select2-drop li", text: value).click
    end

    def select2_create_choice(value, options = {})
      raise "Must pass a hash containing 'from'" if not options.is_a?(Hash) or not options.has_key?(:from)
      select_name = options[:from]

      page.execute_script %Q{$('#{select_name}').select2('open')}
      page.execute_script "$('input.select2-input').val('#{value}').trigger('keyup-change');"
      sleep(1)
      page.execute_script(%Q{$("div.select2-result-label:contains('#{value}')").mouseup()})
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::Select2
end
