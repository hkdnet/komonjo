require 'grape'
require_relative 'lib/models/api/response_base'

# API class
class API < Grape::API
  format :json

  get 'channels' do
    res = Komonjo::Model::API::ResponseBase.new
    api_token = params[:api_token] || ''
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
    res = Komonjo::Model::API::ResponseBase.new
    api_token = params[:api_token] || ''
    channel_name = params[:channel_name] || ''
    if api_token != '' && channel_name != ''
      messages_service = Komonjo::Service::MessagesService.new(api_token)
      res.data = messages_service.messages(channel_name)
    else
      res.ok = false
      res.message = 'ERROR: api_token and channel_name are required.'
    end
    res
  end
end
