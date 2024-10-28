 # This file should ensure the existence of records required to run the application in every environment (production,
 # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
 # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
 #
 # Example:
 #
 #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
 #     MovieGenre.find_or_create_by!(name: genre_name)
 #   end
 # db/seeds.rb

 # Borrar todos los usuarios existentes (opcional, solo si deseas reiniciar)
 User.destroy_all

# Crear un usuario administrador
admin_user = User.create!(
  name: "Esteban",
  email: "esteban@empresa.com",
  password: "123456", # Asegúrate de usar una contraseña segura
  password_confirmation: "123456",
  admin: true # Asegúrate de que tu modelo User tenga un atributo admin
)


normal_user = User.create!(
  name: "Carola",
  email: "carola@gmail.com",
  password: "123456", # Cambia a una contraseña segura
  password_confirmation: "123456",
  admin: false # Este usuario no es administrador
)

 puts "Usuario administrador creado: #{admin_user.email}"
 puts "Usuario normal creado: #{normal_user.email}"
