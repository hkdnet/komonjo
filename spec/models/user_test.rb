module KomonjoTest
  module Model
    # test for Komonjo::Model::User
    module UserTest
      describe Komonjo::Model::User do
        describe 'create' do
          it 'should return an instance of User' do
            h = {}
            u = Komonjo::Model::User.create(h)
            u.class.must_equal Komonjo::Model::User
          end
        end
        describe 'attributes' do
          ATTRS = %i(id name deleted color is_admin is_owner is_primary_owner
                     is_restricted is_ultra_restricted has_2fa has_files)
          r = Random.new
          ATTRS.each do |e|
            it "should be able to read attr #{e}" do
              h = {}
              val = r.rand(1000).to_s
              h[e] = val
              u = Komonjo::Model::User.create(h)
              fail "no method: #{e}" unless u.respond_to? e.to_s
              u.send(e).must_equal val
            end

            it "should be able to write attr #{e}" do
              h = {}
              u = Komonjo::Model::User.create(h)
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
