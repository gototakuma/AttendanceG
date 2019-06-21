User.create!(name:  "管理者",
             email: "email@sample.com",
             belongs: "社長",
             code: "1",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             instructor: false)

3.times do |n|
  name = "上長#{n+1}"
  email = "instructor#{1+n}@sample.com"
  code = 2+n
  User.create!(name: name,
             email: email,
             belongs: "取締役",
             code: code,
             password: "password",
             password_confirmation: "password",
             admin: false,
             instructor: true)
end

5.times do |n|
  name  = Faker::Name.name
  email = "email#{n+1}@sample.com"
  belongs = "営業部(#{n+1})"
  code = n+10
  password = "password"
  User.create!(name:  name,
               email: email,
               belongs: belongs,
               code: code,
               password:              password,
               password_confirmation: password)
end
