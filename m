Return-Path: <linux-hyperv+bounces-6755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9380B46312
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CDE1D224B9
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F8315D47;
	Fri,  5 Sep 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="TairyvWA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD08315D22;
	Fri,  5 Sep 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099015; cv=pass; b=nfLHR8/q8Dgv9a8MnWBAKM8rAn4TS340XCeVEQ+d3e1YlGoNT4eu7l0SZOmjD8d1DQlh0Is2adpENjUn91r+9KqnEUsg54Qy69bNN0tEuMHIbs3cvw8fbU5gYRe3gvWJjwYLjFQwQ3PqDryrEX8b41/HgS5xb9kchfUHPdLhDJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099015; c=relaxed/simple;
	bh=bDppVikZqz1VDZwZU00PCgVbwhIeGhaop80vGUK9GzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY7Nrs2ndorA0Fkix0Z1QtG5W1H+MAQ8U5tjsLoufMweCLm9pI6APbO3YMzgwJIAPd7pscOevfE0QtU5AJDvfN9kSU5Bp05fHiOhRC/gu8rmFrNwyhNf4xcYnNF6XoQcMzqGbzu7i25ILK71pr1jCJstglBzbwo5QLCj1VF+7a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=TairyvWA; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1757099001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PUxM6M9dytJ6SNCVS257ONnSvXpBQi66v1A3YYFGsP5lcz5S3brKvGgsMCpT4f+GtBeKdqR72XBQi5Ouj9dbFVUTqmjMV52y3wqLxpIa/jyvs0tijda54QXzUvjAJC4UO01+efHrDrX8V0GFE6p0ZQs/U4GQEo8nxprW/mUp4sU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757099001; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BjWePr2hlI+rQ4+nuIiucc+BsZmLUX4MO6xnw2zoglM=; 
	b=goxvPd6tXP1G3BO1M5yTtzI/U0vuai5EYclu4WUy4lI1CuxiuU9LJglfRMWX1N8MQIr+batPp8VUzCyx5jV9MV2plu5G+lHhqwrTnFS7DG7qwj7F3Syms2dt/Gc1rc8vQT0h3j7egyXXNpZR3ldlw1/3JhKLIv5NOfUApmFbEPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757099000;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BjWePr2hlI+rQ4+nuIiucc+BsZmLUX4MO6xnw2zoglM=;
	b=TairyvWAXdH9X3gVoDACdja28SFOpGeNwP5wCoFSVSRDnH1kpxP/YsCmg51R9wnY
	mfaEbwg4EOUODgGd+tUsRPswCkBz0p0anqWYcge1QHQZthUV4LCCFCLCe84g8av0Vmx
	1JogsohC9pK80V6kWVwj3IfUNAgbAIPmf18e9eAI=
Received: by mx.zohomail.com with SMTPS id 1757098997366957.6801432970645;
	Fri, 5 Sep 2025 12:03:17 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:03:11 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the
 hypervisor
Message-ID: <aLsz78GrA_mqucOb@anirudh-surface.localdomain>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
X-ZohoMailClient: External

On Thu, Aug 28, 2025 at 05:43:48PM -0700, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Some newer hypervisor APIs are gated by feature bits in the so-called
> "vmm capabilities" partition property. Store the capabilities on
> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h      |  1 +
>  drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
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
> index 56ababab57ce..29f61ecc9771 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct device *dev)
>  	return err;
>  }
>  
> +static int mshv_init_vmm_caps(struct device *dev)
> +{
> +	int ret;
> +
> +	memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> +						0, &mshv_root.vmm_caps,
> +						sizeof(mshv_root.vmm_caps));
> +
> +	/*
> +	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
> +	 * older hyperv. Ignore the -EIO error code.
> +	 */
> +	if (ret && ret != -EIO)
> +		return ret;
> +
> +	dev_dbg(dev, "vmm_caps=0x%llx\n", mshv_root.vmm_caps.as_uint64[0]);
> +
> +	return 0;
> +}
> +
>  static int __init mshv_parent_partition_init(void)
>  {
>  	int ret;
> @@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto remove_cpu_state;
>  
> +	ret = mshv_init_vmm_caps(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to get VMM capabilities\n");
> +		goto exit_partition;

Should this really be treated as a failure here? We could still offer
/dev/mshv albeit with potentially limited capabilities.

Thanks,
Anirudh.

> +	}
> +
>  	ret = mshv_irqfd_wq_init();
>  	if (ret)
>  		goto exit_partition;
> -- 
> 2.34.1
> 

