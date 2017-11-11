require 'rails_helper'

RSpec.describe Filter::Resource::Callout do
  include SomlengScfm::SpecHelpers::FilterHelpers

  let(:filterable_factory) { :callout }
  let(:association_chain) { Callout }

  describe "#resources" do
    include_examples "metadata_attribute_filter"

    context "filtering" do
      let(:callout) { create(filterable_factory, :running) }

      def setup_scenario
        callout
      end

      context "by status" do
        def filter_params
          super.merge(:status => status)
        end

        def assert_filter!
          expect(subject.resources).to match_array(asserted_results)
        end

        context "status matches" do
          let(:status) { "running" }
          let(:asserted_results) { [callout] }
          it { assert_filter! }
        end

        context "does not match" do
          let(:status) { "stopped" }
          let(:asserted_results) { [] }
          it { assert_filter! }
        end
      end
    end
  end
end
