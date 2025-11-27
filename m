Return-Path: <linux-hyperv+bounces-7863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300FC8CDEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 06:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9F23AD9FB
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 05:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E91EA7CC;
	Thu, 27 Nov 2025 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hexbites.dev header.i=@hexbites.dev header.b="IMHFGSuL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832C8F4A;
	Thu, 27 Nov 2025 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221210; cv=none; b=rJzQpLQH6YdTwggfx/RME1HwgPMsj8Jq2wTTR1ww1k3HQBlCmfnlBp8evVDWcSYTAkkm2myUN7wgXGXTkoD6IsPw/l3c0rg3f+VgTh6yrGrmfU/hrPR+4oy0gLCER8AxwaMFq/VvOzKUavashzu9TA3PT+mID/eUz0ThX4yGnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221210; c=relaxed/simple;
	bh=/GER6qx6PTvc64ZKpqAzaD29rdaOtTO+szsW/UovgRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9EVwktkUQRni5qCKoV0NSmlgrdNIVuGewo2heLv6ncPd5BvpFAoY7s3OmalgDIpA/IUAzqsKiAFcW3FEm8GISYeXDABrxVevGPmhV1TSy0hdR504XiEwMFJ9k19nuRBC/iA3SeZ0oBve0DN/FMa9bgZRNGJx63txS/OBa5QtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexbites.dev; spf=pass smtp.mailfrom=hexbites.dev; dkim=pass (2048-bit key) header.d=hexbites.dev header.i=@hexbites.dev header.b=IMHFGSuL; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexbites.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexbites.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4dH4RM61x7z9ypV;
	Thu, 27 Nov 2025 06:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hexbites.dev;
	s=MBO0001; t=1764220607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3crp1oAMGcLM/mqJd/tUs0ah6/JZWuP7G4VEK1d0n4=;
	b=IMHFGSuLUkl4sELUttdcrtjPwzri5P67OEO0RCwD658lvRzQISogpAuKVun7ZFRTWcXMS/
	A1QqCGLd15I8RsivqqODa0JXFtGYHUN3NnSfxWvvg0nvhqVnBbj5KsDvPKq5suq+qsvlHf
	Gjwrucn+XhhvyIWNJr4/h0675tIBGgerSQuYxN6I526x1JZCu8JtYAMWpuPARC0nID4Giz
	MoNmmbwJ2OWcVG7AT75Z0j8fWguQ5VFBRMNg2fBi8WqkaCy+R+5wRYe3m/oo01YYqSrvQv
	u8yqb3+QNAggCnSmbRVRKjlDedI4PoOtGgYd5x053XX/7LzpLzoxzJ3D+9qI2g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of vdso@hexbites.dev designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=vdso@hexbites.dev
From: vdso@hexbites.dev
To: ltykernel@gmail.com
Cc: decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	tiala@microsoft.com,
	vdso@hexbites.dev,
	wei.liu@kernel.org
Subject: Re: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory support
Date: Wed, 26 Nov 2025 21:15:59 -0800
Message-ID: <20251127051559.60238-1-vdso@hexbites.dev>
In-Reply-To: <20251124182920.9365-1-tiala@microsoft.com>
References: <20251124182920.9365-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4dH4RM61x7z9ypV

From: Roman Kisel <vdso@hexbites.dev>

Tianyu Lan wrote:

> In CVM(Confidential VM), system memory is encrypted
> by default. Device drivers typically use the swiotlb
> bounce buffer for DMA memory, which is decrypted
> and shared between the guest and host. Confidential
> Vmbus, however, supports a confidential channel
> that employs encrypted memory for the Vmbus ring
> buffer and external DMA memory. The support for
> the confidential ring buffer has already been
> integrated.
>
> In CVM, device drivers usually employ the standard
> DMA API to map DMA memory with the bounce buffer,
> which remains transparent to the device driver.
> For external DMA memory support, Hyper-V specific
> DMA operations are introduced, bypassing the bounce
> buffer when the confidential external memory flag
> is set. These DMA operations might also be reused
> for TDISP devices in the future, which also support
> DMA operations with encrypted memory.
>
> The DMA operations used are global architecture
> DMA operations (for details, see get_arch_dma_ops()
> and get_dma_ops()), and there is no need to set up
> for each device individually.
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Tinayu,

Looks great to me!

Reviewed-by: Roman Kisel <vdso@hexbites.dev>

P.S. For the inclined reader, here is how the old, only for
storage and not satisfactory in other ways my attempt to solve this:

https://lore.kernel.org/linux-hyperv/20250409000835.285105-6-romank@linux.microsoft.com/
https://lore.kernel.org/linux-hyperv/20250409000835.285105-7-romank@linux.microsoft.com/

Maybe it'd be a good idea to CC folks who provided feedback back then.

> ---
>  drivers/hv/vmbus_drv.c | 90 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0dc4692b411a..ca31231b2c32 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -39,6 +39,9 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> +#include "../../kernel/dma/direct.h"
> +
> +extern const struct dma_map_ops *dma_ops;
>
>  struct vmbus_dynid {
>  	struct list_head node;
> @@ -1429,6 +1432,88 @@ static int vmbus_alloc_synic_and_connect(void)
>  	return -ENOMEM;
>  }
>
> +
> +static bool hyperv_private_memory_dma(struct device *dev)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +
> +	if (hv_dev && hv_dev->channel && hv_dev->channel->co_external_memory)
> +		return true;
> +	else
> +		return false;
> +}
> +
> +static dma_addr_t hyperv_dma_map_page(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size,
> +		enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +
> +	if (hyperv_private_memory_dma(dev))
> +		return __phys_to_dma(dev, phys);
> +	else
> +		return dma_direct_map_phys(dev, phys, size, dir, attrs);
> +}
> +
> +static void hyperv_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!hyperv_private_memory_dma(dev))
> +		dma_direct_unmap_phys(dev, dma_handle, size, dir, attrs);
> +}
> +
> +static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *sgl,
> +		int nelems, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	dma_addr_t dma_addr;
> +	int i;
> +
> +	if (hyperv_private_memory_dma(dev)) {
> +		for_each_sg(sgl, sg, nelems, i) {
> +			dma_addr = __phys_to_dma(dev, sg_phys(sg));
> +			sg_dma_address(sg) = dma_addr;
> +			sg_dma_len(sg) = sg->length;
> +		}
> +
> +		return nelems;
> +	} else {
> +		return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
> +	}
> +}
> +
> +static void hyperv_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nelems, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!hyperv_private_memory_dma(dev))
> +		dma_direct_unmap_sg(dev, sgl, nelems, dir, attrs);
> +}
> +
> +static int hyperv_dma_supported(struct device *dev, u64 mask)
> +{
> +	dev->coherent_dma_mask = mask;
> +	return 1;
> +}
> +
> +static size_t hyperv_dma_max_mapping_size(struct device *dev)
> +{
> +	if (hyperv_private_memory_dma(dev))
> +		return SIZE_MAX;
> +	else
> +		return swiotlb_max_mapping_size(dev);
> +}
> +
> +const struct dma_map_ops hyperv_dma_ops = {
> +	.map_page               = hyperv_dma_map_page,
> +	.unmap_page             = hyperv_dma_unmap_page,
> +	.map_sg                 = hyperv_dma_map_sg,
> +	.unmap_sg               = hyperv_dma_unmap_sg,
> +	.dma_supported          = hyperv_dma_supported,
> +	.max_mapping_size	= hyperv_dma_max_mapping_size,
> +};
> +
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1479,8 +1564,11 @@ static int vmbus_bus_init(void)
>  	 * doing that on each VP while initializing SynIC's wastes time.
>  	 */
>  	is_confidential = ms_hyperv.confidential_vmbus_available;
> -	if (is_confidential)
> +	if (is_confidential) {
> +		dma_ops = &hyperv_dma_ops;
>  		pr_info("Establishing connection to the confidential VMBus\n");
> +	}
> +
>  	hv_para_set_sint_proxy(!is_confidential);
>  	ret = vmbus_alloc_synic_and_connect();
>  	if (ret)
> --
> 2.50.1

