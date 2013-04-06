require 'rubygems'
require 'doubles/version'


class Doubles
  attr_accessor :current_path, :args

  def initialize current_path, args=''
    @current_path = current_path
    @args = args
  end

  def file_content

  end

  def convert_rb line
    start_double = nil
    start_single = nil
    had_inter = false
    inter = false
    remark = false
    pos = 0
    line.each_char do |char|

      if char == '#' && !start_double && !start_single
        remark = true
      end

      unless remark
        if char == "'"
          if start_single
            start_single = nil
          else
            start_single = pos
          end
        end
        if char == '"' && !start_single && !inter
          if start_double
            unless had_inter
              line[start_double] = "'"
              line[pos] = "'"
            end
            start_double = nil
            had_inter = false
          else
            start_double = pos
          end
        end

        if char == '#' && line[pos+1] == '{' && start_double
          had_inter = true
          inter = true
        end

        if char == '}' && inter
          inter = false
        end

        pos += 1
      end
    end
  end


end
