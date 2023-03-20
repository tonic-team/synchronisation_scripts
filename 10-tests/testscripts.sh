value=`cat .gitmodules`
echo $value

if grep -q 06_dissemination ".gitmodules"; then
  echo $value
fi