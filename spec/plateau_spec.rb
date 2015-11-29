require 'rspec'
require_relative '../lib/rover'
require_relative '../lib/plateau'

describe Plateau do
  subject { Plateau.new(5, 4) }

  context 'initialize' do
    context 'with valid values' do
      it 'sets the upper_x and upper_y' do
        expect(subject.upper_x).to eq(5)
        expect(subject.upper_y).to eq(4)
      end

      it 'initializes an empty rover array' do
        expect(subject.rovers).to eq([])
      end
    end

    context 'with invalid upper_x' do
      it { expect { Plateau.new('', 4) }.to raise_error('Plateau upper_x () is invalid') }
    end

    context 'with invalid upper_y' do
      it { expect { Plateau.new(5, 'abc') }.to raise_error('Plateau upper_y (abc) is invalid') }
    end
  end

  describe '#valid_coordinates?(x, y)' do
    context 'with valid coordinates' do
      it 'returns true' do
        expect(subject.valid_coordinates?(2, 2)).to be(true)
      end
    end

    context 'with an invalid x coordinate' do
      it 'returns false' do
        expect(subject.valid_coordinates?(6, 2)).to be(false)
      end
    end

    context 'with an invalid y coordinate' do
      it 'returns false' do
        expect(subject.valid_coordinates?(2, 5)).to be(false)
      end
    end
  end

  describe '#create_rover' do
    it 'creates and adds a rover' do
      rover = double
      expect(Rover).to receive(:new).with(subject, 2, 3, 'N').and_return(rover)

      expect(subject.create_rover(2, 3, 'N')).to eq(rover)
      expect(subject.rovers).to include(rover)
    end
  end

  describe '#rover_positions' do
    before do
      rover1 = double(to_s: 'Foo')
      rover2 = double(to_s: 'Bar')
      subject.instance_variable_set(:@rovers, [rover1, rover2])
    end

    it 'returns the rover positions formatted as string' do
      expect(subject.rover_positions).to eq("Foo\n\nBar")
    end
  end
end
