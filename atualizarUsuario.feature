Feature: Atualizar um usuário
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas

    Background: Configuar Url 
        Given url baseUrl
        And path "users"
        Scenario: Atualizar usuário com sucesso
            * def temp = call read("utils/criarUsuario.feature")
            * set temp.createdUser.email = "ashe@tokyo.jp"
            * set temp.createdUser.name = "Ashelia B'nargin Dalmasca"
            Given request temp.createdUser
            And path temp.createdUser.id
            When method put
            Then status 200
            And match response.id == temp.createdUser.id
            And match response.name == temp.createdUser.name
            And match response.email == temp.createdUser.email
            And match response.createdAt == temp.createdUser.createdAt
            And match response.updatedAt == "#string"

            # apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp
        Scenario: Atualizar usuário sem email
            * def temp = call read("utils/criarUsuario.feature")
            * def user = {name: "#(temp.createdUser.name)"}
            Given request user
            And path temp.createdUser.id
            When method put
            Then status 400

            # apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp
        Scenario: Atualizar usuário sem nome
            * def temp = call read("utils/criarUsuario.feature")
            * def user = {email: "#(temp.createdUser.email)"}
            Given request user
            And path temp.createdUser.id
            When method put
            Then status 400

            # apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp
        Scenario: Criar usuário com email inválido
            * def temp = call read("utils/criarUsuario.feature")
            * def user = {name: "#(temp.createdUser.name)", email: "asddd"}
            Given request user
            And path temp.createdUser.id
            When method put
            Then status 400

             # apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp
        #Os dois testes abaixo atualizam usuários com email 59, 60 e 61 caracteres
        Scenario Outline: Atualizar usuário com email <email>
            * def temp = call read("utils/criarUsuario.feature")
            * def user = {name: "#(temp.createdUser.name)", email: "#(email)"}
            
            Given request user
            And path temp.createdUser.id
            When method put
            Then status 200
            And match response.id == temp.createdUser.id
            And match response.name == user.name
            And match response.email == user.email
            And match response.createdAt == temp.createdUser.createdAt
            And match response.updatedAt == "#string"

            #apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp
        
            Examples:
                | email                                                       |
                | hanabihanabihanabihanabihabihabihanabihanabihanab@email.com |
                | hanabihanabihanabihanabihabihabihanabihanabihanabi@email.com|
        Scenario: Criar usuário com email de 61 caracteres
            * def temp = call read("utils/criarUsuario.feature")
            * def user = {name: "#(temp.createdUser.name)", email: "hanabihanabihanabihanabihabihabihanabihanabihanabih@email.com"}
            
            Given request user
            And path temp.createdUser.id
            When method put
            Then status 400

             #apaga o usuário criado
            * call read("utils/deletarUsuario.feature") temp