require 'interactive_bitmap_editor/matrix/matrix'

module InteractiveBitmapEditor
  class CommandParser
    def initialize(matrix=nil)
      @matrix = matrix
    end

    def parse(str)
      opts = str.split(' ')
      case opts.shift.upcase
      when 'I'
        m, n = opts.map(&:to_i)

        @matrix = InteractiveBitmapEditor::Matrix::Matrix.new(m, n)
      when 'C'
        @matrix.clear
      when 'V'
        colour    = opts.pop
        y, x1, x2 = opts.map(&:to_i)

        @matrix.draw_vertical(y, x1, x2, colour)
      when 'H'
        colour    = opts.pop
        x, y1, y2 = opts.map(&:to_i)

        @matrix.draw_horizontal(x, y1, y2, colour)
      end
    end

    private
  end
end
