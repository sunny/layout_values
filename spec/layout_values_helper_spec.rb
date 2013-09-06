require_relative "../app/helpers/layout_values_helper"

# required for #present?
require "active_support/core_ext/string"

describe LayoutValuesHelper do
  include LayoutValuesHelper

  let(:controller) { double(:controller, controller_name: "pages", action_name: "index") }


  it "should set the title in content_for" do
    allow(self).to receive(:content_for)
    title "hi"
    expect(self).to have_received(:content_for).with(:title, "hi")
  end

  it "should return the title when it gets set" do
    allow(self).to receive(:content_for)
    expect(title("hi")).to eq("hi")
  end

  describe "with a content_for" do
    before do
      allow(self).to receive(:content_for?).with(:title) { true }
      allow(self).to receive(:content_for).with(:title) { "hi" }
    end

    it "should return the value through the format translation" do
      allow(self).to receive(:t).with("layout.title.format", title: "hi", default: "hi") { "hi - my site" }
      allow(self).to receive(:strip_tags).with("hi - my site") { "hi - my site" }
      expect(title).to eq("hi - my site")
    end
  end

  describe "with an empty content_for" do
    before do
      allow(self).to receive(:content_for?).with(:title) { true }
      allow(self).to receive(:content_for).with(:title) { "" }
    end

    it "should return the value through the default translation" do
      allow(self).to receive(:t).with("layout.title.default", default: "") { "default" }
      allow(self).to receive(:strip_tags).with("default") { "default" }
      expect(title).to eq("default")
    end
  end

  describe "without a content_for" do
    before do
      allow(self).to receive(:content_for?).with(:title) { false }
    end

    it "should return the title in the controller translation" do
      allow(self).to receive(:t).with("pages.index.title", default: "") { "translated" }
      allow(self).to receive(:t).with("layout.title.format", title: "translated", default: "translated") { "formatted translated" }
      allow(self).to receive(:strip_tags).with("formatted translated") { "formatted translated" }

      expect(title).to eq("formatted translated")
    end

    it "should return the default if no controller translation" do
      allow(self).to receive(:t).with("pages.index.title", default: "") { "" }
      allow(self).to receive(:t).with("layout.title.default", default: "") { "default" }
      allow(self).to receive(:strip_tags).with("default") { "default" }

      expect(title).to eq("default")
    end
  end
end

