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
