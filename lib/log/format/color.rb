module Log::Format::Color
  def self.header(text)
    Rainbow(text).yellow
  end
end
