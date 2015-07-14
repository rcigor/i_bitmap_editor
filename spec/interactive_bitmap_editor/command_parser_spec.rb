require 'interactive_bitmap_editor/matrix/matrix'
require 'interactive_bitmap_editor/command_parser'

RSpec.describe InteractiveBitmapEditor::CommandParser do
  let(:matrix) do
    instance_double(InteractiveBitmapEditor::Matrix::Matrix)
  end

  it 'parses matrix creation instruction' do
    expect(InteractiveBitmapEditor::Matrix::Matrix).to receive(:new).with(8, 29)
      .and_return(matrix)

    described_class.new.parse(" I  8 29")
  end

  it 'parses clear instruction' do
    expect(matrix).to receive(:clear)
      .and_return(matrix)

    described_class.new(matrix).parse(" C")
  end

  it 'parses vertical lines instruction' do
    expect(matrix).to receive(:draw_vertical)
      .with(2, 3, 5, 'A')
      .and_return(matrix)

    described_class.new(matrix).parse(" V 2 3 5 A")
  end

  it 'parses horizontal lines instruction' do
    expect(matrix).to receive(:draw_horizontal)
      .with(3, 1, 4, 'Z')
      .and_return(matrix)

    described_class.new(matrix).parse(" H   3 1   4  Z")
  end
end
