function tableToJson(tbl)

    local result  = {}
    local isArray = (#tbl > 0)

    for k, v in pairs(tbl) do

        local key = ""
        if not isArray then
            key = '"' .. tostring(k) .. '":'
        end

        local valueType = type(v)

        if valueType == "table" then

            table.insert(result, key .. serialize(v))
        elseif valueType == "string" then

            table.insert(result, key .. '"' .. v .. '"')
        elseif valueType == "number" or valueType == "boolean" then
            
            table.insert(result, key .. tostring(v))
        else
            
            table.insert(result, key .. "null")
        end
    end

    if isArray then
        return '[' .. table.concat(result, ',') .. ']'
    end

    return '{' .. table.concat(result, ',') .. '}'
end