require 'interactive_bitmap_editor/matrix'

RSpec.describe InteractiveBitmapEditor::Matrix do
  let(:matrix) { described_class.new(5, 5) }

  it 'accepts dimensions between 1 and 250 only' do
    expect{described_class.new(280, 280)}
      .to raise_error('Dimensions over limits')
    expect{described_class.new(251, 5)}
      .to raise_error('Dimensions over limits')
    expect{described_class.new(20, -5)}
      .to raise_error('Dimensions over limits')

    expect{described_class.new(5, 5)}
      .not_to raise_error
  end

  it 'initializes all pixels with "O"' do
    expect(matrix.contents).to eq(
      ignore_indentation(
        "OOOOO
         OOOOO
         OOOOO
         OOOOO
         OOOOO"
      )
    )
  end

  it 'sets colour pixel by pixel' do
    matrix.pixel(2, 4).colour = 'A'

    expect(matrix.contents).to eq(
      ignore_indentation(
        "OOOOO
         OOOAO
         OOOOO
         OOOOO
         OOOOO"
      )
    )
  end

  it 'clears' do
    matrix.pixel(2, 4).colour = 'A'
    matrix.clear

    expect(matrix.pixel(2, 4).colour).to eq('O')
  end

  it 'draws vertical lines' do
    matrix.draw_vertical(3, 2, 4, 'Z')
    matrix.draw_vertical(1, 1, 5, 'X')

    expect(matrix.contents).to eq(
      ignore_indentation(
        "XOOOO
         XOZOO
         XOZOO
         XOZOO
         XOOOO"
      )
    )
  end

  it 'draws horizontal lines' do
    matrix.draw_horizontal(1, 1, 5, 'F')
    matrix.draw_horizontal(5, 2, 5, 'F')

    expect(matrix.contents).to eq(
      ignore_indentation(
        "FFFFF
         OOOOO
         OOOOO
         OOOOO
         OFFFF"
      )
    )
  end

  it 'overrides previously drawn lines' do
    matrix.draw_horizontal(1, 1, 5, 'F')
    matrix.draw_horizontal(1, 1, 5, 'B')

    matrix.draw_vertical(2, 1, 3, 'H')

    expect(matrix.contents).to eq(
      ignore_indentation(
        "BHBBB
         OHOOO
         OHOOO
         OOOOO
         OOOOO"
      )
    )
  end

  context 'regions' do
    it 'propagates colour to all pixels of a region' do
      matrix.pixel(3, 2).colour = 'W'
      matrix.pixel(4, 3).colour = 'Q'
      matrix.pixel(5, 4).colour = 'T'

      matrix.fill_region(3, 3, 'Z')
      expect(matrix.contents).to eq(
        ignore_indentation(
          "ZZZZZ
           ZZZZZ
           ZWZZZ
           ZZQZZ
           ZZZTZ"
        )
      )
    end

    it 'does not propagate colour aslant' do
      matrix.draw_vertical(1, 2, 5, 'B')
      matrix.draw_horizontal(1, 2, 5, 'B')

      matrix.fill_region(3, 3, 'Z')
      expect(matrix.contents).to eq(
        ignore_indentation(
          "OBBBB
           BZZZZ
           BZZZZ
           BZZZZ
           BZZZZ"
        )
      )
    end
  end

  private
  def ignore_indentation(str)
    str.gsub(/[^\S\n]/, '')
  end
end
