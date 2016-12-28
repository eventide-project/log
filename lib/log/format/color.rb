module Log::Format::Color
  def self.header(text)
    TerminalColors::Apply.(text, fg: :white)
  end
end
