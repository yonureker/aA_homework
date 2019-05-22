require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { Chef.new("Onur") }
  let(:desert1) { Dessert.new("Baklava", 4, :chef)}
  

  describe "#initialize" do
    it "sets a type" do
      expect(desert1.type).to eq("Baklava")
    end

    it "sets a quantity" do
      expect(desert1.quantity).to eq(4)
    end

    it "starts ingredients as an empty array" do
      expect(desert1.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{ Dessert.new("Baklava", "blab", "Curry")}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      desert1.add_ingredient("Sugar")
      expect(desert1.ingredients).to eq(["Sugar"])
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      new_ingredients = ["banana", "syrup", "chocolate", "strawberry"]

      new_ingredients.each do |ingredient|
        desert1.add_ingredient(ingredient)
      end

      expect(desert1.ingredients).to eq(new_ingredients)
      desert1.mix!
      expect(desert1.ingredients).not_to eq(new_ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      desert1.eat(1)
      expect(desert1.quantity).to eq(3)

      desert1.eat(1)
      expect(desert1.quantity).to eq(2)
    end


    it "raises an error if the amount is greater than the quantity" do
      expect {desert1.eat(10)}.to raise_error(StandardError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(desert1.serve).to include(desert1.chef.to_s.capitalize)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(desert1)
      desert1.make_more
    end
  end
end
