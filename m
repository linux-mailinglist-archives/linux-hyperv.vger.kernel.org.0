Return-Path: <linux-hyperv+bounces-2819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DD95C7EF
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 10:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D76281C48
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA814375C;
	Fri, 23 Aug 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="OEui8JWO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9D140397;
	Fri, 23 Aug 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401356; cv=none; b=bjZqmk3dp6HT3prq19ao6/0UGe/Y1y6k5u3uKQbzOFVHRyyVfxvbWWSTEyLmafTZqivtoh5CfitCTCb4zu60lPtK/F3YNTaZkXR62LOa5cu0goVXrHgAyat+EFHlNnSC0nnvuU+q0Y4QxonICO3+wdxeVS76QPhhSj+XZUbQd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401356; c=relaxed/simple;
	bh=SN03MvplYGLYS3Ez9HBdXBkwhl2F8dh3j3O/JVS9lds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onWbptSNHxtkn0P+/iawO+OchRIfm8NEpXM325kwXDBMCUTdTUMrpPvjvD5kDTpE6MflA28hN4Llqe2qXaumW9oBb0rla9VkNaF5AVCvnhr7nqqahBLVL4IyGPdNGQvySRhb4TWCg7egcrnt1gnZEYLNBcRdL86HQnMi0U6b3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=OEui8JWO; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 174A91EDDE4;
	Fri, 23 Aug 2024 10:22:32 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724401352; bh=QcbuVrnSLvYWlw/4wWxnpJHFEiLVUSrBLQYJUm8AiQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OEui8JWOUqmhI7bjHT/b2HCKNOcFPQxCUr641ZDqRi7RKL2PxGsSn5lU56hqpmDW9
	 G7f4RasFO1/aHLQpYZaAZ/zj9O48xNWcsBKLCZxN6BXSY7Lv+Cg9dKb6pHoW4oJaBD
	 yyJi/oMd84J+zIWPJY7I1ruJi9W0azntPTfrMDLJSc9CDu3m04hEIeiiOvEgIjuNFw
	 8JHkkbSx2Ss3E1mTliS0ZsR7uaCcF/lixNun7AdWbA1A0EQsw/3WEQoU6tPknplOUL
	 R2FFbTnNcxBEwM6ABXaznsLXSwURBvJVaUzBzVKh8cor9oqa9TbZUWqN75yWsyhwM5
	 Xe+b0P5jM99yQ==
Date: Fri, 23 Aug 2024 10:22:31 +0200
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
Subject: Re: [RFC 6/7] nvme: Move BLK_MQ_F_BLOCKING indicator to struct
 nvme_ctrl
Message-ID: <20240823102231.5def53f4@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-7-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-7-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 11:37:17 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> The NVMe setting that controls the BLK_MQ_F_BLOCKING flag on the
> request queue is currently a flag in struct nvme_ctrl_ops, where
> it is not writable. A new use case needs this flag to be writable
> based on a determination made during the NVMe device probe function.
> 
> Move this setting to struct nvme_ctrl, and update the only user to
> set it in the new location.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/nvme/host/core.c | 4 ++--
>  drivers/nvme/host/nvme.h | 2 +-
>  drivers/nvme/host/tcp.c  | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33fa01c599ad..f1ce325471f1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4495,7 +4495,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  		set->reserved_tags = 2;
>  	set->numa_node = ctrl->numa_node;
>  	set->flags = BLK_MQ_F_NO_SCHED;
> -	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +	if (ctrl->blocking)
>  		set->flags |= BLK_MQ_F_BLOCKING;
>  	set->cmd_size = cmd_size;
>  	set->driver_data = ctrl;
> @@ -4565,7 +4565,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  		set->reserved_tags = 1;
>  	set->numa_node = ctrl->numa_node;
>  	set->flags = BLK_MQ_F_SHOULD_MERGE;
> -	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +	if (ctrl->blocking)
>  		set->flags |= BLK_MQ_F_BLOCKING;
>  	set->cmd_size = cmd_size,
>  	set->driver_data = ctrl;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ae5314d32943..28709f166cab 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -338,6 +338,7 @@ struct nvme_ctrl {
>  	unsigned int shutdown_timeout;
>  	unsigned int kato;
>  	bool subsystem;
> +	bool blocking;
>  	unsigned long quirks;
>  	struct nvme_id_power_state psd[32];
>  	struct nvme_effects_log *effects;
> @@ -546,7 +547,6 @@ struct nvme_ctrl_ops {
>  	unsigned int flags;
>  #define NVME_F_FABRICS			(1 << 0)
>  #define NVME_F_METADATA_SUPPORTED	(1 << 1)
> -#define NVME_F_BLOCKING			(1 << 2)
>  
>  	const struct attribute_group **dev_attr_groups;
>  	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9ea6be0b0392..6b9fdf7dc1ac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2658,7 +2658,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
>  static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
>  	.name			= "tcp",
>  	.module			= THIS_MODULE,
> -	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
> +	.flags			= NVME_F_FABRICS,
>  	.reg_read32		= nvmf_reg_read32,
>  	.reg_read64		= nvmf_reg_read64,
>  	.reg_write32		= nvmf_reg_write32,
> @@ -2762,6 +2762,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>  	if (ret)
>  		goto out_kfree_queues;
>  
> +	ctrl->ctrl.blocking = true;
>  	return ctrl;
>  out_kfree_queues:
>  	kfree(ctrl->queues);


