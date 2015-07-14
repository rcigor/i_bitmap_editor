module InteractiveBitmapEditor
  module IO
    class Printer
      def print(str)
        STDOUT.print(str)
      end
    end
  end
end
