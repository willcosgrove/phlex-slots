require "phlex/slots"

include Phlex::Slots

test "slot is a class" do
  expect(Slot.class) == Class
end

test "you can create an empty slot" do
  assert Slot.new
end

test "you can create a slot with content" do
  assert Slot.new(content: -> { "My content" })
end

test "you can create a slot with attributes" do
  assert Slot.new(attributes: { class: "foo" })
end

test "a slot can be coerced into a proc" do
  slot = Slot.new
  assert slot.respond_to? :to_proc
  expect(slot).to_receive(:to_proc) do
    @super.call
  end

  Object.new.tap(&slot)
end