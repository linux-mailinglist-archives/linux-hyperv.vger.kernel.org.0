Return-Path: <linux-hyperv+bounces-9827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ytMEG3MUyWl9uQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9827-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Mar 2026 14:00:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18A351DEC
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Mar 2026 14:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0B83007C97
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Mar 2026 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E83128CA;
	Sun, 29 Mar 2026 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WWP5zca0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAD1397
	for <linux-hyperv@vger.kernel.org>; Sun, 29 Mar 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774785566; cv=none; b=MMyVd9sBxBZ2wdSIslap3eVoQn8vTNKywOhNagixiYNhGTwtSmay/S6qZkQLwNFWnQmTZW2KXOQetLjPhqlOs0352CgChJnHwQxFRTORsKFVAmlQqZQR7c2dSPmIpqvufFMx7mn+Xr1W9uqCkGdLOJb3wmFt2m5Kb4Qza73Dzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774785566; c=relaxed/simple;
	bh=LfI9pgmBY79Np+lQOxCYoOL1BkzxSFHfIk9gb4Agm8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBjQVskOH3P8hwb/jM2EK66Mn0aUXMozhJBdfwHv/XoC6fkZojPdSORwTaKOO9CG4zOfPTm85crPLQI7WP+gQRJhe4FaYBrF2z/xyxZnqt4JH6EzqvQkzGZVxzK6Kw99YsXoa3vsCY7SsBLprkl3KasWlaQa3uWWQ0wskKAP6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WWP5zca0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ea45648-453b-4578-9b75-c9b4bf70cf6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774785562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/TRxauqrb8y/s8bKO+jkfvWBOuO4JDFCPKCpLe1NBA=;
	b=WWP5zca0AQV46LJn6/JgCu+x8PTq1a5zjva/cCWfQoV6VM0OMfa/9B3P9MG1liDYADfE1q
	NfgMSMhJltCFQBq5mrIaTKIxjvsr+x5vwymsxF3gMrlqgdiVyolj6lzlgLGuVfG+9d6IY+
	73SSwuWr6Btwhfvb+gmnIdCIZTkaYiA=
Date: Sun, 29 Mar 2026 13:59:15 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/16] RDMA: Consolidate patterns with sizeof() to
 ib_copy_validate_udata_in()
To: Jason Gunthorpe <jgg@nvidia.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Cheng Xu
 <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Kai Shen <kaishen@linux.alibaba.com>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
 Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, Michal Kalderon <mkalderon@marvell.com>,
 Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>,
 Satish Kharat <satishkh@cisco.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Yossi Leybovich <sleybo@amazon.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Long Li <longli@microsoft.com>, patches@lists.linux.dev
References: <3-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <3-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[nvidia.com,amd.com,broadcom.com,linux.alibaba.com,linux.dev,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9827-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 9F18A351DEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25.03.2026 22:26, Jason Gunthorpe wrote:
> Similar to the prior patch, these patterns are open coding an
> offsetofend() using sizeof(), which targets the last member of the
> current struct.
> 
> Reviewed-by: Long Li <longli@microsoft.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/hw/mana/qp.c       | 27 +++++++++------------------
>   drivers/infiniband/hw/mana/wq.c       | 10 ++--------
>   drivers/infiniband/hw/mlx4/main.c     |  6 ++----
>   drivers/infiniband/hw/mlx5/cq.c       |  2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++-----------
>   drivers/infiniband/sw/siw/siw_verbs.c |  6 +-----
>   6 files changed, 17 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 82f84f7ad37a90..69c8d4f7a1f46b 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -111,16 +111,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>   	u32 port;
>   	int ret;
>   
> -	if (!udata || udata->inlen < sizeof(ucmd))
> +	if (!udata)
>   		return -EINVAL;
>   
> -	ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> -	if (ret) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed copy from udata for create rss-qp, err %d\n",
> -			  ret);
> +	ret = ib_copy_validate_udata_in(udata, ucmd, port);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	if (attr->cap.max_recv_wr > mdev->adapter_caps.max_qp_wr) {
>   		ibdev_dbg(&mdev->ib_dev,
> @@ -282,15 +278,12 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>   	u32 port;
>   	int err;
>   
> -	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
> +	if (!mana_ucontext)
>   		return -EINVAL;
>   
> -	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed to copy from udata create qp-raw, %d\n", err);
> +	err = ib_copy_validate_udata_in(udata, ucmd, port);
> +	if (err)
>   		return err;
> -	}
>   
>   	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
>   		ibdev_dbg(&mdev->ib_dev,
> @@ -535,17 +528,15 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
>   	u64 flags = 0;
>   	u32 doorbell;
>   
> -	if (!udata || udata->inlen < sizeof(ucmd))
> +	if (!udata)
>   		return -EINVAL;
>   
>   	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
>   	doorbell = mana_ucontext->doorbell;
>   	flags = MANA_RC_FLAG_NO_FMR;
> -	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n", err);
> +	err = ib_copy_validate_udata_in(udata, ucmd, queue_size);
> +	if (err)
>   		return err;
> -	}
>   
>   	for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
>   		/* skip FMR for user-level RC QPs */
> diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
> index 6206244f762e42..aceeea7f17b339 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -15,15 +15,9 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>   	struct mana_ib_wq *wq;
>   	int err;
>   
> -	if (udata->inlen < sizeof(ucmd))
> -		return ERR_PTR(-EINVAL);
> -
> -	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed to copy from udata for create wq, %d\n", err);
> +	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
> +	if (err)
>   		return ERR_PTR(err);
> -	}
>   
>   	wq = kzalloc_obj(*wq);
>   	if (!wq)
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index 73e17b4339eb60..16e4cffbd7a84d 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -50,6 +50,7 @@
>   #include <rdma/ib_user_verbs.h>
>   #include <rdma/ib_addr.h>
>   #include <rdma/ib_cache.h>
> +#include <rdma/uverbs_ioctl.h>
>   
>   #include <net/bonding.h>
>   
> @@ -445,10 +446,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
>   	struct mlx4_clock_params clock_params;
>   
>   	if (uhw->inlen) {
> -		if (uhw->inlen < sizeof(cmd))
> -			return -EINVAL;
> -
> -		err = ib_copy_from_udata(&cmd, uhw, sizeof(cmd));
> +		err = ib_copy_validate_udata_in(uhw, cmd, reserved);
>   		if (err)
>   			return err;
>   
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index 643b3b7d387834..f5e75e51c6763f 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -1229,7 +1229,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
>   	struct ib_umem *umem;
>   	int err;
>   
> -	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
> +	err = ib_copy_validate_udata_in(udata, ucmd, reserved1);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index fe41362c51444c..c9fd40bfa09eb2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -452,18 +452,9 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
>   	int err;
>   
>   	if (udata) {
> -		if (udata->inlen < sizeof(cmd)) {
> -			err = -EINVAL;
> -			rxe_dbg_srq(srq, "malformed udata\n");
> +		err = ib_copy_validate_udata_in(udata, cmd, mmap_info_addr);
> +		if (err)
>   			goto err_out;
> -		}
> -
> -		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
> -		if (err) {
> -			err = -EFAULT;
> -			rxe_dbg_srq(srq, "unable to read udata\n");
> -			goto err_out;
> -		}
>   	}
>   
>   	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index ef504db8f2b48b..1e1d262a4ae2db 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -1373,11 +1373,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>   		struct siw_uresp_reg_mr uresp = {};
>   		struct siw_mem *mem = mr->mem;
>   
> -		if (udata->inlen < sizeof(ureq)) {
> -			rv = -EINVAL;
> -			goto err_out;
> -		}
> -		rv = ib_copy_from_udata(&ureq, udata, sizeof(ureq));
> +		rv = ib_copy_validate_udata_in(udata, ureq, pad);
>   		if (rv)
>   			goto err_out;
>   
Looks good for siw driver. Thank you.

Reviewed-by: Bernard Metzler <bernard.metzler@linux.dev>

