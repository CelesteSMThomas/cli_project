class Api

    require 'digest'
    TS = Time.now.to_i.to_s
    HASH = Digest::MD5.hexdigest(TS + ENV['PRIVATE_KEY'] + ENV['PUBLIC_KEY'])
    BASE_URL = "http://gateway.marvel.com/v1/public/characters?ts=#{TS}&apikey=#{ENV['PUBLIC_KEY']}&hash=#{HASH}"


    def self.get_characters
        res = RestClient.get(BASE_URL + "&limit=100")
        data = JSON.parse(res.body)
        counter = 1
        data["data"]["results"].each { |superhero| 
            name = superhero["name"] 
            description = superhero["description"]
            comic_link = superhero["urls"][-1]["url"]
            image = superhero["thumbnail"]["path"] + ".jpg"
            id = counter
            marvel_id = superhero["id"]
            counter += 1
        Superhero.new(name, description, image, comic_link, marvel_id, id)
    }
    res = RestClient.get(BASE_URL + "&limit=100&offset=100")
        data = JSON.parse(res.body)
        counter = 101
        data["data"]["results"].each { |superhero| 
            name = superhero["name"] 
            description = superhero["description"]
            comic_link = superhero["urls"][-1]["url"]
            image = superhero["thumbnail"]["path"] + ".jpg"
            id = counter
            marvel_id = superhero["id"]
            counter += 1
           
        Superhero.new(name, description, image, comic_link, marvel_id, id)
    }
    end

    def self.get_first_available_comic(id)
        selected_superhero = Superhero.find_by_index(id)
        new_url = BASE_URL.split("?").join("/#{selected_superhero.marvel_id}/comics?") + "&limit=1"
        res = RestClient.get(new_url)
        data = JSON.parse(res.body)
        comic = data["data"]["results"][0]
        title = comic["title"] 
        if comic["description"] == nil
            comic_description = "Unfortunately, there is no description for this comic."
        else 
            comic_description = comic["description"]
        end
        page_count = comic["pageCount"]
        available_copies = comic["creators"]["available"]
        if comic["urls"][1] == nil
            purchase_link = "Unfortunately, there is no link for this comicbook."
        else 
            purchase_link = comic["urls"][1]["url"]
         end

        if comic["prices"][0]["price"] == 0 || comic["prices"][0]["price"] == nil
        print_price = "There is no print price available."
        else 
            print_price = comic["prices"][0]["price"]
        end
        if comic["prices"][1] == nil || comic["prices"][1]["price"] == 0 
        digital_price = "There is no digital price available."
        else 
            digital_price = comic["prices"][1]["price"]
        end
        selected_superhero.update(title, comic_description, page_count, available_copies, purchase_link, print_price, digital_price)
        selected_superhero
    end

end
