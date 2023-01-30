require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a customer_id" do
    subject.customer_id=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product_count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end
  it "is not valid with a product_count less than 1" do
    expect(subject.product_count ).to be >= 1
  end
  it "is not valid if the product_count is not all digits" do
    expect(subject.product_count).to be_a_kind_of(Integer)
  end
end