#!/usr/bin/env elvish
use path
use str

if (!= (count $args) 2) {
  echo 'Usage: elvish install.elv PRESET TARGET'
  echo '  PRESET - one of the presets defined in config.yml'
  echo '  TARGET - destination directory, typically $HOME'
  fail 'Wrong number of arguments'
}

var repo = (path:dir (src)[name])
var preset = $args[0]
var target = $args[1]
var config = (yq -o json $repo/config.yml | from-json)

var layers = $config[presets][$preset]
echo Installing "'"$preset"'" preset into: $target

for layer $layers {
  echo Installing "'"$layer"'" layer

  for src_file [$repo/$layer/**[match-hidden][type:regular]] {
    var src_file_rel = $src_file[(+ 1 (count $repo))..]
    var dst_file = $target$src_file_rel[(count $layer)..]
    var dst_parent_dir = (path:dir $dst_file)
    var report
    try {
      set report = [(mkdir -pv $dst_parent_dir 2> /dev/null)]
    } catch {
      echo (styled $dst_parent_dir red) '(failed to create directory)'
      echo (styled $dst_file yellow) '(skipped)'
    } else {
      for dir_path $report {
        echo (styled $dir_path green) '(directory created)'
      }

      if ?(test -L $dst_file) {
        try {
          ln -hfs $src_file $dst_file
        } catch {
          echo (styled $dst_file red) '(failed to update symlink)'
        } else {
          echo (styled $dst_file blue) '(symlink updated)'
        }
      } elif ?(test -e $dst_file) {
        echo (styled $dst_file yellow) '(skipped)'
      } else {
        try {
          ln -s $src_file $dst_file
        } catch {
          echo (styled $dst_file red) '(failed to create symlink)'
        } else {
          echo (styled $dst_file green) '(symlink created)'
        }
      }
    }
  }
}

echo Installation complete
