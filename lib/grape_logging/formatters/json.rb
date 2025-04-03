module GrapeLogging
  module Formatters
    class Json
      def call(severity, datetime, _, data)
        payload = {
          date: datetime,
          severity: severity,
          data: format(data)
        }

        payload.to_json + "\n"
      rescue JSON::GeneratorError, Encoding::UndefinedConversionError => e
        payload.to_s + "\n"
      end

      private

      def format(data)
        if data.is_a?(String) || data.is_a?(Hash)
          data
        elsif data.is_a?(Exception)
          format_exception(data)
        else
          data.inspect
        end
      end

      def format_exception(exception)
        {
          exception: {
            message: exception.message
          }
        }
      end
    end
  end
end
