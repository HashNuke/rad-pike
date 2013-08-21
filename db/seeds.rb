# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Creating issue state types..."
["Resolved", "Unresolved", "Unknown"].each do |issue_state_type|
  IssueStateType.find_or_create_by_name issue_state_type
end

puts "Creating user roles..."
["Admin", "Staff", "Deactivated Staff", "Customer", "Guest"].each do |role_name|
  Role.find_or_create_by_name role_name
end

puts "Creating first admin user"
User.find_or_create_by_email("admin@example.com",
  password: "password",
  role_id:  Role.admin.id,
  name: "Support Superhuman")
