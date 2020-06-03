class Cli
    require 'tty-prompt'
    
  
    def run
        # welcome
        Api.get_characters
        main
    end


    def main
        response = print_menu
        id = valid_id?(response)
        superhero = Superhero.find_by_id(id)
       print_details(superhero)
       want_more_information?(superhero)
    end

    def second_request(superhero)
        id = superhero.id
        #binding.pry
        updated_superhero = get_first_comic(id)
        print_comic_details(updated_superhero)
        print_continue
    end

#We use the following methods when not using the tty-prompt
    # def welcome
    #     puts "Welcome to the Marvel Superhero CLI!"
    #     puts "What Superhero do you want to know about? Here's a list!"
    # end

    # def ask_for_input
    #     puts "Please select a superhero by number."  
    # end

    # def get_input
    #     gets.strip
    #  end

    

    def print_menu
        prompt = TTY::Prompt.new
       prompt.enum_select("Welcome to the Marvel Superhero CLI!\n What Superhero do you want to know about? Here's a list!\n Enter a number from the list to see more info about that character \n\n", Superhero.choices, per_page: 20)
    end

    def print_details(superhero)
        puts "Name: #{superhero.name}"
        puts "Superhero Description: #{superhero.description}"
        puts "Image: #{superhero.image}"
        puts "Bio Link: #{superhero.bio_link}"
        puts "Comic Link: #{superhero.comic_link}"
    end

    def print_comic_details(superhero)
        puts "First Comic #{superhero.name} Appeared In!"
        puts "Title: #{superhero.title}"
        puts "Description: #{superhero.comic_description}"
        puts "Page Count: #{superhero.page_count}"
        puts "Available Copies: #{superhero.available_copies}"
        puts "Print Price: #{superhero.print_price}"
        puts "Digital Price: #{superhero.digital_price}"
        puts "Purchase Here: #{superhero.purchase_link}"
    end

    def print_continue
        puts "Would you like to search again? (yes/no)"
        response = gets.strip.downcase
        if response == "yes" || response == "y"
            run
        elsif response == "no" || response =="n"
        print_goodbye
        exit
        else 
            print_error
            sleep 1
            print_continue
        end
    end

    def print_goodbye
       puts "Thank you for searching! Be Super! Goodbye"
    end

    def print_error
        puts "That is an invaild selection. Please select again."
    end


    def want_more_information?(superhero)
        puts "Would you like to know the first comic this Superhero appeared in? Please enter yes or no."
        response = gets.strip.downcase
        if response == "yes" || response == "y"
            second_request(superhero)
        elsif response == "no" || response == "n"
        "Thank you for searching! Be Super! Goodbye"
        exit
        else 
            print_error
            sleep 1
            want_more_information?
        end
    end

 

    def valid_id?(id)
        id = id.to_i
        if id < 1 || id > Superhero.all.size
            print_error
            sleep 1
            main
        end
            id
    end


    def get_first_comic(id)
        Api.get_first_appeared_comic(id)
    end

end