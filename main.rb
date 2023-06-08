require "./print.rb"

class PasswordValidator
  include Print

  def initialize(path)
    file = File.open(path)
    @data = parse_data(file.readlines.map(&:chomp))
    file.close
  end

  def parse_data(data)
    parsed = []
    data.each do |line|
      symbol, range, password = line.split(' ')
      min, max = range.scan(/\d+/).map(&:to_i)
      parsed.append({ symbol: symbol, min: min, max: max, password: password })
    end
    parsed
  end

  def is_valid_password?(data)
    count = data[:password].count(data[:symbol])
    count >= data[:min] && count <= data[:max]
  end

  def count_valid_passwords
    start_validator
    total_passwords(@data.length)
    valid_passwords(@data.count { |line| is_valid_password?(line) })
  end
end

path_to_file = 'passwords.txt'
check = PasswordValidator.new(path_to_file).count_valid_passwords

