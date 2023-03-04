require "phlex"
require "zeitwerk"

module Phlex::Slots
  Loader = Zeitwerk::Loader.new.tap do |loader|
    loader.push_dir("#{__dir__}/slots", namespace: Phlex::Slots)
		loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
    loader.setup
  end

  class Error < StandardError; end
  class MoreThanOneDefaultSlotError < Error; end

  def self.included(base)
    base.include(Phlex::DeferredRender)
    base.extend(ClassMethods)
    base.prepend(Initializer)
  end

  def slot = @__slots__

  def format_object(object)
    case object
    when Slot
      unsafe_raw(object.call)
    else
      super
    end
  end
end
