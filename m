Return-Path: <linux-hyperv+bounces-1825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C288ACEA
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 19:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF191F67D83
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BF84D2E;
	Mon, 25 Mar 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dE3Y4WZO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057E495E5;
	Mon, 25 Mar 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387415; cv=none; b=IpgaFYcr1VK7ZASiq/XVNRI2m9ZAqbadQAbKTNe9G6Y5pjeMK8m++BFpTExy4rnJMasrcsyOWjwFa1bYZ8DT9AC4OmVh9cUOWmVtc1eEv0EnwaNWgJ6yCT0UBw8ZMacB43blcKdur1uNyjPydjoeZfZrLq7J1xJXXBdx+bUPgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387415; c=relaxed/simple;
	bh=BYJzYT4NQKRLwLKk/EBpQuhT2Nji9CLyF0I+i+pUB7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lptRjRGV9u5juEqcIdhb4V8qBRFVkpecF3WMQ18gJYCWnb6XbWqTI/LDN8XplonyND6+3ZKKvKqmWUeKAmq9MZwn+uEQL70TuYDmWLr+To+ec7mtWw50ZYjLF5y60/QXpyBVqE6HW67zpcPuFtCNIMueTg7O2/5UkG/64P6JMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dE3Y4WZO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.32.128] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 43D0520B74C0;
	Mon, 25 Mar 2024 10:23:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43D0520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711387407;
	bh=lnc4G3BBPQZGYVAtWNJgDDBSmC1uJv/ZEHMGSWBLpjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dE3Y4WZOgv6povt1qfY3cw+a/AhDliTwnSRHQMNaeCoxu6qh/7r15MBRfwS0YhYbm
	 waahp4b8Dl2p19yMph5CqLRfR/UXoPWKQX2krMHNwhrgCtcU1QSYMNu1R9OoRZap1o
	 bhRxNI8UmB/5BSYY9l0RbQPBPWKbJsuoMaxQb63E=
Message-ID: <eea2ddef-ba2e-4424-84d0-2af0340be899@linux.microsoft.com>
Date: Mon, 25 Mar 2024 10:23:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
References: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/2024 6:46 AM, Shradha Gupta wrote:
> If the network configuration strings are passed as a combination of IPv4
> and IPv6 addresses, the current KVP daemon does not handle processing for
> the keyfile configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
> 
> Testcases ran:Rhel 9, Hyper-V VMs
>               (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> 
> Co-developed-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  Changes in v5
>  * Included Ani's proposed patch and added him as co-author
> ---
>  tools/hv/hv_kvp_daemon.c | 213 +++++++++++++++++++++++++++++++--------
>  1 file changed, 172 insertions(+), 41 deletions(-)
> 

<snip>

>  }
>  
>  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  {
> -	int error = 0;
> +	int error = 0, ip_ver;
>  	char if_filename[PATH_MAX];
>  	char nm_filename[PATH_MAX];
>  	FILE *ifcfg_file, *nmfile;
>  	char cmd[PATH_MAX];
> -	int is_ipv6 = 0;
>  	char *mac_addr;
>  	int str_len;
>  
> @@ -1421,52 +1510,94 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	if (error)
>  		goto setval_error;
>  
> -	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> -		error = fprintf(nmfile, "\n[ipv6]\n");
> -		if (error < 0)
> -			goto setval_error;
> -		is_ipv6 = 1;
> -	} else {
> -		error = fprintf(nmfile, "\n[ipv4]\n");
> -		if (error < 0)
> -			goto setval_error;
> -	}
> -
>  	/*
>  	 * Now we populate the keyfile format
> +	 *
> +	 * The keyfile format expects the IPv6 and IPv4 configuration in
> +	 * different sections. Therefore we iterate through the list twice,
> +	 * once to populate the IPv4 section and the next time for IPv6
>  	 */
> +	ip_ver = IPV4;
> +	do {
> +		if (ip_ver == IPV4) {
> +			error = fprintf(nmfile, "\n[ipv4]\n");
> +			if (error < 0)
> +				goto setval_error;
> +		} else {
> +			error = fprintf(nmfile, "\n[ipv6]\n");
> +			if (error < 0)
> +				goto setval_error;
> +		}
>  
> -	if (new_val->dhcp_enabled) {
> -		error = kvp_write_file(nmfile, "method", "", "auto");
> -		if (error < 0)
> -			goto setval_error;
> -	} else {
> -		error = kvp_write_file(nmfile, "method", "", "manual");
> +		/*
> +		 * Write the configuration for ipaddress, netmask, gateway and
> +		 * name services
> +		 */
> +		error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +					     (char *)new_val->sub_net,
> +					     ip_ver);
>  		if (error < 0)
>  			goto setval_error;
> -	}
>  
> -	/*
> -	 * Write the configuration for ipaddress, netmask, gateway and
> -	 * name services
> -	 */
> -	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> -				     (char *)new_val->sub_net, is_ipv6);
> -	if (error < 0)
> -		goto setval_error;
> +		/*
> +		 * As dhcp_enabled is only valid for ipv4, we do not set dhcp
> +		 * methods for ipv6 based on dhcp_enabled flag.
> +		 *
> +		 * For ipv4, set method to manual only when dhcp_enabled is
> +		 * false and specific ipv4 addresses are configured. If neither
> +		 * dhcp_enabled is true and no ipv4 addresses are configured,
> +		 * set method to 'disabled'.
> +		 *
> +		 * For ipv6, set method to manual when we configure ipv6
> +		 * addresses. Otherwise set method to 'auto' so that SLAAC from
> +		 * RA may be used.
> +		 */
> +		if (ip_ver == IPV4) {
> +			if (new_val->dhcp_enabled) {
> +				error = kvp_write_file(nmfile, "method", "",
> +						       "auto");
> +				if (error < 0)
> +					goto setval_error;
> +			} else if (error) {

FWIW, for v5:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

> +				error = kvp_write_file(nmfile, "method", "",
> +						       "manual");
> +				if (error < 0)
> +					goto setval_error;
> +			} else {
> +				error = kvp_write_file(nmfile, "method", "",
> +						       "disabled");
> +				if (error < 0)
> +					goto setval_error;
> +			}


<snip>

Thanks,
Easwar


