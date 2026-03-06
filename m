Return-Path: <linux-hyperv+bounces-9159-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC3lA/1NqmmIOwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9159-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:46:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95B21B489
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF10E30E7870
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 03:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C933CEBB;
	Fri,  6 Mar 2026 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="osGe+3L9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F08248873;
	Fri,  6 Mar 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768485; cv=none; b=HEaUF7pnO7GJ8Cc/VHkhN2wqwwzrhFjrBC5izE+t9ybESyWH/tYDhUORbK2yfUoRi2PkWicOBvPuJwUG1srJuhCnjonw81YYPO+q37d73iMHnOgBo+9mGKGaCq5Mzi4Z69Usd95UguFcJNLGmNK7PiH63+DRQ+XEaludecmB3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768485; c=relaxed/simple;
	bh=SagAAyhFCSFGyYcmVQF7FWOkOAUBqAkRHEVJ+rHEeqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9GLAlF1ItTOR+p97M04vZwANsQXW6r+YS6mngEzCLuAz2dXZ/tNAwBpwm4ScUCVtvUBcm0sjii+pi3MflqMSXp5e9sL9gdxdZWGfKugLIrAW167LrXBCVtwfYLU6d8O4a74iIa+srOS2QPLJvvOiXVxh2gnPcEn9gsuNJgi5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=osGe+3L9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA6C820B6F02;
	Thu,  5 Mar 2026 19:41:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA6C820B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772768484;
	bh=KHOwLExV6T2Yft716koXb6mfhvwl93XgxzzuZkWLfM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=osGe+3L92rhAj+8WwMORAr0nNjjXRS26YVau0z+oCtUFYG61ZYdMc3SiG3bNR+1zT
	 cYbvHApkaYQ6uUxsYWZfiVQ7RpGDWWRedCnyw+GKZqSAhBk7CRkkbtATkIxAuJKSRY
	 dzYrfncArMLbd6sBi7YBn19sYaqyx9ljWgT59R4E=
Message-ID: <40435d99-56fa-350e-1147-8e45acf5494e@linux.microsoft.com>
Date: Thu, 5 Mar 2026 19:41:23 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/4] mshv: Pre-deposit pages for SLAT creation
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B95B21B489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9159-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/3/26 16:23, Stanislav Kinsburskii wrote:
> Deposit enough pages up front to avoid guest address space region creation
> failures due to low memory. This also speeds up guest creation.

Does this imply that some hypercall fails and has no return of
insufficient memory?

> Calculate the required number of pages based on the guest's physical
> address space size, rounded up to 1 GB chunks. Even the smallest guests are
> assumed to need at least 1 GB worth of deposits. This is because every
> guest requires tens of megabytes of deposited pages for hypervisor
> overhead, making smaller deposits impractical.
> 
> Estimating in 1 GB chunks prevents over-depositing for larger guests while
> accepting some over-deposit for smaller ones. This trade-off keeps the
> estimate close to actual needs for larger guests.
> 
> Also withdraw the deposited pages if address space region creation fails.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root_main.c |   25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 48c842b6938d..cb5b4505f8eb 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -39,6 +39,7 @@
>   #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
>   #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
>   #define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)
> +#define MSHV_1G_DEPOSIT_PAGES			(6 * SZ_1M >> PAGE_SHIFT)
>   
>   MODULE_AUTHOR("Microsoft");
>   MODULE_LICENSE("GPL");
> @@ -1324,6 +1325,18 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
>   	return ret;
>   }
>   
> +static u64
> +mshv_region_deposit_slat_pages(struct mshv_mem_region *region)

I don't think it is accurate to say slat pages, because in case of
overdeposit, they may be used for non-slat purposes according to my
understanding.

> +{
> +	u64 region_in_gbs, slat_pages;
> +
> +	/* SLAT needs 6 MB per 1 GB of address space. */
> +	region_in_gbs = DIV_ROUND_UP(region->nr_pages << HV_HYP_PAGE_SHIFT, SZ_1G);
> +	slat_pages = region_in_gbs * MSHV_1G_DEPOSIT_PAGES;
> +
> +	return slat_pages;
> +}
> +

Again, unconditionally depositing for each region is not good because
that is empirical, and hyp will reuse the leftover ram.

/*
>    * This maps two things: guest RAM and for pci passthru mmio space.
>    *
> @@ -1364,6 +1377,11 @@ mshv_map_user_memory(struct mshv_partition *partition,
>   	if (ret)
>   		return ret;
>   
> +	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> +				    mshv_region_deposit_slat_pages(region));
> +	if (ret)
> +		goto free_region;
> +
>   	switch (region->mreg_type) {
>   	case MSHV_REGION_TYPE_MEM_PINNED:
>   		ret = mshv_prepare_pinned_region(region);
> @@ -1392,7 +1410,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>   				   region->hv_map_flags, ret);
>   
>   	if (ret)
> -		goto errout;
> +		goto withdraw_memory;
>   
>   	spin_lock(&partition->pt_mem_regions_lock);
>   	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> @@ -1400,7 +1418,10 @@ mshv_map_user_memory(struct mshv_partition *partition,
>   
>   	return 0;
>   
> -errout:
> +withdraw_memory:
> +	hv_call_withdraw_memory(mshv_region_deposit_slat_pages(region),
> +				NUMA_NO_NODE, partition->pt_id);
> +free_region:
>   	vfree(region);
>   	return ret;
>   }
> 
> 


