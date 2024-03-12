Return-Path: <linux-hyperv+bounces-1736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A0879974
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4037FB22A11
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC2137C22;
	Tue, 12 Mar 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e4yEFBeG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAE7C0B2;
	Tue, 12 Mar 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262687; cv=none; b=g3s3qlpcMKUoKS6U8nFxutAndd/Pc11e0iheES7FTbU1pG/Mb8LRRyfEn7xzd5CuNqnkC5JM0cyDdUtRlQOMzBiI3N+9jcrSudrtgOcVIhp4Hdepqhy6+hBxvuXrxUuRnmQuu7Eg6onNzhUUGcRlc50BR+jprvAjrXo7QbVlc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262687; c=relaxed/simple;
	bh=7M3JOtuWE4IVXe/oN5epO/lknwhQ1BWe7uK40fES9/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I64Sutup46wpcFKasONrt6qDPHaGyobwqnwGyZuKmQKkkRBFUnlG0H4JOQN36bpkV6PKC4TnJw9+iKHUbHc/vsqPJ6Vo7GREVss2ODJdeEb/VDF3fbXr2XcrX7LLnHrHslgfwn3H4tnYnCcbQ3wtGXufNCsSDspCJtAnVLrWA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e4yEFBeG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.160.249] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 693EE20B74C0;
	Tue, 12 Mar 2024 09:58:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 693EE20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710262685;
	bh=ozQaUNiP5dhmwGCp3i4ufKlOW6XPUdf59hzQAg3LXwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4yEFBeGxq1gtOLT9Ctwy/3UWT/4UZKqlPdj/qz6+nd4Mp0pNXreESjA63uxd45S9
	 PeC478YzVSgbhKv4zg33yU6VGuxpwtrHbfVrGLQ93yuOTNS7Y+Q+71EOLkK5v83l73
	 e3EHsUNSh8Xlxl/ACca7Y+TvWEEy7wGLAY9BbgzM=
Message-ID: <3bf8844a-3e19-4105-8cce-2b1f8f98d3bc@linux.microsoft.com>
Date: Tue, 12 Mar 2024 09:58:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
Content-Language: en-US
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
 Ani Sinha <anisinha@redhat.com>, Shradha Gupta <shradhagupta@microsoft.com>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2024 5:38 AM, Shradha Gupta wrote:
> If the network configuration strings are passed as a combination of IPv and

                                                                      *IPv4*

> IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
                                         *does not/doesn't*
> configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
> 
> Built-on: Rhel9
> Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)

As mentioned by Jakub[1], what value does this information provide?
Please follow Haiyang's suggestion [2] and put SKU and test information, or just
skip it.

[1] https://lore.kernel.org/all/20240307072923.6cc8a2ba@kernel.org/
[2] https://lore.kernel.org/all/DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com/

> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes in v2
>  * Use calloc to avoid initialization later
>  * Return standard error codes
>  * Free the output_str pointer on completion
>  * Add out-of bound checks while writing to buffers
> ---
>  tools/hv/hv_kvp_daemon.c | 173 +++++++++++++++++++++++++++++----------
>  1 file changed, 132 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..ae65be004eb1 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,6 +76,12 @@ enum {
>  	DNS
>  };
>  
> +enum {
> +	IPV4 = 1,
> +	IPV6,
> +	IP_TYPE_MAX
> +};
> +
>  static int in_hand_shake;
>  
>  static char *os_name = "";
> @@ -102,6 +108,7 @@ static struct utsname uts_buf;
>  
>  #define MAX_FILE_NAME 100
>  #define ENTRIES_PER_BLOCK 50
> +#define MAX_IP_ENTRIES 64

Is this a limitation defined by hv_kvp? If so, is it possible it may change in a later
version? A comment would help here

>  
>  struct kvp_record {
>  	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> @@ -1171,6 +1178,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
>  	return 0;
>  }
>  
> +int ip_version_check(const char *input_addr)
> +{
> +	struct in6_addr addr;
> +
> +	if (inet_pton(AF_INET, input_addr, &addr))
> +		return IPV4;
> +	else if (inet_pton(AF_INET6, input_addr, &addr))
> +		return IPV6;

You can skip the else here...

> +	else
> +		return -EINVAL;

...and you can skip the else here as well and just return -EINVAL

> +}
> +
>  /*
>   * Only IPv4 subnet strings needs to be converted to plen
>   * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1216,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
>  	return plen;
>  }
>  
> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> +				  int ip_sec)
> +{
> +	char addr[INET6_ADDRSTRLEN], *output_str;
> +	int ip_offset = 0, error = 0, ip_ver;
> +	char *param_name;
> +
> +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
> +				    sizeof(char));
> +
> +	if (!output_str)
> +		return -ENOMEM;
> +
> +	memset(addr, 0, sizeof(addr));
> +
> +	if (type == DNS) {
> +		param_name = "dns";
> +	} else if (type == GATEWAY) {
> +		param_name = "gateway";
> +	} else {
> +		error = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +				   (MAX_IP_ADDR_SIZE * 2))) {
> +		ip_ver = ip_version_check(addr);
> +		if (ip_ver < 0)
> +			continue;
> +
> +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
> +			    (strlen(addr))) {
> +				strcat(output_str, addr);
> +				strcat(output_str, ",");

Prefer strncat() here

> +			}
> +			memset(addr, 0, sizeof(addr));
> +
> +		} else {
> +			memset(addr, 0, sizeof(addr));
> +			continue;
> +		}
> +	}
> +
> +	if (strlen(output_str)) {
> +		output_str[strlen(output_str) - 1] = '\0';
> +		error = fprintf(f, "%s=%s\n", param_name, output_str);
> +		if (error <  0)
> +			goto cleanup;
> +	}
> +
> +cleanup:
> +	free(output_str);
> +	return error;
> +}
> +
>  static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> -				int is_ipv6)
> +				int ip_sec)
>  {
>  	char addr[INET6_ADDRSTRLEN];
>  	char subnet_addr[INET6_ADDRSTRLEN];
>  	int error, i = 0;
>  	int ip_offset = 0, subnet_offset = 0;
> -	int plen;
> +	int plen, ip_ver;
>  
>  	memset(addr, 0, sizeof(addr));
>  	memset(subnet_addr, 0, sizeof(subnet_addr));
> @@ -1216,10 +1292,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
>  						       subnet_addr,
>  						       (MAX_IP_ADDR_SIZE *
>  							2))) {
> -		if (!is_ipv6)
> +		ip_ver = ip_version_check(addr);
> +		if (ip_ver < 0)
> +			continue;
> +
> +		if (ip_ver == IPV4 && ip_sec == IPV4)
>  			plen = kvp_subnet_to_plen((char *)subnet_addr);
> -		else
> +		else if (ip_ver == IPV6 && ip_sec == IPV6)
>  			plen = atoi(subnet_addr);
> +		else
> +			continue;
>  
>  		if (plen < 0)
>  			return plen;
> @@ -1238,12 +1320,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
>  
>  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  {
> -	int error = 0;
> +	int error = 0, ip_type;

nit: Can we keep ip_ver through all the functions for consistency

<snip>

Thanks,
Easwar


