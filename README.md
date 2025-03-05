# snippet-creator.nvim

A Neovim plugin to create snippet definitions interactively.

## Usage

1.  Install the plugin using your plugin manager (e.g., LazyVim).
2.  Open a file where you want to insert a snippet definition (e.g., a `.json` or `.lua` file for your snippet configuration).
3.  Run `:SnippetCreate`.
4.  Follow the prompts to enter the snippet's prefix, description, and body.

## Example

After running `:SnippetCreate` and entering the following:

- **Prefix:** `log`
- **Description:** `Console log`
- **Body:**
  - `console.log("$1");`
  - `END`

The following snippet definition will be inserted:

```json
  "Console log": {
    "prefix": "log",
    "body": [
      "console.log(\"$1\");"
    ],
    "description": "Console log"
  }
```
