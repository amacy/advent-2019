require_relative "../lib/intcode"
require "pry"

RSpec.describe Intcode do
  it "supports Optcode 1" do
    expect(Intcode.run([1,0,0,0,99])).to eq [2,0,0,0,99]
    expect(Intcode.run([1,1,1,4,99,5,6,0,99])).to eq [30,1,1,4,2,5,6,0,99]
    expect(Intcode.run([1101,100,-1,4,0])).to eq [1101,100,-1,4,99]
  end

  it "supports Optcode 2" do
    expect(Intcode.run([2,3,0,3,99])).to eq [2,3,0,6,99]
    expect(Intcode.run([2,4,4,5,99,0])).to eq [2,4,4,5,99,9801]
    expect(Intcode.run([1002,4,3,4,33])).to eq [1002,4,3,4,99]
  end

  it "supports Optcode 3" do

  end

  it "supports Optcode 4" do

  end

  it "supports the input with multiple optcodes" do
    expect(Intcode.run([1,9,10,3,2,3,11,0,99,30,40,50])).to eq [3500,9,10,70,2,3,11,0,99,30,40,50]
  end
end
