module Phlex::Slots
  module Initializer
    def initialize(*args, **attributes, &block)
      @__slots__ = {}
      unset_slots = []

      self.class.slots.each_key do |slot_name|
        if (slot_content = attributes.delete(slot_name))
          @__slots__[slot_name] = Slot.new(attributes: {}, content: proc { slot_content })
        else
          unset_slots << slot_name
        end
      end

      super(*args, **attributes, &block)

      # We wait until after super to set unset slot defaults so that the default definitions
      # can take advantage of any state set in the initializer
      unset_slots.each do |slot_name|
        next unless (default_content_proc = self.class.slots[slot_name])

        default_content = instance_exec(&default_content_proc)
        @__slots__[slot_name] = Slot.new(attributes: {}, content: proc { default_content })
      end
    end
  end
end