require 'grape'
require_relative 'lib/models/api/response_base'

# API class
class API < Grape::API
  format :json

  get 'channels' do
    api_token = params[:api_token]
    res = Komonjo::Model::API::ResponseBase.new
    if !api_token.nil? && api_token != ''
      channels_service = Komonjo::Service::ChannelsService.new(api_token)
      res.data = channels_service.channels.map(&:name)
    else
      res.ok = false
      res.message = 'ERROR: api_token is required.'
    end
    res
  end

  get 'messages' do
    { recource: 'messages' }
  end
end
