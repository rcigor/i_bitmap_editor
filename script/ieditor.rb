require 'interactive_bitmap_editor/command_interpreter'
require 'interactive_bitmap_editor/io/printer'
require 'interactive_bitmap_editor/io/reader'
require 'interactive_bitmap_editor/exceptions'
require 'interactive_bitmap_editor/helpers/indefinitely'

printer = InteractiveBitmapEditor::IO::Printer.new
reader  = InteractiveBitmapEditor::IO::Reader.new

interpreter = InteractiveBitmapEditor::CommandInterpreter.new(printer)

printer.print "Type Q for help.\n\n"

InteractiveBitmapEditor::indefinitely do
  printer.print '> '
  begin
    interpreter.execute(reader.get)
  rescue InteractiveBitmapEditor::Exceptions::AbortProgram
    printer.print "Goodbye.\n"
    abort
  rescue InteractiveBitmapEditor::Exceptions::WrongDimensions
    printer.print "Invalid dimensions.\n"
  rescue InteractiveBitmapEditor::Exceptions::WrongParameters
    printer.print "Unexpected parameters.\n"
  rescue InteractiveBitmapEditor::Exceptions::UnknownCommand
    printer.print "Unsupported command.\n"
  end
end
