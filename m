Return-Path: <linux-hyperv+bounces-2820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D095C808
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5761F22F11
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF79143C6C;
	Fri, 23 Aug 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="XC9qMPOO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4047142E9D;
	Fri, 23 Aug 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401606; cv=none; b=ExdnjF/ctOb3YWfHbstWCISuF2/dpY2shUVSlDbzkijY945txTfOJVtek+QygrpAYhrxDMLRm9V12OLCfMVVCrUi/QWJ7UutaK7CBZIDjk3Ia4oQ4JPqbN8VYxUu1fxreTaQmoOV6pj6sI+swYBMT26cupWlCQDPE9qKboBvyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401606; c=relaxed/simple;
	bh=7T7/wu2fTf7TBVQfzGOrguX+PSXn0cZDoDAeHENBD68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyGYWYYAhb5mwzviBXHklz44Ii9C7to3DY1GtmiskYoQxDyE1FE/egnN5eB878SGbrx/KIF9X4xSSrpIVv3o4MgJL8iYWP2KR1ynpTCk+xcpubqVKDFd2bbN70UCl0OZ4XHLxummS03YbStQr5zXYNG3OVDFmC3quGQ2iJ0DRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=XC9qMPOO; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id DE4CB1EFCD7;
	Fri, 23 Aug 2024 10:26:42 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724401603; bh=Cb6PqhKpP7ar8ly8cR261dRzbAdFkd8uMnNKWb2a72o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XC9qMPOORHKhGxtuEqYZWhvcUQLSNDTTWFjMy7+rqMjBR9aYZGjGlBG+CmW7OwuBd
	 79L2I6aLuc6yr04anJqToCOvN8WGrTn4Qj3hDxFjqcIPA19NIw9Qv5BX9fA94+0GLp
	 l0KLIqCBvO5HvmmGNdpFXIx5W/2SAWYzfdlkVsvrgKK7684mvl3vazypXIiu4q3eT6
	 ly51l/+pDVIJAnQLo31UocvED2gBi2BKjLawYJsX20XKZjre3ZP5ZDr36H+cLhz3Cq
	 FS9QfPScXdp/I8kJkYGIub0pHKSC4fz0ZnE8ceUv/MIW5c8GKhp+GCt7HxqKo4RFyf
	 E3DQF8XeboGVQ==
Date: Fri, 23 Aug 2024 10:26:42 +0200
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
Subject: Re: [RFC 7/7] nvme: Enable swiotlb throttling for NVMe PCI devices
Message-ID: <20240823102642.3f7f893a@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-8-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-8-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 11:37:18 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
> because DMA cannot be done to private (encrypted) portions of VM
> memory. The bounce buffer memory is marked shared (decrypted) at
> boot time, so I/O is done to/from the bounce buffer memory and then
> copied by the CPU to/from the final target memory (i.e, "bounced").
> Storage devices can be large consumers of bounce buffer memory because
> it is possible to have large numbers of I/Os in flight across multiple
> devices. Bounce buffer memory must be pre-allocated at boot time, and
> it is difficult to know how much memory to allocate to handle peak
> storage I/O loads. Consequently, bounce buffer memory is typically
> over-provisioned, which wastes memory, and may still not avoid a peak
> that exhausts bounce buffer memory and cause storage I/O errors.
> 
> For Coco VMs running with NVMe PCI devices, update the driver to
> permit bounce buffer throttling. Gate the throttling behavior
> on a DMA layer check indicating that throttling is useful, so that
> no change occurs in a non-CoCo VM. If throttling is useful, enable
> the BLK_MQ_F_BLOCKING flag, and pass the DMA_ATTR_MAY_BLOCK attribute
> into dma_map_bvec() and dma_map_sgtable() calls. With these options in
> place, DMA map requests are pended when necessary to reduce the
> likelihood of usage peaks caused by the NVMe driver that could exhaust
> bounce buffer memory and generate errors.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/nvme/host/pci.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6cd9395ba9ec..2c39943a87f8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -156,6 +156,7 @@ struct nvme_dev {
>  	dma_addr_t host_mem_descs_dma;
>  	struct nvme_host_mem_buf_desc *host_mem_descs;
>  	void **host_mem_desc_bufs;
> +	unsigned long dma_attrs;
>  	unsigned int nr_allocated_queues;
>  	unsigned int nr_write_queues;
>  	unsigned int nr_poll_queues;
> @@ -735,7 +736,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
>  	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
>  	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
>  
> -	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
> +	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
> +					dev->dma_attrs);
>  	if (dma_mapping_error(dev->dev, iod->first_dma))
>  		return BLK_STS_RESOURCE;
>  	iod->dma_len = bv->bv_len;
> @@ -754,7 +756,8 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
> -	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
> +	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
> +					dev->dma_attrs);
>  	if (dma_mapping_error(dev->dev, iod->first_dma))
>  		return BLK_STS_RESOURCE;
>  	iod->dma_len = bv->bv_len;
> @@ -800,7 +803,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  
>  	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
> -			     DMA_ATTR_NO_WARN);
> +			     dev->dma_attrs | DMA_ATTR_NO_WARN);
>  	if (rc) {
>  		if (rc == -EREMOTEIO)
>  			ret = BLK_STS_TARGET;
> @@ -828,7 +831,8 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct bio_vec bv = rq_integrity_vec(req);
>  
> -	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
> +	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req),
> +					dev->dma_attrs);
>  	if (dma_mapping_error(dev->dev, iod->meta_dma))
>  		return BLK_STS_IOERR;
>  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> @@ -3040,6 +3044,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 * a single integrity segment for the separate metadata pointer.
>  	 */
>  	dev->ctrl.max_integrity_segments = 1;
> +
> +	if (dma_recommend_may_block(dev->dev)) {
> +		dev->ctrl.blocking = true;
> +		dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
> +	}
> +
>  	return dev;
>  
>  out_put_device:


