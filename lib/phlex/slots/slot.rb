module Phlex::Slots
  class Slot < Phlex::SGML
    attr_reader :attributes, :content

    def initialize(attributes: {}, content: nil)
      @attributes = attributes
      @content = content
    end

    def template = yield_content(&@content)
    def to_proc = @content || proc {}
  end
end