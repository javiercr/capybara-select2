require "capybara-select2/version"
require 'rspec/core'

module Capybara
  module Select2
    def select2(value, options = {})
      raise "Must pass a hash containing 'from'" if not options.is_a?(Hash) or not options.has_key?(:from)
      select_id = options[:from].gsub(/#/, '') # If the id comes with #, we remove it
      select2_container = find("#s2id_#{select_id}").click
      page.document.find(".select2-drop-active li", text: value).click
    end

    def select2_create_choice(value, options = {})
      raise "Must pass a hash containing 'from'" if not options.is_a?(Hash) or not options.has_key?(:from)
      select_id = options[:from]

      page.execute_script %Q{$('#{select_id}').select2('open')}
      page.execute_script "$('input.select2-input').val('#{value}').trigger('keyup-change');"
      sleep(1)
      page.execute_script(%Q{$("div.select2-result-label:contains('#{value}')").mouseup()})
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::Select2
end
