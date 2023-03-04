require "phlex"
require "phlex/slots"
require "phlex/testing/view_helper"
include Phlex::Testing::ViewHelper

class Component < Phlex::HTML
  include Phlex::Slots
  slot :title

  def template
    h1 { slot[:title] }
  end
end

test "A slot can be rendered without passing it as a block, or without calling render" do
  expect(render Component.new(title: "Hello")) == "<h1>Hello</h1>"
end