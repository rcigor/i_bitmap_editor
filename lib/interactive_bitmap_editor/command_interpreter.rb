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
        m, n = numeric_params(opts)

        validate_numeric(m, n)
        @matrix = InteractiveBitmapEditor::Matrix::Matrix.new(m, n)
      when 'C'
        @matrix.clear
      when 'V'
        colour    = opts.pop
        x, y1, y2 = numeric_params(opts)

        validate_colour(colour)
        validate_numeric(x, y1, y2)

        @matrix.draw_vertical(x, y1, y2, colour)
      when 'H'
        colour    = opts.pop
        y, x1, x2 = numeric_params(opts)

        validate_colour(colour)
        validate_numeric(y, x1, x2)

        @matrix.draw_horizontal(y, x1, x2, colour)
      when 'F'
        colour    = opts.pop
        x, y      = numeric_params(opts)

        validate_colour(colour)
        validate_numeric(x, y)

        @matrix.fill_region(x, y, colour)
      when 'P'
        @printer.print @matrix.contents
      when 'X'
        raise InteractiveBitmapEditor::Exceptions::AbortProgram.new
      else
        raise InteractiveBitmapEditor::Exceptions::UnknownCommand.new

      end
    end

    private
    def validate_numeric(*numbers)
      unless numbers.all?{|n|n.is_a?(Numeric)}
        raise InteractiveBitmapEditor::Exceptions::WrongParameters.new
      end
    end

    def validate_colour(colour)
      unless colour.size == 1 && colour =~ /[A-Za-z]/
        raise InteractiveBitmapEditor::Exceptions::WrongParameters.new
      end
    end

    def numeric_params opts
      opts.map(&:to_i)
    end
  end
end
