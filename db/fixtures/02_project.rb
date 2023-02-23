Project.seed do |s|
  s.id = 1
  s.name = 'テストプロジェクト1'
  s.description = 'これはテスト用プロジェクトです。'
  s.user = User.first
end

Project.seed do |s|
  s.id = 2
  s.name = 'テストプロジェクト2'
  s.description = 'これはテスト用プロジェクトです。'
  s.user = User.second
end

Project.seed do |s|
  s.id = 3
  s.name = 'テストプロジェクト3'
  s.description = 'これはテスト用プロジェクトです。'
  s.user = User.second
end
