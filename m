Return-Path: <linux-hyperv+bounces-1305-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E024680B5A4
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Dec 2023 18:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1692F1C20865
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Dec 2023 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54C18E0C;
	Sat,  9 Dec 2023 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBZNKlD7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF931168BD;
	Sat,  9 Dec 2023 17:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C47C433C7;
	Sat,  9 Dec 2023 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702143238;
	bh=4mVZhE9mdS5wzDZreGCJL6zv3QXpgI2brftE/jLZkpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBZNKlD7ja5zgBRgYPJ9ZqROXNt7zVF+4LggKlO29CQ3kfSdsnnXilIFUB8N1a9k9
	 70oiEJmyTV71FBrwOEGYi8zc80vJZRGZkl3ucqA3ql2/R1gkr7nvU2rzuVflTCfcvy
	 uD+Zlb/NlfvXphzPu0iB1wkA3qA0FXFD2T5D4qw86Vb+tT6Seim2wHPyqyIEuftXZv
	 KjuWj8xmvtoBUEVBdtsas3fEpwY6yJ4wZ+VfSg8h71fTk1eW2RiGKurzbfbtPoSAn4
	 jytuWNtaybWh+Cs0yWHRrS7tdmCVgfRajYikogaR3Z3aznq/wWHuu2WBCDQr0WCx1c
	 TUaxK55+sHmFA==
Date: Sat, 9 Dec 2023 17:33:52 +0000
From: Simon Horman <horms@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v2 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Message-ID: <20231209173352.GC5817@kernel.org>
References: <1701730979-1148-1-git-send-email-longli@linuxonhyperv.com>
 <1701730979-1148-4-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701730979-1148-4-git-send-email-longli@linuxonhyperv.com>

On Mon, Dec 04, 2023 at 03:02:59PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> At probing time, the MANA core code allocates EQs for supporting interrupts
> on Ethernet queues. The same interrupt mechanisum is used by RAW QP.
> 
> Use the same EQs for delivering interrupts on the CQ for the RAW QP.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Hi Long Li,

some minor feedback from my side.

...

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 4667b18ec1dd..186d9829bb93 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -99,25 +99,34 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
>  	struct mana_ib_dev *mdev =
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
> +	struct ib_ucontext *ib_ucontext = pd->uobject->context;
>  	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp = {};
>  	struct mana_ib_create_qp_rss ucmd = {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct gdma_queue **gdma_cq_allocated;
>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
> +	struct gdma_queue *gdma_cq;
>  	unsigned int ind_tbl_size;
>  	struct mana_context *mc;
>  	struct net_device *ndev;
> +	struct gdma_context *gc;
>  	struct mana_ib_cq *cq;
>  	struct mana_ib_wq *wq;
>  	struct gdma_dev *gd;
> +	struct mana_eq *eq;
>  	struct ib_cq *ibcq;
>  	struct ib_wq *ibwq;
>  	int i = 0;
>  	u32 port;
>  	int ret;
>  
> -	gd = &mdev->gdma_dev->gdma_context->mana;
> +	gc = mdev->gdma_dev->gdma_context;
> +	gd = &gc->mana;
>  	mc = gd->driver_data;
> +	mana_ucontext =
> +		container_of(ib_ucontext, struct mana_ib_ucontext, ibucontext);
>  
>  	if (!udata || udata->inlen < sizeof(ucmd))
>  		return -EINVAL;

nit: mana_ucontext appears to be set but unused.

     Flagged by W=1 builds.

> @@ -179,6 +188,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		goto fail;
>  	}
>  
> +	gdma_cq_allocated = kcalloc(ind_tbl_size, sizeof(*gdma_cq_allocated),
> +				    GFP_KERNEL);
> +	if (!gdma_cq_allocated) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
>  	qp->port = port;
>  
>  	for (i = 0; i < ind_tbl_size; i++) {

...

> @@ -219,6 +236,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		resp.entries[i].wqid = wq->id;
>  
>  		mana_ind_table[i] = wq->rx_object;
> +
> +		/* Create CQ table entry */
> +		WARN_ON(gc->cq_table[cq->id]);
> +		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> +		if (!gdma_cq) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +		gdma_cq_allocated[i] = gdma_cq;
> +
> +		gdma_cq->cq.context = cq;
> +		gdma_cq->type = GDMA_CQ;
> +		gdma_cq->cq.callback = mana_ib_cq_handler;
> +		gdma_cq->id = cq->id;
> +		gc->cq_table[cq->id] = gdma_cq;
>  	}
>  	resp.num_entries = i;
>  
> @@ -238,6 +270,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		goto fail;
>  	}
>  
> +	kfree(gdma_cq_allocated);
>  	kfree(mana_ind_table);
>  
>  	return 0;
> @@ -247,8 +280,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		ibwq = ind_tbl->ind_tbl[i];
>  		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
>  		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
> +
> +		if (gdma_cq_allocated[i]) {

nit: It is not clear to me that condition can ever be false.
     If we get here then gdma_cq_allocated[i] is a valid pointer.

> +			gc->cq_table[gdma_cq_allocated[i]->id] =
> +				NULL;
> +			kfree(gdma_cq_allocated[i]);
> +		}
>  	}
>  
> +	kfree(gdma_cq_allocated);
>  	kfree(mana_ind_table);
>  
>  	return ret;

...

