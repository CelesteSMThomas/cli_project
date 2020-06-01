class Cli
    
    def run
        welcome
        Api.get_characters
        main
    end


    def main
        print_all
        ask_for_input
        id = valid_id?(get_input)
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


    def welcome
        puts "Welcome to the Marvel Superhero CLI!"
        puts "What Superhero do you want to know about? Here's a list!"
    end


    def ask_for_input
        puts "Please select a superhero by number."
    end
    

    def print_all
        Superhero.all.each do |s| 
            puts "#{s.id}. #{s.name}"
        end
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


    def get_input
       gets.strip
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