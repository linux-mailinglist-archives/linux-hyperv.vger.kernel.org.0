Return-Path: <linux-hyperv+bounces-8849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M0AK/tXj2lqQQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8849-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 17:57:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAA1386E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF4F3004C4F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485B27EFEE;
	Fri, 13 Feb 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iwjF+FKe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E76330D54
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Feb 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001808; cv=none; b=dNLVAcw+BdfA2Zk2GS3Oj0/ojbKovjhRJwXRsLVCpXQ+/YBaVcVguaTmOZWPf3O1SzJtnmclHTrxX4uHCTpQS2/hVbeKUd1lQc/muuQqyzJpU+pXF3z36RN8w7txq69Qcb6YV3K6CBLBLMObKE5sbhx0UTJM1SqyjNPZsom7Dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001808; c=relaxed/simple;
	bh=m947ln53rLc1KgoJScIrYHCASXl0o+bjAqXvE84dElk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPzrNuAjhG0/XvTMbtvjXI370sJ8GzW1o0ZleGm9hmL/w0cr1CUWkw2e08UBZLwrG4kq7hDoR9O915PIyA2HmZl0S2hdoX+28cgElVxAeKQKKo6SVt1OJHKRrMSzkKQM0QwEio/7mBE8WnYdSbXxFhuvJn1Ta/80F2xgJ+Duqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iwjF+FKe; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <054452b7-7e08-4f8c-8010-e1b69c4b3997@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771001804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsPIT/BXG9iCmRmU1sk4/Ec6DvS5Pp9bH0ifVOzoGWk=;
	b=iwjF+FKeXEruV7CEL1G/jo7s+zGnQxf6ESHxDbczNIw9uFV62elb95DO9oZ9J5mUCoUrUM
	1n/7pL6Z+TH4xAfAff32oLfsJbsmDhvbBUrev9Z6/6p4V5EGNcjPiETcxw+05cm5U/BTgd
	vCg+KZte0YWui5nHD3ty3AAJ2VvnawQ=
Date: Fri, 13 Feb 2026 17:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 28/50] RDMA/siw: Split user and kernel CQ
 creation paths
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Michael Margolin <mrgolin@amazon.com>, Gal Pressman
 <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>,
 Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>,
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
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-28-f3be85847922@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260213-refactor-umem-v1-28-f3be85847922@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8849-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32CAA1386E5
X-Rspamd-Action: no action

On 13.02.2026 11:58, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Separate the CQ creation logic into distinct kernel and user flows.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/sw/siw/siw_main.c  |   1 +
>   drivers/infiniband/sw/siw/siw_verbs.c | 111 +++++++++++++++++++++++-----------
>   drivers/infiniband/sw/siw/siw_verbs.h |   2 +
>   3 files changed, 80 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 5168307229a9..75dcf3578eac 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -232,6 +232,7 @@ static const struct ib_device_ops siw_device_ops = {
>   	.alloc_pd = siw_alloc_pd,
>   	.alloc_ucontext = siw_alloc_ucontext,
>   	.create_cq = siw_create_cq,
> +	.create_user_cq = siw_create_user_cq,
>   	.create_qp = siw_create_qp,
>   	.create_srq = siw_create_srq,
>   	.dealloc_driver = siw_device_cleanup,
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index efa2f097b582..92b25b389b69 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -1139,15 +1139,15 @@ int siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
>    * @attrs: uverbs bundle
>    */
>   
> -int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
> -		  struct uverbs_attr_bundle *attrs)
> +int siw_create_user_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
> +		       struct uverbs_attr_bundle *attrs)
>   {
>   	struct ib_udata *udata = &attrs->driver_udata;
>   	struct siw_device *sdev = to_siw_dev(base_cq->device);
>   	struct siw_cq *cq = to_siw_cq(base_cq);
>   	int rv, size = attr->cqe;
>   
> -	if (attr->flags)
> +	if (attr->flags || base_cq->umem)
>   		return -EOPNOTSUPP;
>   
>   	if (atomic_inc_return(&sdev->num_cq) > SIW_MAX_CQ) {
> @@ -1155,7 +1155,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>   		rv = -ENOMEM;
>   		goto err_out;
>   	}
> -	if (size < 1 || size > sdev->attrs.max_cqe) {
> +	if (attr->cqe > sdev->attrs.max_cqe) {
>   		siw_dbg(base_cq->device, "CQ size error: %d\n", size);
>   		rv = -EINVAL;
>   		goto err_out;
> @@ -1164,13 +1164,8 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>   	cq->base_cq.cqe = size;
>   	cq->num_cqe = size;
>   
> -	if (udata)
> -		cq->queue = vmalloc_user(size * sizeof(struct siw_cqe) +
> -					 sizeof(struct siw_cq_ctrl));
> -	else
> -		cq->queue = vzalloc(size * sizeof(struct siw_cqe) +
> -				    sizeof(struct siw_cq_ctrl));
> -
> +	cq->queue = vmalloc_user(size * sizeof(struct siw_cqe) +
> +				 sizeof(struct siw_cq_ctrl));
>   	if (cq->queue == NULL) {
>   		rv = -ENOMEM;
>   		goto err_out;
> @@ -1182,33 +1177,32 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>   
>   	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
>   
> -	if (udata) {
> -		struct siw_uresp_create_cq uresp = {};
> -		struct siw_ucontext *ctx =
> -			rdma_udata_to_drv_context(udata, struct siw_ucontext,
> -						  base_ucontext);
> -		size_t length = size * sizeof(struct siw_cqe) +
> -			sizeof(struct siw_cq_ctrl);
> +	struct siw_uresp_create_cq uresp = {};
> +	struct siw_ucontext *ctx =
> +		rdma_udata_to_drv_context(udata, struct siw_ucontext,
> +					  base_ucontext);
> +	size_t length = size * sizeof(struct siw_cqe) +
> +		sizeof(struct siw_cq_ctrl);
>   
> -		cq->cq_entry =
> -			siw_mmap_entry_insert(ctx, cq->queue,
> -					      length, &uresp.cq_key);
> -		if (!cq->cq_entry) {
> -			rv = -ENOMEM;
> -			goto err_out;
> -		}
> +	cq->cq_entry =
> +		siw_mmap_entry_insert(ctx, cq->queue,
> +				      length, &uresp.cq_key);
> +	if (!cq->cq_entry) {
> +		rv = -ENOMEM;
> +		goto err_out;
> +	}
>   
> -		uresp.cq_id = cq->id;
> -		uresp.num_cqe = size;
> +	uresp.cq_id = cq->id;
> +	uresp.num_cqe = size;
>   
> -		if (udata->outlen < sizeof(uresp)) {
> -			rv = -EINVAL;
> -			goto err_out;
> -		}
> -		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
> -		if (rv)
> -			goto err_out;
> +	if (udata->outlen < sizeof(uresp)) {
> +		rv = -EINVAL;
> +		goto err_out;
>   	}
> +	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
> +	if (rv)
> +		goto err_out;
> +
>   	return 0;
>   
>   err_out:
> @@ -1227,6 +1221,55 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>   	return rv;
>   }
>   
> +int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
> +		  struct uverbs_attr_bundle *attrs)
> +{
> +	struct siw_device *sdev = to_siw_dev(base_cq->device);
> +	struct siw_cq *cq = to_siw_cq(base_cq);
> +	int rv, size = attr->cqe;
> +
> +	if (attr->flags)
> +		return -EOPNOTSUPP;
> +
> +	if (atomic_inc_return(&sdev->num_cq) > SIW_MAX_CQ) {
> +		siw_dbg(base_cq->device, "too many CQ's\n");
> +		rv = -ENOMEM;
> +		goto err_out;
> +	}
> +	if (size < 1 || size > sdev->attrs.max_cqe) {

isn't there now also a check for zero sized CQ in
__ib_alloc_cq(), which obsoletes that < 1 check?

Everything looks right otherwise.

Thanks,
Bernard.

> +		siw_dbg(base_cq->device, "CQ size error: %d\n", size);
> +		rv = -EINVAL;
> +		goto err_out;
> +	}
> +	size = roundup_pow_of_two(size);
> +	cq->base_cq.cqe = size;
> +	cq->num_cqe = size;
> +
> +	cq->queue = vzalloc(size * sizeof(struct siw_cqe) +
> +			    sizeof(struct siw_cq_ctrl));
> +	if (cq->queue == NULL) {
> +		rv = -ENOMEM;
> +		goto err_out;
> +	}
> +	get_random_bytes(&cq->id, 4);
> +	siw_dbg(base_cq->device, "new CQ [%u]\n", cq->id);
> +
> +	spin_lock_init(&cq->lock);
> +
> +	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
> +
> +	return 0;
> +
> +err_out:
> +	siw_dbg(base_cq->device, "CQ creation failed: %d", rv);
> +
> +	if (cq->queue)
> +		vfree(cq->queue);
> +	atomic_dec(&sdev->num_cq);
> +
> +	return rv;
> +}
> +
>   /*
>    * siw_poll_cq()
>    *
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
> index e9f4463aecdc..527c356b55af 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.h
> +++ b/drivers/infiniband/sw/siw/siw_verbs.h
> @@ -44,6 +44,8 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
>   		     struct ib_udata *udata);
>   int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>   		  struct uverbs_attr_bundle *attrs);
> +int siw_create_user_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
> +		       struct uverbs_attr_bundle *attrs);
>   int siw_query_port(struct ib_device *base_dev, u32 port,
>   		   struct ib_port_attr *attr);
>   int siw_query_gid(struct ib_device *base_dev, u32 port, int idx,
> 


