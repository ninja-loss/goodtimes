module Goodtimes
  module DateTimeFormats

    def self.import( *formats )
      date_time_formats( *formats ).each do |format, pattern|
        Date::DATE_FORMATS.merge!( format => pattern )
        Time::DATE_FORMATS.merge!( format => pattern )
      end

      time_formats( *formats ).each do |format, pattern|
        Time::DATE_FORMATS.merge!( format => pattern )
      end
    end

    def self.time_formats( *formats )
      time_formats = {
        :military_time                 => "%R",
        :military_time_with_zone       => "%R %Z",
      }

      formats.empty? ?
        time_formats :
        time_formats.select { |format, pattern| formats.include?( format ) }
    end

    def self.date_time_formats( *formats )
      date_time_formats = {
        :isdn                          => "%Y-%m-%d",
        :isdn_with_time                => "%Y-%m-%d %I:%M %p",
        :isdn_with_time_long           => "%Y-%m-%d %I:%M:%S %p",
        :timestamp                     => "%Y%m%d%H%M%S",
        :timestamp_long                => "%Y%m%d%H%M%S%L",
        :time_only                     => "%I:%M:%S %p %Z",
        :us                            => "%B %d, %Y",
        :us_abbreviated                => "%b. %d, %Y",
        :us_abbreviated_with_time      => "%b. %d, %Y %I:%M %p",
        :us_abbreviated_with_time_long => "%b. %d, %Y %I:%M:%S %p",
        :us_long                       => "%B %d, %Y at %I:%M:%S %p",
        :us_long_with_zone             => "%B %d, %Y at %I:%M:%S %p %z",
        :us_short                      => "%m-%d-%Y",
        :us_short_slashed              => "%Y/%m/%d",
        :us_slashed_long               => "%Y/%m/%d %I:%M:%S"
      }

      formats.empty? ?
        date_time_formats :
        date_time_formats.select { |format, pattern| formats.include?( format ) }
    end

  end
end
