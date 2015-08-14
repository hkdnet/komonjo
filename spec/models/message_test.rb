module KomonjoTest
  module Model
    # test for Komonjo::Model::Message
    module MessageTest
      describe Komonjo::Model::Message do
        describe 'create' do
          it 'should return an instance of User' do
            h = {}
            u = Komonjo::Model::Message.create(h)
            u.class.must_equal Komonjo::Model::Message
          end
        end
        describe 'attributes' do
          ATTRS = %i(type channel user text ts edited subtype)
          r = Random.new
          ATTRS.each do |e|
            it "should be able to read attr #{e}" do
              h = {}
              val = r.rand(1000).to_s
              h[e] = val
              m = Komonjo::Model::Message.create(h)
              fail "no method: #{e}" unless m.respond_to? e.to_s
              m.send(e).must_equal val
            end

            it "should be able to write attr #{e}" do
              h = {}
              m = Komonjo::Model::Message.create(h)
              fail "no method: #{e}" unless m.respond_to?("#{e}=")
              val = r.rand(1000)
              m.send("#{e}=", val)
              m.send(e).must_equal val
            end
          end
        end
        describe 'markdowns' do
          describe 'to_markdown' do
            ts = Time.local(2006, 1, 2, 15, 4, 6)
            u = Komonjo::Model::User.create(
              name: 'test01',
              profile: {
                image_48: 'icon_url' })
            m = Komonjo::Model::Message.create(ts: ts, text: 'test', user: u)

            it 'should return non-nested icon' do
              m.icon_markdown.must_equal "* ![test01 icon](icon_url)\n"
            end

            it 'should return nested name' do
              m.name_markdown.must_equal "\t- test01\n"
            end

            it 'should return nested ts' do
              m.ts_markdown
                .must_equal "\t- 2006-01-02 15:04:06\n"
            end

            it 'should return nested text' do
              m.text_markdown
                .must_equal "\t- test\n"
            end

            it 'should be equal to all markdowns' do
              m.to_markdown.must_equal [
                m.icon_markdown,
                m.name_markdown,
                m.ts_markdown,
                m.text_markdown
              ].join
            end
          end
        end
      end
    end
  end
end
