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

  def check_checked_in
    cco = File.exists?(self.class.check_in_path)
    puts cco
    return cco
  end

  def output
    output = "no output"

    if @cmd == 'in'
      check_in
      output ='You are checked in'

    elsif @cmd == 'out'
      #check to see if already checked in
      if(check_checked_in == false)
        puts 'You are already checked out'
        output = 'You are already checked out'
      else
        File.delete(self.class.check_in_path)
        output = 'You are checked out'
       end

    else
      'You are in limbo'
    end

    return output
  end

end
