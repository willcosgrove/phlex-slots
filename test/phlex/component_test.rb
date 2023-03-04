require "phlex"
require "phlex/slots"

class MyComponent < Phlex::HTML
  include Phlex::Slots

  slot :title

  def template
    div(**slot[:title].attributes, &slot[:title])
  end
end

test "MyComponent is a Phlex::DeferredRender" do
  assert(Phlex::DeferredRender === MyComponent.new)
end

test "slots can be set via the initializer" do
  component = MyComponent.new(title: "Hello")
  expect(component.call) == "<div>Hello</div>"
end

test "slots can be set via a block" do
  component = MyComponent.new
  expect(component.call { |c| c.title { "From Block" } }) == "<div>From Block</div>"
end

test "slots set via a block can also accept arbitrary attributes" do
  component = MyComponent.new
  expect(
    component.call do |c|
      c.title(class: "custom-class") { "From Block" }
    end
  ) == %{<div class="custom-class">From Block</div>}
end

test ".slots returns a hash of slots" do
  expect(MyComponent.slots) == { title: false }
end

class MyChildComponent < MyComponent
  slot :child_slot

  def template
    h1(**slot[:title].attributes, &slot[:title])
    div(**slot[:child_slot].attributes, &slot[:child_slot])
  end
end

test "slots work fine with inheritance" do
  component = MyChildComponent.new
  expect(
    component.call do |c|
      c.title(class: "text-xl") { "My Title" }
      c.child_slot { "Child slot" }
    end
  ) == %{<h1 class="text-xl">My Title</h1><div>Child slot</div>}

  assert(MyChildComponent.slots.key? :title)
  assert(MyChildComponent.slots.key? :child_slot)

  component = MyChildComponent.new(title: "String title", child_slot: "Child string")
  expect(component.call) == %{<h1>String title</h1><div>Child string</div>}
end

class MyChildChildComponent < MyChildComponent
  slot :child_child_slot
end

test "slots work with multiple levels of inheritance" do
  expect(MyChildChildComponent.slots.size) == 3
end