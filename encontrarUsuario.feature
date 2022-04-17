Feature: Encontrar um usuário
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário

    Background: Configurar url
        Given url baseUrl
        And path "users"

        Scenario: Encontrar usuário existente
            # cria um usuário temporário
            * def temp = call read("utils/criarUsuario.feature")
            And path temp.createdUser.id 
            When method get
            Then status 200
            And match response == temp.createdUser

            #apaga o usuário temporário
            * call read("utils/deletarUsuario.feature") temp
        
        Scenario: Encontrar usuário inexistente
            # cria um usuário temporário
            * def temp = call read("utils/criarUsuario.feature")
            * call read("utils/deletarUsuario.feature") temp
            And path temp.createdUser.id 
            When method get
            Then status 404