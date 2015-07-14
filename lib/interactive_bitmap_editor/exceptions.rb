module InteractiveBitmapEditor
  module Exceptions
    class AbortProgram    < StandardError ; end
    class WrongDimensions < StandardError ; end
    class WrongParameters < StandardError ; end
    class UnknownCommand  < StandardError ; end
  end
end
