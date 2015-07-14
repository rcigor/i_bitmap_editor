require 'interactive_bitmap_editor/matrix/matrix'
require 'interactive_bitmap_editor/command_interpreter'
require 'interactive_bitmap_editor/io/printer'

RSpec.describe InteractiveBitmapEditor::CommandInterpreter do
  let(:printer) { instance_double(InteractiveBitmapEditor::IO::Printer, print: nil) }

  it 'creates matrix from instruction' do
    expect(InteractiveBitmapEditor::Matrix::Matrix).to receive(:new).with(8, 29)

    described_class.new(printer).execute(" I  8 29")
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
      instance = described_class.new(printer)
      instance.execute("I 10 10")
      instance
    end

    it 'understands clear command' do
      expect(matrix).to receive(:clear)
        .and_return(matrix)

      subject.execute(" C")
    end

    it 'understands vertical lines' do
      expect(matrix).to receive(:draw_vertical)
        .with(2, 3, 5, 'A')
        .and_return(matrix)

      subject.execute(" V 2 3 5 A")
    end

    it 'understands horizontal lines' do
      expect(matrix).to receive(:draw_horizontal)
        .with(3, 1, 4, 'Z')
        .and_return(matrix)

      subject.execute(" H   3 1   4  Z")
    end

    it 'understands region filling instruction' do
      expect(matrix).to receive(:fill_region)
        .with(1, 4, 'G')
        .and_return(matrix)

      subject.execute("F 1 4 G")
    end

    it 'understands printing instruction' do
      allow(matrix).to receive(:contents)
        .and_return('TestContent')

      expect(printer).to receive(:print).with('TestContent')

      subject.execute("P")
    end
  end

  describe 'unexpected parameters' do
    subject do
      instance = described_class.new(printer)
      instance.execute("I 10 10")
      instance
    end

    it 'raises when unexpected params are passed' do
      expect{ subject.execute('I ') }
        .to raise_error(InteractiveBitmapEditor::Exceptions::WrongParameters)

      expect{ subject.execute('V 8 ') }
        .to raise_error(InteractiveBitmapEditor::Exceptions::WrongParameters)

      expect{ subject.execute('F L ') }
        .to raise_error(InteractiveBitmapEditor::Exceptions::WrongParameters)
    end
  end
end
