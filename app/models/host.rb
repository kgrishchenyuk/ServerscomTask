require 'resolv'

class Host < ApplicationRecord
  has_many :ping_results

  validates :ipaddr, uniqueness: true, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }

  def self.ping
    pattern = %r{
      ^PING\b # match ping
      [^(]*\(([^)]*)\) # capture IP
      \s([^.]*)\. # capture the bytes of data
      .*?(\d+)\spackets\stransmitted # capture transmitted
      .*?(\d+)\sreceived # capture received
      .*?(\d+%)\spacket\sloss # capture loss
      .*?time\s(\d+ms) # capture total time
      .*?=\s([^\/]*)\/([^\/]*)\/([^\/]*)\/(.*?)\sms # capture min/avg/max/mdev RTT
    }imsx

    Host.where(active: true).map do |host|
      Thread.new do
        ping_output = `ping -c 5 -W 60 -q #{host.ipaddr.to_s}`

        if $?.exitstatus == 0
          groups = ping_output.match(pattern)

          params = {
            success: true, 
            transmitted: groups[3].to_i,
            received: groups[4].to_i,
            min_rtt: groups[7].to_f,
            avg_rtt: groups[8].to_f,
            max_rtt: groups[9].to_f,
            mdev_rtt: groups[10].to_f
          }
        else
          params = { success: false, transmitted: 5, received: 0 }
        end

        host.ping_results.create(params)
      end
    end.each(&:join)
  end
end
