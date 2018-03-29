require 'tempfile'

module Equation
  def self.parse(sgcink_data)
    raise InvalidPathDataError unless sgcink_data.match?(/^SCG_INK(\n\d+(\s\d+)?)*$/)
    file = Tempfile.new(['equation', '.scgink'])
    file.write(sgcink_data)
    file.rewind
    Dir.chdir("/var/seshat-web/seshat")
    result = `./seshat -c Config/CONFIG -i #{file.path} | tail -n 1`
    file.unlink
    result
  end

  class InvalidPathDataError < StandardError; end
end
