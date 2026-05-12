Return-Path: <linux-hyperv+bounces-10793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOkFi2NAmrzuAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10793-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:15:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0C518C95
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 444C3301CFC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A83016FC;
	Tue, 12 May 2026 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHT2LSCj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F21E5B9A;
	Tue, 12 May 2026 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552074; cv=none; b=X24FTHTDfczsv1E04/VMVSCWmi7IlHW/78svBrCx3jDw32y/0/5nUEX0r0Y5MRVQ1kmjKW/0hP7GtQsEtdpi9iBkKb4Bkdqt+4OgXHt9IzMowVkmkGeBS+DIur//W8mM+7J1TmfiybbyRmUPvwtUX7eANr4Tp0MB00G3b12y444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552074; c=relaxed/simple;
	bh=OGqISf99uUDD5TjodzVnFEBmwpHFAZJ0O5itA3RCgjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3bVjEHgc3eqXcW5pOsOUq7fEeeiVOxBxiB9p/GgRDyILLeaTxjmghiKLegnP8PiSZHVkc6ogZZa15XW/aTl2D2l6H/fyKF0Mzcxbu9UNbv0KglkllgGKu2oTRAHsKjk77SvTHkkp6KCcKpcJSED/dtJQGiF/glVrV52piCmKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHT2LSCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D5C2BCF5;
	Tue, 12 May 2026 02:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552074;
	bh=OGqISf99uUDD5TjodzVnFEBmwpHFAZJ0O5itA3RCgjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHT2LSCjJNSGfwpVGsTdWGuXZAwjyrPXb0I/tOufgM8W6VfV/hBh9LQDHsyv0L55d
	 9xp1L6WfJx2LMxSXplFc88X8hFqYum+UYcDbUqYGyhLfDpKt3S0yw+waoYcKzXaA2U
	 d0Kb9KRX47hdi3gIIgRyzM7dvpYmmo4NPjZ98xWqPgCE+JBpFoxBCXJwF+EYK6NTb5
	 c4YXqGeX7fWB9PJ4rX7An3a47BrJRteWk47OG0Zj43rHm49KHhK0PP3S3g0UH9QT1L
	 pr2fYEkktGfBgiCR2s668Adogz9UL4PaffVn1GGSNNbjUOPMKKBtimMIyd4GTRwwmn
	 KkkUaabAyrB5g==
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
Date: Mon, 11 May 2026 19:14:32 -0700
Message-ID: <20260512021432.850108-1-kuba@kernel.org>
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
X-Rspamd-Queue-Id: C0F0C518C95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-10793-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: mana: Create separate EQs for each vPort

This commit prepares for assigning vPorts to dedicated MSI-X vectors by
removing EQ sharing among the vPorts and creating dedicated EQs for each
vPort. It moves the EQ definition from struct mana_context to struct
mana_port_context and exports related functions for the RDMA driver.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index ac5e75dd3494d..8000ab6e8beb9 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -55,15 +57,22 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>  		return err;
>  	}
>  
> -	mutex_unlock(&pd->vport_mutex);
>  
>  	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
>  	pd->tx_vp_offset = mpc->tx_vp_offset;
> +	err = mana_create_eq(mpc);
> +	if (err) {
> +		mana_uncfg_vport(mpc);
> +		pd->vport_use_count--;
> +	}
>  
> -	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
> -		  mpc->port_handle, pd->pdn, doorbell_id);
> +	mutex_unlock(&pd->vport_mutex);

How does this handle a Protection Domain shared across multiple physical
ports?

Looking at the earlier part of mana_ib_cfg_vport(), if a PD is already
in use, the code increments pd->vport_use_count and returns early:

	pd->vport_use_count++;
	if (pd->vport_use_count > 1) {
		ibdev_dbg(&dev->ib_dev,
			  "Skip as this PD is already configured vport\n");
		mutex_unlock(&pd->vport_mutex);
		return 0;
	}

If a second port is configured with the same PD, it skips calling
mana_create_eq() for the new port's mpc. Will this cause mpc->eqs to
remain NULL for the second port and fail subsequent queue creations?

[ ... ]

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 0fbcf449c134b..6167742df9d29 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -171,7 +171,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
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

Does this explicit i-- cause a resource leak in the error path?

The fail block cleans up previously created WQ objects using a post-decrement
while loop:

fail:
	while (i-- > 0) {
		ibwq = ind_tbl->ind_tbl[i];
		ibcq = ibwq->cq;
		...
		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
	}

If we manually decrement i before jumping to the fail block, the while loop
will decrement it again prior to evaluation, completely skipping the cleanup
of the WQ object that was just successfully created at the original index i.

> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];

What guarantees the lifetime of the mpc->eqs array for active RSS QPs?

Since mana_ib_create_qp_rss() doesn't take a reference count or hold a lock
that prevents mana_destroy_eq() from running, if the Ethernet interface is
brought down or the RAW QP is destroyed, could mana_destroy_eq() free the
array while RSS QPs are still actively using it?

Additionally, can this out-of-bounds read if an ethtool channel update
changes mpc->num_queues while the interface is down?

If a RAW QP is created while the interface is down, mpc->eqs is sized to the
old channel count. If the channel count is then increased, mpc->num_queues
updates but the array isn't reallocated because the interface is down and
queue deallocation was skipped. This could lead to accessing past the end of
the allocation both here and in mana_destroy_eq().

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b2faa7cf398f3..cef86c9310543 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> -static void mana_create_eq_debugfs(struct mana_context *ac, int i)
> +static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
>  {
> -	struct mana_eq eq = ac->eqs[i];
> +	struct mana_eq eq = apc->eqs[i];
>  	char eqnum[32];
>  
>  	sprintf(eqnum, "eq%d", i);
> -	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, ac->mana_eqs_debugfs);
> +	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
>  }

Does this update the actual debugfs pointer in the array?

By using struct mana_eq eq = apc->eqs[i];, it creates a local by-value copy
on the stack. The debugfs directory is created, but the pointer in the actual
apc->eqs array remains NULL. Would it be better to use a pointer reference
like struct mana_eq *eq = &apc->eqs[i]; here?

[ ... ]

> -static int mana_create_eq(struct mana_context *ac)
> +int mana_create_eq(struct mana_port_context *apc)
>  {
> -	struct gdma_dev *gd = ac->gdma_dev;
> +	struct gdma_dev *gd = apc->ac->gdma_dev;
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct gdma_queue_spec spec = {};
>  	int err;
>  	int i;
>  
> -	ac->eqs = kzalloc_objs(struct mana_eq, gc->max_num_queues);
> -	if (!ac->eqs)
> +	WARN_ON(apc->eqs);
> +	apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
> +	if (!apc->eqs)
>  		return -ENOMEM;
>  
>  	spec.type = GDMA_EQ;
>  	spec.monitor_avl_buf = false;
>  	spec.queue_size = EQ_SIZE;
>  	spec.eq.callback = NULL;
> -	spec.eq.context = ac->eqs;
> +	spec.eq.context = apc->eqs;
>  	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
>  
> -	ac->mana_eqs_debugfs = debugfs_create_dir("EQs", gc->mana_pci_debugfs);
> +	apc->mana_eqs_debugfs = debugfs_create_dir("EQs",
> +						    apc->mana_port_debugfs);
>  
> -	for (i = 0; i < gc->max_num_queues; i++) {
> +	for (i = 0; i < apc->num_queues; i++) {
>  		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
> -		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
> +		err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);

Could there be a race condition between mana_create_eq() and
mana_ib_create_qp_rss() here?

apc->eqs is assigned immediately after allocation, but before the individual
eq structures are populated by mana_gd_create_mana_eq() in this loop.

If an RDMA application concurrently calls mana_ib_create_qp_rss(), it checks
if (!mpc->eqs). That check will pass because the array is allocated, but
accessing eq->eq->id could result in a NULL pointer dereference because the
element has not been fully initialized yet.

