Return-Path: <linux-hyperv+bounces-8962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGFKMAMLnWmtMgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8962-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 03:20:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E5180F75
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 03:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8D433043007
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E804257844;
	Tue, 24 Feb 2026 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JCElgWyo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B21A9FBC;
	Tue, 24 Feb 2026 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899648; cv=none; b=XFiImEFVgJgCLeg8p8n9MetEowWzrmPyvYXoQV81B0oYXXfLLls//7L58HECDgIoAx+MnAPn6/T1P5fXOrEBuAFO12NZr8Vl1EHOln/T0V3YFKt/6XNdr/VF6mfJmNKgLHvk2LaI005/UyhA2mHH6Xr0bUwdv96GQsDR9RTeZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899648; c=relaxed/simple;
	bh=QVtETeMIvWxV8av+SuMZmWt+LvkclADDZxyCmEvf8lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t92EDEONSl+Cz6JSj76x1k0xK5W+yeBonB1dXxozo0NAOtICpbsYpob0EzNwROcZP2obpoU9osT7g4NgPcl5xU30k1kCvi4ZgnJQXz1AsKkydVlaF5ky9smxwoe3FI85bo5RPhAlydVjlnThU12toda1Nweoo1ofu7lIbHs+AEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JCElgWyo; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771899643; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dSMTnfW7xSjBWmL+Aw8k6L1FyIuFBWf32tPw0GOuVvM=;
	b=JCElgWyoaLdGdFU0su/YjWmI+LrjFL34DZY7/iBb5hMuqdHU2EW39E5wLRgaorz+C+I6f2NDlmerAVnk7TKGMTts9auKo59cWtFAZq4rUarKxsGRu+JD903Y4r6FcIKwQSDaghOQPIYpLzCgKGvkEQ4kVJwLnwaiIj7UE+igQcs=
Received: from 30.221.115.171(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WzhsATM_1771899640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 10:20:41 +0800
Message-ID: <b1070bb3-5963-2e2b-288c-ac5912b6c22e@linux.alibaba.com>
Date: Tue, 24 Feb 2026 10:20:39 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next 26/50] RDMA/erdma: Separate user and kernel CQ
 creation paths
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Michael Margolin <mrgolin@amazon.com>, Gal Pressman
 <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>,
 Kai Shen <kaishen@linux.alibaba.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Long Li <longli@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Bernard Metzler <bernard.metzler@linux.dev>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-26-f3be85847922@nvidia.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260213-refactor-umem-v1-26-f3be85847922@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8962-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 2B9E5180F75
X-Rspamd-Action: no action



On 2/13/26 6:58 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Split CQ creation into distinct kernel and user flows. The hns driver,
> inherited from mlx4, uses a problematic pattern that shares and caches
> umem in hns_roce_db_map_user(). This design blocks the driver from
> supporting generic umem sources (VMA, dmabuf, memfd, and others).
> 
> In addition, let's delete counter that counts CQ creation errors. There
> are multiple ways to debug kernel in modern kernel without need to rely
> on that debugfs counter.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cq.c      | 103 ++++++++++++++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_debugfs.c |   1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h  |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c    |   1 +
>  4 files changed, 82 insertions(+), 26 deletions(-)
> 

Hi Leon,

The driver name in this patch's title should be "RDMA/hns".

Thanks,
Cheng Xu

> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
> index 857a913326cd..0f24a916466b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
> @@ -335,7 +335,10 @@ static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
>  {
>  	struct ib_device *ibdev = &hr_dev->ib_dev;
>  
> -	if (!attr->cqe || attr->cqe > hr_dev->caps.max_cqes) {
> +	if (attr->flags)
> +		return -EOPNOTSUPP;
> +
> +	if (attr->cqe > hr_dev->caps.max_cqes) {
>  		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
>  			  attr->cqe, hr_dev->caps.max_cqes);
>  		return -EINVAL;
> @@ -407,8 +410,8 @@ static int set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
>  	return 0;
>  }
>  
> -int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
> -		       struct uverbs_attr_bundle *attrs)
> +int hns_roce_create_user_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
> +			    struct uverbs_attr_bundle *attrs)
>  {
>  	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
>  	struct ib_udata *udata = &attrs->driver_udata;
> @@ -418,31 +421,27 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  	struct hns_roce_ib_create_cq ucmd = {};
>  	int ret;
>  
> -	if (attr->flags) {
> -		ret = -EOPNOTSUPP;
> -		goto err_out;
> -	}
> +	if (ib_cq->umem)
> +		return -EOPNOTSUPP;
>  
>  	ret = verify_cq_create_attr(hr_dev, attr);
>  	if (ret)
> -		goto err_out;
> +		return ret;
>  
> -	if (udata) {
> -		ret = get_cq_ucmd(hr_cq, udata, &ucmd);
> -		if (ret)
> -			goto err_out;
> -	}
> +	ret = get_cq_ucmd(hr_cq, udata, &ucmd);
> +	if (ret)
> +		return ret;
>  
>  	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
>  
>  	ret = set_cqe_size(hr_cq, udata, &ucmd);
>  	if (ret)
> -		goto err_out;
> +		return ret;
>  
>  	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
>  	if (ret) {
>  		ibdev_err(ibdev, "failed to alloc CQ buf, ret = %d.\n", ret);
> -		goto err_out;
> +		return ret;
>  	}
>  
>  	ret = alloc_cq_db(hr_dev, hr_cq, udata, ucmd.db_addr, &resp);
> @@ -464,13 +463,11 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  		goto err_cqn;
>  	}
>  
> -	if (udata) {
> -		resp.cqn = hr_cq->cqn;
> -		ret = ib_copy_to_udata(udata, &resp,
> -				       min(udata->outlen, sizeof(resp)));
> -		if (ret)
> -			goto err_cqc;
> -	}
> +	resp.cqn = hr_cq->cqn;
> +	ret = ib_copy_to_udata(udata, &resp,
> +			       min(udata->outlen, sizeof(resp)));
> +	if (ret)
> +		goto err_cqc;
>  
>  	hr_cq->cons_index = 0;
>  	hr_cq->arm_sn = 1;
> @@ -487,9 +484,67 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  	free_cq_db(hr_dev, hr_cq, udata);
>  err_cq_buf:
>  	free_cq_buf(hr_dev, hr_cq);
> -err_out:
> -	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT]);
> +	return ret;
> +}
> +
> +int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
> +		       struct uverbs_attr_bundle *attrs)
> +{
> +	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
> +	struct hns_roce_ib_create_cq_resp resp = {};
> +	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct hns_roce_ib_create_cq ucmd = {};
> +	int ret;
> +
> +	ret = verify_cq_create_attr(hr_dev, attr);
> +	if (ret)
> +		return ret;
> +
> +	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
> +
> +	ret = set_cqe_size(hr_cq, NULL, &ucmd);
> +	if (ret)
> +		return ret;
>  
> +	ret = alloc_cq_buf(hr_dev, hr_cq, NULL, 0);
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to alloc CQ buf, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = alloc_cq_db(hr_dev, hr_cq, NULL, 0, &resp);
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to alloc CQ db, ret = %d.\n", ret);
> +		goto err_cq_buf;
> +	}
> +
> +	ret = alloc_cqn(hr_dev, hr_cq, NULL);
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to alloc CQN, ret = %d.\n", ret);
> +		goto err_cq_db;
> +	}
> +
> +	ret = alloc_cqc(hr_dev, hr_cq);
> +	if (ret) {
> +		ibdev_err(ibdev,
> +			  "failed to alloc CQ context, ret = %d.\n", ret);
> +		goto err_cqn;
> +	}
> +
> +	hr_cq->cons_index = 0;
> +	hr_cq->arm_sn = 1;
> +	refcount_set(&hr_cq->refcount, 1);
> +	init_completion(&hr_cq->free);
> +
> +	return 0;
> +
> +err_cqn:
> +	free_cqn(hr_dev, hr_cq->cqn);
> +err_cq_db:
> +	free_cq_db(hr_dev, hr_cq, NULL);
> +err_cq_buf:
> +	free_cq_buf(hr_dev, hr_cq);
>  	return ret;
>  }
>  
> diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> index b869cdc54118..481b30f2f5b5 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
> @@ -47,7 +47,6 @@ static const char * const sw_stat_info[] = {
>  	[HNS_ROCE_DFX_MBX_EVENT_CNT] = "mbx_event",
>  	[HNS_ROCE_DFX_QP_CREATE_ERR_CNT] = "qp_create_err",
>  	[HNS_ROCE_DFX_QP_MODIFY_ERR_CNT] = "qp_modify_err",
> -	[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT] = "cq_create_err",
>  	[HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT] = "cq_modify_err",
>  	[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT] = "srq_create_err",
>  	[HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT] = "srq_modify_err",
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 3f032b8038af..fdc5f487d7a3 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -902,7 +902,6 @@ enum hns_roce_sw_dfx_stat_index {
>  	HNS_ROCE_DFX_MBX_EVENT_CNT,
>  	HNS_ROCE_DFX_QP_CREATE_ERR_CNT,
>  	HNS_ROCE_DFX_QP_MODIFY_ERR_CNT,
> -	HNS_ROCE_DFX_CQ_CREATE_ERR_CNT,
>  	HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT,
>  	HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT,
>  	HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT,
> @@ -1295,6 +1294,8 @@ int to_hr_qp_type(int qp_type);
>  
>  int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  		       struct uverbs_attr_bundle *attrs);
> +int hns_roce_create_user_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
> +			    struct uverbs_attr_bundle *attrs);
>  
>  int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
>  int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index a3490bab297a..64de49bf8df7 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -727,6 +727,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
>  	.create_ah = hns_roce_create_ah,
>  	.create_user_ah = hns_roce_create_ah,
>  	.create_cq = hns_roce_create_cq,
> +	.create_user_cq = hns_roce_create_user_cq,
>  	.create_qp = hns_roce_create_qp,
>  	.dealloc_pd = hns_roce_dealloc_pd,
>  	.dealloc_ucontext = hns_roce_dealloc_ucontext,
> 

