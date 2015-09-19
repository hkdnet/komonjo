require 'lib/gateways/messages_gateway'

module Komonjo
  module Mock
    # Mock for SlackConnection
    class SlackMock
      class << self
        def chat_logs
          g = Komonjo::Gateway::MessagesGateway.new(channels_history('test'),
                                                    users_list)
          g.messages
        end

        def users_list
          [{ id: 'id001', name: 'name001', deleted: false,
             profile: { image_48: '' } },
           { id: 'id002', name: 'name002', deleted: false,
             profile: { image_48: '' } }]
        end

        def channels_history(channel_name)
          [{ type: 'message', user: 'id001', channel: channel_name,
             text: 'Hello, world' },
           { type: 'message', user: 'id002', channel: channel_name,
             text: 'This is Komonjo' }]
        end

        def channels_list
          [{
            'id': 'C024BE91L',
            'name': 'channel1',
            'is_channel': 'true',
            'created': 1_360_782_804,
            'creator': 'U024BE7LH',
            'is_archived': false,
            'is_general': false,
            'members': %w(U024BE7LH U024BE7LH),
            'topic': {
              'value': 'Fun times',
              'creator': 'U024BE7LV',
              'last_set': 1_369_677_212
            },
            'purpose': {
              'value': 'This channel is for fun',
              'creator': 'U024BE7LH',
              'last_set': 1_360_782_804
            },
            'is_member': true,
            'last_read': '1401383885.000061',
            'latest': {
              'hoge': 'fuga'
            },
            'unread_count': 0,
            'unread_count_display': 0
          }, {
            'id': 'C024BE91L',
            'name': 'channel1',
            'is_channel': 'true',
            'created': 1_360_782_804,
            'creator': 'U024BE7LH',
            'is_archived': false,
            'is_general': false,
            'members': %w(U024BE7LH U024BE7LH),
            'topic': {
              'value': 'Fun times',
              'creator': 'U024BE7LV',
              'last_set': 1_369_677_212
            },
            'purpose': {
              'value': 'This channel is for fun',
              'creator': 'U024BE7LH',
              'last_set': 1_360_782_804
            },
            'is_member': true,
            'last_read': '1401383885.000061',
            'latest': {
              'hoge': 'fuga'
            },
            'unread_count': 0,
            'unread_count_display': 0
          }]
        end
      end
    end
  end
end
