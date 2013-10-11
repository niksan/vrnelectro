namespace :export do
  
  task iek: :environment do
    Export::Iek.do!  
  end

end
