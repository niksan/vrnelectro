class PaperTrail::Version < ActiveRecord::Base
=begin
  if defined?(Rails::Console)
    PaperTrail.whodunnit = "#{`whoami`.strip}: console"
  elsif File.basename($0) == "rake"
    PaperTrail.whodunnit = "#{`whoami`.strip}: rake #{ARGV.join ' '}"
  end
=end
end
