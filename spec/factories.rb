require 'rails_helper'
require 'faker'

FactoryBot.define do
    factory :customer do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
    end
  
    factory :merchant do
      name { Faker::Company.name }
      status { 'active' }
    end
  
    factory :item do
      name { Faker::Commerce.product_name }
      description { Faker::Lorem.sentence }
      unit_price { Faker::Number.decimal(l_digits: 2) }
      status { 'active' }
      merchant
    end
  
    factory :invoice do
        status { ['completed', 'in progress'].sample } 
        customer
      end
  
    factory :transaction do
      credit_card_number { Faker::Business.credit_card_number }
      credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
      invoice
      result { 'success' }
    end
  
    factory :invoice_item do
        quantity { 1 }
        unit_price { 10 }
        status { 'pending' } 
        invoice
        item
      end
  end
  