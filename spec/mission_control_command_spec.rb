require 'rspec'

require_relative '../lib/mission_control_command'

describe MissionControlCommand do
  it 'has a check in path'

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
