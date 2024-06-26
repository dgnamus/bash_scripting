#!/bin/bash
project_dir="$(basename https://github.com/kodekloudhub/solar-system-9 .git)"

clone_project() {
        cd /home/bob/git
        git clone https://github.com/kodekloudhub/solar-system-9.git
}

clone_project
find "/home/bob/git/${project_dir}" -type f | wc -l
                                                  



#!/bin/bash
project_dir="$(basename https://github.com/kodekloudhub/solar-system-9 .git)"

clone_project() {
  cd /home/bob/git/
  git clone https://github.com/kodekloudhub/solar-system-9.git
}
clone_project
find "/home/bob/git/${project_dir}" -type f | wc -l