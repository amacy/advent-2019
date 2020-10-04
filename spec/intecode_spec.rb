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
    expect(Intcode.run([3, 3, 99, 0])).to eq [3, 3, 99, 1]
  end

  it "supports Optcode 4" do
    expect(Intcode.run([4, 3, 99, 76])).to eq [76]
  end

  context "optcode 5 - jump-if-true" do
    context "immediate mode" do
      it "works" do
        expect(Intcode.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [0])).to eq [0]
        expect(Intcode.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [7])).to eq [1]
      end
    end
  end

  context "optcode 6 - jump-if-false" do
    context "position mode" do
      it "works" do
        expect(Intcode.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [0])).to eq [0]
        expect(Intcode.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [7])).to eq [1]
      end
    end
  end

  context "optcode 7 - less than" do
    context "position mode" do
      it "calculates whether the input is less than a value" do
        expect(Intcode.run([3,9,7,9,10,9,4,9,99,-1,8], [7])).to eq [1]
        expect(Intcode.run([3,9,7,9,10,9,4,9,99,-1,8], [8])).to eq [0]
      end
    end

    context "immediate mode" do
      it "calculates whether the input is less than a value" do
        expect(Intcode.run([3,3,1107,-1,8,3,4,3,99], [7])).to eq [1]
        expect(Intcode.run([3,3,1107,-1,8,3,4,3,99], [8])).to eq [0]
      end
    end
  end

  context "optcode 8 - equal to" do
    context "position mode" do
      it "calculates whether the input is equal to a value" do
        expect(Intcode.run([3,9,8,9,10,9,4,9,99,-1,8], [7])).to eq [0]
        expect(Intcode.run([3,9,8,9,10,9,4,9,99,-1,8], [8])).to eq [1]
      end
    end

    context "immediate mode" do
      it "calculates whether the input is equal to a value" do
        expect(Intcode.run([3,3,1108,-1,8,3,4,3,99], [7])).to eq [0]
        expect(Intcode.run([3,3,1108,-1,8,3,4,3,99], [8])).to eq [1]
      end
    end
  end

  it "supports the input with multiple optcodes" do
    expect(Intcode.run([1,9,10,3,2,3,11,0,99,30,40,50])).to eq [3500,9,10,70,2,3,11,0,99,30,40,50]
    program_2 = [
      3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
      1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
      999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99,
    ]
    expect(Intcode.run(program_2, [7])).to eq [999]
    expect(Intcode.run(program_2, [8])).to eq [1000]
    expect(Intcode.run(program_2, [9])).to eq [1001]
  end
end
