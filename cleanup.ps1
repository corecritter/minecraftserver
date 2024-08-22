$pvs = kubectl get pv --no-headers

foreach($pv in $pvs) {
    $columns = $pv.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($columns[6] -eq "nfs-csi" -and $columns[4] -eq "Released") {
        kubectl delete pv $columns[0]
    }
}