module Goodtimes

  module AttrWriters

    def self.included( base )
      base.extend ClassMethods
    end

    module ClassMethods

      def date_attr_writer( *args )
        options = args.extract_options!
        format = options[:format]

        if format
          if format.is_a?( Symbol )
            format_key = format
            if Date::DATE_FORMATS.has_key?( format_key )
              format = Date::DATE_FORMATS[format_key]
            else
              raise "The format key :#{format_key} is not a defined date format"
            end
          end
        else
          unless Date::DATE_FORMATS.has_key?( :default )
            raise 'You must provide a format option or define a :default date format'
          end
          format = Date::DATE_FORMATS[:default]
        end

        args.each do |attr|
          define_method "#{attr}=" do |date|
            if date.is_a?( String )
              date = date.blank? ? nil : Date.strptime( date, format )
            end
            write_attribute( attr, date )
          end
        end
      end

      def time_attr_writer( *args )
        options = args.extract_options!
        format = options[:format]

        if format
          if format.is_a?( Symbol )
            format_key = format
            if Time::DATE_FORMATS.has_key?( format_key )
              format = Time::DATE_FORMATS[format_key]
            else
              raise 'The format key you provided is not a defined date format'
            end
          end
        else
          unless Time::DATE_FORMATS.has_key?( :default )
            raise 'You must provide a format option or define a default date format'
          end
          format = Time::DATE_FORMATS[:default]
        end

        args.each do |attr|
          define_method "#{attr}=" do |date|
            write_attribute( attr, date.blank? ? nil : Time.strptime( date, format ))
          end
        end
      end

    end

  end

end
