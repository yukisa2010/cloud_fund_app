User.seed do |s|
  s.id = 1
  s.email = 'admin@example.com'
  s.password = 'password'
  s.status = :admin
end

User.seed do |s|
  s.id = 2
  s.email = 'user@example.com'
  s.password = 'password'
  s.status = :normal
end
