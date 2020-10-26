# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

x = 11000

until x == 11029
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{x}"
  raw_json = open(url).read
  json = JSON.parse(raw_json)

  if !json['drinks'].nil?
    new_cocktail = Cocktail.new(name: json['drinks'].first['strDrink'])

    image_url = json['drinks'].first['strDrinkThumb']
    file = URI.open(image_url)
    new_cocktail.photo.attach(io: file, filename: "cocktail_#{x}.jpg", content_type: 'image/jpg')
    puts "Photo attached"

    new_cocktail.save!
    puts "New #{x} cocktail saved"

    i = 1

    until json['drinks'].first["strIngredient#{i}"].nil?
      if Ingredient.where(name: json['drinks'].first["strIngredient#{i}"]).exists?
        new_ingredient = Ingredient.where(name: json['drinks'].first["strIngredient#{i}"]).first
        puts "Ingredient #{i} exists"

        if json['drinks'].first["strMeasure#{i}"].nil?
          new_dose = Dose.new(description: 'Some')
        else
          new_dose = Dose.new(description: json['drinks'].first["strMeasure#{i}"])
        end
      else
        new_ingredient = Ingredient.create(name: json['drinks'].first["strIngredient#{i}"])
        puts "New ingredient created #{i}"

        if json['drinks'].first["strMeasure#{i}"].nil?
          new_dose = Dose.new(description: 'Some')
        else
          new_dose = Dose.new(description: json['drinks'].first["strMeasure#{i}"])
          puts "Dose setup done"
        end
      end

      new_dose.cocktail = new_cocktail
      new_dose.ingredient = new_ingredient
      new_dose.save!

      puts "New dose #{i} created"

      i += 1
    end
  end

  x += 1
end
