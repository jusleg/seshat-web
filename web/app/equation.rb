require 'tempfile'

module Equation
  def self.parse(sgcink_data)
    raise InvalidPathDataError unless sgcink_data.to_s.match?(/^SCG_INK(\n\d+(\s\d+)?)*$/)
    output = seshat_file(sgcink_data)
    raise SeshatError, output if output.match?(/Error/i)
    output
  end

  def self.seshat_file(data)
    file = Tempfile.new(['equation', '.scgink'])
    file.write(data)
    file.rewind
    Dir.chdir(ENV['SESHAT_PATH'])
    result = `./seshat -c Config/CONFIG -i #{file.path} | tail -n 1`
    file.unlink
    result.strip
  end

  class InvalidPathDataError < StandardError; end
  class SeshatError < StandardError; end
end
