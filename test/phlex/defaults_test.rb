require "phlex"
require "phlex/slots"

class FormControl < Phlex::HTML
  include Phlex::Slots

  # If you use a slot with the same name as an element, you'll need to use the _element alias
  slot :label, -> { @method.to_s.capitalize }
  slot :description

  def initialize(form, method)
    @form = form
    @method = method
  end

  def template
    div do
      # _label instead of label because label() is now the slot setter
      _label(**mix({class: "block"}, slot[:label].attributes), &slot[:label])
      input(name: "#{@method}")
      if slot[:description]
        p(class: "mt-2", &slot[:description])
      end
    end
  end
end

test "defaults work" do
  f = Object.new
  expect(FormControl.new(f, :title).call) == %{<div><label class="block">Title</label><input name="title"></div>}
end