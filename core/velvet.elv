use epm

fn run-flawless { |velvet-version @test-scripts|
  epm:install 'github.com/giancosta86/velvet@'$velvet-version

  var velvet-module: = (
    use-mod 'github.com/giancosta86/velvet/'$velvet-version'/velvet'
  )

  velvet-module:velvet &flawless $@test-scripts
}