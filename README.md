# OxScrapper

Basic tool for getting definition of a word from Oxford dictionary. 

## Prerequisites

- Elixir 1.15+ 

## Prepare 

```
git clone git@github.com:dargonaxxe/oxford_dictionary_scrapper.git oxscrapper 
cd oxscrapper
mix deps.get && mix deps.compile
```

## Build 

```
OUTPUT_DIR=output MIX_ENV=prod mix escript.build
```

## Use 

### Prepare input file

Currently, OxScrapper only supports semicolon separated words contained in a file.
Other formats support is yet to come.
```
echo "bread;duck;dog;silver" > input.csv
```

### Use OxScrapper

```
./scrapper input.csv output.csv
```

