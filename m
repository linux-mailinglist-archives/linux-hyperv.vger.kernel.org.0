Return-Path: <linux-hyperv+bounces-8852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H3fDzeyj2k4SwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8852-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 00:22:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF74139F7F
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 00:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CBB3303A85F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7662773E5;
	Fri, 13 Feb 2026 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lv7QZffq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965622517AA
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Feb 2026 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771024947; cv=none; b=Hfvrp1QrtLtsYmstDxlMREHqrAL0v9hM/tTIj0E/IvIP+30kmzM0ROCbWlPp+1btg67Yz3DVCXz9nDrDW4mOE16xl4E99kDDca1XGpAZAiI8aOEddF819rRy+We4Z9ZiP7kuMTjMKlMqUewJ56KltwvkXNarLPPSSwTtdoVClx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771024947; c=relaxed/simple;
	bh=UQJ6pYXPnPIXRM8pirMc4ug+s9oYY+R3WK/G2UaY5uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdIz89VP3cNCGJoeWBe/QzL74WmjeK+d4EPB+L+pIPsBX2Nx6Gwe5mWQ1eOcx+atMHoXT82KfIwiME6rRO1oR35HQ4kuwTGHGN6Yxy3SYYpSI885Y/Y/7EaOsNfNHNVgBoM14mhZVm3HeHz8gnP3Q2SiRvKT8nADXv0/KacqjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lv7QZffq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <459a01fe-8f23-4114-a127-98ec95c53464@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771024941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bje+VS+HFc4IP5MZonfLHHhjiuUCgTadQIT/tXFDSo=;
	b=lv7QZffqRt9lWP9tzW9wJx7l6G5Of/DfSmbd732cmGm9+xdcBoXlqsBiuTxpzY/0KARVR0
	P1yZBpssN2K8k2PgFLnv2i6d3DtkxLzCihxfyE9mYZVVLwJw1wynGqbbcyCX6qKpupPv3A
	o9Z2EldUq//1yE9yf68/bK0LQJFOgNc=
Date: Fri, 13 Feb 2026 15:22:13 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 29/50] RDMA/rxe: Split user and kernel CQ
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
 Bernard Metzler <bernard.metzler@linux.dev>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-29-f3be85847922@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260213-refactor-umem-v1-29-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8852-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 8CF74139F7F
X-Rspamd-Action: no action

On 2/13/26 2:58 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Separate the CQ creation logic into distinct kernel and user flows.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 81 ++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 38d8c408320f..1e651bdd8622 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1072,58 +1072,70 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>   }
>   
>   /* cq */
> -static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> -			 struct uverbs_attr_bundle *attrs)
> +static int rxe_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +			      struct uverbs_attr_bundle *attrs)
>   {
>   	struct ib_udata *udata = &attrs->driver_udata;
>   	struct ib_device *dev = ibcq->device;
>   	struct rxe_dev *rxe = to_rdev(dev);
>   	struct rxe_cq *cq = to_rcq(ibcq);
> -	struct rxe_create_cq_resp __user *uresp = NULL;
> -	int err, cleanup_err;
> +	struct rxe_create_cq_resp __user *uresp;
> +	int err;
>   
> -	if (udata) {
> -		if (udata->outlen < sizeof(*uresp)) {
> -			err = -EINVAL;
> -			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
> -			goto err_out;
> -		}
> -		uresp = udata->outbuf;
> -	}
> +	if (udata->outlen < sizeof(*uresp))
> +		return -EINVAL;
>   
> -	if (attr->flags) {
> -		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "bad attr->flags, err = %d\n", err);
> -		goto err_out;
> -	}
> +	uresp = udata->outbuf;
>   
> -	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
> -	if (err) {
> -		rxe_dbg_dev(rxe, "bad init attributes, err = %d\n", err);
> -		goto err_out;
> -	}
> +	if (attr->flags || ibcq->umem)
> +		return -EOPNOTSUPP;
> +
> +	if (attr->cqe > rxe->attr.max_cqe)
> +		return -EINVAL;
>   
>   	err = rxe_add_to_pool(&rxe->cq_pool, cq);
> -	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create cq, err = %d\n", err);
> -		goto err_out;
> -	}
> +	if (err)
> +		return err;
>   
>   	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
>   			       uresp);

Neither rxe_create_user_cq() nor rxe_create_cq() explicitly validates 
attr->comp_vector. Is this guaranteed to be validated by the core before 
reaching the driver, or should rxe still enforce device-specific limits?

> -	if (err) {
> -		rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
> +	if (err)
>   		goto err_cleanup;

The err_cleanup label is only used for this specific error path. It may 
improve readability to inline the cleanup logic at this site and remove 
the label altogether.

> -	}
>   
>   	return 0;
>   
>   err_cleanup:
> -	cleanup_err = rxe_cleanup(cq);
> -	if (cleanup_err)
> -		rxe_err_cq(cq, "cleanup failed, err = %d\n", cleanup_err);
> -err_out:
> -	rxe_err_dev(rxe, "returned err = %d\n", err);
> +	rxe_cleanup(cq);
> +	return err;
> +}
> +
> +static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +			 struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_device *dev = ibcq->device;
> +	struct rxe_dev *rxe = to_rdev(dev);
> +	struct rxe_cq *cq = to_rcq(ibcq);
> +	int err;
> +
> +	if (attr->flags)
> +		return -EOPNOTSUPP;
> +
> +	if (attr->cqe > rxe->attr.max_cqe)
> +		return -EINVAL;
> +
> +	err = rxe_add_to_pool(&rxe->cq_pool, cq);
> +	if (err)
> +		return err;
> +
> +	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, NULL,
> +			       NULL);
> +	if (err)
> +		goto err_cleanup;

ditto

Thanks a lot.

Zhu Yanjun

> +
> +	return 0;
> +
> +err_cleanup:
> +	rxe_cleanup(cq);
>   	return err;
>   }
>   
> @@ -1478,6 +1490,7 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	.attach_mcast = rxe_attach_mcast,
>   	.create_ah = rxe_create_ah,
>   	.create_cq = rxe_create_cq,
> +	.create_user_cq = rxe_create_user_cq,
>   	.create_qp = rxe_create_qp,
>   	.create_srq = rxe_create_srq,
>   	.create_user_ah = rxe_create_ah,
> 


