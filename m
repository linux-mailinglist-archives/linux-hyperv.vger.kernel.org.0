Return-Path: <linux-hyperv+bounces-109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527E7A51E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Sep 2023 20:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AB02817F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Sep 2023 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74685262AD;
	Mon, 18 Sep 2023 18:18:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FB1F5E9
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Sep 2023 18:18:46 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F6A8102;
	Mon, 18 Sep 2023 11:18:43 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CDB8A212C0DF; Mon, 18 Sep 2023 11:18:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDB8A212C0DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695061122;
	bh=RToYM9HwrIZsDyANzSbEw7l/rLA8hxMi1pMchc01GoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUaeFjAh256bKEAXqSrzgtlpkJI1v2rijW3b5xr4EyCpxjCVsIVE7RMJJbHFmNQKC
	 5+5qLJPhiQpEzXIcj7kJR9Oy65fjgrTNhlW0lZnzd8Uj+WU3bYuU2+LigjkXiuEr6I
	 CitZkZoWfvkqzgMzXSqDdu0KCR6nd+35Axoqta2s=
Date: Mon, 18 Sep 2023 11:18:42 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5] hv/hv_kvp_daemon:Support for keyfile based connection
 profile
Message-ID: <20230918181842.GA24684@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695056777-19108-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695056777-19108-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 10:06:17AM -0700, Shradha Gupta wrote:
> Ifcfg config file support in NetworkManger is deprecated. This patch
> provides support for the new keyfile config format for connection
> profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> to generate the new network configuration in keyfile
> format(.ini-style format) along with a ifcfg format configuration.
> The ifcfg format configuration is also retained to support easy
> backward compatibility for distro vendors. These configurations are
> stored in temp files which are further translated using the
> hv_set_ifconfig.sh script. This script is implemented by individual
> distros based on the network management commands supported.
> For example, RHEL's implementation could be found here:
> https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> Debian's implementation could be found here:
> https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> 
> The next part of this support is to let the Distro vendors consume
> these modified implementations to the new configuration format.
> 
> Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes v4->v5
>  * Fixed alignment and indentation errors
> ---
>  tools/hv/hv_kvp_daemon.c    | 217 +++++++++++++++++++++++++++++++-----
>  tools/hv/hv_set_ifconfig.sh |  39 ++++++-
>  2 files changed, 224 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 27f5e7dfc2f7..2f706f8be25b 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -1171,13 +1171,81 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
>  	return 0;
>  }
>  
> +/*
> + * Only IPv4 subnet strings needs to be converted to plen
> + * For IPv6 the subnet is already privided in plen format
> + */
> +static int kvp_subnet_to_plen(char *subnet_addr_str)
> +{
> +	int plen = 0;
> +	struct in_addr subnet_addr4;
> +
> +	/*
> +	 * Convert subnet address to binary representation
> +	 */
> +	if (inet_pton(AF_INET, subnet_addr_str, &subnet_addr4) == 1) {
> +		uint32_t subnet_mask = ntohl(subnet_addr4.s_addr);
> +
> +		while (subnet_mask & 0x80000000) {
> +			plen++;
> +			subnet_mask <<= 1;
> +		}
> +	} else {
> +		return -1;
> +	}
> +
> +	return plen;
> +}
> +
> +static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> +				int is_ipv6)
> +{
> +	int error = 0;

No need of initializing it.

> +	char addr[INET6_ADDRSTRLEN];
> +	char subnet_addr[INET6_ADDRSTRLEN];
> +	int i = 0;
> +	int ip_offset = 0, subnet_offset = 0;
> +	int plen;
> +
> +	memset(addr, 0, sizeof(addr));
> +	memset(subnet_addr, 0, sizeof(subnet_addr));
> +
> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +				   (MAX_IP_ADDR_SIZE * 2)) &&
> +				   parse_ip_val_buffer(subnet,
> +						       &subnet_offset,
> +						       subnet_addr,
> +						       (MAX_IP_ADDR_SIZE *
> +							2))) {
> +		if (!is_ipv6)
> +			plen = kvp_subnet_to_plen((char *)subnet_addr);
> +		else
> +			plen = atoi(subnet_addr);
> +
> +		if (plen < 0)
> +			return plen;
> +
> +		error = fprintf(f, "address%d=%s/%d\n", ++i, (char *)addr,
> +				plen);
> +		if (error < 0)
> +			return error;
> +
> +		memset(addr, 0, sizeof(addr));
> +		memset(subnet_addr, 0, sizeof(subnet_addr));
> +	}
> +
> +	return 0;
> +}
> +
>  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  {
>  	int error = 0;
>  	char if_file[PATH_MAX];
> -	FILE *file;
> +	char nm_file[PATH_MAX];
> +	FILE *ifcfg_file, *nmfile;
>  	char cmd[PATH_MAX];
>  	char *mac_addr;
> +	int is_ipv6;
>  	int str_len;
>  
>  	/*
> @@ -1197,7 +1265,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	 * in a given distro to configure the interface and so are free
>  	 * ignore information that may not be relevant.
>  	 *
> -	 * Here is the format of the ip configuration file:
> +	 * Here is the ifcfg format of the ip configuration file:
>  	 *
>  	 * HWADDR=macaddr
>  	 * DEVICE=interface name
> @@ -1220,6 +1288,32 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	 * tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
>  	 * IPV6NETMASK.
>  	 *
> +	 * Here is the keyfile format of the ip configuration file:
> +	 *
> +	 * [ethernet]
> +	 * mac-address=macaddr
> +	 * [connection]
> +	 * interface-name=interface name
> +	 *
> +	 * [ipv4]
> +	 * method=<protocol> (where <protocol> is "auto" if DHCP is configured
> +	 *                       or "manual" if no boot-time protocol should be used)
> +	 *
> +	 * address1=ipaddr1/plen
> +	 * address2=ipaddr2/plen
> +	 *
> +	 * gateway=gateway1;gateway2
> +	 *
> +	 * dns=dns1;dns2
> +	 *
> +	 * [ipv6]
> +	 * address1=ipaddr1/plen
> +	 * address2=ipaddr2/plen
> +	 *
> +	 * gateway=gateway1;gateway2
> +	 *
> +	 * dns=dns1;dns2
> +	 *
>  	 * The host can specify multiple ipv4 and ipv6 addresses to be
>  	 * configured for the interface. Furthermore, the configuration
>  	 * needs to be persistent. A subsequent GET call on the interface
> @@ -1227,14 +1321,28 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	 * call.
>  	 */
>  
> +	/*
> +	 * We are populating both ifcfg and nmconnection files
> +	 */
>  	snprintf(if_file, sizeof(if_file), "%s%s%s", KVP_CONFIG_LOC,
> -		"/ifcfg-", if_name);
> +		 "/ifcfg-", if_name);
>  
> -	file = fopen(if_file, "w");
> +	ifcfg_file = fopen(if_file, "w");
>  
> -	if (file == NULL) {
> +	if (!ifcfg_file) {
>  		syslog(LOG_ERR, "Failed to open config file; error: %d %s",
> -				errno, strerror(errno));
> +		       errno, strerror(errno));
> +		return HV_E_FAIL;
> +	}
> +
> +	snprintf(nm_file, sizeof(if_file), "%s%s%s%s", KVP_CONFIG_LOC,

Do we want to change sizeof(if_file) to sizeof(nm_file).

> +		 "/", if_name, ".nmconnection");
> +
> +	nmfile = fopen(nm_file, "w");
> +
> +	if (!nmfile) {
> +		syslog(LOG_ERR, "Failed to open config file; error: %d %s",
> +		       errno, strerror(errno));

if_file is open at this point, close it before returning.

>  		return HV_E_FAIL;
>  	}
>  
> @@ -1248,12 +1356,28 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  		goto setval_error;
>  	}
>  
> -	error = kvp_write_file(file, "HWADDR", "", mac_addr);
> -	free(mac_addr);
> +	error = kvp_write_file(ifcfg_file, "HWADDR", "", mac_addr);
> +	if (error < 0)

we are not freeing mac_addr in case of error.

- Saurabh

> +		goto setval_error;
> +
> +	error = kvp_write_file(ifcfg_file, "DEVICE", "", if_name);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error = fprintf(nmfile, "\n[connection]\n");
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error = kvp_write_file(nmfile, "interface-name", "", if_name);
>  	if (error)
>  		goto setval_error;
>  
> -	error = kvp_write_file(file, "DEVICE", "", if_name);
> +	error = fprintf(nmfile, "\n[ethernet]\n");
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error = kvp_write_file(nmfile, "mac-address", "", mac_addr);
> +	free(mac_addr);
>  	if (error)
>  		goto setval_error;
>  
> @@ -1263,47 +1387,87 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	 * proceed to parse and pass the IPv6 information to the
>  	 * disto-specific script hv_set_ifconfig.
>  	 */
> +
> +	/*
> +	 * First populate the ifcfg file format
> +	 */
>  	if (new_val->dhcp_enabled) {
> -		error = kvp_write_file(file, "BOOTPROTO", "", "dhcp");
> +		error = kvp_write_file(ifcfg_file, "BOOTPROTO", "", "dhcp");
>  		if (error)
>  			goto setval_error;
> -
>  	} else {
> -		error = kvp_write_file(file, "BOOTPROTO", "", "none");
> +		error = kvp_write_file(ifcfg_file, "BOOTPROTO", "", "none");
>  		if (error)
>  			goto setval_error;
>  	}
>  
> -	/*
> -	 * Write the configuration for ipaddress, netmask, gateway and
> -	 * name servers.
> -	 */
> -
> -	error = process_ip_string(file, (char *)new_val->ip_addr, IPADDR);
> +	error = process_ip_string(ifcfg_file, (char *)new_val->ip_addr,
> +				  IPADDR);
>  	if (error)
>  		goto setval_error;
>  
> -	error = process_ip_string(file, (char *)new_val->sub_net, NETMASK);
> +	error = process_ip_string(ifcfg_file, (char *)new_val->sub_net,
> +				  NETMASK);
>  	if (error)
>  		goto setval_error;
>  
> -	error = process_ip_string(file, (char *)new_val->gate_way, GATEWAY);
> +	error = process_ip_string(ifcfg_file, (char *)new_val->gate_way,
> +				  GATEWAY);
>  	if (error)
>  		goto setval_error;
>  
> -	error = process_ip_string(file, (char *)new_val->dns_addr, DNS);
> +	error = process_ip_string(ifcfg_file, (char *)new_val->dns_addr, DNS);
>  	if (error)
>  		goto setval_error;
>  
> -	fclose(file);
> +	if (new_val->addr_family == ADDR_FAMILY_IPV6) {
> +		error = fprintf(nmfile, "\n[ipv6]\n");
> +		is_ipv6 = 1;
> +		if (error < 0)
> +			goto setval_error;
> +	} else {
> +		error = fprintf(nmfile, "\n[ipv4]\n");
> +		if (error < 0)
> +			goto setval_error;
> +	}
> +
> +	if (new_val->dhcp_enabled) {
> +		error = kvp_write_file(nmfile, "method", "", "auto");
> +		if (error < 0)
> +			goto setval_error;
> +	} else {
> +		error = kvp_write_file(nmfile, "method", "", "manual");
> +		if (error < 0)
> +			goto setval_error;
> +	}
> +
> +	/*
> +	 * Write the configuration for ipaddress, netmask, gateway and
> +	 * name services
> +	 */
> +	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +				     (char *)new_val->sub_net, is_ipv6);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> +	if (error < 0)
> +		goto setval_error;
> +
> +	fclose(nmfile);
> +	fclose(ifcfg_file);
>  
>  	/*
>  	 * Now that we have populated the configuration file,
>  	 * invoke the external script to do its magic.
>  	 */
>  
> -	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
> -			   "hv_set_ifconfig", if_file);
> +	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s %s",
> +			   "hv_set_ifconfig", if_file, nm_file);
>  	/*
>  	 * This is a little overcautious, but it's necessary to suppress some
>  	 * false warnings from gcc 8.0.1.
> @@ -1316,14 +1480,15 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  
>  	if (system(cmd)) {
>  		syslog(LOG_ERR, "Failed to execute cmd '%s'; error: %d %s",
> -				cmd, errno, strerror(errno));
> +		       cmd, errno, strerror(errno));
>  		return HV_E_FAIL;
>  	}
>  	return 0;
>  
>  setval_error:
>  	syslog(LOG_ERR, "Failed to write config file");
> -	fclose(file);
> +	fclose(ifcfg_file);
> +	fclose(nmfile);
>  	return error;
>  }
>  
> diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
> index d10fe35b7f25..ae5a7a8249a2 100755
> --- a/tools/hv/hv_set_ifconfig.sh
> +++ b/tools/hv/hv_set_ifconfig.sh
> @@ -18,12 +18,12 @@
>  #
>  # This example script is based on a RHEL environment.
>  #
> -# Here is the format of the ip configuration file:
> +# Here is the ifcfg format of the ip configuration file:
>  #
>  # HWADDR=macaddr
>  # DEVICE=interface name
>  # BOOTPROTO=<protocol> (where <protocol> is "dhcp" if DHCP is configured
> -#                       or "none" if no boot-time protocol should be used)
> +# 			or "none" if no boot-time protocol should be used)
>  #
>  # IPADDR0=ipaddr1
>  # IPADDR1=ipaddr2
> @@ -41,6 +41,32 @@
>  # tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
>  # IPV6NETMASK.
>  #
> +# Here is the keyfile format of the ip configuration file:
> +#
> +# [ethernet]
> +# mac-address=macaddr
> +# [connection]
> +# interface-name=interface name
> +#
> +# [ipv4]
> +# method=<protocol> (where <protocol> is "auto" if DHCP is configured
> +#                       or "manual" if no boot-time protocol should be used)
> +#
> +# address1=ipaddr1/plen
> +# address=ipaddr2/plen
> +#
> +# gateway=gateway1;gateway2
> +#
> +# dns=dns1;
> +#
> +# [ipv6]
> +# address1=ipaddr1/plen
> +# address2=ipaddr1/plen
> +#
> +# gateway=gateway1;gateway2
> +#
> +# dns=dns1;dns2
> +#
>  # The host can specify multiple ipv4 and ipv6 addresses to be
>  # configured for the interface. Furthermore, the configuration
>  # needs to be persistent. A subsequent GET call on the interface
> @@ -48,18 +74,19 @@
>  # call.
>  #
>  
> -
> -
>  echo "IPV6INIT=yes" >> $1
>  echo "NM_CONTROLLED=no" >> $1
>  echo "PEERDNS=yes" >> $1
>  echo "ONBOOT=yes" >> $1
>  
> -
>  cp $1 /etc/sysconfig/network-scripts/
>  
> +chmod 600 $2
> +interface=$(echo $2 | awk -F - '{ print $2 }')
> +filename="${2##*/}"
> +
> +sed '/\[connection\]/a autoconnect=true' $2 > /etc/NetworkManager/system-connections/${filename}
>  
> -interface=$(echo $1 | awk -F - '{ print $2 }')
>  
>  /sbin/ifdown $interface 2>/dev/null
>  /sbin/ifup $interface 2>/dev/null
> -- 
> 2.34.1
> 

