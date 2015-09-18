class CartesianProduct
  include Enumerable

  def initialize(first_seq, second_seq)
    @first_seq = first_seq
    @second_seq = second_seq
  end
  
  def each
    @first_seq.each do |first_seq|
      @second_seq.each { |second_seq| yield [first_seq, second_seq] }
    end
  end
end