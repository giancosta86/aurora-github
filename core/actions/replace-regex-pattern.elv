use os
use re
use str
use github.com/giancosta86/elvish/v1/edit
use github.com/giancosta86/elvish/v1/string
use ./input

fn main {
  var files = (
    input:string files |
      string:escape-single-quotes
  )

  var regex = (input:string regex)

  var replacement = (input:string replacement)

  str:split , $files | each { |file-wildcard|
    eval 'put '$file-wildcard | each { |path|
      if (os:is-regular $path) {
        edit:file $path { |content|
          re:replace $regex $replacement $content
        }
      }
    }
  }
}