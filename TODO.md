# TODO Items

## Items in progress or desired
- [x] Introduce `;` as a separator
- [x] Named functions
- [x] Not defined variables should return `nil`
- [x] Modulo operator
- [x] `and` operator
- [x] `or` operator
- [ ] `elseif` statement
- [x] Variables with numbers in name
- [x] Variable assignment supports table elements
- [x] Table DOT notation t.b same as t["b"]
- [ ] Iterator for Table using `pairs`/`ipairs`
- [ ] `_G` for globals access
- [ ] `for` loop
- [ ] `while` loop
- [ ] `repeat` loop
- [ ] Short circuit / tenary operator
- [ ] Dot property syntax in Table for string keys
- [x] Numbers beginning with `.` (Ex `.5`),
- [x] Supports type(Number) = number, Number is float or int under the hood
- [ ] Handle global vs local variables in lua style
- [ ] Function calls with single params should not require parens
- [ ] Metatable support for tables

## Lexer

### 1. Missing Keywords

The lexer currently supports basic control flow (`if`, `then`, `else`, `end`, `return`) and logical operators, but it is missing several crucial Lua keywords for loops, scoping, and advanced control flow:

* **Scoping:** `local`
* **Loops:** `for`, `while`, `do`, `repeat`, `until`, `in`, `break`
* **Control Flow:** `elseif`
* **Modern Lua (5.2+):** `goto`

### 2. Number Parsing Limitations

* **Scientific Notation:** Lua supports exponents (e.g., `1e-5`, `2E10`).
* **Hexadecimal:** Lua supports hex values starting with `0x` or `0X` (e.g., `0xFF`).
* *Note:* Prior to Lua 5.3, all numbers were double-precision floats. Lua 5.3 introduced distinct integer and float subtypes

### 3. String and Comment Quirks

There are a few syntax rules specific to Lua's multiline features that the lexer doesn't quite match yet:

* **Multiline Strings:** Lua allows strings to be declared using double square brackets `[[string here]]`. This is completely missing and needs to be parsed similarly to multiline comments.
* **Standard Multiline Comments:** lexer expects multiline comments to end with `]]--`. In standard Lua, a multiline comment starts with `--[[` and ends simply with `]]`. The trailing `--` is not required.
* **Nested/Leveled Brackets:** Advanced Lua strings and comments allow "levels" using equals signs to avoid early termination (e.g., `[=[...]=]` or `--[==[...]==]`).
* **Escape Sequences:** `_read_string` method handles escaped quotes (`\"`, `\'`), but ignores standard escape sequences like `\n`, `\t`, `\\`, or `\xXX`.

### 4. Missing Operators and Symbols

* **Method Calls:** `:` (Colon) is vital in Lua for object-oriented method calls (e.g., `player:jump()`).
* **Varargs:** `...` (Three dots) is used for variable arguments in functions.
* **Exponentiation:** `^` (Caret).
* **Modern Lua (5.3+) Operators:** needs Floor Division (`//`) and Bitwise operators (`&`, `|`, `~` as binary XOR, `<<`, `>>`).

**Next Steps**
* Add a `KEYWORDS` dictionary so don't have to write a new `if identifier == "..."` block for every single keyword in `next_token` function. Do a dictionary lookup before defaulting to the `IDENTIFIER` token.

## Parser

This is a Pratt parser and handles things like table literals, index expressions, and first-class functions.

### 1. Variables & Scope

* **`local` Declarations:** parser currently treats all assignments as global (or at least, scope-agnostic). Lua relies heavily on the `local` keyword (e.g., `local x = 5`). Needs a `parse_local_statement`.
* **Multiple Assignment:** Lua allows assigning multiple variables at once: `a, b = 1, 2`. Currently, the assignment logic assumes a single L-value and a single R-value.
* **`nil` Keyword Support:** The lexer captures `nil`, but `parser.py` is missing `TokenType.NIL` in `self.prefix_parse_fns`. Without this, evaluating `x = nil` will throw a "No prefix fn found" error.

### 2. Control Flow & Loops

* **`elseif` Branches:**  `parse_if_expression` handles `if` and `else`, but it doesn't loop to handle `elseif` conditions.
* **`while` Loops:** it need a `parse_while_statement` to handle `while <condition> do <block> end`.
* **`for` Loops:** Lua has two types of `for` loops that need parsing:
* Numeric: `for i = 1, 10, 1 do ... end`
* Generic (Iterators): `for k, v in pairs(t) do ... end`


* **`repeat ... until` Loops:** The standard post-condition loop.
* **`break` Statement:** Needed to exit loops early.

### 3. Advanced Functions & Methods

* **Named Function Statements:** it currently parses anonymous function *literals* (e.g., `f = function() end`), but can't parse standard named function declarations natively (e.g., `function doSomething() end`). Standard Lua syntactic sugar treats this as `doSomething = function() end` under the hood.
* **Method Calls (`:`):** In Lua, `player:jump()` is syntactic sugar for `player.jump(player)`. The parser currently doesn't recognize the colon operator for indexing/calling.
* **Varargs (`...`):** Parsing the literal `...` as a valid parameter in function definitions and as an expression inside function bodies.

### 4. Table Edge Cases

* **Implicit String Keys:** In Lua, `t = { a = 1 }` is valid syntactic sugar for `t = { ["a"] = 1 }`. Right now, `parse_table_identifier_pair` correctly attempts to parse this, but need to ensure it flawlessly creates the underlying string literal for the evaluator.
