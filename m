Return-Path: <linux-hyperv+bounces-10791-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFrAN9aNAmqXuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10791-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:17:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDC518D70
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D03483094889
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4633858B;
	Tue, 12 May 2026 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVHSs2oe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5B330B2E;
	Tue, 12 May 2026 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552049; cv=none; b=rbdd4mG04Mp9iCDDySWc+a8M3M/rUh0mdjsTuk3w1OSSI0IZHiYLP7WR4WTIVr0qnthMP7AVI/Qhpb2QSejldv7ZiLm3Z6tXNSJfSJ8eYLVFK1fRZ1lAEx9Z1OzApZic5BbF0XjsuitUkKqgcCulKkCFz5IyquB1AyvWs9D6Iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552049; c=relaxed/simple;
	bh=lYSc0cG6f5CleOPGkC7RKKoeqHd1RRNl/krSvsLRj5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0O9RGsB6o5fFZhfDj8DQHvLLwS9jU5pTWKvcviSEEQpi9Hy1PLiQO7NP5qR/1bL6DtohPYoszf3ZtwnItOi8ndZU1d6SAinluZwuymUh0CfjD/aJgZ2HYspHvqHl9pXdFnb2A2jIojWd5D86irRsDNEbGohyNcKDldJ5X0cX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVHSs2oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7625C2BCF5;
	Tue, 12 May 2026 02:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552048;
	bh=lYSc0cG6f5CleOPGkC7RKKoeqHd1RRNl/krSvsLRj5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVHSs2oeQq9ybYV+38QTjRuSzKMoVky26um56aMfTmolmOMsAxmrf2HeKzPAU/Stj
	 9MM0oBbAAnlPXfhesaNjVvA/LCoc/wyu8Z1cTAK9PFHJ1M5r2LAWJ8Fjeg8gfym2mI
	 1iiyKRQaa6EMicGfWpQaBlViTtm0/JMZrV65SzAL+965dF52rhLyj+mVwko01mSpPU
	 Jb63UDOfhkZ1YfxP6RPnoDZNZTcrE+F14cP1EPE1g0NyjYWbf5nkIxCo5Co5ZCI62l
	 lt3PNbOymHegOwXO3zMKPDDjbXmNaWibiEI+yOXp2mctS148EabFuoMWc2Aobn2e/a
	 2FKoU4HoBeNGg==
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
Subject: Re: [PATCH net-next v7 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Mon, 11 May 2026 19:14:06 -0700
Message-ID: <20260512021406.849861-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507191237.438671-6-longli@microsoft.com>
References: <20260507191237.438671-6-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BDDC518D70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10791-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: mana: Allocate interrupt context for each EQ when creating vPort

This commit switches the vPort EQ creation path to acquire a GIC (either
dedicated or shared) for each EQ via mana_gd_get_gic()/mana_gd_put_gic(),
adds a new irq field to struct gdma_queue's EQ union and a debugfs entry
for it, and moves the msix_index invalidation out of mana_gd_deregister_irq()
into the mana_gd_create_eq() error path.

[Low]
The changelog is a single sentence, but the patch makes several coupled
changes beyond acquiring a GIC per EQ:

  - it adds a new per-EQ irq field on the shared struct gdma_queue,
  - it adds a new debugfs entry for that field,
  - it changes an invariant in gdma_main.c (see the comment on
    mana_gd_deregister_irq() below),
  - it splits the GIC lifecycle across two source files — mana_en.c now
    owns get_gic/put_gic around mana_gd_create_mana_eq(), while
    mana_gd_register_irq() is still called internally from the create path.

Could the commit message describe the resulting ownership contract
(caller holds a GIC reference across create/destroy, register_irq does
not) and justify the scope of the new field?

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 850afdbd9c4e..54127c385240 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -854,7 +854,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
>  	}
>  	spin_unlock_irqrestore(&gic->lock, flags);
>  
> -	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
>  	synchronize_rcu();
>  }

[Low]
Removing the msix_index reset from mana_gd_deregister_irq() and relocating
it to the mana_gd_create_eq() error path is the prerequisite that lets the
new mana_destroy_eq() read eq->eq.msix_index before calling
mana_gd_destroy_queue():

    msi = eq->eq.msix_index;
    mana_gd_destroy_queue(gc, eq);
    mana_gd_put_gic(gc, !gc->msi_sharing, msi);

Could the changelog mention this intentional invariant change and the
ownership contract it implies?  Any out-of-tree caller that relied on
mana_gd_deregister_irq() to invalidate msix_index will now silently observe
stale values after a normal destroy.

> @@ -969,6 +968,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
>  out:
>  	dev_err(dev, "Failed to create EQ: %d\n", err);
>  	mana_gd_destroy_eq(gc, false, queue);
> +	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
>  	return err;
>  }
>  
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2f106d6f5be4..b3684fa3eb4a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -1664,6 +1668,8 @@ int mana_create_eq(struct mana_port_context *apc)
>  	struct gdma_queue_spec spec = {};
>  	int err;
>  	int i;
> +	int msi;
> +	struct gdma_irq_context *gic;
>  
>  	WARN_ON(apc->eqs);
>  	apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
> @@ -1681,12 +1687,24 @@ int mana_create_eq(struct mana_port_context *apc)
>  						    apc->mana_port_debugfs);
>  
>  	for (i = 0; i < apc->num_queues; i++) {
> -		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
> +		msi = (i + 1) % gc->num_msix_usable;
> +		if (gc->msi_sharing)
> +			spec.eq.msix_index = msi;
> +
> +		gic = mana_gd_get_gic(gc, !gc->msi_sharing, &msi);
> +		if (!gic) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		spec.eq.msix_index = msi;

[Low]
Is the conditional write to spec.eq.msix_index dead?

    if (gc->msi_sharing)
        spec.eq.msix_index = msi;

    gic = mana_gd_get_gic(gc, !gc->msi_sharing, &msi);
    ...
    spec.eq.msix_index = msi;

The unconditional assignment after mana_gd_get_gic() always overwrites the
conditional one.  In the non-sharing case, mana_gd_get_gic() also reassigns
*msi_requested via find_first_zero_bit(), so the pre-computed
(i + 1) % gc->num_msix_usable is only consumed in the sharing branch.

Would splitting the sharing and non-sharing paths, or dropping the
conditional write entirely, make the intent clearer and avoid the
inverted-boolean fallthrough (!gc->msi_sharing)?

> +
>  		err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);
>  		if (err) {
>  			dev_err(gc->dev, "Failed to create EQ %d : %d\n", i, err);
> +			mana_gd_put_gic(gc, !gc->msi_sharing, msi);
>  			goto out;
>  		}
> +		apc->eqs[i].eq->eq.irq = gic->irq;
>  		mana_create_eq_debugfs(apc, i);
>  	}

[Low]
The new struct gdma_queue.eq.irq field is only assigned here on the vPort
path:

    apc->eqs[i].eq->eq.irq = gic->irq;

The other in-tree caller of mana_gd_create_mana_eq(), mana_ib_create_eqs()
in drivers/infiniband/hw/mana/main.c, creates EQs using the same struct
but never assigns eq.irq, leaving it zero.  No debugfs is wired up for ib
EQs today, so the zero is not user-visible, but any future consumer that
reads this field on an ib EQ will see 0 rather than the real IRQ number.

Should mana_gd_create_mana_eq() (or its callers) populate eq.irq
uniformly so the field has one well-defined meaning across all EQs?

> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index fbe3c1427b45..6c138cc77407 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -342,6 +342,7 @@ struct gdma_queue {
>  			void *context;
>  
>  			unsigned int msix_index;
> +			unsigned int irq;
>  
>  			u32 log2_throttle_limit;
>  		} eq;

