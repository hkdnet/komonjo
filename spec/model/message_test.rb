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
          ATTRS.each do |a|
            it "should be able to read attr #{a}" do
              h = {}
              val = r.rand(1000).to_s
              h[a] = val
              m = Komonjo::Model::Message.create(h)
              fail "no method: #{a}" unless m.respond_to? a.to_s
              m.send(a).must_equal val
            end

            it "should be able to write attr #{a}" do
              h = {}
              m = Komonjo::Model::Message.create(h)
              fail "no method: #{a}" unless m.respond_to?("#{a}=")
              val = r.rand(1000)
              m.send("#{a}=", val)
              m.send(a).must_equal val
            end
          end
        end
      end
    end
  end
end
