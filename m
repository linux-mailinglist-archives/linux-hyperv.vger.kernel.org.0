Return-Path: <linux-hyperv+bounces-2880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D896B9609E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903DC28329C
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFCF1A0B10;
	Tue, 27 Aug 2024 12:19:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F91A08BC;
	Tue, 27 Aug 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761160; cv=none; b=Jvd69gsN/OtqLAZau6Imr0weTyJT4PVoYrNg9m6uKq8Z6S+HnNMerW0WAVcNlguwc48R/w7Seqm6NzAaqXdEq5yFqk++rRVmDeUuy1ixocoIu9VHZnhCW5tyPWJM5vJ2ahYD9b5wEDywrBcs2Dsy2dKYcpYQ4HdUNvcr+pZKa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761160; c=relaxed/simple;
	bh=PY/odrZ7HFMDFloiTo+2Oa6vUtHjnrzFME+/EnQwvEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPLJ1L3C7RjbXxvnrTUI3w+PQguu6WaWmK+n5wB5+Zg8MMN3xPdkelAx1at2sit9xTdjbBNycx9Gq9JLcB5UMNPzdJDM4i6CvIaNeENrk+m/6C+zgdOD5aMwVLNM969fjmm4uJ6VQtFcG+f62qq2eBw20mBXTBd01ehpPIKEP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0DCDA7;
	Tue, 27 Aug 2024 05:19:43 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185FF3F762;
	Tue, 27 Aug 2024 05:19:14 -0700 (PDT)
Message-ID: <92ebdc16-7938-462a-bb0e-4d5d368c5eb1@arm.com>
Date: Tue, 27 Aug 2024 13:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: check that busses support the DMA API before
 setting dma parameters
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240824034925.1163244-1-hch@lst.de>
 <20240824034925.1163244-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240824034925.1163244-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2024 4:49 am, Christoph Hellwig wrote:
> We'll start throwing warnings soon when dma_set_seg_boundary and
> dma_set_max_seg_size are called on devices for buses that don't fully
> support the DMA API.  Prepare for that by making the calls in the SCSI
> midlayer conditional.

Just thinking ahead, might it be worth a logical "are SG segment limits 
relevant?" wrapper around the dev->dma_parms reference? Not a big deal 
for now if we think this site is the only user, so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 3958a6d14bf457..7f0394c4492033 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1988,8 +1988,15 @@ void scsi_init_limits(struct Scsi_Host *shost, struct queue_limits *lim)
>   	if (shost->no_highmem)
>   		lim->features |= BLK_FEAT_BOUNCE_HIGH;
>   
> -	dma_set_seg_boundary(dev, shost->dma_boundary);
> -	dma_set_max_seg_size(dev, shost->max_segment_size);
> +	/*
> +	 * Propagate the DMA formation properties to the dma-mapping layer as
> +	 * a courtesy service to the LLDDs.  This needs to check that the buses
> +	 * actually support the DMA API first, though.
> +	 */
> +	if (dev->dma_parms) {
> +		dma_set_seg_boundary(dev, shost->dma_boundary);
> +		dma_set_max_seg_size(dev, shost->max_segment_size);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(scsi_init_limits);
>   

