require 'estm.rb'

describe Estm do
  context "receives an input matrix of length 4 x 7" do
    matrix = [
        ['L','L','L','L'],
        ['L','L','L','L'],
        ['L','L','L','L'],
        ['L','C','C','L'],
        ['C','S','S','C'],
        ['S','S','S','S'],
        ['S','S','S','S'],
        ]
    subject = described_class.new(matrix)
    
    describe "# parse_example_matrix" do
      it "returns a Hash" do
        expect(subject.parse_example_matrix[0]).to be_a_kind_of(Hash)
      end
      it "returns a Set" do
        expect(subject.parse_example_matrix[1]).to be_a_kind_of(Set)
      end
      it "records 3 tile types" do
        expect(subject.parse_example_matrix[0].length).to eq(3)
      end
    end
  
    describe "# valid_dirs" do
      it "should accept (int, int) as its parameters" do
        expect{ subject.valid_dirs(4, 7) }.to_not raise_error
      end
      
      context "it receives top left edge coordinate" do
        it "should return array [[1, 0], [0, -1]] for input 0, 0" do
          expect(subject.valid_dirs(0, 0)).to contain_exactly(RIGHT, UP)
        end
      end
      
      context "it receives a bottom right edge coordinate" do
        it "should return [[-1, 0], [0, -1]] for input (6, 3)" do
          expect(subject.valid_dirs(6, 3)).to contain_exactly(LEFT, DOWN)
        end
      end
      
      context "it receives a middle coordinate" do
        it "should return [[-1, 0], [0, -1], [1, 0], [0, 1]] for input (1, 1)" do
          expect(subject.valid_dirs(1, 1)).to contain_exactly(RIGHT, LEFT, DOWN, UP)
        end
      end
      
      context "it receives a three edged coordinate" do
        it "should return [[-1, 0], [0, -1], [0, 1]] for input (0, 1)" do
          expect(subject.valid_dirs(0, 1)).to contain_exactly(RIGHT, DOWN, UP)
        end
      end
    end
    
  end # input matrix context
end