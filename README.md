# cli_project
**First CLI Project**

This CLI allows you to access specific details of a Marvel Super-Hero.

MARVEL API DOCUMENTATION: https://developer.marvel.com/documentation/generalinfo
https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0


First run bundle install or bundle, which will install all of the required gems for you.

Next create an .env file by cding into cli_project and typing: touch .env

Update your env file with the following keys obtained from Marvel
PRIVATE_KEY = "your private key"
PUBLIC_KEY = "your public key"

This allows you to successfully hide your public and private key which allows you to successfully access your get request.

The get_characters method limits the superheroes to 200. If you would like to obtain more superheros you will need to instantiate another get request and start your offset at 201 as well as your counter.

Next run bin/run which will activate the program.

Make a selection of the super hero you are interested in by number and press enter.

You will receive back the following information; Super-Hero name, description, image, biography, and a link to all the comics that Super-Hero has appeared in.

Next you will receive the option to learn about the first available comic for this Super-Hero. If you select yes you will then receive that comic's title, page count, copies available


