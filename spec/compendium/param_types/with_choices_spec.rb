require 'spec_helper'
require 'compendium/param_types/with_choices'

describe Compendium::ParamTypes::WithChoices do
  subject{ described_class.new(0, %w(a b c)) }

  it { is_expected.not_to be_boolean }
  it { is_expected.not_to be_date }
  it { is_expected.not_to be_dropdown }
  it { is_expected.not_to be_radio }

  it "should return the index when given an index" do
    p = described_class.new(1, [:foo, :bar, :baz])
    expect(p).to eq(1)
  end

  it "should return the index when given a value" do
    p = described_class.new(:foo, [:foo, :bar, :baz])
    expect(p).to eq(0)
  end

  it "should return the index when given a string value" do
    p = described_class.new("2", [:foo, :bar, :baz])
    expect(p).to eq(2)
  end

  it "should raise an error if given an invalid index" do
    expect { described_class.new(3, [:foo, :bar, :baz]) }.to raise_error IndexError
  end

  it "should raise an error if given a value that is not included in the choices" do
    expect { described_class.new(:quux, [:foo, :bar, :baz]) }.to raise_error IndexError
  end

  describe "#value" do
    it "should return the value of the given choice" do
      p = described_class.new(2, [:foo, :bar, :baz])
      expect(p.value).to eq(:baz)
    end
  end
end