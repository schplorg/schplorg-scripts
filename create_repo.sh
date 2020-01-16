#!/bin/bash
if [ "$#" -lt 1 ]; then
echo "### Usage: ./create_repo REPO [DEPLOY_PATH] [DEPLOY_BRANCH]"
else
REPO=$1
echo "### Creating repo $REPO"
mkdir "$REPO"
cd "$REPO"
git init
cd ..
git clone --bare "$REPO" "$REPO.git"
rm -rf "$REPO"
fi
if [ "$#" -eq 3 ]; then
# create deploy hook
DEPLOY_BRANCH=$3
DEPLOY_PATH=$2
mkdir "$DEPLOY_PATH"
HOOK="$REPO.git/hooks/post-receive"
echo "#!/bin/bash" >> $HOOK
echo "DEPLOY_PATH="$DEPLOY_PATH >> $HOOK
echo "DEPLOY_BRANCH="$DEPLOY_BRANCH >> $HOOK
echo $'while read oldrev newrev refname' >> $HOOK
echo $'do' >> $HOOK
echo $'    BRANCH=$(git rev-parse --symbolic --abbrev-ref $refname)' >> $HOOK
echo $'    if [ -n "$BRANCH" ] && [ "$DEPLOY_BRANCH" == "$BRANCH" ]; then' >> $HOOK
echo $'       rm -rf $DEPLOY_PATH/*' >> $HOOK
echo $'       GIT_WORK_TREE=$DEPLOY_PATH git checkout $DEPLOY_BRANCH -f' >> $HOOK
echo $'    fi' >> $HOOK
echo $'done' >> $HOOK
chmod +x "$HOOK"
echo "### To access your repository:"
fi
echo "git remote add origin ssh://root@yourserver.com:22/[path to $REPO.git]"
