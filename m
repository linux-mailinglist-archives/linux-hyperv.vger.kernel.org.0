Return-Path: <linux-hyperv+bounces-2817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46195C784
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 10:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9944287B06
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFE149C5A;
	Fri, 23 Aug 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ANKZx1em"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805E149C62;
	Fri, 23 Aug 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400538; cv=none; b=cco5NFoq/kZOkU4UhlH7B9GaOOSvtJ1PgBflnecsyPAtQfHu2ArKjysVyMfx7z0AshIDJFVL/+zzZmEfo8e/d49keD/2ayWJqvo/ravgw2ATdwoNqrS2vSTx2hG4T+nPBrwhBm/S0oFGT6FCFwomAgFf/+60/2MHmz2s/rKQbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400538; c=relaxed/simple;
	bh=8qbO4TvxcDkSJEXI7K+mXHRTyJP04PNgQbY90dWFpNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfMruUuxyR/IrNheLBwQH64tufR24NRip+7dUl1Lu46o8jjf3FricnzRwCahq8EST5PFjpWSKDDQiPHemVqsDLdhe24snAsHX0PNuxwEVHRYItRrdFgtGZ9/qzqR+n+9QbaJ4wJtlOtdm2RcLIgMz/xMzxJbWGA+T1ideSDLy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ANKZx1em; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id EB98F1F1F0E;
	Fri, 23 Aug 2024 10:08:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724400534; bh=O4JppdwbWGFP1nVYHk+FUidvoThmdHfNE8PVWBlwh/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANKZx1em/5Hq+8j2ti8Uu3/wZvJAcwNqvopisDqkkv0AfwfKI/eteuieZAqpAky0Y
	 fmrScluuWbIfY2O9que2bpi3QOuIYuK55RLkpQ0soLVsLIPlK+EGZzx7iUqXMbP+A+
	 Rx0yX9NKjrjcwroew40JHSjb6jhtE9tlEePOiIu1MYkeD5PV5/8jfe3KZ5sg2O+j6+
	 w7oacKUAjf2joF8DWR2CKq///aRssgU+blLd5urdTAzb7IoJCtDi9RSqC1WciFRFwt
	 KfMQxbW0xM/vurn0o+aY1rX2FFXPFmlUTpiqjVKV5/K6Ns4lo25l+xdDDe1Rce08QJ
	 Sl8wmIb2j5dnQ==
Date: Fri, 23 Aug 2024 10:08:53 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 4/7] scsi_lib_dma: Add _attrs variant of scsi_dma_map()
Message-ID: <20240823100853.6cab2245@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-5-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-5-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 11:37:15 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> Extend the SCSI DMA mapping interfaces by adding the "_attrs" variant
> of scsi_dma_map(). This variant allows passing DMA_ATTR_* values, such
> as is needed to support swiotlb throttling. The existing scsi_dma_map()
> interface is unchanged, so no incompatibilities are introduced.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/scsi/scsi_lib_dma.c | 13 +++++++------
>  include/scsi/scsi_cmnd.h    |  7 +++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib_dma.c b/drivers/scsi/scsi_lib_dma.c
> index 5723915275ad..34453a79be97 100644
> --- a/drivers/scsi/scsi_lib_dma.c
> +++ b/drivers/scsi/scsi_lib_dma.c
> @@ -14,30 +14,31 @@
>  #include <scsi/scsi_host.h>
>  
>  /**
> - * scsi_dma_map - perform DMA mapping against command's sg lists
> + * scsi_dma_map_attrs - perform DMA mapping against command's sg lists
>   * @cmd:	scsi command
> + * @attrs:	DMA attribute flags
>   *
>   * Returns the number of sg lists actually used, zero if the sg lists
>   * is NULL, or -ENOMEM if the mapping failed.
>   */
> -int scsi_dma_map(struct scsi_cmnd *cmd)
> +int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
>  {
>  	int nseg = 0;
>  
>  	if (scsi_sg_count(cmd)) {
>  		struct device *dev = cmd->device->host->dma_dev;
>  
> -		nseg = dma_map_sg(dev, scsi_sglist(cmd), scsi_sg_count(cmd),
> -				  cmd->sc_data_direction);
> +		nseg = dma_map_sg_attrs(dev, scsi_sglist(cmd),
> +			scsi_sg_count(cmd), cmd->sc_data_direction, attrs);
>  		if (unlikely(!nseg))
>  			return -ENOMEM;
>  	}
>  	return nseg;
>  }
> -EXPORT_SYMBOL(scsi_dma_map);
> +EXPORT_SYMBOL(scsi_dma_map_attrs);
>  
>  /**
> - * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map
> + * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map_attrs
>   * @cmd:	scsi command
>   */
>  void scsi_dma_unmap(struct scsi_cmnd *cmd)
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 45c40d200154..6603003bc588 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -170,11 +170,14 @@ extern void scsi_kunmap_atomic_sg(void *virt);
>  blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
>  void scsi_free_sgtables(struct scsi_cmnd *cmd);
>  
> +#define scsi_dma_map(cmd) scsi_dma_map_attrs(cmd, 0)
> +
>  #ifdef CONFIG_SCSI_DMA
> -extern int scsi_dma_map(struct scsi_cmnd *cmd);
> +extern int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs);
>  extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
>  #else /* !CONFIG_SCSI_DMA */
> -static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
> +static inline int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
> +						{ return -ENOSYS; }
>  static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
>  #endif /* !CONFIG_SCSI_DMA */
>  


