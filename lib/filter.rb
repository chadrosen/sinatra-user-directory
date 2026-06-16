module UserFilter
  def self.apply(users, role)
    return users unless role && !role.empty?
    users.select! { |u| u['role'] == role.downcase }
    users
  end
end
