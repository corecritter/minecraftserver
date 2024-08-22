#This will cleanup unused PVs. It is destructive and I was only using this for debugging cleanup

$pvs = kubectl get pv --no-headers

foreach($pv in $pvs) {
    $columns = $pv.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($columns[6] -eq "nfs-csi" -and $columns[4] -eq "Released") {
        kubectl delete pv $columns[0]
    }
}