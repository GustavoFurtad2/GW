function removeSpaces(string) {

    let buffer = ""
    let onString = false

    for (charIndex in string.length) {

        const currentChar = string.substring(charIndex, charIndex)

        if (currentChar == '"' || currentChar == "'") {

            onString = !onString
        }

        if (onString || !onString && currentChar != " ") {

            buffer += currentChar
        }
    }

    return buffer
}

module.exports = {
    removeSpaces
}
