Feature: Criar usuario

    Scenario:
        Given url baseUrl
        Given path "users"
        Given path createdUser.id
        When method delete