require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "Included" do
        logger = Log::Controls::Log.example

        logger.tags = [:some_tag, :'-some_other_tag']

        context "Tags prefixed with minus (-)" do
          test "Are excluded" do
            assert(logger.excluded_tags == [:some_other_tag])
          end
        end
      end
    end
  end
end
