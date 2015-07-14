module InteractiveBitmapEditor
  def self.indefinitely
    while true do
      yield
    end
  end
end
