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
    expect(matrix.contents)
      .to eq(
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

    expect(matrix.pixel(2,4).colour).to eq('A')
  end

  it 'clears' do
    matrix.pixel(2,4).colour = 'A'
    matrix.clear

    expect(matrix.pixel(2,4).colour).to eq('O')
  end

  private
  def ignore_indentation(str)
    str.gsub(/[^\S\n]/, '')
  end
end
