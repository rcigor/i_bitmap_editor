module InteractiveBitmapEditor
  module Matrix
    class Pixel
      def initialize(colour)
        @colour = colour
      end

      attr_accessor :colour
    end
  end
end
