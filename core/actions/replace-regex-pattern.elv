use os
use re
use github.com/giancosta86/ethereal/v1/edit
use github.com/giancosta86/ethereal/v1/string
use ./input

fn main {
  var files = (input:list files)

  var regex = (input:string regex)

  var replacement = (
    input:string &optional replacement |
      coalesce (all) ''
  )

  all $files | each { |file-wildcard|
    var escaped-wildcard = (string:escape-single-quotes $file-wildcard)

    eval 'put '$escaped-wildcard | each { |path|
      if (os:is-regular $path) {
        edit:file $path { |content|
          re:replace $regex $replacement $content
        }
      }
    }
  }
}