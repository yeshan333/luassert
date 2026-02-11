---@meta

---Function similarly to spies, except that stubs do not call the function that they replace.
---@class luassert.stub : luassert.spy
---@overload fun(object:table, key:string, ...:any):luassert.stub
local stub = {}

---Creates a new stub that replaces a method in a table in place.
---@param object table The object that the method is in
---@param key string The key of the method in the `object` to replace
---@param ... any A function that operates on the remaining passed in values and returns more values or just values to return
---@return luassert.stub stub A stub object that can be used to perform assertions
---@return any ... Values returned by a passed in function or just the values passed in
---
---## Example
---```
---describe("Stubs", function()
---    local t = {
---        lottery = function(...)
---            print("Your numbers: " .. table.concat({ ... }, ","))
---        end,
---    }
---
---    it("Tests stubs", function()
---        local myStub = stub.new(t, "lottery")
---
---        t.lottery(1, 2, 3) -- does not print
---        t.lottery(4, 5, 6) -- does not print
---
---        assert.stub(myStub).called_with(1, 2, 3)
---        assert.stub(myStub).called_with(4, 5, 6)
---        assert.stub(myStub).called(2)
---        assert.stub(myStub).called_less_than(3)
---
---        myStub:revert()
---
---        t.lottery(10, 11, 12) -- prints
---    end)
---end)
---```
function stub.new(object, key, ...) end

---Set the return values for the stub.
---@param ... any The values to return when the stub is called
---@return luassert.stub stub The stub object for chaining
function stub:returns(...) end

---Set a function to be invoked when the stub is called.
---@param func function The function to invoke
---@return luassert.stub stub The stub object for chaining
function stub:invokes(func) end

---@class luassert.stub.default_behavior
---@field returns fun(...):luassert.stub Set the default return values
---@field invokes fun(func:function):luassert.stub Set the default function to invoke

---Default behavior settings for the stub.
stub.by_default = {}

---@class luassert.stub.on_call_return
---@field returns fun(...):luassert.stub Set the return values for this specific call pattern
---@field invokes fun(func:function):luassert.stub Set the function to invoke for this specific call pattern

---Set up a specific behavior when the stub is called with specific arguments.
---@param ... any The arguments to match
---@return luassert.stub.on_call_return behavior The behavior configuration object
function stub:on_call_with(...) end

return stub
