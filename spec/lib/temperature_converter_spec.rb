require 'spec_helper'

describe TemperatureConverter do
  describe '#c_to_f' do
    subject { TemperatureConverter.new(temperature).c_to_f }

    context 'when 0' do
      let(:temperature) { 0 }
      it { should eq 32 }
    end

    context 'when 100' do
      let(:temperature) { 100 }
      it { should eq 212 }
    end

    context 'when -20' do
      let(:temperature) { -20 }
      it { should eq(-4.0) }
    end
  end

  describe 'f_to_c' do
    subject { TemperatureConverter.new(temperature).f_to_c }

    context 'when 32' do
      let(:temperature) { 32 }
      it { should eq 0 }
    end

    context 'when 212' do
      let(:temperature) { 212 }
      it { should eq 100 }
    end

    context 'when -20' do
      let(:temperature) { -20 }
      it { should eq(-28.88888888888889) }
    end
  end
end
