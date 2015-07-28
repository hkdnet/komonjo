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
          ATTRS.each do |a|
            it "should be able to read attr #{a}" do
              h = {}
              val = r.rand(1000).to_s
              h[a] = val
              u = Komonjo::Model::Profile.create(h)
              fail "no method: #{a}" unless u.respond_to? a.to_s
              u.send(a).must_equal val
            end

            it "should be able to write attr #{a}" do
              h = {}
              u = Komonjo::Model::Profile.create(h)
              fail "no method: #{a}" unless u.respond_to?("#{a}=")
              val = r.rand(1000)
              u.send("#{a}=", val)
              u.send(a).must_equal val
            end
          end
        end
      end
    end
  end
end
