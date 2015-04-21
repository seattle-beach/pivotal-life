require 'spec_helper'

describe Forecast::TemperatureConverter do
  describe 'c to f' do
    let(:converter) { Forecast::TemperatureConverter.new(current: temperature, apparent: 10, unit: :c, alt_unit: :f) }

    context 'when 0' do
      let(:temperature) { 0 }

      it do
        expect(converter.current_degrees).to eq '0°C'
        expect(converter.alternate_degrees).to eq '32°F'
        expect(converter.apparent_degrees).to eq '10°C'
      end
    end

    context 'when 100' do
      let(:temperature) { 100 }

      it do
        expect(converter.current_degrees).to eq '100°C'
        expect(converter.alternate_degrees).to eq '212°F'
        expect(converter.apparent_degrees).to eq '10°C'
      end
    end

    context 'when -20' do
      let(:temperature) { -20 }

      it do
        expect(converter.current_degrees).to eq '-20°C'
        expect(converter.alternate_degrees).to eq '-4°F'
        expect(converter.apparent_degrees).to eq '10°C'
      end
    end
  end

  describe 'f to c' do
    let(:converter) { Forecast::TemperatureConverter.new(current: temperature, apparent: 10, unit: :f, alt_unit: :c) }

    context 'when 32' do
      let(:temperature) { 32 }

      it do
        expect(converter.current_degrees).to eq '32°F'
        expect(converter.alternate_degrees).to eq '0°C'
        expect(converter.apparent_degrees).to eq '10°F'
      end
    end

    context 'when 212' do
      let(:temperature) { 212 }

      it do
        expect(converter.current_degrees).to eq '212°F'
        expect(converter.alternate_degrees).to eq '100°C'
        expect(converter.apparent_degrees).to eq '10°F'
      end
    end

    context 'when -20' do
      let(:temperature) { -20 }

      it do
        expect(converter.current_degrees).to eq '-20°F'
        expect(converter.alternate_degrees).to eq '-29°C'
        expect(converter.apparent_degrees).to eq '10°F'
      end
    end
  end
end
