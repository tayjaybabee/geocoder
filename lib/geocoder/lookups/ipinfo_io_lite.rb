require 'geocoder/lookups/base'
require 'geocoder/results/ipinfo_io_lite'

module Geocoder::Lookup
  class IpinfoIoLite < Base
    def name
      'Ipinfo.io Lite'
    end

    private # ---------------------------------------------------------------

    def base_query_url(query)
      url = "#{protocol}://api.ipinfo.io/lite/#{query.sanitized_text}"
      url << '?' if configuration.api_key
      url
    end

    def results(query)
      # don't look up a loopback or private address, just return the stored result
      return [reserved_result(query.text)] if query.internal_ip_address?

      if !(doc = fetch_data(query)).is_a?(Hash) or doc['error']
        []
      else
        [doc]
      end
    end

    def reserved_result(ip)
      {
        'ip' => ip,
        'bogon' => true
      }
    end

    def query_url_params(query)
      {
        token: configuration.api_key
      }.merge(super)
    end
  end
end
