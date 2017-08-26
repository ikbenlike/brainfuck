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
        elseif code:sub(iptr, iptr) == ']' then
        end
        iptr = iptr + 1
    end
end

r = readfile(arg[1])
runbrainfuck(r)
