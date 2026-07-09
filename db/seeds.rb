# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Create admin custodian and account if they don't exist 
account = Account.find_or_create_by!(admin_custodian_fname: 'Admin1')
custodian = account.custodians.find_or_create_by!(fname: 'Admin1', email: 'admin1@example.com')
custodian.update!(is_admin: true)
account.update!(admin_custodian_id: custodian.id)
