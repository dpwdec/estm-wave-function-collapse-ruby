require 'estm.rb'

describe Estm do
  describe "# parse_example_matrix" do
    context "receives an input matrix of length 3 x 3" do
        matrix = [
        ['L', 'L', 'L'],
        ['R', 'L', 'L'],
        ['N', 'L', 'N']
        ]
        subject = described_class.new(matrix)
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
  end
end