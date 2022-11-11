require 'rest-client'
require 'json'

class VetApi

    def initialize
      @url = 'http://[::1]:3000'
      @headers = {
        'content-type': "application/json",
        'x-apikey': "34d25946-2929-4305-8c68-bcdd55347cc2",
        'cache-control': "no-cache"
      }
    end    

    def call
        response = RestClient.get(@url, @headers)
        body = JSON.parse(response, { symbolize_names: true })
        body
    end
end
 