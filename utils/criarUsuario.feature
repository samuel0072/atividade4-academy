Feature: Criar usuario

    Scenario:
        * def createdUser = {name: "murayama", email:"murayama@email.com"}
        Given url baseUrl
        Given path "users"
        Given request createdUser
        When method post
        * set createdUser.createdAt = response.createdAt
        * set createdUser.id = response.id
        * set createdUser.updatedAt = response.updatedAt