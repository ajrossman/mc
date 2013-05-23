require 'rspec'
require 'pry'

require_relative '../lib/mission_control_command'

describe MissionControlCommand do

let(:filepath) {MissionControlCommand.check_in_path}


  describe "#check_in_file_exists?" do

    it "returns true if check in file exists and mc" do
      File.open(filepath, "w") do |f|
        f.puts 'checkedin'
      end
      expect(MissionControlCommand.check_in_file_exists?).to be_true
    end

    it "returns false if check in file doesnt exist" do
      if FileTest.exists?(filepath)
        FileUtils.rm(filepath)
      end
      expect(File.exists?(filepath)).to_not be_true
      expect(MissionControlCommand.check_in_file_exists?).to_not be_true
    end

  end



  describe 'while checking in' do

    it 'acknowledges my checkin' do
      cmd = MissionControlCommand.new('in')
      expect(cmd.output).to include('You are checked in')
    end

    it 'creates a checkin file in home directory' do
      if FileTest.exists?(filepath)
        FileUtils.rm(filepath)
      end
      cmd = MissionControlCommand.new('in')
      cmd.output
      expect(FileTest.exists?(filepath)).to be_true
    end

    it 'I get a message that I am already checked in if I was already checked in' do
      File.open(filepath, "w") do |f|
        f.puts 'checkedin'
      end
      cmd = MissionControlCommand.new('in')
      expect(cmd.output).to include('You are already checked in')
    end

  end


  describe 'while checking out' do

    it 'acknowledges my check out' do
      File.open(filepath, "w") do |f|
        f.puts 'checkedin'
      end
      cmd = MissionControlCommand.new('out')
      expect(cmd.output).to include('You are checked out')
    end

    it 'deletes the checkin file in my home directory on checkout' do
      File.open(filepath, "w") do |f|
        f.puts 'checkedin'
      end
      cmd = MissionControlCommand.new('out')
      cmd.output
      expect(FileTest.exists?(filepath)).to_not be_true
    end

    it 'I get a message that I am already checked out if I was already checked out' do
      if FileTest.exists?(filepath)
        FileUtils.rm(filepath)
      end
      cmd = MissionControlCommand.new('out')
      expect(cmd.output).to include('You are already checked out')
    end

  end

  describe 'for time tracking' do

    it 'time is written to checkin object at checkin' do
      if FileTest.exists?(filepath)
        FileUtils.rm(filepath)
      end

      cmd = MissionControlCommand.new('in')
      cmd.output

      File.open(filepath, 'r').each_line do |line|
        puts line
        expect(line.to_i).to be > 1000000
      end

    end

    it 'the total time at Mission Contol is calculated at checkout' do
      File.open(filepath, 'r').each_line do |line|
        Time_at_la = Time.now.to_i - line.to_i
      end
    end

  end

end
