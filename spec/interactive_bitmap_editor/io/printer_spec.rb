require 'spec_helper'
require 'interactive_bitmap_editor/io/printer'

RSpec.describe InteractiveBitmapEditor::IO::Printer do
  class FakeStdout
    def print(str)
    end
  end

  let(:fake_stdout_instance) { FakeStdout.new }

  before do
    STDOUT = fake_stdout_instance
  end

  it ' prints to STDOUT' do
    expect(fake_stdout_instance).to receive(:print).with('hello')

    described_class.new.print('hello')
  end
end
