require 'rails_helper'

describe Contact do

  #name、email、contentが全て入力されていれば有効な状態であること
  it "is valid with name, email and content" do
    contact = Contact.new(
	                  name: 'hitoshi nakanishi', 
			  email: 'naka24naka24@gmail.com', 
			  content: 'テストです'
                         )
    expect(contact).to be_valid
  end

  #nameが無いと無効な状態であること
  it "is invalid without a name" do
    contact = Contact.new(
	                  email: 'naka24naka24@gmail.com',
			  content: 'テストです'
                         )
    expect(contact).not_to be_valid
    expect(contact.errors[:name]).to include("を入力してください")              				        			
  end
  
  #emailが無いと無効な状態であること
  it "is invalid without a email" do
    contact = Contact.new(
	                  name: 'hitoshi nakanishi',
                          content: 'テストです'
                         )
    expect(contact).not_to be_valid
    expect(contact.errors[:email]).to include("を入力してください")
  end

  #contentが無いと無効な状態であること
  it "is invalid without a content" do
    contact = Contact.new(
	                  name: 'hitoshi nakanishi',
                          email: 'naka24naka24@gmail.com'
                         )			        				        				      					                                					      					    			
    expect(contact).not_to be_valid
    expect(contact.errors[:content]).to include("を入力してください")
  end
end
