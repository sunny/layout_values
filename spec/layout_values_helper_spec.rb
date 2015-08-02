require_relative "../app/helpers/layout_values_helper"
require "spec_helper"

describe LayoutValuesHelper do
  class MockView
    include LayoutValuesHelper

    def content_for?(*)
      false
    end

    def content_for(*)
      nil
    end

    def t(*)
      ""
    end

    def strip_tags(v)
      v
    end
  end

  let(:view) { MockView.new }
  let(:controller) {
    double(:controller, controller_name: "pages", action_name: "index")
  }
  before { allow(view).to receive(:controller) { controller } }

  methods = %i(title meta_description meta_keywords)
  methods.each do |method|
    describe "##{method}" do
      describe "with an argument" do
        it "sets the content_for" do
          allow(view).to receive(:content_for)
          view.send(method, "bar")
          expect(view).to have_received(:content_for).with(method, "bar")
        end

        it "returns the value it sets" do
          expect(view.send(method, "bar")).to eq("bar")
        end
      end

      describe "with no arguments" do
        describe "without a content_for" do
          before do
            allow(view).to receive(:content_for?).with(method) { false }
          end

          it "defaults to ''" do
            expect(view.send(method)).to eq("")
          end

          it "returns the controller locale value" do
            allow(view).to receive(:t).with("pages.index.#{method}",
                                            default: "") {
              "translated"
            }
            allow(view).to receive(:t).with("layout.#{method}.format",
                                            method => "translated",
                                            default: "translated") {
              "formatted translated"
            }

            expect(view.send(method)).to eq("formatted translated")
          end

          it "returns the default controller locale value" do
            allow(view).to receive(:t).with("pages.index.#{method}",
                                            default: "") { "" }
            allow(view).to receive(:t).with("layout.#{method}.default",
                                            default: "") { "default" }

            expect(view.send(method)).to eq("default")
          end
        end

        context "with a content_for" do
          before do
            allow(view).to receive(:content_for?).with(method) { true }
            allow(view).to receive(:content_for).with(method) { "foo" }
          end

          it "returns the content formatted" do
            allow(view).to receive(:t).with("layout.#{method}.format",
                                            method => "foo",
                                            default: "foo") { "foo - my site" }

            expect(view.send(method)).to eq("foo - my site")
          end

          it "strips tags" do
            allow(view).to receive(:t).with("layout.#{method}.format",
                                            method => "foo",
                                            default: "foo") { "foo - my site" }
            allow(view).to receive(:strip_tags) { "stripped" }

            expect(view.send(method)).to eq("stripped")
          end
        end

        context "with an empty content_for" do
          before do
            allow(view).to receive(:content_for?).with(method) { true }
            allow(view).to receive(:content_for).with(method) { "" }
          end

          it "returns the locales default" do
            allow(view).to receive(:t).with("layout.#{method}.default",
                                            default: "") { "default" }

            expect(view.send(method)).to eq("default")
          end
        end
      end
    end
  end
end

