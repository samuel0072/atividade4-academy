Feature: Listar Usuários
    Como uma pessoa qualquer
    Desejo consultar todos os usuários cadastrados
    Para ter as informações de todos os usuários

    Background: Configurar base url
        Given url baseUrl
        And path "users"
       
        Scenario: Checa o formato da resposta
            * def responseFormat = { id: "#string", name: "#string",  email: "#string", createdAt: "#string",  updatedAt: "#string"}
            When method get
            Then match response == "#array"
            And match each response == responseFormat

        Scenario: Verifica a existência de um usuário recém-criado
            # cria um usuário temporário
            * def createdUser = call read("utils/criarUsuario.feature")
            
            #verifica se as insformações do usuário criado estão no array de resposta
            When method get
            Then match response contains createdUser.createdUser

            #apaga o usuário temporário
            * call read("utils/deletarUsuario.feature") createdUser