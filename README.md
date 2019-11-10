# Codefuckery

Find out how fucked up your code is.

## Installation

Add this line to your application's Gemfile:

```
gem 'codefuckery'
```

And then execute:

```
$ bundle install
```

Or install the gem:

```
gem install codefuckery
```

## Usage
Run `codefuckery` from the command line. Provide the directory with your source code as a parameter.
By default it will count the words `fuck`, `shit` and `sorry` recursively in all files.

```
$ codefuckery path/to/your/source
```

Output:
```
  fuck: 4
  shit: 12
  sorry: 0

Your code is a bit fucked up 💩
```

To limit the search to certain file types add the `--filetypes` parameter with a comma-delimited list of file extensions:

```
$ codefuckery --filetypes html,css,js path/to/your/source
```

`codefuckery` lets you customize the word list:

```
$ codefuckery --words fixme,todo,refactor path/to/your/source
```

Use regular expressions for really powerful searches for really fuuuuucked up situations. This will find comments like `// This code is shiiiit. Sooorrrry for fuuuucking up so bad`

```
$ codefuckery --words fu+ck,shi+t,so+rr+y path/to/your/source
```

If you want to limit the search to the specified directory only (excluding sub-directories) provide the `--no-recursive` option:

```
$ codefuckery --no-recursive path/to/your/source
```

## Contributing
Feel free to contribute to `codefuckery`. Just submit a pull request with your suggestion. If you find any bugs please open a [new GitHub issue](https://github.com/martinhoeller/codefuckery/issues/new).
