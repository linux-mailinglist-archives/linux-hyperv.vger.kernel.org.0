Return-Path: <linux-hyperv+bounces-6949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C2B8695C
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5139E16F484
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69982D6E7C;
	Thu, 18 Sep 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HXwS/xrA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE72D3EC7;
	Thu, 18 Sep 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221439; cv=none; b=U6VvsRexrwS0tZVctzwf14fz9JeiHnEnaBeqTE/VqTJKvGGLqrZac1WdCOeTq7HRPpaqENfACYAPbXjCPFWTp09YlWBkTvzaemjooZjDZ7hFRlb+fWy2ZkR6MHOcgv45a9I583Pn/eN9AvKTTESv7/1XV6OSIzhfMXBQZAdH1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221439; c=relaxed/simple;
	bh=gxz+eJCz0rokLGRT6TV7jyNmc/1TKTG7PL2bDriAILA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/DjlG9zqbhFmatJ5EPtbkO31Nwf0RrfyzfHcqA+BT90pRhU3CGt+/Qd7HELPzxC0zGsWtrBfRjDgKviMG0hJ94sUR7TSTkNoev7PuGQzJpSkHrwyT2vhkcWeZsJmakHVs/cjXcsZkHr4pxf+3dFJiMlXb9WaFeztHA/WkDISbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HXwS/xrA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [131.107.8.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81A4120143DE;
	Thu, 18 Sep 2025 11:50:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81A4120143DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758221437;
	bh=nkckIRmNMbfy71XGeKeE26eRdwB4pFLivsPGAg37dxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXwS/xrAi6lMcyEVQU4BYSx1OpvYjzWrZm7uKbhsqyP+BeotKSW1J8nWbS9VaUBhD
	 6cJGG3rJmMU0eOjNyY3HZXXYeJj1GPFRjHnnCdoVDQxEXCWJJpFfsxJ/Ug7TudoSac
	 P0bVUFfiVjt/fwvoiYOOjSebhNCJlr+qEa3DgbzU=
Date: Thu, 18 Sep 2025 11:50:35 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v3 3/5] mshv: Get the vmm capabilities offered by the
 hypervisor
Message-ID: <aMxUe7WLzMXJY16c@skinsburskii.localdomain>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758066262-15477-4-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Sep 16, 2025 at 04:44:20PM -0700, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some hypervisor APIs are gated by feature bits in the
> "vmm capabilities" partition property. Store the capabilities on
> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
> 
> This is not supported on all hypervisors. In that case, just set the
> capabilities to 0 and proceed as normal.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/mshv_root.h      |  1 +
>  drivers/hv/mshv_root_main.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 4aeb03bea6b6..0cb1e2589fe1 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -178,6 +178,7 @@ struct mshv_root {
>  	struct hv_synic_pages __percpu *synic_pages;
>  	spinlock_t pt_ht_lock;
>  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
> +	struct hv_partition_property_vmm_capabilities vmm_caps;
>  };
>  
>  /*
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 24df47726363..f7738cefbdf3 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2201,6 +2201,26 @@ static int __init mshv_root_partition_init(struct device *dev)
>  	return err;
>  }
>  
> +static void mshv_init_vmm_caps(struct device *dev)
> +{
> +	int ret;

nit: this is void function so ret looks redundant.

> +
> +	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));

Zeroying is redundant as mshv_root is a statci variable.

> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> +						0, &mshv_root.vmm_caps,

Also, we align "slow" hypercalls by PAGE_SIZE. Why is it fine to not do
it here?

Thanks,
Stanislav

> +						sizeof(mshv_root.vmm_caps));
> +
> +	/*
> +	 * HVCALL_GET_PARTITION_PROPERTY_EX or HV_PARTITION_PROPERTY_VMM_CAPABILITIES
> +	 * may not be supported. Leave them as 0 in that case.
> +	 */
> +	if (ret)
> +		dev_warn(dev, "Unable to get VMM capabilities\n");
> +
> +	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
> +}
> +
>  static int __init mshv_parent_partition_init(void)
>  {
>  	int ret;
> @@ -2253,6 +2273,8 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto remove_cpu_state;
>  
> +	mshv_init_vmm_caps(dev);
> +
>  	ret = mshv_irqfd_wq_init();
>  	if (ret)
>  		goto exit_partition;
> -- 
> 2.34.1
> 

