require 'helper'

describe Yotpo::Purchase do
  describe '#create_new_purchase' do
    before(:all) do
      create_new_purchase_request = {
          email: Faker::Internet.email,
          customer_name: Faker::Internet.user_name,
          order_id: '123',
          platform: 'shopify',
          products: [
              p1: {
                  url: 'http://example_product_url1.com',
                  name: 'product1',
                  image: 'http://example_product_image_url1.com',
                  description: 'this is the description of a product'
              }
          ],
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('create_new_purchase') do
        @response = Yotpo.create_new_purchase(create_new_purchase_request)
      end

    end

    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#create_new_purchases' do
    before(:all) do
      create_new_purchase_request = {
          orders: [
              {
                  email: Faker::Internet.email,
                  customer_name: Faker::Internet.user_name,
                  order_id: '123',
                  platform: 'shopify',
                  products: [
                      p1: {
                          url: 'http://example_product_url1.com',
                          name: 'product1',
                          image: 'http://example_product_image_url1.com',
                          description: 'this is the description of a product'
                      }
                  ]


              }
          ],
        utoken: @utoken,
        app_key: @app_key
      }
      VCR.use_cassette('create_new_purchases') do
        @response = Yotpo.create_new_purchases(create_new_purchase_request)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#get_purchases' do
    before(:all) do
      get_purchases_request = {
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('get_purchases') do
        @response = Yotpo.get_purchases(get_purchases_request)
      end
    end

    subject { @response.body.purchases[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :user_email }
    it { should respond_to :user_name }
    it { should respond_to :product_sku }
    it { should respond_to :order_id }
    it { should respond_to :product_name }
    it { should respond_to :product_url }
    it { should respond_to :order_date }
    it { should respond_to :product_description }
    it { should respond_to :product_image }
    it { should respond_to :delivery_date }
    it { should respond_to :created_at }
  end
end