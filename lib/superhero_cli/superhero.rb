class Superhero 
    attr_reader :name, :description, :bio_link, :image, :comic_link, :marvel_id, :id
    attr_accessor :title, :comic_description, :page_count, :available_copies, :purchase_link, :print_price, :digital_price
    @@all = []
    @@choices = {}

    def initialize(name, description, bio_link, image, comic_link, marvel_id, id)
        @name = name
       if description == ""
        @description = "This Superhero does not have a description."
        else
            @description = description
       end
        @bio_link = bio_link
        @comic_link = comic_link
        @image = image
        @marvel_id = marvel_id
        @id = id
        @@choices[name] = id
        @@all << self
    end

    def self.all
        @@all
    end

    def self.choices
        @@choices
    end

    def update(title, comic_description, page_count, available_copies, purchase_link, print_price, digital_price)
        self.title = title
        self.comic_description = comic_description
        self.page_count = page_count
        self.available_copies = available_copies
        self.purchase_link = purchase_link
        self.print_price = print_price
        self.digital_price = digital_price
    end

    def self.find_by_index(id)
        index = id.to_i - 1
        all[index]
        #binding.pry
    end

end