# Lua interpreter in Python

This is a lua interpreter written in Python, it includes:

- [x] Lexer
- [x] Parser
- [x] A internal AST representation
- [x] Repl
- [x] Interpeter

The repository is a continuation of an existing project for learning purposes.

## Running repl

- `python repl.py`

Use `pytest` for testing functionality.

## TODO
- [x] Introduce `;` as a separator
- [x] Named functions
- [x] Not defined variables should return `nil`
- [x] Modulo operator
- [x] `and` operator
- [x] `or` operator
- [ ] `elseif` statement
- [x] Variables with numbers in name
- [x] Table DOT notation t.b same as t["b"]
- [ ] Iterator for Table using `pairs`/`ipairs`
- [ ] `_G` for globals access
- [ ] `for` loop
- [ ] `while` loop
- [ ] `repeat` loop
- [ ] Short circuit / tenary operator
- [ ] Dot property syntax in Table for string keys
- [ ] Numbers beginning with `.` (Ex `.5`)
- [ ] Handle global vs local variables in lua style
- [ ] Function calls with single params should not require parens
- [ ] Metatable support for tables


## Supports
- Single and multiline comments
- Variable assignments
- Numbers
- Strings
- Tables
- Addition, multiplication and division
- If statements
- Comparison operators (`==`, `>=`, `>`, `<`, `<≠`, `~=`)
- String concat `..`
- `return`
- `function` declarations (both named and anymous with closures)
- `not` logical operator
- Negative values
- Table indexing
- Table count with `#`
- Non existing identifiers return nil
- Modulo operator
