require_relative 'contact'

class CRM

  def initialize(name)
    puts "This is the #{name} CRM!"
    @name = name
  end

  def main_menu
    while true
        print_main_menu
        user_selected = gets.to_i
        call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
  end

  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Enter a Note: "
    note = gets.chomp

    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )
  end

  def modify_existing_contact
    puts "What is the ID of the contact you'd like to change?"
    which_contact = gets.chomp
    puts "What would you like to change? Enter first_name, last_name, email, or note"
    attribute_to_change = gets.chomp
    puts "What do you want the new value to be?"
    new_value = gets.chomp
    # use the id to select which contact to call the method on
    contact_to_change = Contact.find(which_contact.to_i)
    # call update from contacts (attribute to change, new_value)
    contact_to_change.update(attribute_to_change => new_value)
    puts "New contact information: #{contact_to_change.first_name} #{contact_to_change.last_name},
          #{contact_to_change.email}, #{contact_to_change.note}"
  end

  def delete_contact
    puts "What is the ID of the contact you'd like to delete?"
    which_contact = gets.chomp
    contact_to_delete = Contact.find(which_contact.to_i)
    contact_to_delete.delete
    puts "Contact Deleted"
  end

  def display_all_contacts
    all = Contact.all
    all.each do |contact|
      puts "#{contact.id}: #{contact.last_name}, #{contact.first_name}. #{contact.email}. #{contact.note}"
    end
  end

  def search_by_attribute
    puts "What would you like to search by?  Enter: first_name, last_name, or email"
    attribute_to_search_by = gets.chomp
    puts "What would you like to search for?"
    search_term = gets.chomp
    contact = Contact.find_by(attribute_to_search_by => search_term)
    puts "#{contact.last_name}, #{contact.first_name}. #{contact.email}. #{contact.note}"
  end

end

at_exit do
  ActiveRecord::Base.connection.close
end
