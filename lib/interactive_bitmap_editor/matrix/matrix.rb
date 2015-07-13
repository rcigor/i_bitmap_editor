require 'interactive_bitmap_editor/matrix/pixel'

module InteractiveBitmapEditor
  module Matrix
    class Matrix
      def initialize(number_of_rows, number_of_cols)
        dimensions = [number_of_rows, number_of_cols]

        raise 'Dimensions over limits' if dimensions.max > 250 || dimensions.min < 1

        @number_of_rows = number_of_rows
        @number_of_cols = number_of_cols

        initialize_matrix
      end

      def pixel(x,y)
        (@matrix[x-1]||[])[y-1]
      end

      def clear
        initialize_matrix
      end

      def contents
        @matrix.map do |row|
          row.map do |pixel|
            pixel.colour
          end.join('')
        end.join("\n")
      end

      def draw_vertical(y, x1, x2, colour)
        @matrix[x1-1..x2-1].each do |column|
          column[y-1].colour = colour
        end
      end

      def draw_horizontal(x, y1, y2, colour)
        @matrix[x-1][y1-1..y2-1].each do |pixel|
          pixel.colour = colour
        end
      end

      def fill_region(x, y, colour)
        original_colour = pixel(x, y).colour
        pixel(x, y).colour = colour

        same_colour_adjacent(x, y) do |x, y|
          propagate_colour(x, y, colour, original_colour)
        end
      end

      private

      attr_reader :number_of_rows, :number_of_cols, :matrix

      def initialize_matrix
        @matrix = Array.new(number_of_rows) do
          Array.new(number_of_cols) do
            InteractiveBitmapEditor::Matrix::Pixel.new('O')
          end
        end
      end

      def propagate_colour(x, y, colour, original_colour)
        return unless x.between?(1, @number_of_rows) && y.between?(1, @number_of_cols)

        if pixel(x, y).colour == original_colour
          pixel(x, y).colour = colour

          same_colour_adjacent(x, y) { |x, y| propagate_colour(x, y, colour, original_colour) }
        end
      end

      def same_colour_adjacent(x, y)
        [
          [x+1, y],
          [x-1, y],
          [x, y+1],
          [x, y-1]
        ].each do |(x,y)|
          yield x,y
        end
      end
    end
  end
end
