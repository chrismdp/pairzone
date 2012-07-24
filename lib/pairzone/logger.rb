module Pairzone
  class Logger
    class << self
      def configure_from(globals)
        @level = globals[:d]
      end

      def stdout
        @stdout ||= HighLine.new($stdin, $stdout)
      end

      def stderr
        @stderr ||= HighLine.new($stdin, $stderr)
      end

      def info(msg)
        stdout.say(msg)
      end

      def debug(msg)
        stderr.say("<%= color('debug:', YELLOW + BOLD) %> #{msg}") if @level
      end

      def error(msg)
        stdout.say("<%= color('Pairzone error:', RED + BOLD) %> #{msg}")
      end
    end
  end
end
