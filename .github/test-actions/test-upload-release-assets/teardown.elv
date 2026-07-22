var tag = (get-env tag)

echo 🚮 Now deleting the $tag release and its tag...
gh release delete --cleanup-tag --yes $tag
echo ✅ Test release and tag deleted!
