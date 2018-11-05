# buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")
# take current build number from Project's Info.plist
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "Betolimp/Info.plist")

# take commit's hash by tag with current build number
commit=$(git rev-list -n 1 build_"${buildNumber}")

# create new change.log and write here git logs from commit
# change path to change.log file
touch "/Users/$(whoami)/Desktop/changelogs/build_${buildNumber}_change.log"
git log --pretty=format:"%h - %an, %ar : %s" ${commit}.. > "/Users/$(whoami)/Desktop/changelogs/build_${buildNumber}_change.log"
# git log --pretty=fuller ${commit}.. > "/Users/alexander/Desktop/changelogs/build_${buildNumber}_change.log"

# slack file upload setup
# https://github.com/rockymadden/slack-cli
# export SLACK_CLI_TOKEN='token'
# slack chat send [<text> [channel]]
# slack file upload [<file> [channels]]

slack file upload --file "/Users/$(whoami)/Desktop/changelogs/build_${buildNumber}_change.log" --channels [channels] --comment "build_${buildNumber}"
rm "/Users/$(whoami)/Desktop/changelogs/build_${buildNumber}_change.log"

# increment build number
buildNumber=$(($buildNumber + 1))

# create new tag with incremented build number
git tag build_${buildNumber}

# move next 2 lines to "Increment Build script"
# commit incremented build number in Info.plist
# git commit -m "build no. ${buildNumber}"
# git push origin HEAD
