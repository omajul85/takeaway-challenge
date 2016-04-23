require 'takeaway'
require 'menu'
require 'order'

describe Takeaway do
  subject(:takeaway) { described_class.new(menu, order) }
  let(:dishes) { {"Chicken"=>4.5, "Pork"=>5.5, "Steak"=>9.3} }
  let(:menu) { Menu.new dishes }
  let(:order) { Order }
  let(:printed_menu) { "Chicken: £4.50\nPork: £5.50\nSteak: £9.30" }
  let(:printed_order) { "Chicken x 2\nSteak x 5" }
    
  it "read the menu" do
    expect(takeaway.print_menu).to eq printed_menu
  end
  
  it "selects some number of several available dishes" do
    takeaway.select_dish("Chicken", 3)
    expect(takeaway.order.dishes).to include "Chicken"
  end
  
  it "unselects a dish" do
    takeaway.unselect_dish("Chicken")
    expect(takeaway.order.dishes).not_to include "Chicken"
  end
  
  it "prints the total" do
    takeaway.select_dish("Chicken", 3)
    expect(takeaway.total).to eq 13.5
  end
  
  describe "#print_current_order" do
    it "prints the current order if not empty" do
      takeaway.select_dish("Chicken", 2)
      takeaway.select_dish("Steak", 5)
      expect(takeaway.print_current_order).to eq printed_order  
    end
    
    it "raise error if order is empty" do
      expect { takeaway.print_current_order }.to raise_error Order::ERR_EMPTY_ORDER
    end
  
  end
  
  it "raise error if selected dish is not available" do
    expect { takeaway.select_dish("Fish", 3) }.to raise_error Order::ERR_INVALID_ORDER
  end
end