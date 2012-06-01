#encoding: UTF-8
FactoryGirl.define do
  
  sequence :nome do |n|
    "Fulano #{n}"
  end
  
  sequence :email do |n|
    "fulano#{n}@mail.com"
  end
  
  factory :usuario do
    nome { Factory.next(:nome) }
    password "qwerty123"
    email { Factory.next(:email) }
    
  end
end