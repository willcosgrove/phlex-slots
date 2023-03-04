module Phlex::Slots
  module ClassMethods
    def inherited(base)
      base.instance_variable_set(:@__slot_definitions__, slots.dup)
      super
    end

    def slot(slot_name, default_content = false)
      @__slot_definitions__ ||= {}
      @__slot_definitions__[slot_name] = default_content

      define_method slot_name do |**attributes, &content|
        @__slots__[slot_name] = Slot.new(attributes:, content:)
      end
    end

    def default_slot(slot_name)
      raise MoreThanOneDefaultSlotError if defined?(@__default_slot_defined__)

      @__slot_definitions__ ||= {}
      @__slot_definitions__[slot_name] = false
      @__default_slot_defined__ = true

      define_method :__vanish__ do |*, &block|
        content = capture(&block)
        @__slots__[slot_name] = Slot.new(content: proc { unsafe_raw(content) })
      end
    end

    def slots = @__slot_definitions__ || {}
  end
end