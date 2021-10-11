module UserHelper 

  def self.digest_password(password)
    Digest::SHA384.hexdigest password
  end

end  