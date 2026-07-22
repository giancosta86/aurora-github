var test-tag = (get-env test-tag)

echo 🚮 Now deleting the ''''$test-tag'''' release and its tag...
gh release delete --cleanup-tag --yes $test-tag
echo ✅ Test release and tag deleted!
