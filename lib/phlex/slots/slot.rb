module Phlex::Slots
  class Slot
    attr_reader :attributes, :content

    def initialize(attributes: {}, content: nil)
      @attributes = attributes
      @content = content
    end

    def to_proc = @content || proc {}
    def empty? = @content.nil?
  end
end