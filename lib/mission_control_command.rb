class MissionControlCommand

  def initialize(cmd)
    @cmd = cmd
  end

  def self.check_in_path
    ENV['HOME'] + '/.check_in'
  end

  def self.check_in_file_exists?
    File.exists?(check_in_path)
  end

  def check_in
    File.open(self.class.check_in_path, "w") do |f|
      f.puts 'checkedin'
    end
  end

  def check_out
    filepath = MissionControlCommand.check_in_path
    File.delete(filepath)
  end


  def check_checked_in
    cco = File.exists?(self.class.check_in_path)
    return cco
  end


  def output
    output = "no output"

    if @cmd == 'in'
      if(check_checked_in == true)
        output = 'You are already checked in'
      else
        check_in
        output ='You are checked in'
      end

    elsif @cmd == 'out'
      if(check_checked_in == false)
        output = 'You are already checked out'
      else
        check_out
        output = 'You are checked out'
      end

    else
      'You are in limbo and cannot be saved'
    end

    return output
  end

end
