require 'interactive_bitmap_editor/matrix'

RSpec.describe InteractiveBitmapEditor::Matrix do
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
    matrix = described_class.new(5,5)

    expect(matrix.pixel(0,0).colour).to eq('O')
    expect(matrix.pixel(2,4).colour).to eq('O')
  end

  it 'allows to change the colour of a pixel' do
    matrix = described_class.new(5,5)
    matrix.pixel(2,4).colour = 'A'

    expect(matrix.pixel(2,4).colour).to eq('A')
  end
end
