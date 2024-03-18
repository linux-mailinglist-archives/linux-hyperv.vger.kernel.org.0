Return-Path: <linux-hyperv+bounces-1772-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDF87ED4C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 17:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97007281339
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C15D52F6E;
	Mon, 18 Mar 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Aw3Qz1Js"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D084F5F8;
	Mon, 18 Mar 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778760; cv=none; b=gEvnKOzBpG2hqTyxzwFDO7yfG21kxuw5kzPKwfuQYbaENUL+zOZnK0OikQzJh4eljGzXB1HHBJQCVF8jicYS5c5lbAEPozfrLiG6u268tjOde+ow25X2NXFuM0znbObvJrw0OYJmdZ1+NRGvIX2lfF1ZNNY3EgJGKpQoHISQNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778760; c=relaxed/simple;
	bh=zhMdbPT3xHZcvvpIG9l/1agPAegRTeUMlHwrwzZ/U6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqY15QFfi/K1S0cc+lTW/7HH/Xc6IssK8dXD6c7FmOMrBNMsWg6IA6rqZ8k66zJwnTucatzeSjla3RPiH1BdI0kmbgkwvC6g21UPQqo8Sc5ldESwZHec87sRgA09rNkOdB0/E4wHVOy1+x9a3MONUC1eSau8farnPcBhuygP0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Aw3Qz1Js; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.101] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 97EB020B74C0;
	Mon, 18 Mar 2024 09:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97EB020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710778758;
	bh=G9/0I5GNTTFBySMk2TCfzprCYhkTXP2zNkVIW8m1/bQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aw3Qz1Jsim+f5kTaPY45tB5GzT/UwJVleGlmmIkvMF9IjYluooN5aV2S5Vz9YQuEX
	 H29+ErgoMHvX2oCK8bQ6CMuOBV6z7Wpeo4b8SzkFv8/6gX77XQfX4ytpDAd0FYeKrZ
	 SDgIDkV9SZuXw5vmfIHjvJ/PEi1rXPngZo/JCVnc=
Message-ID: <9d24633d-b2bf-4cbe-86f7-6df56ba14657@linux.microsoft.com>
Date: Mon, 18 Mar 2024 09:19:16 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/2024 7:45 PM, Shradha Gupta wrote:
> If the network configuration strings are passed as a combination of IPv and

Repeating a few unaddressed comments from v2.

Missing a 4 in the IPv4 string here

> IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile

You probably want to add a space so it reads as *...KVP daemon does not*, or contract it to *doesn't*

> configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
> 
> Testcases ran:Rhel 9, Hyper-V VMs
>               (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes in v3
>  * Introduced a macro for the output string size
>  * Added cound checks and used strncpy instead of strncpy
>  * Rearranged code to reduce total lines of code
> ---
>  tools/hv/hv_kvp_daemon.c | 177 ++++++++++++++++++++++++++++++---------
>  1 file changed, 136 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..156cef99d361 100644
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
> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
>  
>  #define MAX_FILE_NAME 100
>  #define ENTRIES_PER_BLOCK 50
> +/*
> + * Change this entry if the number of addresses increases in future
> + */
> +#define MAX_IP_ENTRIES 64
> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
>  
>  struct kvp_record {
>  	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
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
> +
> +	return -EINVAL;
> +}
> +
>  /*
>   * Only IPv4 subnet strings needs to be converted to plen
>   * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1220,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
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
> +	memset(addr, 0, sizeof(addr));

Echoing Ani, you don't need this memset here since your first step in the loop below is to
memset(addr, 0).

> +
> +	if (type == DNS)
> +		param_name = "dns";
> +	else if (type == GATEWAY)
> +		param_name = "gateway";
> +	else
> +		return -EINVAL;
> +
> +	output_str = (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
> +	if (!output_str)
> +		return -ENOMEM;
> +
> +	while (1) {
> +		memset(addr, 0, sizeof(addr));
> +
> +		if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +					 (MAX_IP_ADDR_SIZE * 2)))
> +			break;
> +
> +		ip_ver = ip_version_check(addr);
> +		if (ip_ver < 0)
> +			continue;
> +
> +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> +			/*
> +			 * do a bound check to avoid out-of bound writes
> +			 */
> +			if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
> +			    (strlen(addr) + 1)) {
> +				strncat(output_str, addr,
> +					OUTSTR_BUF_SIZE - strlen(output_str));
> +				strncat(output_str, ",",
> +					OUTSTR_BUF_SIZE - strlen(output_str));
> +			}
> +		} else {
> +			continue;
> +		}
> +	}
> +
> +	if (strlen(output_str)) {
> +		output_str[strlen(output_str) - 1] = '\0';

You don't need this since you're using strncat which adds its own '\0'. I wasn't quite able to follow along 
on the discussion between Ani and you, so putting this in here in case it wasn't already mentioned.

> +		error = fprintf(f, "%s=%s\n", param_name, output_str);
> +	}
> +
> +	free(output_str);
> +	return error;
> +}

<snip>


