require 'estm.rb'
require 'rspec/collection_matchers'

shared_context "LCS matrix" do
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
        expect { subject.parse_example_matrix }.to change(subject, :weights).to be_a_kind_of(Hash)
      end
      
      it "returns a Set" do
        expect { subject.parse_example_matrix }.to change(subject, :compatibilities).to be_a_kind_of(Set)
      end
      
      it "records 3 tile types" do
        expect { subject.parse_example_matrix }.to change(subject, :weights).to have_exactly(3).items
      end
      
      it "records 14 'L' types" do
        expect { subject.parse_example_matrix }.to change(subject, :weights).to include("L" => 14)
      end
      
      it "returns a set of relationships" do
        expect { subject.parse_example_matrix }.to change(subject, :compatibilities).to have_exactly(22).items
      end
    end
    
    context "an ABCD matrix" do
      include_context "ABCD matrix" do
        it "records 4 different tile types" do
          expect { subject.parse_example_matrix }.to change(subject, :weights).to have_exactly(4).items
        end
        
        it "records 4 'D' types" do
          expect { subject.parse_example_matrix }.to change(subject, :weights).to include("D" => 4)
        end
        
        it "returns a set of 32 relationships" do
          expect { subject.parse_example_matrix }.to change(subject, :compatibilities).to have_exactly(32).items
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
  
  describe "#check" do
    context "an LCS matrix" do
      include_context "LCS matrix"
      before { subject.parse_example_matrix }
      it "should return true when checking for (L, L, RIGHT)" do
        expect(subject.check('L', 'L', RIGHT)).to be true
      end
      
      it "should return false when checking for (S, L, LEFT)" do
        expect(subject.check('S', 'L', LEFT)).to be false
      end
    end
    context "an ABCD matrix" do
      include_context "ABCD matrix"
      before { subject.parse_example_matrix }
      it "should return true when checking for (A, D, LEFT)" do
        expect(subject.check('A', 'D', LEFT)). to be true
      end
      
      it "should return false when checking for (A, D, RIGHT)" do
        expect(subject.check('A', 'D', RIGHT)). to be false
      end
    end
  end
end

# it seems like a really big problem
# its not possible to test for a method that appears in an objects constructor
# which means its possible to create versions of an object that are less than ideal
# surely this is not a good idea??
describe Wave do
  describe "#init_coefficients" do
    context "has a size of 3 x 3 and input of weights from Estm" do
      let(:model_db) { instance_double(Estm, :weights => {'L' => 5, 'S' => 10, 'C' => 3}) }
      subject { described_class.new([3, 3], model_db) }
      
      it "calls gets weights from model" do
        expect(model_db).to receive(:weights)
        subject.init_coefficients
      end
      
      it "has a size of 3 x 3 and an input of weights" do
        expect { subject.init_coefficients }
        .to change(subject, :coefficients)
        .to contain_exactly([['L', 'S', 'C'], ['L', 'S', 'C'], ['L', 'S', 'C']], [['L', 'S', 'C'], ['L', 'S', 'C'], ['L', 'S', 'C']], [['L', 'S', 'C'], ['L', 'S', 'C'],['L', 'S', 'C']])
      end
    end
    
    xit " has a size of 5 x 3 and an input of weights" do
      weights = {'A' => 9, 'B' => 20, 'C' => 5, 'D' => 33}
      subject = described_class.new([5, 3], weights)
      expect { subject.init_coefficients }
      .to change(subject, :coefficients)
      .to contain_exactly([5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3], [5, 10, 3])
    end
  end
end