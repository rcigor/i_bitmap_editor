require 'interactive_bitmap_editor/matrix/matrix'
require 'interactive_bitmap_editor/exceptions'

module InteractiveBitmapEditor
  class CommandInterpreter
    def initialize(printer)
      @printer = printer
    end

    def execute(str)
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
      when 'R'
        colour    = opts.pop
        x, y      = opts.map(&:to_i)

        @matrix.fill_region(x, y, colour)
      when 'P'
        @printer.print @matrix.contents
      when 'X'
        raise InteractiveBitmapEditor::Exceptions::AbortProgram
      else
        raise InteractiveBitmapEditor::Exceptions::UnknownCommand
      end
    end

    private
  end
end
