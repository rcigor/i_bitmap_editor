module InteractiveBitmapEditor
  class Matrix
    def initialize(number_of_rows, number_of_cols)
      dimensions = [number_of_rows, number_of_cols]

      raise 'Dimensions over limits' if dimensions.max > 250 || dimensions.min < 1

      @number_of_rows = number_of_rows
      @number_of_cols = number_of_cols

      initialize_matrix
    end

    def pixel(x,y)
      @matrix[x][y]
    end

    def clear
      initialize_matrix
    end

    private

    attr_reader :number_of_rows, :number_of_cols, :matrix

    def initialize_matrix
      @matrix         = Array.new(number_of_rows, Array.new(number_of_cols, Pixel.new('O')))
    end
  end

  class Pixel
    def initialize(colour)
      @colour = colour
    end

    attr_accessor :colour
  end
end
