require_relative '../spec_helper'

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
    ATTRS.each do |a|
      it "should be able to read attr #{a}" do
        h = {}
        val = r.rand(1000).to_s
        h[a] = val
        u = Komonjo::Model::User.create(h)
        fail "no method: #{a}" unless u.respond_to? a.to_s
        u.send(a).must_equal val
      end

      it "should be able to write attr #{a}" do
        h = {}
        u = Komonjo::Model::User.create(h)
        fail "no method: #{a}" unless u.respond_to?("#{a}=")
        val = r.rand(1000)
        u.send("#{a}=", val)
        u.send(a).must_equal val
      end
    end
  end
end
