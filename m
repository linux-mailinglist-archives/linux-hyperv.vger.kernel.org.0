Return-Path: <linux-hyperv+bounces-9158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLAeMitLqmmIOwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9158-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:34:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA221B23C
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 332633013013
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F040353ED9;
	Fri,  6 Mar 2026 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XiieWHop"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903331AAA8;
	Fri,  6 Mar 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768041; cv=none; b=c935/FTqHYYfdEExl4k3XnTsrSAW3Vu970M1mLuyEo4s5zPdKX24SDKbx7zth+HH7WKxvI8Gi19MxXLgGRZIx+Kyj0LpCmbt4mm9yTdTdqYQX88ySg7mHAQ3IrJP+RS6StabmvDrG/8LW3Vowf9lH7vTs9jbpedDyHne0ucLW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768041; c=relaxed/simple;
	bh=w4vLLjXTHr0FobW1nLcGqXP3tT3PgPO3SteIT9vC3dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAV3aLeGlhhWGQ8z4dRzmyL6hGNyZrSE+IGHQRwQikeYG0O1iocIPgcOddCDnMFtombPWWkb3NDi6tHXDmFarI0auIOvf9ItCTVxRrstwNRWV5DqmLwuqgAjCBW67Q8EU/X7GGqMzZOg+j+lQcywIu1GJu0Ss8tGcMfYFiL3MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XiieWHop; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E66420B6F02;
	Thu,  5 Mar 2026 19:33:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E66420B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772768039;
	bh=UdFJxS169GpS95twGN8P9VGOVrkEo9bUVAIjn6KCQ+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiieWHop6qEq2E4/La98TdODUvcTRe6EbBDrw6hqE0k1S9TL2o0xC4X2K6rUdGR48
	 LtHfSU950/7uiSryHUCaL5Jqhf4sAqAqnBciak5JRkZu7AiAkQurUIAxXEYu/sOBaL
	 XMD9eXkl5dpAsp20Xolv3Gp3tqB8yf4BL0npH+4U=
Message-ID: <cd12c316-1014-2900-f47c-e092d1484c0a@linux.microsoft.com>
Date: Thu, 5 Mar 2026 19:33:58 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/4] mshv: Fix pre-depositing of pages for virtual
 processor initialization
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258382549.229866.5072213647599344057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177258382549.229866.5072213647599344057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45CA221B23C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9158-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/3/26 16:23, Stanislav Kinsburskii wrote:
> Deposit enough pages up front to avoid virtual processor creation failures
> due to low memory. This also speeds up guest creation. A VP uses 25% more
> pages in a partition with nested virtualization enabled, but the exact
> number doesn't vary much, so deposit a fixed number of pages per VP that
> works for nested virtualization.
> 
> Move page depositing from the hypercall wrapper to the virtual processor
> creation code. The required number of pages is based on empirical data.
> This logic fits better in the virtual processor creation code than in the
> hypercall wrapper.
> 
> Also withdraw the deposited memory if virtual processor creation fails.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/hv_proc.c        |    8 --------
>   drivers/hv/mshv_root_main.c |   11 ++++++++++-
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 0f84a70def30..3d41f52efd9a 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -251,14 +251,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>   	unsigned long irq_flags;
>   	int ret = 0;
>   
> -	/* Root VPs don't seem to need pages deposited */
> -	if (partition_id != hv_current_partition_id) {
> -		/* The value 90 is empirically determined. It may change. */
> -		ret = hv_call_deposit_pages(node, partition_id, 90);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	do {
>   		local_irq_save(irq_flags);
>   
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index fbfc50de332c..48c842b6938d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -38,6 +38,7 @@
>   /* The deposit values below are empirical and may need to be adjusted. */
>   #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
>   #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
> +#define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)


This seems to assume that each vp will use up total of 1M, and I don't
think that is the case. My understanding, hyp will reuse remaining chunks.
IOW, 6M maybe enought for 8 vcpus.


>   MODULE_AUTHOR("Microsoft");
>   MODULE_LICENSE("GPL");
> @@ -1077,10 +1078,15 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   	if (partition->pt_vp_array[args.vp_index])
>   		return -EEXIST;
>   
> +	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> +				    MSHV_VP_DEPOSIT_PAGES);
> +	if (ret)
> +		return ret;
> +
>   	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
>   				0 /* Only valid for root partition VPs */);
>   	if (ret)
> -		return ret;
> +		goto withdraw_mem;
>   
>   	ret = hv_map_vp_state_page(partition->pt_id, args.vp_index,
>   				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> @@ -1177,6 +1183,9 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>   			       intercept_msg_page, input_vtl_zero);
>   destroy_vp:
>   	hv_call_delete_vp(partition->pt_id, args.vp_index);
> +withdraw_mem:
> +	hv_call_withdraw_memory(MSHV_VP_DEPOSIT_PAGES, NUMA_NO_NODE,
> +				partition->pt_id);
>   out:
>   	trace_mshv_create_vp(partition->pt_id, args.vp_index, ret);
>   	return ret;
> 
> 


