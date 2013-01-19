require 'goodtimes'

module Goodtimes

  if defined? Rails::Railtie
    require 'rails'

    class Railtie < Rails::Railtie
      initializer 'goodtimes.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          Goodtimes::Railtie.insert
        end
      end

      #rake_tasks do
        #load "tasks/paperclip.rake"
      #end
    end

  end

  class Railtie

    def self.insert
      ActiveRecord::Base.send :include, Goodtimes::AttrWriters
    end

  end

end
