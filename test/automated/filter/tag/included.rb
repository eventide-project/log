require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "Included" do
        logger = Log::Controls::Log.example

        logger.tags = [:some_tag, :'-some_other_tag']

        context "Tags not prefixed with minus (-)" do
          test "Are included" do
            assert(logger.included_tags == [:some_tag])
          end
        end
      end
    end
  end
end
