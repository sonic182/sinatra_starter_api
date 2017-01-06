require 'sequel'

# DB = RUBY_PLATFORM == "java" ? Sequel.connect('jdbc:sqlite::memory') : Sequel.sqlite # for in memory sqlite3
DB = RUBY_PLATFORM == "java" ? Sequel.connect('jdbc:sqlite:db.sqlite3') : Sequel.sqlite

unless DB.table_exists?(:items)
  DB.create_table :items do
    primary_key :id
    String :name
    Float :price
  end
end

items = DB[:items] # Create a dataset
#
# # Populate the table
items.insert(:name => 'First In Memory', :price => rand * 100)
items.insert(:name => 'Seccond', :price => rand * 100)
items.insert(:name => 'Third', :price => rand * 100)
#
# # Print out the number of records
# puts "Item count: #{items.count}"
#
# # Print out the average price
# puts "The average price is: #{items.avg(:price)}"
