Return-Path: <linux-hyperv+bounces-6761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F39B463F5
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDCFA4476A
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B6283121;
	Fri,  5 Sep 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EMfE/qTy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F9287501;
	Fri,  5 Sep 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101836; cv=none; b=gxpM+vbFt+tMBjvz8ZH6t6YEUFHIJS40gWGcoFmDeAzbFIRwyIWo9ZAFzPRAfezv0wf6XvR9rYh8EvOB7R2qbAyBaUEKhfo93/Pf8ikbE3SuVLROFG8aGiQP6ykTVnoYjW0RHi9tAzlnyTCDn0sTb52CiVUWYgxn7fP9urmAbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101836; c=relaxed/simple;
	bh=voHEJ7PJUDXuXcBLg/dxKU8fgk7weU9CxANGBASCIEY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=slU0vhzQjW+F0Om3tBIeBVxP2DdFAVK0ypTYaA36XpfOv7gvVBQ7IlhFQY6Nr0Phn06THzN6TMw7H/SHeGtqC4HG+OhPC5A6RvPvgbIDPsiInNnJS5og2RXypkUlVrfuF6gToHUuYb+KIF4FLdn48X9KHVYT2r0lSOg/7YOW7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EMfE/qTy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 819ED20171D9;
	Fri,  5 Sep 2025 12:50:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 819ED20171D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757101833;
	bh=fXcKZLaTspFeLZFSa9p0gq9o3lJEfjkhrJb+EIbVsK0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EMfE/qTyPNUMnteZ6o3H45r1oOp7ohXa73yRcdSQiPhpCWd7XdaSDBGQEdW7WxGU+
	 /JD9k6yji+yTZ6TLhR1kGxv9bwrNWBF4fijdmBScAxK6xe/xCVqMj5Zt79ERoPbHHP
	 n5W4QkwWkG5WeYoY41WcOenLQ48zAh7KIKyrh00Q=
Message-ID: <ed4ebc67-dc98-4ce4-af5e-b2f371d27c5b@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:50:33 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, paekkaladevi@linux.microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH 6/6] mshv: Introduce new hypercall to map stats page for
 L1VH partitions
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-7-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-7-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 
> Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
> to map the stats to. This hypercall is required for L1VH partitions,
> depending on the hypervisor version. This uses the same check as the
> state page map location; mshv_use_overlay_gpfn().
> 
> Add mshv_map_vp_state_page() helpers to use this new hypercall or the
> old one depending on availability.
> 
> For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
> cases.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         | 10 ++--
>  drivers/hv/mshv_root_hv_call.c | 92 ++++++++++++++++++++++++++++++++--
>  drivers/hv/mshv_root_main.c    | 25 +++++----
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk_mini.h    |  7 +++
>  5 files changed, 115 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index d7c9520ef788..d16a020ae0ee 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -297,11 +297,11 @@ int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
>  int hv_call_disconnect_port(u64 connection_partition_id,
>  			    union hv_connection_id connection_id);
>  int hv_call_notify_port_ring_empty(u32 sint_index);
> -int hv_call_map_stat_page(enum hv_stats_object_type type,
> -			  const union hv_stats_object_identity *identity,
> -			  void **addr);
> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> -			    const union hv_stats_object_identity *identity);
> +int hv_map_stats_page(enum hv_stats_object_type type,
> +		      const union hv_stats_object_identity *identity,
> +		      void **addr);
> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
> +			const union hv_stats_object_identity *identity);
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 1882cc90f2f5..44013751cfc1 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -804,6 +804,45 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>  	return hv_result_to_errno(status);
>  }
>  
> +static int
> +hv_call_map_stats_page2(enum hv_stats_object_type type,

Again, one line please. Also below.

> +			const union hv_stats_object_identity *identity,
> +			u64 map_location)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_stats_page2 *input;
> +	u64 status;
> +	int ret;
> +
> +	if (!map_location || !mshv_use_overlay_gpfn())
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->type = type;
> +		input->identity = *identity;
> +		input->map_location = map_location;
> +
> +		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
> +
> +		local_irq_restore(flags);
> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				break;
> +			hv_status_debug(status, "\n");
> +			return hv_result_to_errno(status);
> +		}
> +
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
>  static int
>  hv_stats_get_area_type(enum hv_stats_object_type type,
>  		       const union hv_stats_object_identity *identity)
> @@ -822,9 +861,10 @@ hv_stats_get_area_type(enum hv_stats_object_type type,
>  	return -EINVAL;
>  }
>  
> -int hv_call_map_stat_page(enum hv_stats_object_type type,
> -			  const union hv_stats_object_identity *identity,
> -			  void **addr)
> +static int
> +hv_call_map_stats_page(enum hv_stats_object_type type,
> +		       const union hv_stats_object_identity *identity,
> +		       void **addr)

...

>  {
>  	unsigned long flags;
>  	struct hv_input_map_stats_page *input;
> @@ -880,8 +920,37 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
>  	return ret;
>  }
>  
> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> -			    const union hv_stats_object_identity *identity)
> +int hv_map_stats_page(enum hv_stats_object_type type,
> +		      const union hv_stats_object_identity *identity,
> +		      void **addr)
> +{
> +	int ret;
> +	struct page *allocated_page = NULL;
> +
> +	if (!addr)
> +		return -EINVAL;
> +
> +	if (mshv_use_overlay_gpfn()) {
> +		allocated_page = alloc_page(GFP_KERNEL);
> +		if (!allocated_page)
> +			return -ENOMEM;
> +
> +		ret = hv_call_map_stats_page2(type, identity,
> +					      page_to_pfn(allocated_page));
> +		*addr = page_address(allocated_page);
> +	} else {
> +		ret = hv_call_map_stats_page(type, identity, addr);
> +	}
> +
> +	if (ret && allocated_page)
> +		__free_page(allocated_page);
> +
> +	return ret;
> +}
> +
> +static int
> +hv_call_unmap_stats_page(enum hv_stats_object_type type,

...

> +			 const union hv_stats_object_identity *identity)
>  {
>  	unsigned long flags;
>  	struct hv_input_unmap_stats_page *input;
> @@ -900,6 +969,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>  	return hv_result_to_errno(status);
>  }
>  
> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
> +			const union hv_stats_object_identity *identity)
> +{
> +	int ret;
> +
> +	ret = hv_call_unmap_stats_page(type, identity);
> +
> +	if (mshv_use_overlay_gpfn() && page_addr)
> +		__free_page(virt_to_page(page_addr));
> +
> +	return ret;
> +}
> +
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f91880cc9e29..1699423cc524 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -894,7 +894,8 @@ mshv_vp_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
> +				void *stats_pages[])
>  {
>  	union hv_stats_object_identity identity = {
>  		.vp.partition_id = partition_id,
> @@ -902,10 +903,13 @@ static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
>  	};
>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
> +
> +	if (stats_pages[HV_STATS_AREA_PARENT] == stats_pages[HV_STATS_AREA_SELF])
> +		return;
>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>  }
>  
>  static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> @@ -918,14 +922,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>  	int err;
>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> -				    &stats_pages[HV_STATS_AREA_SELF]);
> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> +				&stats_pages[HV_STATS_AREA_SELF]);

Shouldn't this be in the previous patch where the other hv_call_map_stat_page() calls were
converted, same below?

>  	if (err)
>  		return err;
>  
>  	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
> -	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> -				    &stats_pages[HV_STATS_AREA_PARENT]);
> +	err = hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> +				&stats_pages[HV_STATS_AREA_PARENT]);

...

>  	if (err)
>  		goto unmap_self;
>  
> @@ -936,7 +940,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>  
>  unmap_self:
>  	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>  	return err;
>  }
>

<snip>

