Return-Path: <linux-hyperv+bounces-10579-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z+DfL7cX9mlQSQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10579-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:26:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A464B2980
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 990923004C3F
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3593336882;
	Sat,  2 May 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7d9m0q5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF1A9F8D;
	Sat,  2 May 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777735602; cv=none; b=e+HSbHT95/TixqAR41DmU6JsoG0+5NWFPt08jjsm4KzNLg9YWrfyCbMOFN+WNmdkF8q9eFDL5mdMcwKnkAEqIGN4FlCTuaBrI//FSqZyvgHueGGYiBEY1Q+dN51HkqNL84AmmtwqFYGc0jq5ukbigM9SQ+aCNc0BUkghK9Fb1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777735602; c=relaxed/simple;
	bh=SheQN8rmthb94Gq8c40zeewK7HYzbJWGeqJFZU+aUW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6NwFgZDRHfZVYABqp5gWTOdrU5c1AnsMX80nugb3Ex3/eZ2SOYdHt0813gfQDtTvMH76BQLMLyI6+7hKTpyvXTcitj/2SkUJyZXdE45uCgkf9xSmRv//o3aoQqg15CWLCZQgTcncM2QczY4AE0RdQb7fKRZsxh/q9RFeP4EfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7d9m0q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BD3C19425;
	Sat,  2 May 2026 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777735602;
	bh=SheQN8rmthb94Gq8c40zeewK7HYzbJWGeqJFZU+aUW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7d9m0q5kI/2kINLnLXgpwvtlTRfOVrkIwcN90A5/hZKreGUEgawWm5GVNMIrRN1b
	 H8Dj5+Cm40OImDwmmy+UW7Bzm4AT+U48SNZeZrzNbBawyYzGEH0HZ+RBou1HTLBmJv
	 Ui/5lHCaHcRQhSSzqmnwSxw1Ju5Kw0MA+FNByGdfbXFM5+rulklaVAzSelksybc1nk
	 6iit0CZ3OCQAtECSt1WyXXHSFjH/nGcAEEncY4GCzJoosEsky+ZjQ67bgLyclvFXrS
	 TMwV95/z65gxgZ7cBW0Ky69ct9lDBsbeZC/1+ih39ouzepBtIqaSigm+Dn39lxA7Jj
	 6HWuXyT+Lfgdw==
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: 'Simon Horman' <horms@kernel.org>,
	kotaranov@microsoft.com,
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
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/6] net: mana: Create separate EQs for each vPort
Date: Sat,  2 May 2026 16:23:55 +0100
Message-ID: <20260502152354.289044-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429221625.1841150-2-longli@microsoft.com>
References: <20260429221625.1841150-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10A464B2980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10579-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: mana: Create separate EQs for each vPort

This change moves EQ ownership from struct mana_context to struct
mana_port_context so each vPort can have dedicated EQs, and exports
mana_create_eq()/mana_destroy_eq() for use by the MANA RDMA driver.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index ac5e75dd3494..60cc02e4ad10 100644
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
> @@ -55,15 +57,21 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
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
> +
> +	mutex_unlock(&pd->vport_mutex);
>  
>  	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
>  		  mpc->port_handle, pd->pdn, doorbell_id);

On the failure path, mana_uncfg_vport() is called and pd->vport_use_count
is decremented, but execution falls through to the ibdev_dbg() line that
prints the vport handle as if it were a success. Should this debug print
be skipped on the error path so logs are not ambiguous?

Also, pd->tx_shortform_allowed and pd->tx_vp_offset are assigned from mpc
before the mana_create_eq() attempt and are not cleared when that call
fails. Callers are expected to gate on pd->vport_use_count, but is it
worth resetting these fields on failure so the state matches the
pre-patch behavior?

The mutex_unlock(&pd->vport_mutex) has moved from before the field
assignments to after mana_create_eq(). That now holds pd->vport_mutex
across GFP_KERNEL allocations, debugfs directory creation, and multiple
mana_gd_create_mana_eq() firmware RPCs, and establishes the lock order
pd->vport_mutex -> apc->vport_mutex via mana_uncfg_vport() on the error
path. Is the extended critical section intentional?

>  
> -	return 0;
> +	return err;
>  }
>  
>  int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
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

Can the mpc->eqs read race with a concurrent free? mana_ib_create_qp_rss()
runs without pd->vport_mutex or RTNL, but mpc->eqs is freed by
mana_destroy_eq() from two paths:

  mana_ib_uncfg_vport()   (under pd->vport_mutex, on last raw-QP destroy)
  mana_dealloc_queues()   (under RTNL, on netdev down)

both of which do:

  kfree(apc->eqs);
  apc->eqs = NULL;

with no RCU grace period or reader-visible synchronization. If CPU-A
passes the !mpc->eqs check after CPU-B begins ip link set dev X down,
does CPU-A then dereference freed memory via mpc->eqs[...].eq->id?

Separately, what populates mpc->eqs for an RDMA-only RSS QP user on a
probed-but-idle Ethernet port? Pre-patch mana_probe() called
mana_create_eq(ac) unconditionally, so ac->eqs existed for the device
lifetime. After this patch the only creators are mana_alloc_queues()
(Ethernet up) and mana_ib_cfg_vport() (raw QP). An RDMA application that
uses only RSS QPs and never creates a raw QP will now get -EINVAL here
where it used to succeed. Is this intended, and should the commit log
mention it?

The adjacent comment:

   /* EQs are created when a raw QP configures the vport.
    * A raw QP must be created before creating rwq_ind_tbl.
    */

omits the Ethernet-up path that also populates mpc->eqs. Would it be
clearer to describe both creators?

There is also a behavior change in the index expression:

   eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];

Pre-patch this was ac->eqs[cq->comp_vector] sized by gc->max_num_queues.
Now comp_vector is folded modulo mpc->num_queues, which is tunable via
ethtool -L. Userspace that used distinct comp_vector values to hit
distinct EQs will silently alias when comp_vector >= num_queues. Should
this be documented or rejected with -EINVAL rather than silently
wrapped?

Can mpc->num_queues be 0 at this point? mana_set_channels() does not
reject new_count==0, and kzalloc_objs(struct mana_eq, 0) returns
ZERO_SIZE_PTR, which passes the !mpc->eqs check. During the window
between mana_create_eq() and the subsequent netif_set_real_num_tx_queues()
failing, a concurrent RDMA QP create would compute
cq->comp_vector % 0 here. Should mpc->num_queues be validated alongside
mpc->eqs?

The placement of the !mpc->eqs check is inside the per-iteration loop
over ind_tbl_size, but mpc->eqs cannot change across iterations, so the
check is only meaningful at i==0. It works today because i-- then makes
i = -1 and the cleanup while (i-- > 0) skips. Would hoisting the check
above the loop be clearer and less fragile against refactoring?

>  		cq_spec.attached_eq = eq->eq->id;
>  
>  		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
> @@ -317,7 +325,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>  	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
>  	cq_spec.modr_ctx_id = 0;
>  	eq_vec = send_cq->comp_vector;
> -	eq = &mpc->ac->eqs[eq_vec];
> +	if (!mpc->eqs) {
> +		err = -EINVAL;
> +		goto err_destroy_queue;
> +	}
> +	eq = &mpc->eqs[eq_vec % mpc->num_queues];

The same mpc->eqs TOCTOU concern applies here: the check and subsequent
dereference occur without pd->vport_mutex or RTNL held, so a concurrent
mana_dealloc_queues() on the Ethernet side can free mpc->eqs between the
check and the index access. Is there synchronization that prevents this?

The same comp_vector % num_queues aliasing and num_queues==0 divide
concerns apply here as well.

>  	cq_spec.attached_eq = eq->eq->id;
>  
>  	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a654b3699c4c..6c709f8b875d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

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

WARN_ON(apc->eqs) is used as a defensive assertion but execution
proceeds to overwrite apc->eqs unconditionally. If the invariant is
violated, the previous array and all HW EQs it referenced are leaked.
Should this instead bail out with an error or call mana_destroy_eq()
first to keep the function idempotent against future callers?

[ ... ]

> @@ -3326,6 +3349,9 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	mana_fence_rqs(apc);
>  
>  	/* Even in err case, still need to cleanup the vPort */
> +	mana_destroy_rxqs(apc);
> +	mana_destroy_txq(apc);
> +	mana_destroy_eq(apc);
>  	mana_destroy_vport(apc);

What is the intended interaction with outstanding RDMA QPs here? An
RDMA user that created an RSS QP while the Ethernet netdev was up sees
mpc->eqs populated by mana_alloc_queues(). When the admin issues
ip link set dev N down, mana_dealloc_queues() -> mana_destroy_eq()
destroys those EQs and frees mpc->eqs while the RDMA QPs are still
alive, leaving the QPs with dangling attached_eq IDs at the hardware
level and stale kernel references.

Pre-patch ac->eqs lived for the full mana_context lifetime and was torn
down only in mana_remove(). Is unconditionally destroying the EQs on
netdev-down the intended new behavior, and if so how are concurrent
RDMA consumers expected to recover?

>  	return 0;
>  }

