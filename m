Return-Path: <linux-hyperv+bounces-10803-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIPTFHIQA2qX0AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10803-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 13:35:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616151F69F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37D1A30069A0
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D634D2EF5;
	Tue, 12 May 2026 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT/IiXg9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4A3C3C00
	for <linux-hyperv@vger.kernel.org>; Tue, 12 May 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585699; cv=none; b=U5tp7YMOVIQ8C3xGJF1hE5UMf2DzvcNY8thdZSaWuqnIOwJxwyDjJogJtHXUbfEIwNP6w2rD2dYK6IXLkNcbyodcujA9vJgV3eER1Z4WrOIfhgzWOQM6DOCLsXvRLGusdCjo92HuKh4Gbb0yd/GSayoCf/4sSmb1rgGRAyIPkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585699; c=relaxed/simple;
	bh=1IpsV88xPvhWRZi6mj/I6mhERZcG0HdszvNzOvfLg+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR+CX5nQZjxBbTThhu0ej9h4WAJchrUtp1Do2Ue5Bo731uhnfUdZrY6GjKux52loUDzkFa5co3w6/1vfMjok/lZzQuVlalq8nXwG+0jZXS+MXFT8VdExkRwqiFj15gSFIJMAKrVJcQGgWIKcf5QMENd8JmDF6uVfr14nQfsFvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT/IiXg9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778585696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2T1P80e2ayXiD4FLmzXcH0SJv4nUG0BB/kIni+nI35U=;
	b=KT/IiXg9ASZ9jZTIqFffxEssnnSFaxFsjNHVpa6nk9JPeWVBlvrmwiue09/Z7iilEVvI0A
	O1met9El9rvacTB5TjqalVsfT8a2ERjdT4AUobUSQM7/rGsFpWRwpFbJBsOwhXxrv5BycD
	EPg0eRcojnCucCcDDq8T7q3UW8Z4AhE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-r2p_ab2aMVy41g7ch2XGkg-1; Tue,
 12 May 2026 07:34:52 -0400
X-MC-Unique: r2p_ab2aMVy41g7ch2XGkg-1
X-Mimecast-MFC-AGG-ID: r2p_ab2aMVy41g7ch2XGkg_1778585690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17CA4195608B;
	Tue, 12 May 2026 11:34:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A466C1800465;
	Tue, 12 May 2026 11:34:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: longli@microsoft.com
Cc: kotaranov@microsoft.com,
	kuba@kernel.org,
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
Subject: Re: [PATCH net-next v8 1/6] net: mana: Create separate EQs for each vPort
Date: Tue, 12 May 2026 13:34:38 +0200
Message-ID: <20260512113438.168454-1-pabeni@redhat.com>
In-Reply-To: <20260508221202.15725-2-longli@microsoft.com>
References: <20260508221202.15725-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 4616151F69F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10803-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Subject: net: mana: Create separate EQs for each vPort

This patch moves EQ ownership from struct mana_context to
struct mana_port_context, creates per-vPort EQs in mana_alloc_queues()
and mana_ib_cfg_vport(), and exports mana_create_eq()/mana_destroy_eq()
for use by the MANA RDMA driver.

A few questions below about the new lifetime and ordering rules for
mpc->eqs.

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
After this change, mpc->eqs lifetime is governed by pd->vport_use_count,
and only raw QPs call mana_ib_cfg_vport()/mana_ib_uncfg_vport().  RSS
QPs in mana_ib_create_qp_rss() read mpc->eqs and latch eq->eq->id into
the HW CQ via cq_spec.attached_eq, but they do not bump
pd->vport_use_count.

So if a user creates a raw QP on a PD (use_count=1, mpc->eqs allocated),
then creates an RSS QP on the same PD whose CQs now reference those EQ
ids, and finally destroys the raw QP first, this path runs with
use_count dropping to 0 and calls mana_destroy_eq(mpc) -> kfree(apc->eqs)
and mana_gd_destroy_queue() for each EQ while the surviving RSS QP's HW
CQs are still attached to those EQs.

Is there an intended rule that enforces destruction ordering between raw
and RSS QPs on the same PD, or should RSS QPs also participate in the
refcount that guards mpc->eqs?

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
>  
> -	return 0;
> +	if (!err)
> +		ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
> +			  mpc->port_handle, pd->pdn, doorbell_id);
> +
> +	return err;
>  }

[Low]
pd->tx_shortform_allowed and pd->tx_vp_offset are written before
mana_create_eq() is attempted.  On the mana_create_eq() failure branch,
mana_uncfg_vport(mpc) is called and pd->vport_use_count is decremented
back to 0, but pd->tx_shortform_allowed/pd->tx_vp_offset are left set to
the values derived from a vport whose HW-side configuration has been
reverted.  Should these fields only be committed to pd after
mana_create_eq() succeeds?

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 0fbcf449c134..6167742df9d2 100644
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
> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
>  		cq_spec.attached_eq = eq->eq->id;

[Critical]
mana_ib_create_qp_rss() does not acquire pd->vport_mutex and does not
touch pd->vport_use_count.  The NULL check above reads mpc->eqs without
synchronization; immediately after it, the same mpc->eqs is dereferenced
and eq->eq->id is latched into cq_spec.attached_eq.

Can the following sequence occur?

  thread A (creating RSS QP on pd)        thread B (destroying last raw QP on pd)
  mana_ib_create_qp_rss()
    if (!mpc->eqs)  /* non-NULL */
    ...                                   mana_ib_uncfg_vport()
                                            mutex_lock(&pd->vport_mutex);
                                            if (!--pd->vport_use_count)
                                              mana_destroy_eq(mpc);
                                                kfree(apc->eqs);
    eq = &mpc->eqs[... % mpc->num_queues];
    cq_spec.attached_eq = eq->eq->id;     /* reads freed memory */

Is there something else serializing these paths that this reviewer is
missing?

[Medium]
The off-by-one on the error path looks inconsistent with the other fail
sites in this function.  Every other goto fail in this loop leaves i
alone and relies on:

  while (i-- > 0) {
      ibwq = ind_tbl->ind_tbl[i];
      ...
      mana_ib_remove_cq_cb(mdev, cq);
      mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
  }

Here the new branch does ret = -EINVAL; i--; goto fail, which drops one
extra iteration of cleanup.  If this check ever fires at i > 0 (for
example if the lifetime issue above is fixed by making mpc->eqs
observable as NULL mid-loop), the WQ object and installed CQ callback
created in the previous iteration are not torn down.  Should this match
the other fail sites and omit the i--?

[Medium]
Before this patch ac->eqs was populated unconditionally in mana_probe()
and existed for the lifetime of the device, so mana_ib_create_qp_rss()
and mana_ib_create_qp_raw() always had EQs available regardless of
whether any netdev was up or any raw QP had been created.

After this patch, mpc->eqs is populated only by mana_alloc_queues()
(netdev open) or by mana_ib_cfg_vport() (which is only invoked from
mana_ib_create_qp_raw()).  An RDMA user who creates an RSS QP on a PD
while the netdev is down and without a prior raw QP on the same PD will
now see -EINVAL from this new check, where the same call succeeded
before.

The commit message describes this work as preparatory and does not
mention this user-visible ordering requirement.  Should this semantic
change be called out in the commit log, and should the implicit "a raw
QP must be created first" rule be documented somewhere user-facing?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b2faa7cf398f..131a997e1083 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1615,78 +1615,83 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
>  }
>  EXPORT_SYMBOL_NS(mana_destroy_wq_obj, "NET_MANA");
>  
> -static void mana_destroy_eq(struct mana_context *ac)
> +void mana_destroy_eq(struct mana_port_context *apc)
>  {
> +	struct mana_context *ac = apc->ac;
>  	struct gdma_context *gc = ac->gdma_dev->gdma_context;
>  	struct gdma_queue *eq;
>  	int i;
>  
> -	if (!ac->eqs)
> +	if (!apc->eqs)
>  		return;
>  
> -	debugfs_remove_recursive(ac->mana_eqs_debugfs);
> -	ac->mana_eqs_debugfs = NULL;
> +	debugfs_remove_recursive(apc->mana_eqs_debugfs);
> +	apc->mana_eqs_debugfs = NULL;
>  
> -	for (i = 0; i < gc->max_num_queues; i++) {
> -		eq = ac->eqs[i].eq;
> +	for (i = 0; i < apc->num_queues; i++) {
> +		eq = apc->eqs[i].eq;
>  		if (!eq)
>  			continue;
>  
>  		mana_gd_destroy_queue(gc, eq);
>  	}

[High]
The loop bound is now apc->num_queues rather than the immutable
gc->max_num_queues.  mana_create_eq() allocates apc->eqs sized to
apc->num_queues, and mana_destroy_eq() walks the same count.

When RDMA has called mana_ib_cfg_vport() -> mana_create_eq() while the
netdev is down, apc->num_queues can still be mutated underneath it.
mana_detach(false) skips mana_dealloc_queues() when port_st_save is
false, and then mana_set_channels() (ethtool -L) writes
apc->num_queues = new_count while mpc->eqs is already held by the RDMA
side.  mana_attach() then also skips mana_alloc_queues().

When the RDMA user later destroys the last raw QP and this function
runs, i iterates 0..new_count-1.  If new_count is larger than the count
used at kzalloc_objs() time, apc->eqs is read out of bounds and
potentially passed to mana_gd_destroy_queue().  If new_count is smaller,
the tail EQs (real gdma_queue objects with MSI-X and DMA regions) are
leaked.

Before this patch both sides used gc->max_num_queues so no mismatch was
possible.  Should apc->num_queues be snapshotted into apc at
mana_create_eq() time (or should changing num_queues be forbidden while
mpc->eqs is populated by the RDMA path)?

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

[Low]
WARN_ON(apc->eqs) here is advisory only; execution continues into
apc->eqs = kzalloc_objs(...), which unconditionally overwrites any
non-NULL pointer.  If the invariant is ever violated by a future caller
or error path, the prior EQ array and its gdma_queue objects are
orphaned (kernel memory and firmware EQ state leaked) with only a WARN
splat as the signal.

Would "if (WARN_ON(apc->eqs)) return -EEXIST;" express the intent more
safely?
-- 
This is an AI-generated review.


