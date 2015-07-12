require 'interactive_bitmap_editor/matrix'

RSpec.describe InteractiveBitmapEditor::Matrix do
  let(:matrix) { described_class.new(5, 5) }

  it 'only accepts dimensions between 1 and 250' do
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

  it 'allows colour to be set pixel by pixel' do
    matrix.pixel(2,4).colour = 'A'

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
    matrix.pixel(2,4).colour = 'A'
    matrix.clear

    expect(matrix.pixel(2,4).colour).to eq('O')
  end

  it 'allows to draw vertical lines' do
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

  it 'allows to draw horizontal lines' do
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

  it 'latest line will overide previous ones' do
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

  private
  def ignore_indentation(str)
    str.gsub(/[^\S\n]/, '')
  end
end
