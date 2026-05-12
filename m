Return-Path: <linux-hyperv+bounces-10788-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CdBCWmNAmpouQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10788-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:16:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86236518CF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93BB3002A17
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72031079B;
	Tue, 12 May 2026 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIiNd2du"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC92848BE;
	Tue, 12 May 2026 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552043; cv=none; b=kgaUS5xlNBKccev8uNdby1eHnmo0Wf4UBrRGhdEDcDbK1E7Tky7VNFLxNYSCp9vlOwWDA18cndbtOI6x3+JJv8SgPNBeR8AEolZFcsI3fKOroreUYPwDqIATqi+BM74kXKaoq9ssh85UwHjm4jFOc2QmPkU47elMfLCFTtOF9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552043; c=relaxed/simple;
	bh=pFJslUGrwdc29w+hrlhHXY0JzawCF09OH5dfidJXFz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V56KmVTBtKlVh/S/Ndfk4lFz8qfqbLanj6/3KtQZvSrr4hZ4u+UUHnDFsLalrFFcse7PfD/mvT2H12y0h3KaNMBXfIfi6tXi5zwNOQ2QrcJrZmTv21YceDdMS3OVM04iAoJG9qDK1IUurJWJUM7pnxOGPabgb/Hl0PeDAHtwvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIiNd2du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05170C2BCB0;
	Tue, 12 May 2026 02:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552042;
	bh=pFJslUGrwdc29w+hrlhHXY0JzawCF09OH5dfidJXFz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cIiNd2duTnK5XWa/MoxqcAz/G8CnKutLO5ybVitnantGa97QJSWngoTRH2z/Tg16r
	 J8HSIw+HPsqmFAEh+/rH2x/BB6piEX2BgB6x2Yj+FzHufHmFQy7q/O+rIiwidVkH29
	 JU04sZwU14qCfwC/TFRDmJh1gWOc4+GpQOpDlVrQhWDUJHIvIO+adT/ODtxcCQf/eU
	 OuvgoSERX4lQf0ehCo969UZv/RUX3gb63kA9nDb0tR7xylZQCH48MCcGySU5I8P7cd
	 N16gDMU96Dpv8gB3CFO7PThB62YQ6DeUPAgoCvCyr2jRwJFI9NZvnuA+vbsVgY+1QB
	 ny/isVepohHng==
From: Jakub Kicinski <kuba@kernel.org>
To: longli@microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kotaranov@microsoft.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/6] net: mana: Create separate EQs for each vPort
Date: Mon, 11 May 2026 19:13:58 -0700
Message-ID: <20260512021358.849780-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507191237.438671-2-longli@microsoft.com>
References: <20260507191237.438671-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86236518CF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-10788-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Create separate EQs for each vPort

This change removes EQ sharing across vPorts and moves EQ ownership
from struct mana_context to struct mana_port_context. It exports
mana_create_eq() and mana_destroy_eq() so the MANA RDMA driver can
create EQs when a raw QP configures the vport, and also rearranges
mana_alloc_queues()/mana_dealloc_queues() to own the netdev-side
EQ lifecycle.

A few questions on the resulting ownership model below.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index ac5e75dd3494..8000ab6e8beb 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -20,8 +20,10 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
>  	pd->vport_use_count--;
>  	WARN_ON(pd->vport_use_count < 0);
>  
> -	if (!pd->vport_use_count)
> +	if (!pd->vport_use_count) {
> +		mana_destroy_eq(mpc);
>  		mana_uncfg_vport(mpc);
> +	}
>  
>  	mutex_unlock(&pd->vport_mutex);
>  }

[High]
After this change, mpc->eqs has two distinct owners: the RDMA path
frees it here under pd->vport_mutex, and the netdev path frees it under
rtnl_lock via mana_dealloc_queues() -> mana_destroy_eq(). Neither lock
is held by the readers in qp.c. See the comment on the RSS QP path
below.

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 645581359cee..6f1043383e8c 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -168,7 +168,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		cq_spec.gdma_region = cq->queue.gdma_region;
>  		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
>  		cq_spec.modr_ctx_id = 0;
> -		eq = &mpc->ac->eqs[cq->comp_vector];
> +		/* EQs are created when a raw QP configures the vport.
> +		 * A raw QP must be created before creating rwq_ind_tbl.
> +		 */
> +		if (!mpc->eqs) {
> +			ret = -EINVAL;
> +			i--;
> +			goto fail;
> +		}
> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
>  		cq_spec.attached_eq = eq->eq->id;

[High]
Is the NULL check on mpc->eqs safe here without any synchronization?

Before this patch, ac->eqs was allocated in mana_probe() and freed in
mana_remove(), so its lifetime spanned the whole driver. With this
patch, apc->eqs can be freed concurrently by either owner:

    mana_ib_uncfg_vport()                 (pd->vport_mutex)
      mana_destroy_eq(mpc)
        kfree(apc->eqs);
        apc->eqs = NULL;

    mana_dealloc_queues()                 (rtnl_lock, ndo_close)
      mana_destroy_eq(apc)
        kfree(apc->eqs);
        apc->eqs = NULL;

This path holds neither lock. Can the 'if (!mpc->eqs)' observation
survive through the subsequent '&mpc->eqs[...]' and 'eq->eq->id'
dereference, or can a concurrent destroyer free apc->eqs between the
check and the deref and turn this into a read of freed memory?

There is also an initialization window in the writer:

    apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
    ...
    for (i = 0; i < apc->num_queues; i++) {
        ...
        err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);

apc->eqs is published before apc->eqs[i].eq is filled in. Can a
concurrent reader here see apc->eqs non-NULL but apc->eqs[i].eq still
NULL, and fault on eq->eq->id?

[Medium]
mana_ib advertises ib_dev.num_comp_vectors as gc->max_num_queues in
mana_ib_probe(), but this patch sizes the per-port pool as
apc->num_queues, which defaults to min(gc->max_num_queues,
MANA_DEF_NUM_QUEUES) and can be reduced further via ethtool -L.

    eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];

When gc->max_num_queues > apc->num_queues, does this modulo silently
collapse distinct advertised completion vectors onto shared EQs, so
CQs created by userspace with different comp_vector values end up on
the same notification stream? Would it be better to cap
ib_dev.num_comp_vectors to apc->num_queues, or reject comp_vector >=
apc->num_queues, instead of wrapping?

[Medium]
The added comment codifies a new ordering constraint:

    /* EQs are created when a raw QP configures the vport.
     * A raw QP must be created before creating rwq_ind_tbl.
     */

Before this patch, ac->eqs existed from mana_probe() onward, so
mana_ib_create_qp_rss() succeeded whether or not the netdev was up and
whether or not any raw QP had been created on the port. After this
patch, if the netdev is administratively down and no raw QP has
configured the vport, mpc->eqs is NULL and this path returns -EINVAL.

Is that ABI-visible change to RSS QP creation intentional, and worth
calling out in the commit message?

The comment is also slightly incomplete: EQs are created on netdev open
via mana_alloc_queues() -> mana_create_eq() as well, not only when a
raw QP configures the vport. Could the wording be adjusted?

>  
>  		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -3343,6 +3367,9 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	mana_fence_rqs(apc);
>  
>  	/* Even in err case, still need to cleanup the vPort */
> +	mana_destroy_rxqs(apc);
> +	mana_destroy_txq(apc);
> +	mana_destroy_eq(apc);
>  	mana_destroy_vport(apc);
>  
>  	return 0;
-- 
pw-bot: cr

