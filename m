Return-Path: <linux-hyperv+bounces-11026-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPQZAGpnDGpXggUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11026-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 15:36:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AA57FCC5
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7083115DC9
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DEF3403F4;
	Tue, 19 May 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIcgx+Zt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30B348C52
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197346; cv=none; b=mUO14aUuWWA4EeJnFiINgGKrOXFgKF0H0VUg9bcOP2JEWjtDTRz5Ws+fgQKyLyHemPrxv+gTEG4ZplzACJVEcY5sUHuUwbMImAWm+5Ujx4+gXPZCSS88ChAqe8/p+DU8yf7zrtsxK2135dgb+SqrnxTIFPOTFN033r+5pa+jZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197346; c=relaxed/simple;
	bh=aUfCvghQl/ZChtCIkP6PVkVCfuJMS0qHqltd5CaS2eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXPHHPli3NDir8wGpiFnFyezBYrCrjZOS6hIik0+dPU13vhMurT5hw26Oik9ng0C4Vmc3q5g9QKRaYxTrXqrpGDoOPdwtgbDxHLuu3zro7VW190NQB5GWxNVxqLVXZakfv3CbNbIzw0Y8CtOEBdIuJQhx99dqUiAGiVbzoIRG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIcgx+Zt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779197343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HemROw5eZfm9qZYYG1ru2tUaiNrpeY5fpyXTbpzGJg=;
	b=dIcgx+ZtZ/UEj3HtqXSvK5cnnSbbyuwRzOKX4fUKD3aRA25zipstWRVApvpkQK9l2Mo2VI
	ZRBDhHYW/5m3dkUMzSRLkBnqryYkUEURz4/SZA8hedHlm075H6LBhZWMt7Q7NCFxIXYLbV
	SkHgFy2CGbb46/eBaVAO9BoFXSBoHdg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-zyPlOsJ4OdyVjgvMp6zDBg-1; Tue,
 19 May 2026 09:28:57 -0400
X-MC-Unique: zyPlOsJ4OdyVjgvMp6zDBg-1
X-Mimecast-MFC-AGG-ID: zyPlOsJ4OdyVjgvMp6zDBg_1779197330
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 855521956054;
	Tue, 19 May 2026 13:28:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21A5F19560A2;
	Tue, 19 May 2026 13:28:44 +0000 (UTC)
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
Subject: Re: [PATCH net-next v10 1/6] net: mana: Create separate EQs for each vPort
Date: Tue, 19 May 2026 15:28:25 +0200
Message-ID: <20260519132825.172490-1-pabeni@redhat.com>
In-Reply-To: <20260515040508.491748-2-longli@microsoft.com>
References: <20260515040508.491748-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11026-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 692AA57FCC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mana: Create separate EQs for each vPort

This patch moves EQ allocation from per-device to per-vPort, exports
mana_create_eq()/mana_destroy_eq() for use by the RDMA driver, takes
a vport reference for RSS QPs, and adds cross-port PD-sharing
rejection for raw QPs along with serialization between
mana_set_channels() and the RDMA vport configuration.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index ac5e75dd3494..f8a9013f0ca3 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -40,13 +42,27 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>  
>  	pd->vport_use_count++;
>  	if (pd->vport_use_count > 1) {
> +		/* Reject cross-port PD sharing. EQs and vport config
> +		 * are per-port, so the PD must stay bound to the port
> +		 * that was configured on the first raw QP creation.
> +		 */
> +		if (pd->vport_port != port) {
> +			pd->vport_use_count--;
> +			mutex_unlock(&pd->vport_mutex);
> +			ibdev_dbg(&dev->ib_dev,
> +				  "PD already bound to port %u\n",
> +				  pd->vport_port);
> +			return -EINVAL;
> +		}
>  		ibdev_dbg(&dev->ib_dev,
>  			  "Skip as this PD is already configured vport\n");
>  		mutex_unlock(&pd->vport_mutex);
>  		return 0;
>  	}
>  
> -	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id);
> +	pd->vport_port = port;
> +
> +	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id, true);
>  	if (err) {
>  		pd->vport_use_count--;
>  		mutex_unlock(&pd->vport_mutex);

[Low]
In the failure path of mana_ib_cfg_vport(), if mana_cfg_vport() or the
later mana_create_eq() fails, vport_use_count is rolled back to 0 but
pd->vport_port keeps the value just written.

Is the contract that pd->vport_port is only meaningful while
vport_use_count > 0?  That invariant is not documented in the struct
mana_ib_pd comment, and a future reader who consults pd->vport_port
without first checking vport_use_count under vport_mutex would see stale
data.  Would it be worth either resetting pd->vport_port on the rollback
path or documenting the rule explicitly?

> @@ -55,15 +71,23 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>  		return err;
>  	}
>  
> -	mutex_unlock(&pd->vport_mutex);
>  
> -	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
> -	pd->tx_vp_offset = mpc->tx_vp_offset;
> +	err = mana_create_eq(mpc);
> +	if (err) {
> +		mana_uncfg_vport(mpc);
> +		pd->vport_use_count--;
> +	} else {
> +		pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
> +		pd->tx_vp_offset = mpc->tx_vp_offset;
> +	}

[ ... ]

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 0fbcf449c134..108ec4c5ce51 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -155,6 +156,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  
>  	qp->port = port;
>  
> +	/* Take a reference on the vport to ensure EQs outlive this QP.
> +	 * The vport must already be configured by a raw QP.
> +	 */
> +	mutex_lock(&mana_pd->vport_mutex);
> +	if (!mana_pd->vport_use_count) {
> +		mutex_unlock(&mana_pd->vport_mutex);
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +	mana_pd->vport_use_count++;
> +	mutex_unlock(&mana_pd->vport_mutex);
> +

[Critical]
The cross-port PD-sharing check added to mana_ib_cfg_vport() is not
mirrored here.  mana_ib_create_qp_rss() takes the user-supplied port
from ucmd.port and only checks that vport_use_count is non-zero, so the
RSS path will happily attach to a different port than the one bound to
the PD by the first raw QP.

If a user creates a raw QP on port A (which sets pd->vport_port=A and
allocates mpc_A->eqs via mana_create_eq()), then creates an RSS QP on
the same PD with ucmd.port=B where port B has no Ethernet up and no
RDMA activity, mpc_B->eqs is NULL.  The subsequent code in this same
function:

	eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
	cq_spec.attached_eq = eq->eq->id;

would then dereference NULL through mpc_B->eqs.

If port B does have Ethernet up, mpc_B->eqs is owned by the Ethernet
driver and the RSS QP attaches to those EQs.  When the QP is destroyed
mana_ib_destroy_qp_rss() calls mana_ib_uncfg_vport(mdev, pd, qp->port=B),
and once pd->vport_use_count reaches 0 mana_ib_uncfg_vport() will run
mana_destroy_eq(mpc_B) on Ethernet's live EQs and call mana_uncfg_vport
on a port whose apc->vport_use_count was never incremented by this PD,
tripping the WARN_ON in mana_uncfg_vport() and corrupting Ethernet's
vport state.  Meanwhile port A's EQs and vport configuration are leaked
because nothing on this PD will destroy them.

Should mana_ib_create_qp_rss() apply the same pd->vport_port == port
check that mana_ib_cfg_vport() now performs, before bumping
vport_use_count?

[Medium]
The new "vport must already be configured by a raw QP" requirement is a
visible uAPI change.  Before this patch, EQs were allocated device-wide
on mana_context at probe time, so an RSS QP could be created without any
prior raw QP on the PD.  After the patch, applications that legitimately
use only RSS QPs (RX-only RDMA workloads) will see -EINVAL here unless
they also create a raw QP first.

Was breaking the RSS-only case considered, and would lazy EQ creation on
the first QP regardless of type be feasible to avoid the
incompatibility?

>  	for (i = 0; i < ind_tbl_size; i++) {
>  		struct mana_obj_spec wq_spec = {};
>  		struct mana_obj_spec cq_spec = {};
> @@ -171,13 +184,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		cq_spec.gdma_region = cq->queue.gdma_region;
>  		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
>  		cq_spec.modr_ctx_id = 0;
> -		eq = &mpc->ac->eqs[cq->comp_vector];
> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
>  		cq_spec.attached_eq = eq->eq->id;

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 04350973e19e..4633acc976f0 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -462,10 +467,22 @@ static int mana_set_channels(struct net_device *ndev,
>  	unsigned int new_count = channels->combined_count;
>  	unsigned int old_count = apc->num_queues;
>  	int err;
>  
> +	/* Set channel_changing to block RDMA from grabbing the vport
> +	 * during the detach/attach window. mana_cfg_vport() checks
> +	 * this flag under vport_mutex and returns -EBUSY if set.
> +	 */
> +	mutex_lock(&apc->vport_mutex);
> +	if (!apc->port_is_up && apc->vport_use_count) {
> +		mutex_unlock(&apc->vport_mutex);
> +		return -EBUSY;
> +	}
> +	apc->channel_changing = true;
> +	mutex_unlock(&apc->vport_mutex);

[Low]
The commit message says:

    When the port is down, apc->vport_mutex is held for the entire
    operation since mana_detach()/mana_attach() do not take vport_mutex
    in that case. When the port is up, Ethernet owns the vport
    exclusively so no additional locking is needed.

Does this description match the code?  mana_set_channels() drops
apc->vport_mutex immediately after setting channel_changing=true and
runs mana_pre_alloc_rxbufs(), mana_detach() and mana_attach() without
the mutex held, then re-acquires the mutex only at the end to clear the
flag.

The actual serialization mechanism is the channel_changing boolean
checked by mana_cfg_vport() under vport_mutex, not a long mutex hold.
Could the commit message be updated to match the implemented design so
that future readers do not assume a different invariant?
-- 
This is an AI-generated review.


