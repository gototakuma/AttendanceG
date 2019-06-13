User.create!(name:  "管理者",
             email: "email@sample.com",
             belongs: "社長",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             instructor: true)

User.create!(name: "指示者",
             email: "instructor@sample.com",
             belongs: "取締役",
             password: "password",
             password_confirmation: "password",
             admin: true,
             instructor: true)

59.times do |n|
  name  = Faker::Name.name
  email = "email#{n+1}@sample.com"
  belongs = "営業部(#{n+1})"
  password = "password"
  User.create!(name:  name,
               email: email,
               belongs: belongs,
               password:              password,
               password_confirmation: password)
end
