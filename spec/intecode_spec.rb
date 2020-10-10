require_relative "../lib/intcode"
require "pry"

RSpec.describe Intcode do
  it "supports Optcode 1" do
    expect(Intcode.new([1,0,0,0,99]).run).to eq [2,0,0,0,99]
    expect(Intcode.new([1,1,1,4,99,5,6,0,99]).run).to eq [30,1,1,4,2,5,6,0,99]
    expect(Intcode.new([1101,100,-1,4,0]).run).to eq [1101,100,-1,4,99]
  end

  it "supports Optcode 2" do
    expect(Intcode.new([2,3,0,3,99]).run).to eq [2,3,0,6,99]
    expect(Intcode.new([2,4,4,5,99,0]).run).to eq [2,4,4,5,99,9801]
    expect(Intcode.new([1002,4,3,4,33]).run).to eq [1002,4,3,4,99]
  end

  it "supports Optcode 3" do
    expect(Intcode.new([3, 3, 99, 0]).run([1])[0..3]).to eq [3, 3, 99, 1]
  end

  it "supports Optcode 4" do
    expect(Intcode.new([4, 3, 99, 76]).run).to eq [76]
  end

  context "optcode 5 - jump-if-true" do
    context "immediate mode" do
      it "works" do
        expect(Intcode.new([3,3,1105,-1,9,1101,0,0,12,4,12,99,1]).run([0])).to eq [0]
        expect(Intcode.new([3,3,1105,-1,9,1101,0,0,12,4,12,99,1]).run([7])).to eq [1]
      end
    end
  end

  context "optcode 6 - jump-if-false" do
    context "position mode" do
      it "works" do
        expect(Intcode.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]).run([0])).to eq [0]
        expect(Intcode.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]).run([7])).to eq [1]
      end
    end
  end

  context "optcode 7 - less than" do
    context "position mode" do
      it "calculates whether the input is less than a value" do
        expect(Intcode.new([3,9,7,9,10,9,4,9,99,-1,8]).run([7])).to eq [1]
        expect(Intcode.new([3,9,7,9,10,9,4,9,99,-1,8]).run([8])).to eq [0]
      end
    end

    context "immediate mode" do
      it "calculates whether the input is less than a value" do
        expect(Intcode.new([3,3,1107,-1,8,3,4,3,99]).run([7])).to eq [1]
        expect(Intcode.new([3,3,1107,-1,8,3,4,3,99]).run([8])).to eq [0]
      end
    end
  end

  context "optcode 8 - equal to" do
    context "position mode" do
      it "calculates whether the input is equal to a value" do
        expect(Intcode.new([3,9,8,9,10,9,4,9,99,-1,8]).run([7])).to eq [0]
        expect(Intcode.new([3,9,8,9,10,9,4,9,99,-1,8]).run([8])).to eq [1]
      end
    end

    context "immediate mode" do
      it "calculates whether the input is equal to a value" do
        expect(Intcode.new([3,3,1108,-1,8,3,4,3,99]).run([7])).to eq [0]
        expect(Intcode.new([3,3,1108,-1,8,3,4,3,99]).run([8])).to eq [1]
      end
    end
  end

  it "supports the input with multiple optcodes" do
    expect(Intcode.new([1,9,10,3,2,3,11,0,99,30,40,50]).run).to eq [3500,9,10,70,2,3,11,0,99,30,40,50]
    program_2 = [
      3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
      1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
      999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99,
    ]
    expect(Intcode.new(program_2).run([7])).to eq [999]
    expect(Intcode.new(program_2).run([8])).to eq [1000]
    expect(Intcode.new(program_2).run([9])).to eq [1001]
  end

  it "supports day 9 changes" do
    program_1 = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
    expect(Intcode.new(program_1).run).to eq program_1

    program_2 = [1102,34915192,34915192,7,4,7,99,0]
    expect(Intcode.new(program_2).run[0].to_s.length).to eq 16

    program_3 = [104,1125899906842624,99]
    expect(Intcode.new(program_3).run[0]).to eq program_3[1]
  end
end
