require 'spec_helper'
require 'interactive_bitmap_editor/io/reader'

RSpec.describe InteractiveBitmapEditor::IO::Reader do
  class FakeStdin
    def gets
    end
  end

  let(:fake_stdin_instance) { FakeStdin.new }

  before do
    STDIN = fake_stdin_instance
  end

  it 'gets from STDIN' do
    expect(fake_stdin_instance).to receive(:gets)

    described_class.new.get
  end
end
