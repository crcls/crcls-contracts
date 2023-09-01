module.exports = {
  semi: false,
  singleQuote: true,
  printWidth: 80,
  overrides: [
    {
      files: "*.sol",
      options: {
        printWidth: 80,
        tabWidth: 4,
        useTabs: true,
        singleQuote: false,
        bracketSpacing: true,
        explicitTypes: "always"
      }
    }
  ]
}
