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
        
        