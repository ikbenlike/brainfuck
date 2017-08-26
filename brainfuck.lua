function readfile(path)
    local f = io.open(path, "r")
    local content = f:read("*all")
    f:close()
    return content
end

function runbrainfuck(code)
    local data = {}
    for i = 1, 30000 do
        data[i] = 0
    end
    local len = code:len()
    local dptr = 1
    local iptr = 1
    while iptr < len do
        local count = 1
        if code:sub(iptr, iptr) == '>' then
            dptr = dptr + 1
        elseif code:sub(iptr, iptr) == '<' then
            dptr = dptr - 1
        elseif code:sub(iptr, iptr) == '+' then
            data[dptr] = data[dptr] + 1
        elseif code:sub(iptr, iptr) == '-' then
            data[dptr] = data[dptr] - 1
        elseif code:sub(iptr, iptr) == '.' then
            io.write(string.char(data[dptr]))
        elseif code:sub(iptr, iptr) == ',' then
            data[dptr] = string.byte(io.read(1))
        elseif code:sub(iptr, iptr) == '[' then
            if data[dptr] == 0 then
                iptr = iptr + 1
                while count > 0 do
                    if code:sub(iptr, iptr) == '[' then
                        count = count + 1    
                    elseif code:sub(iptr, iptr) == ']' then
                        count = count -1
                    end
                    iptr = iptr + 1
                end
                iptr = iptr + 1
            end
        elseif code:sub(iptr, iptr) == ']' then
            if data[dptr] ~= 0 then
                iptr = iptr - 1
                while count > 0 do
                    if code:sub(iptr, iptr) == ']' then
                        count = count + 1
                    elseif code:sub(iptr, iptr) == '[' then
                        count = count - 1
                    end
                    iptr = iptr - 1
                end
            end
        end
        iptr = iptr + 1
    end
end

runbrainfuck(readfile(arg[1]))
