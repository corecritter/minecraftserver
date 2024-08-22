$pvs = kubectl get pv --no-headers

foreach($pv in $pvs) {
    $columns = $pv.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    if ($columns[6] -eq "nfs-csi" -and $columns[4] -eq "Released" -and $columns[5] -eq "mc/nfs-pvc") {
        kubectl patch pv $columns[0] -p '{\"spec\":{\"claimRef\": null}}'
    }
}