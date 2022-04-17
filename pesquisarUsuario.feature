Feature: Pesquisar usuário
    Como uma pessoa qualquer
    Desejo pesquisar usuário por nome ou e-mail
    Para ser capaz de encontrar um usuário cadastrado facilmente

    Background: Configurar url
        Given url baseUrl
        And path "search"

        Scenario: Pesquisar usuário existente por nome
            # cria um usuário temporário
            * def temp = call read("utils/criarUsuario.feature")
            * def responseFormat = { id: "#string", name: "#string",  email: "#string", createdAt: "#string",  updatedAt: "#string"}
            Given param value = temp.createdUser.name
            When method get
            Then status 200
            And match response == "#array"
            And match each response == responseFormat
            And match response contains temp.createdUser

            #apaga o usuário temporário
            * call read("utils/deletarUsuario.feature") temp

        Scenario: Pesquisar usuário existente por email
            # cria um usuário temporário
            * def temp = call read("utils/criarUsuario.feature")
            * def responseFormat = { id: "#string", name: "#string",  email: "#string", createdAt: "#string",  updatedAt: "#string"}
            Given param value = temp.createdUser.email
            When method get
            Then status 200
            And match response == "#array"
            And match each response == responseFormat
            And match response contains temp.createdUser

            #apaga o usuário temporário
            * call read("utils/deletarUsuario.feature") temp
