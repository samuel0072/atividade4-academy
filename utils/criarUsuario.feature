@ignore
Feature: Criar usuario

    Scenario:
        * def randomEmail = 
        """
        function(){ 
            var data = java.lang.System.currentTimeMillis() + '';
            var uuid = java.util.UUID.randomUUID() + '';
            return  data + uuid + "@email.com";
            }
        """
        * def email = randomEmail();
        * def createdUser = {name: "murayama", email:"#(email)"}
        Given url baseUrl
        Given path "users"
        Given request createdUser
        When method post
        * set createdUser.createdAt = response.createdAt
        * set createdUser.id = response.id
        * set createdUser.updatedAt = response.updatedAt