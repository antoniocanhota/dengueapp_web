#encoding: UTF-8
FactoryGirl.define do
  factory :dispositivo do
    
    sequence(:identificador_do_hardware) {|n| "F_HARDWARE_#{n}"}
    
    factory :dispositivo_smartphone do
      
      sequence(:telefone) { |n| "F_TELEFONE_#{n}" }
      
      factory :dispositivo_smartphone_android do
        sequence(:identificador_do_android) { |n| "F_ANDROID_#{n}"}
      end
      
      factory :dispositivo_iphone do
        #Implementar futuramente
      end
      
    end

    factory :dispositivo_tablet do     
            
      factory :dispositivo_tablet_android do
        sequence(:identificador_do_android) { |n| "F_ANDROID_#{n}"}
      end
      
      factory :dispositivo_ipad do
        #Implementar futuramente
      end
      
    end 
    
  end
end