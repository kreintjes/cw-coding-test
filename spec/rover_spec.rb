require 'rspec'
require_relative '../lib/rover'

describe Rover do
  let(:plateau) do
    plateau = double('plateau')
    allow(plateau).to receive(:valid_coordinates?).and_return(true)
    plateau
  end

  subject { Rover.new(plateau, 2, 3, 'N') }

  context 'initialize' do
    context 'with valid position' do
      it 'sets the plateau' do
        expect(subject.plateau).to eq(plateau)
      end

      it 'sets the coordinates' do
        expect(plateau).to receive(:valid_coordinates?).with(2, 3).and_return(true)
        expect(subject.x).to eq(2)
        expect(subject.y).to eq(3)
      end

      it 'sets the orientation' do
        expect(subject.o).to eq('N')
      end
    end

    context 'with invalid x' do
      it { expect { Rover.new(plateau, 'abc', 3, 'X') }.to raise_error('Rover x (abc) is invalid') }
    end

    context 'with invalid y' do
      it { expect { Rover.new(plateau, 2, nil, 'X') }.to raise_error('Rover y () is invalid') }
    end

    context 'with invalid coordinates' do
      it do
        expect(plateau).to receive(:valid_coordinates?).with(9, 10).and_return(false)
        expect { Rover.new(plateau, 9, 10, 'N') }.to raise_error('Rover coordinates (9, 10) are invalid')
      end
    end

    context 'with invalid orientation' do
      it { expect { Rover.new(plateau, 2, 3, 'X') }.to raise_error('Rover orientation (X) is invalid') }
    end
  end

  describe '#move(instruction)' do
    context 'when orientation is N' do
      subject { Rover.new(plateau, 2, 3, 'N') }

      context 'given instruction M' do
        it 'moves up' do
          expect(plateau).to receive(:valid_coordinates?).with(2, 4).and_return(true)
          expect { subject.move('M') }.to_not change { subject.x }
          expect { subject.move('M') }.to change { subject.y }.by(1)
        end
      end

      context 'given instruction L' do
        it 'rotates left' do
          expect { subject.move('L') }.to change { subject.o }.from('N').to('W')
        end
      end

      context 'given instruction R' do
        it 'rotates right' do
          expect { subject.move('R') }.to change { subject.o }.from('N').to('E')
        end
      end
    end

    context 'when orientation is E' do
      subject { Rover.new(plateau, 2, 3, 'E') }

      context 'given instruction M' do
        it 'moves right' do
          expect(plateau).to receive(:valid_coordinates?).with(3, 3).and_return(true)
          expect { subject.move('M') }.to change { subject.x }.by(1)
          expect { subject.move('M') }.to_not change { subject.y }
        end
      end

      context 'given instruction L' do
        it 'rotates left' do
          expect { subject.move('L') }.to change { subject.o }.from('E').to('N')
        end
      end

      context 'given instruction R' do
        it 'rotates right' do
          expect { subject.move('R') }.to change { subject.o }.from('E').to('S')
        end
      end
    end

    context 'when orientation is S' do
      subject { Rover.new(plateau, 2, 3, 'S') }

      context 'given instruction M' do
        it 'moves down' do
          expect(plateau).to receive(:valid_coordinates?).with(2, 2).and_return(true)
          expect { subject.move('M') }.to_not change { subject.x }
          expect { subject.move('M') }.to change { subject.y }.by(-1)
        end
      end

      context 'given instruction L' do
        it 'rotates left' do
          expect { subject.move('L') }.to change { subject.o }.from('S').to('E')
        end
      end

      context 'given instruction R' do
        it 'rotates right' do
          expect { subject.move('R') }.to change { subject.o }.from('S').to('W')
        end
      end
    end

    context 'when orientation is W' do
      subject { Rover.new(plateau, 2, 3, 'W') }

      context 'given instruction M' do
        it 'moves left' do
          expect(plateau).to receive(:valid_coordinates?).with(1, 3).and_return(true)
          expect { subject.move('M') }.to change { subject.x }.by(-1)
          expect { subject.move('M') }.to_not change { subject.y }
        end
      end

      context 'given instruction L' do
        it 'rotates left' do
          expect { subject.move('L') }.to change { subject.o }.from('W').to('S')
        end
      end

      context 'given instruction R' do
        it 'rotates right' do
          expect { subject.move('R') }.to change { subject.o }.from('W').to('N')
        end
      end
    end

    context 'given instruction M' do
      context 'when new coordinates not valid' do
        it do
          expect(plateau).to receive(:valid_coordinates?).with(2, 4).and_return(false)
          expect { subject.move('M') }.to raise_error('Houston, we have a problem: we just fell off the plateau')
        end
      end

      it 'does not change orientation' do
        expect { subject.move('M') }.to_not change { subject.o }
      end
    end

    context 'given instruction L' do
      it 'does not change coordinates' do
        expect { subject.move('L') }.to_not change { subject.x }
        expect { subject.move('L') }.to_not change { subject.y }
      end
    end

    context 'given instruction R' do
      it 'does not change coordinates' do
        expect { subject.move('R') }.to_not change { subject.x }
        expect { subject.move('R') }.to_not change { subject.y }
      end
    end

    context 'given invalid instruction' do
      it { expect { subject.move('X') }.to raise_error('Invalid Rover instruction (X) given') }
    end
  end

  describe '#to_s' do
    it 'returns the position' do
      expect(subject.to_s).to eq('2 3 N')
    end
  end
end
