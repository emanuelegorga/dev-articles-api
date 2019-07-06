# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Article.create([
    { title: 'Article title 1', content: 'Article content 1', slug: 'Article slug 1' },
    { title: 'Article title 2', content: 'Article content 2', slug: 'Article slug 2' },
    { title: 'Article title 3', content: 'Article content 3', slug: 'Article slug 3' }
])
