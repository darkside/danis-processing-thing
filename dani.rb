require 'fileutils'

class DaniProcessing

  def self.call
    new.call
  end

  def call
    ensure_directories_present!

    files = Dir.glob "./run/**/*.txt"
    files.each do |file|
      process_file file
    end
  end

  # You can try to understand and playing with using the website: rubular.com
  def replace_douple_space_and_return(line)
    line.gsub(/\s{2}\r/, "")
  end

  def replace_double_space_to_comma(line)
    line.gsub("  ", ",")
  end

  def process_file(file)
    basename = File.basename file, ".txt"
    lines = File.readlines file
    File.open("./processed/#{basename}.csv", "w") do |f|
      # loop each line of the source file
      lines.each do |line|
        f.write replace(line)
      end
    end
  end

  def ensure_directories_present!
    FileUtils.mkdir_p "./processed/"
  end

  def replace(line)
    line = replace_douple_space_and_return(line)
    line = replace_double_space_to_comma(line)
    line
  end
end

DaniProcessing.call
