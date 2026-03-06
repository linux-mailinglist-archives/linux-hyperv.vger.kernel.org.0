Return-Path: <linux-hyperv+bounces-9157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL3WN45JqmlkOgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9157-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:27:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E521B171
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8D43021728
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 03:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E936BCE6;
	Fri,  6 Mar 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OCyTwoy7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C036A000;
	Fri,  6 Mar 2026 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767607; cv=none; b=l+UsrfX/3ZMkE4ajALkwaMkaweVa7n0m4AkIP7WwOP80WRvXeGKBehVfcnM0apgiPFZ4m97Nf2k1cHfBbGE0wtgI77Q1JQTkmTsNn9yJ3Cdznd1ER8Jo7NgQBK90IgQQEX2KqQ1cGtiO0eMOOP6IHJiB7mby9/gQWnxgmB+El6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767607; c=relaxed/simple;
	bh=Sx+ZqdJxPCQ544o84ZyRaXqjScaEW2cd5A4dMe5tQ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWeSM4/bxZWFjnjO6fmix31q5W0y7lbzRJkw9Us6zipFChdiOcu97GWS4gSO2nraf6YK3XenyOiuPFo6I/pqlsztCLDZkhpnt3tPw/kabJi1lWn3sXB1gPbs9xALPUQJeMZF4VGj/oNX8jb84EQamyq5xGauJUoOiM4rsb77JsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OCyTwoy7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBD0220B6F02;
	Thu,  5 Mar 2026 19:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBD0220B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772767606;
	bh=7twrQZpcMCiBUHkxNV0VPN0QJF0pvIqqVp6Eq2jNQfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCyTwoy7heHNtByDOnAXUtQSbFpoez2/JzyGvTAeRJXQL+c8Al3FhkCUsYpIvISCc
	 COXHMqRnSBt6vVpZCPCwym9BeugumWrOA5xGOITpHuY6h+FiSovCKpv/FoPVUC2cQY
	 jHqy5Nx8EZBFk2xm+ksKBNqNia+euXt7xvnQGR4s=
Message-ID: <7ff1c51b-d876-464e-3149-61684a22d788@linux.microsoft.com>
Date: Thu, 5 Mar 2026 19:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/4] mshv: Fix pre-depositing of pages for partition
 initialization
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258381999.229866.4628731518107275272.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177258381999.229866.4628731518107275272.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C1E521B171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9157-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Action: no action

On 3/3/26 16:23, Stanislav Kinsburskii wrote:
> Deposit enough pages upfront to avoid partition initialization failures due
> to low memory. This also speeds up partition initialization.

I am curious what kinda of failures are observerd. Normally, hypercall
would fail with insuff memory, and we continue to deposit till it
succeeds, right? Is there an issue there that some calls are not looping
in the deposit path?

> Move page depositing from the hypercall wrapper to the partition
> initialization code. The required number of pages is empirical. This logic
> fits better in the partition initialization code than in the hypercall
> wrapper.
> 
> A partition with nested capability requires 40x more pages (20 MB) to
> accommodate the nested MSHV hypervisor. This may be improved in the future.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root.h         |    1 +
>   drivers/hv/mshv_root_hv_call.c |    6 ------
>   drivers/hv/mshv_root_main.c    |   23 +++++++++++++++++++++--
>   3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 947dfb76bb19..40cf7bdbd62f 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -106,6 +106,7 @@ struct mshv_partition {
>   
>   	struct hlist_node pt_hnode;
>   	u64 pt_id;
> +	u64 pt_flags;
>   	refcount_t pt_ref_count;
>   	struct mutex pt_mutex;
>   
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index bdcb8de7fb47..b8d199f95299 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -15,7 +15,6 @@
>   #include "mshv_root.h"
>   
>   /* Determined empirically */
> -#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>   #define HV_UMAP_GPA_PAGES		512
>   
>   #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> @@ -139,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
>   
>   	input.partition_id = partition_id;
>   
> -	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -				    HV_INIT_PARTITION_DEPOSIT_PAGES);
> -	if (ret)
> -		return ret;
> -
>   	do {
>   		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>   					       *(u64 *)&input);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index d753f41d3b57..fbfc50de332c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -35,6 +35,10 @@
>   #include "mshv.h"
>   #include "mshv_root.h"
>   
> +/* The deposit values below are empirical and may need to be adjusted. */
> +#define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
> +#define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)

This suggests action rather than count. imo, much better would be:

   #define MSHV_PT_NUM_DEPOSIT_PAGES      	(SZ_512K >> PAGE_SHIFT)
   #define MSHV_PT_NUM_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)

+
>   MODULE_AUTHOR("Microsoft");
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
> @@ -1587,6 +1591,15 @@ mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
>   	return ret;
>   }
>   
> +static u64
> +mshv_partition_deposit_pages(struct mshv_partition *partition)
> +{
> +	if (partition->pt_flags &
> +	    HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE)
> +		return MSHV_PARTITION_DEPOSIT_PAGES_NESTED;
> +	return MSHV_PARTITION_DEPOSIT_PAGES;
> +}
> +
>   static long
>   mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>   {
> @@ -1595,6 +1608,11 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>   	if (partition->pt_initialized)
>   		return 0;
>   
> +	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> +				    mshv_partition_deposit_pages(partition));
> +	if (ret)
> +		goto withdraw_mem;
> +
>   	ret = hv_call_initialize_partition(partition->pt_id);
>   	if (ret)
>   		goto withdraw_mem;
> @@ -1610,8 +1628,8 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>   finalize_partition:
>   	hv_call_finalize_partition(partition->pt_id);
>   withdraw_mem:
> -	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> -
> +	hv_call_withdraw_memory(MSHV_PARTITION_DEPOSIT_PAGES,
> +				NUMA_NO_NODE, partition->pt_id);
>   	return ret;
>   }
>   
> @@ -2032,6 +2050,7 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
>   		return -ENOMEM;
>   
>   	partition->pt_module_dev = module_dev;
> +	partition->pt_flags = creation_flags;
>   	partition->isolation_type = isolation_properties.isolation_type;
>   
>   	refcount_set(&partition->pt_ref_count, 1);
> 
> 


