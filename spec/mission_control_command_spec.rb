require 'rspec'
require 'pry'

require_relative '../lib/mission_control_command'

describe MissionControlCommand do
  it 'has a check in path'

  describe "#check_in_file_exists?" do
    it "returns true if check in file exists and mc" do

      file_path = MissionControlCommand.check_in_path
      File.open(file_path, "w") do |f|
        f.puts 'checkedin'
      end

      expect(MissionControlCommand.check_in_file_exists?).to be_true
    end

    it "returns false if check in file doesnt exist" do

      file_path = MissionControlCommand.check_in_path

      if FileTest.exists?(file_path)
        FileUtils.rm(file_path)
      end

      expect(File.exists?(file_path)).to_not be_true

      expect(MissionControlCommand.check_in_file_exists?).to_not be_true
    end
  end

  context 'checking in' do

    it 'acknowledges my check in' do
      cmd = MissionControlCommand.new('in')
      expect(cmd.output).to include('You are checked in')
    end

    it 'creates a check in file' do
      cmd = MissionControlCommand.new('in')
      check_in_path = cmd.class.check_in_path

      if FileTest.exists?(check_in_path)
        FileUtils.rm(check_in_path)
      end

      cmd.output
      expect(FileTest.exists?(check_in_path)).to be_true
    end
  end


  context 'checking out' do
    it 'I get a message that I am already checked out if I was already checked out' do
      cmd = MissionControlCommand.new('out')
      cmd = MissionControlCommand.new('out')
      expect(cmd.output).to include('You are already checked out')
    end


    it 'acknowledges my check out' do

      cmd = MissionControlCommand.new('out')
      expect(cmd.output).to include('You are checked out')
    end



    # it 'removes file upon checkout' do
    #   cmd = MissionControlCommand.new('out')
    #   check_in_path = cmd.class.check_in_path
    #   cmd.output
    #   expect(FileTest.exists?(check_in_path)).to_not be_true
    # end



  end



end
