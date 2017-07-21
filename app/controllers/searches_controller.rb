class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'V3T4USV0I1JRYUBKS2QKJN4HIIQIR1HV413RA3O2LM0TLSDJ'
      req.params['client_secret'] = 'RLHF1HDWZEQ110JZBRIKLJTFLQ1S0ZJUIBQPVNJSQQ2OUOOZ'
      req.params['near'] = params[:zipcode]
      req.params['v'] = '20170720'
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash['response']['venues']
    else
      @error = body_hash['meta']['errorDetail']
    end
    render 'search'
  end
end
