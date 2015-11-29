require 'rspec'
require_relative '../lib/main'

describe 'Main' do
  subject { Main.new }

  # Integration test: does the program puts the correct output for the given input
  describe '#run' do
    context 'with valid input' do
      it 'should print the correct output' do
        expect { subject.run('files/input.txt') }.to output(File.read('files/output.txt')).to_stdout
      end
    end

    context 'with invalid input' do
      it do
        expect { subject.run(nil) }.to raise_error(RuntimeError)
        expect { subject.run('files/input_empty.txt') }.to raise_error(RuntimeError)
        expect { subject.run('files/input_faulty_plateau.txt') }.to raise_error(RuntimeError)
        expect { subject.run('files/input_faulty_rover_setup.txt') }.to raise_error(RuntimeError)
        expect { subject.run('files/input_faulty_rover_instructions.txt') }.to raise_error(RuntimeError)
        expect { subject.run('files/input_rover_fall_off.txt') }.to raise_error(RuntimeError)
      end
    end
  end
end
