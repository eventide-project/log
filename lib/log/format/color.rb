module Log::Format::Color
  def self.header(text)
    Rainbow(text).white
  end
end
