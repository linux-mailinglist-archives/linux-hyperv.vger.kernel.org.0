Return-Path: <linux-hyperv+bounces-1763-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923D87D24B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Mar 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B54A284100
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Mar 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21691482D3;
	Fri, 15 Mar 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rSVsPH7E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B34779D;
	Fri, 15 Mar 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521786; cv=none; b=aDPC6G3iSfYofL9jA+mzqfI7jljOgTErZAjld7LW5U9ugZPmfkcn1W3Brx+OSCrTmd6BdDS1TkDsm0AmBSR8eh0NziPZz+WPW7RT0R+HSQeLiejMc2/iRplgMUhQ0FQFdZVYbhxu+a/Icf4xWgrEbxJbzJ1cnSpsAa87AWcIcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521786; c=relaxed/simple;
	bh=WdvwjxQVySFmsU+ux3dQqefsmL5GQWcxrNM2Du895kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6IxaoSCqFOFu2m3zD8NZRsvorUhtNTc1R9bRksb62NrOifANd0GbHssTPElK6XSK09keYeRMQAN1vbRDN9MwckJjuuq+mTV/f4Y/9tMGgdfbAWayn463bYXDjVNsFQKodEV+e3MI0XELFzs1ASb25DFVgob3/73VZkHxoCTiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rSVsPH7E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.154] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC5F720B74C0;
	Fri, 15 Mar 2024 09:56:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC5F720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710521784;
	bh=Q78OTWOsVRBCL80yDDNEfCI9drv9glFw8Ky35vj5BKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rSVsPH7E852ccfLCYlhbYQV4XdBIIohLhdPGxy7GYa1OsmerTjMJ6iRldg68M1qGO
	 ltnxyOb7WP0YoJpudcR8fzqrgqAn5uWI+D4MCOTe+3WsCOJ5sxU3WKymHt6nSsZGix
	 FinTjVTBGNmicQoaWhzqdLggvo6NdU2UjcnyU7G0=
Message-ID: <dd1b378d-6750-419f-8c46-a8f42c0ebe11@linux.microsoft.com>
Date: Fri, 15 Mar 2024 09:56:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
 Ani Sinha <anisinha@redhat.com>, Shradha Gupta <shradhagupta@microsoft.com>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
 <3bf8844a-3e19-4105-8cce-2b1f8f98d3bc@linux.microsoft.com>
 <20240313052212.GB22465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240315140914.GA14685@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240315140914.GA14685@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/2024 7:09 AM, Shradha Gupta wrote:

<snip>

>>>>  }
>>>>  
>>>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
>>>> +				  int ip_sec)
>>>> +{
>>>> +	char addr[INET6_ADDRSTRLEN], *output_str;
>>>> +	int ip_offset = 0, error = 0, ip_ver;
>>>> +	char *param_name;
>>>> +
>>>> +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
>>>> +				    sizeof(char));
>>>> +
>>>> +	if (!output_str)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	memset(addr, 0, sizeof(addr));
>>>> +
>>>> +	if (type == DNS) {
>>>> +		param_name = "dns";
>>>> +	} else if (type == GATEWAY) {
>>>> +		param_name = "gateway";
>>>> +	} else {
>>>> +		error = -EINVAL;
>>>> +		goto cleanup;
>>>> +	}
>>>> +
>>>> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
>>>> +				   (MAX_IP_ADDR_SIZE * 2))) {
>>>> +		ip_ver = ip_version_check(addr);
>>>> +		if (ip_ver < 0)
>>>> +			continue;
>>>> +
>>>> +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
>>>> +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
>>>> +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
>>>> +			    (strlen(addr))) {
>>>> +				strcat(output_str, addr);
>>>> +				strcat(output_str, ",");
>>>
>>> Prefer strncat() here
> Is this needed with the bound check above. I am trying to keep parity with the rest of the 
> file.
>>>
<snip>

I missed this earlier because my comment was more of a general best practice comment.

Note that in the worst case where your bounds check (INET6_ADDRSTRLEN*MAX_IP_ENTRIES) - strlen(output_str) equals (strlen(addr) + 1),
you will be adding strlen(addr)+1(","), and end up with no ASCII NUL '\0' delimiter.

If you're going to rely on the bounds check to ensure correctness, you'll need to correct that. Generally speaking, strncat would still
be helpful in case the bounds check changes in the future.

Thanks,
Easwar


