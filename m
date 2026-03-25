Return-Path: <linux-hyperv+bounces-9752-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHL5Jj+pw2nAtAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9752-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:22:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB10322161
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7118301A9CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D713115BC;
	Wed, 25 Mar 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO8wt1yf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06582F3C18;
	Wed, 25 Mar 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430525; cv=none; b=A1neDcSwIWlGTjtqMudhOK0DOUX8cz17dPxDE6QqaX1NF/cWVaVVH0M5oRAQPNbft8j5cwlaC3YAhjriIbZL0YgN+6QFwjOYlmDpT2u6TbjF23/Zv5Prd6O7cfPO/Twwj9f0LTC6irZ/xVqA0KjHw+MFViXt+mamKIyAb7TI4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430525; c=relaxed/simple;
	bh=Ak+Y2Irbt9Vy7emvnxV1c3MbwGabTZfucRgopnZqMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBufS5m4GeWGF1o8v0mxQshPqba5Kefnmo2Ez+EXzh0ZpDkmX5Ul/cljEqrydpNfyzJCeM/h/br+mX3m6ifLWS+04kBQZDyf8+muwGhnTb1i2QkLL6eEpb+yEB3PmTb8bi3DU/hjPiRx04l31ZzF0Mm3oHUMN/5LerPoJ9gzpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO8wt1yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E6AC4CEF7;
	Wed, 25 Mar 2026 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774430525;
	bh=Ak+Y2Irbt9Vy7emvnxV1c3MbwGabTZfucRgopnZqMck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO8wt1yfpnT9fh76npBs2P2IAamaEGlYCxXIjQMCoM89o3YFtC5iLVkVlE4Qs1IYj
	 OCBMXNnpXCdkW/vRnnS6hqLzlPRzgPxIRswguYbWXC6V4Aj8hwqPQ99AJm3JZnvED7
	 tRZrHROPnumyjAUV9jgpHngj+762dqUt/S58m8TaNaWLxONbMZoOUEbJIH7wYh8Y/5
	 LECLRTsfN9NNxslRFqVgOZh2gpovrkqXQuR+7SbC1tXUJqgW0QTWDUUPt5RD6C8doR
	 5o1wanARdfGXQJI7ncu2x2q3Rked/Lp+TAMyMVxi+SsYGp9+CZs+O4A5g/ETNEHWqq
	 y2GY+EDGZIa9Q==
Date: Wed, 25 Mar 2026 11:22:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, Tianyu Lan <tiala@microsoft.com>,
	iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, vdso@hexbites.dev,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA
 transfers
Message-ID: <20260325092200.GQ814676@unreal>
References: <20260325075649.248241-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325075649.248241-1-tiala@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9752-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,samsung.com,arm.com,lists.linux.dev,vger.kernel.org,infradead.org,hexbites.dev,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 3FB10322161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:56:49AM -0400, Tianyu Lan wrote:
> Hyper-V provides Confidential VMBus to communicate between
> device model and device guest driver via encrypted/private
> memory in Confidential VM. The device model is in OpenHCL
> (https://openvmm.dev/guide/user_guide/openhcl.html) that
> plays the paravisor role.
> 
> For a VMBus device, there are two communication methods to
> talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> DMA transfer.
> 
> The Confidential VMBus Ring buffer has been upstreamed by
> Roman Kisel(commit 6802d8af47d1).
> 
> The dynamic DMA transition of VMBus device normally goes
> through DMA core and it uses SWIOTLB as bounce buffer in
> a CoCo VM.
> 
> The Confidential VMBus device can do DMA directly to
> private/encrypted memory. Because the swiotlb is decrypted
> memory, the DMA transfer must not be bounced through the
> swiotlb, so as to preserve confidentiality. This is different
> from the default for Linux CoCo VMs, so disable the VMBus
> device's use of swiotlb.
> 
> Expose swiotlb_dev_disable() from DMA Core to disable
> bounce buffer for device.

It feels awkward and like a layering violation to let arbitrary kernel
drivers manipulate SWIOTLB, which sits beneath the DMA core.

Thanks

> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c  | 6 +++++-
>  include/linux/swiotlb.h | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3d1a58b667db..84e6971fc90f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
>  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>  
> +	device_initialize(&child_device_obj->device);
> +	if (child_device_obj->channel->co_external_memory)
> +		swiotlb_dev_disable(&child_device_obj->device);
> +
>  	/*
>  	 * Register with the LDM. This will kick off the driver/device
>  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
>  	 */
> -	ret = device_register(&child_device_obj->device);
> +	ret = device_add(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
>  		put_device(&child_device_obj->device);
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..7c572570d5d9 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline bool swiotlb_dev_disable(struct device *dev)
> +{
> +	return dev->dma_io_tlb_mem == NULL;
> +}
> +
>  static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> -- 
> 2.50.1
> 
> 

