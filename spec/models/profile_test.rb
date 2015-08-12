module KomonjoTest
  module Model
    # test for Komonjo::Model::Profile
    module ProfileTest
      describe Komonjo::Model::Profile do
        describe 'create' do
          it 'should return an instance of User' do
            h = {}
            u = Komonjo::Model::Profile.create(h)
            u.class.must_equal Komonjo::Model::Profile
          end
        end
        describe 'attributes' do
          ATTRS = %i(first_name last_name real_name email skype phone image_24
                     image_32 image_48 image_72 image_192 )
          r = Random.new
          ATTRS.each do |e|
            it "should be able to read attr #{e}" do
              h = {}
              val = r.rand(1000).to_s
              h[e] = val
              u = Komonjo::Model::Profile.create(h)
              fail "no method: #{e}" unless u.respond_to? e.to_s
              u.send(e).must_equal val
            end

            it "should be able to write attr #{e}" do
              h = {}
              u = Komonjo::Model::Profile.create(h)
              fail "no method: #{e}" unless u.respond_to?("#{e}=")
              val = r.rand(1000)
              u.send("#{e}=", val)
              u.send(e).must_equal val
            end
          end
        end
      end
    end
  end
end
