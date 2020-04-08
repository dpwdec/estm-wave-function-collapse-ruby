require 'estm.rb'

shared_context "LCS matrix" do
  #S = 7, C = 8, L = 7
  matrix = [
        ['L','L','L','L'],
        ['L','L','L','L'],
        ['L','L','L','L'],
        ['L','C','C','L'],
        ['C','S','S','C'],
        ['S','S','S','S'],
        ['S','S','S','S'],
        ]
  let(:subject) { described_class.new(matrix) }
end

shared_context "ABCD matrix" do
  #D = 3, A = 9, C = 12, B = 8
  #<Set: {
  #["D", "A", [1, 0]], 
  #["D", "D", [0, 1]], 
  #["D", "D", [0, -1]],
  
  #["A", "D", [-1, 0]], 
  #["A", "A", [1, 0]], 
  #["A", "A", [0, 1]], 
  #["A", "A", [0, -1]], 
  #["A", "A", [-1, 0]], 
  #["A", "C", [1, 0]], 
  #["A", "C", [0, 1]], 
  #["A", "C", [0, -1]], 
  #["A", "C", [-1, 0]], 
  
  #["C", "A", [-1, 0]], 
  #["C", "B", [1, 0]], 
  #["C", "A", [0, -1]], 
  #["C", "C", [0, 1]], 
  #["C", "C", [0, -1]], 
  #["C", "A", [0, 1]], 
  #["C", "C", [1, 0]], 
  #["C", "B", [0, 1]],
  #["C", "B", [0, -1]], 
  #["C", "C", [-1, 0]], 
  #["C", "A", [1, 0]], 
  #["C", "B", [-1, 0]]}>
  
  #["B", "C", [-1, 0]], 
  #["B", "B", [1, 0]], 
  #["B", "C", [0, -1]], 
  #["B", "B", [0, 1]], 
  #["B", "B", [0, -1]], 
  #["B", "C", [0, 1]], 
  #["B", "B", [-1, 0]], 
  #["B", "C", [1, 0]], 
  matrix = [
    ['D','D','D','D'],
    ['A','A','A','A'],
    ['A','A','A','A'],
    ['A','C','C','A'],
    ['C','B','B','C'],
    ['C','B','B','C'],
    ['A','C','C','A'],
    ]
  let(:subject) { described_class.new(matrix) }
end

describe Estm do
    describe "# parse_example_matrix" do
      context "an LCS matrix" do
        include_context "LCS matrix"
        it "returns a Hash" do
          expect(subject.parse_example_matrix[0]).to be_a_kind_of(Hash)
        end
        
        it "returns a Set" do
          expect(subject.parse_example_matrix[1]).to be_a_kind_of(Set)
        end
        
        it "records 3 tile types" do
          expect(subject.parse_example_matrix[0].length).to eq(3)
        end
        
        it "records 14 'L' types" do
          expect(subject.parse_example_matrix[0]["L"]).to eq(14)
        end
        
        it "returns a set of relationships" do
          expect(subject.parse_example_matrix[1].length).to eq(22)
        end
      end
      
      context "an ABCD matrix" do
        include_context "ABCD matrix" do
          it "records 4 tile types" do
            expect(subject.parse_example_matrix[0].length).to eq(4)
          end
          
          it "records 4 'D' types" do
            expect(subject.parse_example_matrix[0]["D"]).to eq(4)
          end
          
          it "returns a set of 28 relationships" do
            expect(subject.parse_example_matrix[1].length).to eq(32)
          end
        end
      end
    end
  
    describe "# valid_dirs" do
      context "in an LCS matrix" do
        include_context "LCS matrix"
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
      
      context "an ABCD matrix" do
        include_context "ABCD matrix"
        it "it should returns DOWN, UP, RIGHT for middle edge (0, 2)" do
          expect(subject.valid_dirs(0, 2)).to contain_exactly(RIGHT, DOWN, UP)
        end
      end
    end
end