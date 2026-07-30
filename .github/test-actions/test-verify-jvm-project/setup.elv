use github.com/giancosta86/ethereal/v1/console

console:section &emoji=☕ 'Java tools' {
  java --version |
    head -n 1 |
    echo ☕ Java version: (all)

  mvn --version |
    head -n 1 |
    echo 🪶 Maven version: (all)

  gradle --version |
    grep -P '^Gradle \d+\.\d+(\.\d+)?$' |
    head -n 1 |
    cut -d ' ' -f 2 |
    echo 🐘 Gradle version: (all)
}