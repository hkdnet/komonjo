module Komonjo
  module Mock
    # Mock for SlackConnection
    class SlackMock
      class << self
        def chat_logs
          [{ 'text' => '=-=-= this is dummy data =-=-=', 'username' => 'bot',
             'type' => 'message', 'subtype' => 'bot_message',
             'ts' => '1437406342.000007' },
           { 'type' => 'message', 'user' => 'User01', 'text' => 'ほう',
             'ts' => '1437405883.000006', 'username' => 'User01' },
           { 'text' => 'TEST from slack-api', 'username' => 'bot',
             'type' => 'message', 'subtype' => 'bot_message',
             'ts' => '1437405875.000005' },
           { 'type' => 'message', 'user' => 'User02', 'text' => 'fuga',
             'ts' => '1437405463.000004', 'username' => 'User01' },
           { 'type' => 'message', 'user' => 'User02', 'text' => 'hoge',
             'ts' => '1437405463.000003', 'username' => 'User01' },
           { 'user' => 'User01', 'type' => 'message',
             'subtype' => 'channel_join',
             'text' => '<@User01|Username01> has joined the channel',
             'ts' => '1437405457.000002', 'username' => 'User01' }]
        end
      end
    end
  end
end
