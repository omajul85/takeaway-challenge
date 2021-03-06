require 'order'

describe Order do
  subject(:order) { described_class.new(menu) }
  let(:menu) { double(:menu, contains?: true, dishes: {"Chicken"=>4.5, "Pork"=>5.5, "Steak"=>9.3}) }
  let(:dishes) { {"Chicken"=>2, "Pork"=>3} }
  
  describe "#add" do
    it "adds dish to the order" do
      # allow(menu).to receive(:contains?).and_return true
      order.add("Chicken", 5)
      expect(order.contains?("Chicken")).to be true
    end
    
    it "raises error if dish is not on the menu" do
      allow(menu).to receive(:contains?).and_return false
      expect{ order.add("Chicken", 5) }.to raise_error described_class::ERR_INVALID_ORDER
    end
  end
  
  describe "#remove" do
    it "removes dish from the order" do
      order.add("Pork", 5)
      order.remove("Pork")
      expect(order.contains?("Pork")).to be false
    end
  end
  
  describe "#total" do
    it "calculates the total of the order" do
      expect(order).to receive(:dishes).and_return dishes
      expect(order.total).to eq 25.5
    end
  end
  
  describe "#display" do
    it "prints the order in a user friendly way" do
      order.add("Lamb", 2)
      order.add("Gambas", 5)
      printed_order = "Lamb x 2\nGambas x 5"
      expect(order.display).to eq printed_order
    end
  end
  
  describe "#reset" do
    it "resets the order (empty the dishes hash)" do
      order.add("Lamb", 2)
      order.add("Gambas", 5)
      order.reset
      expect(order.dishes).to be_empty
    end
  end
end
