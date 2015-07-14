require 'interactive_bitmap_editor/matrix/matrix'
require 'interactive_bitmap_editor/command_parser'
require 'interactive_bitmap_editor/io/printer'

RSpec.describe InteractiveBitmapEditor::CommandParser do
  let(:printer) { instance_double(InteractiveBitmapEditor::IO::Printer, print: nil) }

  it 'creates matrix from instruction' do
    expect(InteractiveBitmapEditor::Matrix::Matrix).to receive(:new).with(8, 29)

    described_class.new(printer).parse(" I  8 29")
  end

  describe 'commands that mutate the matrix' do
    let(:matrix) do
      instance_double(InteractiveBitmapEditor::Matrix::Matrix)
    end

    before do
      allow(InteractiveBitmapEditor::Matrix::Matrix).to receive(:new)
        .and_return(matrix)
    end

    subject do
      parser = described_class.new(printer)
      parser.parse("I 10 10")
      parser
    end

    it 'parses clear instruction' do
      expect(matrix).to receive(:clear)
        .and_return(matrix)

      subject.parse(" C")
    end

    it 'parses vertical lines instruction' do
      expect(matrix).to receive(:draw_vertical)
        .with(2, 3, 5, 'A')
        .and_return(matrix)

      subject.parse(" V 2 3 5 A")
    end

    it 'parses horizontal lines instruction' do
      expect(matrix).to receive(:draw_horizontal)
        .with(3, 1, 4, 'Z')
        .and_return(matrix)

      subject.parse(" H   3 1   4  Z")
    end

    it 'parses region filling instruction' do
      expect(matrix).to receive(:fill_region)
        .with(1, 4, 'G')
        .and_return(matrix)

      subject.parse("R 1 4 G")
    end

    it 'parses printing instruction' do
      allow(matrix).to receive(:contents)
        .and_return('TestContent')

      expect(printer).to receive(:print).with('TestContent')

      subject.parse("P")
    end
  end
end
