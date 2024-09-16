let users = {}

class User {

    roomLink
    onlline = true

    inARoom = false

    constructor(username, ip, socket) {

        this.username = username
        this.socket = socket
        this.ip = ip
    }

}

module.exports = {
    users,
    User
}
