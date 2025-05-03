use str
use github.com/giancosta86/aurora-elvish/edit

var notes-file = $args[0]

{
  tmp pwd = actions

  edit:file $notes-file { |content|
    var actual-content = $content

    put * | each { |action-name|
      var tick-quoted-name = '`'$action-name'`'

      var markdown-link = '['$action-name'](actions/'$action-name'/README.md)'

      set actual-content = (str:replace $tick-quoted-name $markdown-link $actual-content)
    }

    put $actual-content
  }
}