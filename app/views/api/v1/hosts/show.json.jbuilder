json.id @host.id
json.ipaddr @host.ipaddr
json.max_rtt @ping_results.maximum(:max_rtt)
json.avg_rtt @ping_results.average(:avg_rtt).round(3)
json.min_rtt @ping_results.minimum(:min_rtt)
json.med_rtt  @ping_results.median(:avg_rtt).round(3)
json.mdev_rtt @ping_results.average(:mdev_rtt).round(3)
json.lost_pct (((@ping_results.sum(:transmitted) - @ping_results.sum(:received)) / @ping_results.sum(:transmitted).to_f) * 100).round(2)