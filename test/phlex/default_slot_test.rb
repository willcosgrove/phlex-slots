require "phlex"
require "phlex/slots"
require "phlex/testing/view_helper"
include Phlex::Testing::ViewHelper

class Alert < Phlex::HTML
  include Phlex::Slots

  slot :title
  default_slot :body

  def template
    div(class: "alert") do
      h1(&slot[:title])
      render slot[:body]
    end
  end
end

class MyView < Phlex::HTML
  def template
    render(Alert.new) do |a|
      a.title { "My Title" }
      h1 { "Hello alert" }
      div { " ok" }
    end
  end
end

test "default slots" do
  expect(
    render(MyView.new)
  ) == %(<div class="alert"><h1>My Title</h1><h1>Hello alert</h1><div> ok</div></div>)
end

test "you cannot define two default slots" do
  expect {
    class BadComponent < Phlex::HTML
      include Phlex::Slots

      default_slot :slot_1
      default_slot :slot_2
    end
  }.to_raise Phlex::Slots::MoreThanOneDefaultSlotError
end