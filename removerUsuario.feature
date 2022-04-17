Feature: Remover um usuário
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas

    Background: Configurar url
        Given url baseUrl
        And path "users"

        Scenario: Remover usuário existente
            # cria um usuário temporário
            * def temp = call read("utils/criarUsuario.feature")
            And path temp.createdUser.id 
            When method delete
            Then status 204
