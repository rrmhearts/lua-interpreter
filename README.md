# Lua interpreter in Python

This is a Lua interpreter written in Python, it includes:

- [x] Lexer
- [x] Parser
- [x] A internal AST representation
- [x] Repl
- [x] Interpeter

The repository is a continuation of an existing project for learning purposes.

## Running repl

- `python repl.py`

Use `pytest` for testing functionality.

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

See [TODO.md](./TODO.md) for future items to support.