local open = io.open

tree = {{-1}}
nodec = 65
overall = 0

-- Compatibility: Lua-5.1
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local function read_file()
    local file = open("input", "rb") 
    if not file then return nil end
    local content = file:read "*a" 
    file:close()
    print(content)
    return split(content, " ")
end

local function nextm(list)

    num = list[1]
    table.remove(list, 1)
    return tonumber(num)
end

local function build(tree, input, parent) 

    if input.length == 0 then
        return tree 
    end

    -- printtree(tree)
    local children = nextm(input) 

    -- add node to tree:
    local currentparent = {nodec,{},{}} 
    table.insert(tree, currentparent)
    nodec = nodec + 1 
    local metac = nextm(input) 

    print("node: " .. currentparent[1])
    print("children # " .. children)
    print("parent " .. parent[1])

    local c = 0
    -- add children recursive
    while c < children do
        print("get child #" .. c .. " of " .. children)
        build(tree, input, currentparent) 
        c = c + 1
    end

    -- add meta
    local i = 0
    local meta = {}

    print(metac .. " meta for " .. currentparent[1])
    while i < metac do 
        local val = nextm(input) 

        table.insert(meta, val)
        print(val) 
        overall = overall + val
        i = i + 1
    end

    currentparent[3] = meta 
end 

build(tree, read_file(),tree[1])

print("sum of metadata " .. overall)
