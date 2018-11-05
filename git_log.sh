
slack
rc=$?
# check slack-cli pre-installed
if [[ $rc == 1 ]] then
	# take current build number from Project's Info.plist
	buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")

	# take commit's hash by tag with current build number
	commit=$(git rev-list -n 1 build_"${buildNumber}")

	# create new change.log and write here git logs from commit
	# change path to change.log file
	touch "./build_${buildNumber}_change.log"
	git log --pretty=format:"%h - %an, %ar : %s" ${commit}.. > "./build_${buildNumber}_change.log"
	# git log --pretty=fuller ${commit}.. > "/Users/alexander/Desktop/changelogs/build_${buildNumber}_change.log"

	# slack file upload setup
	# for slack-cli install https://github.com/rockymadden/slack-cli
	export SLACK_CLI_TOKEN=[token]
	# slack chat send [<text> [channel]]
	# slack file upload [<file> [channels]]

	slack file upload --file "./build_${buildNumber}_change.log" --channels [channels] --comment "build_${buildNumber}"
	rm "./build_${buildNumber}_change.log"
fi
