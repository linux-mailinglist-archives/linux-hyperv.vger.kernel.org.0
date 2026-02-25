Return-Path: <linux-hyperv+bounces-8977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIq5AhGynmlxWwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8977-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 09:25:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222B194299
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79EE43041BCF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C03101C2;
	Wed, 25 Feb 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJCsM6N2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072B2D063E;
	Wed, 25 Feb 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007864; cv=none; b=MOBRbNnUphsA7U2OgdohIqC41eBHFmztuBHK3gwwb9bqPlB0zkbNdLg03940+13r/4JWS8yigCbTragdy/L955hz/Tr0EEsqFVUy1gbG0csPUMVsYO9TBpv0tKIym5gG8Na9QfD5HVOmbNK9BAbf/KbotBFlRmyOco7pNfuFgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007864; c=relaxed/simple;
	bh=ppwLBv+bRl0MuIG9o64/1GBk8qLUMoGaYaQBPTNIgpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIh1sXFEh5O47jhbfkSmMCn2ETMXzvPfdMF+aGawgEoHUdUL1Cx56Hx+dBHIQ5dO1EBidivHyOWw6+hYkmcsNQMicYxlsP6hIAs36yRof5qLnwgiSaH3GycPrwzAhD75W/7W46XWMZnH2uHmtR6s88rfOgTlG9HdO2aGggf8aVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJCsM6N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DDAC116D0;
	Wed, 25 Feb 2026 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772007864;
	bh=ppwLBv+bRl0MuIG9o64/1GBk8qLUMoGaYaQBPTNIgpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJCsM6N2igmDWi88bXhKigzKvixKJkf5S43Dzt1Jer2wbhMGf13Qdpr5n04g4N6uB
	 FiBCIRp6zt8zlfKoMyVKoj9/NCsrcGWHN4KfdzteUkaxidhwhVjbFvGH2HiCWtThYq
	 Ga6zG0hKJZ2KMuFYMuWrwFKVuL38yFsF4s8jFrFaWtg/F2mlOQZlzkZ26xfVJW8Dru
	 E8pmf1L7LnzqpZlWYwk9Mt1DXALl7J+wmEAuZDr7ns+YxxCqirU9Ds1Il4aHXHAfUe
	 mB+MBDxG+cwkLIItubB08DVNZljtGfyJ+VJI0/w4ZEnRhyRNJjSr4uujLik4r0rEKR
	 B7bB8v4pjyYfQ==
Date: Wed, 25 Feb 2026 10:24:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH rdma-next 25/50] RDMA/mana: Provide a modern
 CQ creation interface
Message-ID: <20260225082421.GC9541@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-25-f3be85847922@nvidia.com>
 <DS3PR21MB5735C22704C2AA25C5037EA5CE74A@DS3PR21MB5735.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS3PR21MB5735C22704C2AA25C5037EA5CE74A@DS3PR21MB5735.namprd21.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8977-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9222B194299
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:30:37PM +0000, Long Li wrote:
> > diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
> > index 2dce1b677115..605122ecf9f9 100644
> > --- a/drivers/infiniband/hw/mana/cq.c
> > +++ b/drivers/infiniband/hw/mana/cq.c
> > @@ -5,8 +5,8 @@
> > 
> >  #include "mana_ib.h"
> > 
> > -int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > -		      struct uverbs_attr_bundle *attrs)
> > +int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr
> > *attr,
> > +			   struct uverbs_attr_bundle *attrs)
> >  {
> >  	struct ib_udata *udata = &attrs->driver_udata;
> >  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> > @@ -17,7 +17,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > ib_cq_init_attr *attr,
> >  	struct mana_ib_dev *mdev;
> >  	bool is_rnic_cq;
> >  	u32 doorbell;
> > -	u32 buf_size;
> >  	int err;
> > 
> >  	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev); @@ -26,44
> > +25,100 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > ib_cq_init_attr *attr,
> >  	cq->cq_handle = INVALID_MANA_HANDLE;
> >  	is_rnic_cq = mana_ib_is_rnic(mdev);
> > 
> > -	if (udata) {
> > -		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> > -			return -EINVAL;
> > +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> > +		return -EINVAL;
> > 
> > -		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> > udata->inlen));
> > -		if (err) {
> > -			ibdev_dbg(ibdev, "Failed to copy from udata for create
> > cq, %d\n", err);
> > -			return err;
> > -		}
> > +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> > >inlen));
> > +	if (err) {
> > +		ibdev_dbg(ibdev, "Failed to copy from udata for create
> > cq, %d\n", err);
> > +		return err;
> > +	}
> > 
> > -		if ((!is_rnic_cq && attr->cqe > mdev-
> > >adapter_caps.max_qp_wr) ||
> > -		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
> > -			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> > >cqe);
> > -			return -EINVAL;
> > -		}
> > +	if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
> > +	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
> > +		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> > +		return -EINVAL;
> > +	}
> > +
> > +	cq->cqe = attr->cqe;
> > +	if (!ibcq->umem)
> > +		ibcq->umem = ib_umem_get(ibdev, ucmd.buf_addr,
> > +				     cq->cqe * COMP_ENTRY_SIZE,
> > +				     IB_ACCESS_LOCAL_WRITE);
> > +	if (IS_ERR(ibcq->umem))
> > +		return PTR_ERR(ibcq->umem);
> > +	cq->queue.umem = ibcq->umem;
> > +
> > +	err = mana_ib_create_queue(mdev, &cq->queue);
> > +	if (err)
> > +		return err;
> 
> Should we call ib_umem_release() on this err?

<...>

> >  err_destroy_queue:
> >  	mana_ib_destroy_queue(mdev, &qp->raw_sq);
> > +	return err;
> 
> Should remove this "return err", the error handling code should fall through.

The main idea of this series is to allocate/release umem in the core logic.
See patch #5 https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-5-f3be85847922@nvidia.com/

> 
> > +
> > +err_release_umem:
> > +	ib_umem_release(qp->raw_sq.umem);
> > 
> >  err_free_vport:
> >  	mana_ib_uncfg_vport(mdev, pd, port);
> > @@ -553,13 +566,25 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp,
> > struct ib_pd *ibpd,
> >  		if (i == MANA_RC_SEND_QUEUE_FMR) {
> >  			qp->rc_qp.queues[i].id = INVALID_QUEUE_ID;
> >  			qp->rc_qp.queues[i].gdma_region =
> > GDMA_INVALID_DMA_REGION;
> > +			qp->rc_qp.queues[i].umem = NULL;
> >  			continue;
> >  		}
> > -		err = mana_ib_create_queue(mdev, ucmd.queue_buf[j],
> > ucmd.queue_size[j],
> > -					   &qp->rc_qp.queues[i]);
> > +		qp->rc_qp.queues[i].umem = ib_umem_get(&mdev->ib_dev,
> > +						       ucmd.queue_buf[j],
> > +						       ucmd.queue_size[j],
> > +
> > IB_ACCESS_LOCAL_WRITE);
> > +		if (IS_ERR(qp->rc_qp.queues[i].umem)) {
> > +			err = PTR_ERR(qp->rc_qp.queues[i].umem);
> > +			ibdev_err(&mdev->ib_dev, "Failed to get umem for
> > queue %d, err %d\n",
> > +				  i, err);
> > +			goto release_umems;
> 
> mana_ib_create_queue() may already have created some queues, need to clean them up or we have a leak. 
> 
> Maybe use destroy_queues: to call ib_umem_release()?

We should remove mana_ib_create_rc_qp() hunk, it came from my future
work where I removed umem from QPs as well.

Thanks

