Feature: Criar Usuário
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente

    Background: Configuar Url 
        Given url baseUrl
        And path "users"

        Scenario: Criar usuário com sucesso
            * def user = {name: "Iida Masayuki", email: "iida@email.com"}
            Given request user
            When method post
            Then status 201
            And match response contains user
            # checa se os outros atributos são do tipo especificado
            And match response.id == "#string"
            And match response.createdAt == "#string"
            And match response.updatedAt == "#string"

            # apaga o usuário criado
            * def createdUser = user
            * set createdUser.id = response.id
            * call read("utils/deletarUsuario.feature") createdUser

        Scenario: Criar usuário sem email
            * def user = {name: "Idda Masayuki"}
            Given request user
            When method post
            Then status 400

        Scenario: Criar usuário sem nome
            * def user = {email: "iida@email.com"}
            Given request user
            When method post
            Then status 400

        Scenario: Criar usuário com email inválido
            * def user = {email: "iida@email"}
            Given request user
            When method post
            Then status 400

        #Os dois testes abaixo criam usuários com email 59, 60 e 61 caracteres
        Scenario Outline: Criar usuário com email <email>
            * def user = {name: "Hanabi", email: "#(email)"}
            Given request user
            When method post
            Then status <responseCode>
            And match response contains user
            # checa se os outros atributos são do tipo especificado
            And match response.id == "#string"
            And match response.createdAt == "#string"
            And match response.updatedAt == "#string"

            # apaga o usuário criado
            * def createdUser = user
            * set createdUser.id = response.id
            * call read("utils/deletarUsuario.feature") createdUser
        
            Examples:
                | email                                                       | responseCode | 
                | hanabihanabihanabihanabihabihabihanabihanabihanab@email.com | 201          | 
                | hanabihanabihanabihanabihabihabihanabihanabihanabi@email.com| 201          |
        
        Scenario: Criar usuário com email de 61 caracteres
            * def user = {name: "Hanabi", email: "hanabihanabihanabihanabihabihabihanabihanabihanabih@email.com"}
            Given request user
            When method post
            Then status 400

        #os dois testes abaixo criam usuários com nome de 99, 100 e 101 caracteres
        Scenario Outline: Criar usuário com nome <name>
            * def user = {name: "#(name)", email: "kira@email.com"}
            Given request user
            When method post
            Then status 201
            And match response contains user
            # checa se os outros atributos são do tipo especificado
            And match response.id == "#string"
            And match response.createdAt == "#string"
            And match response.updatedAt == "#string"

            # apaga o usuário criado
            * def createdUser = user
            * set createdUser.id = response.id
            * call read("utils/deletarUsuario.feature") createdUser
        
            Examples:
                | name                                                                                                | 
                | YoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikag |
                | YoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikage|
        
        Scenario: Criar usuário com nome de 101 caracteres
            * def user = {name: "YoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageKiraYoshikageK", email: "kira@email.com"}
            Given request user
            When method post
            Then status 400
        
        Scenario: Criar usuário com mesmo email
            * def user1 = {name: "Iida Masayuki", email: "iida@email.com"}
            * def user2 = {name: "Iida Masayuki", email: "iida@email.com"}
            Given request user1
            When method post

            * set user1.id = response.id
            * def responseMessage = { error: "User already exists." }
            
            Given path "users"
            Given request user2
            When method post
            Then status 422
            And match response == responseMessage

            # apaga o usuário criado
            * def createdUser = user1
            * call read("utils/deletarUsuario.feature") createdUser