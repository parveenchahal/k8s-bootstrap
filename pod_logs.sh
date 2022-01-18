pat=$1
if [ -z $pat ]
then
  echo 'Filter pattern not provided'
  exit
fi

t=$2
if [ -z $t ]
then
  t=0
fi

pat_res=$(kubectl get pod -A | grep -i $pat | wc -l)
if [ $pat_res -gt 1 ]
then
  echo "Multiple results for pattern $pat"
  exit
fi

ns=$(kubectl get pod -A | grep -i $pat | awk '{print $1}')
pod=$(kubectl get pod -A | grep -i $pat | awk '{print $2}')

kubectl logs $pod -n $ns --tail=$t -f
