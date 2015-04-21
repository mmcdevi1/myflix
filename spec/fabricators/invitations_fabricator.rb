Fabricator(:invitation) do 
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.email }
  message { "Sign up for myflix" }
end