module InteractiveBitmapEditor
  class Matrix
    def initialize(number_of_rows, number_of_cols)
      dimensions = [number_of_rows, number_of_cols]

      raise 'Dimensions over limits' if dimensions.max > 250 || dimensions.min < 1

      @number_of_rows = number_of_rows
      @number_of_cols = number_of_cols

      @matrix         = Array.new(number_of_rows, Array.new(number_of_cols, 0))
    end

    def pixel(x,y)
      @matrix[x][y]
    end

    private

    attr_reader :number_of_rows, :number_of_cols, :matrix
  end
end
