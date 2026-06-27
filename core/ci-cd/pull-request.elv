var -branch-name-var = GITHUB_HEAD_REF

fn get-branch {
  get-env $-branch-name-var
}