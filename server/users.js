let users = {}

class User {

    roomLink
    onlline = true

    inARoom = false

    constructor(username) {

        this.username = username
    }

}

module.exports = {
    users,
    User
}
