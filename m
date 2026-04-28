Return-Path: <linux-hyperv+bounces-10412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP4TA3Ea8GntOQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10412-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 04:24:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF347CBBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 04:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F5D303D71B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA133914E9;
	Tue, 28 Apr 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ds09qLxV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38A38AC8A;
	Tue, 28 Apr 2026 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342998; cv=none; b=pSlDFGihWANJjnD/fqZE2lET455l28AJx93iog4GRg4e3EWIgjnIJrknegKy5kkUbUlxQAW5aUdXFxVZUqDF6lb6KRVIWkfNYPdSqRlzXcdXCJN9RAALAbuvvVtR2iLXmP83zZ7O1Ll7MSt1EXVCZe0vkYD/BKKzldedNyyyJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342998; c=relaxed/simple;
	bh=TNZqXvd0YLPBBdpUOavSQgk4IOl7Wok2ZTBYXP877IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIgd7PXkCFxQkXvhLvpAl8Q5CPW8aMb2nns18ftTmPU2Ufxg+3e9wtj6CB2STPwzsz6y3dYYHgVwG2TzNN4AGiA/A9h/75ZFjC0LIjXgjXa7lwaalPyfFvVdsmvEiFrB8MNBVtFMpTslyzWKd+E+AClC1+9d17QHF4nQafqpw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ds09qLxV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.0.48] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id D70FD20B716A;
	Mon, 27 Apr 2026 19:23:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D70FD20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777342998;
	bh=O6M4uZwgdMRNPS90zv/rayrIEjO/b3NvMxBlhseVnxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ds09qLxVSGafIwqxavq67AAIZCNKNE4RNJn7eabvjjxtL0+hS5jXt4hB0tJvsXbkk
	 zdL4TBeGytgx2TpaaLbGU42l5gak2PkDU8sq4pNX2OweHNbj0aTUC1RhLIGbD/142J
	 FTwqYhRtJW0XxYBT9XxDQr3KvRx5hppyy05Jwjsc=
Message-ID: <5c882157-2f83-2581-1a36-15a8d4cac61b@linux.microsoft.com>
Date: Mon, 27 Apr 2026 19:23:15 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 13/13] mshv: pin all ram mem regions if partition has
 device passthru
Content-Language: en-US
To: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
 <20260422023239.1171963-14-mrathor@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260422023239.1171963-14-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 63CF347CBBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10412-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


Please ignore this patch, something went wrong during merge/rebase.
The setting of pt_regions_pinned should be in a different function.

Thanks,
-Mukesh

On 4/21/26 19:32, Mukesh R wrote:
> Given the sporadic errors, mostly from high end devices, when regions are
> not pinned and a PCI device is passthru'd to a VM, for now, force all
> regions for the VM to be pinned. Even tho VFIO may pin them, the regions
> would still be marked movable, so do it upfront in mshv.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>   drivers/hv/mshv_root.h      | 6 ++++++
>   drivers/hv/mshv_root_main.c | 5 ++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index b9880d0bdc4d..32260df84f86 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -141,6 +141,7 @@ struct mshv_partition {
>   	pid_t pt_vmm_tgid;
>   	bool import_completed;
>   	bool pt_initialized;
> +	bool pt_regions_pinned;
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
>   	struct dentry *pt_stats_dentry;
>   	struct dentry *pt_vp_dentry;
> @@ -277,6 +278,11 @@ static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
>   	return partition->isolation_type == HV_PARTITION_ISOLATION_TYPE_SNP;
>   }
>   
> +static inline bool mshv_pt_regions_pinned(struct mshv_partition *pt)
> +{
> +	return pt->pt_regions_pinned || mshv_partition_encrypted(pt);
> +}
> +
>   struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
>   void mshv_partition_put(struct mshv_partition *partition);
>   struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index a7864463961b..251cf88a2b0b 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1333,7 +1333,7 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>   
>   	if (is_mmio)
>   		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
> -	else if (mshv_partition_encrypted(partition) ||
> +	else if (mshv_pt_regions_pinned(partition) ||
>   		 !mshv_region_movable_init(rg))
>   		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
>   	else
> @@ -1406,6 +1406,9 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
>   		goto err_out;
>   	}
>   
> +	/* For now, all regions must be pinned if there is device passthru. */
> +	partition->pt_regions_pinned = true;
> +
>   	return 0;
>   
>   invalidate_region:


