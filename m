Return-Path: <linux-hyperv+bounces-10790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJYUO6eNAmqXuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10790-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:17:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99278518D58
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 663273082A36
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F533D4FD;
	Tue, 12 May 2026 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAmL6R5J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59027314A6B;
	Tue, 12 May 2026 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552046; cv=none; b=kdvth70gdn3ROyilG1Jp0Huj5MT90r1cwDhFgtVUeZe/2BBR9wd/H/4KAWcUFYvuTv9LJZqjIRkFVnsafzrSX8L2BRHIUUpYnCNIMqfZLsRuNCgTPd09imWRKeqrNpcJtm+Je6/+VJy2+GF8f+UQhkXS83BF1+eQfmo9lZT4fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552046; c=relaxed/simple;
	bh=AltVCeLpOU+QIabG4kSQ+AYcylfY1UCJb6hIHmqzcv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2T3m/KPneO+jDQMwBSk5yhlk6Etzioqwg7r5hJ+tgzhyPfafFUv++zL1nGLt7O4Q14CXlsSHcB+un2v7b76XxYP2GeE71RAkHbj8NFclymuhStpX2qzsfHHiJGD5UBFs4tGVeTMO78UcEDSfGb1nZhehOPPJHBWCEvXkMCWYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAmL6R5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721DCC2BCF7;
	Tue, 12 May 2026 02:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552046;
	bh=AltVCeLpOU+QIabG4kSQ+AYcylfY1UCJb6hIHmqzcv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAmL6R5JOoh4fgwlWj7xLCx0RCyX4HgWIxHj4jyiiEhgX2Qx7EmMaGuIlxvpCXpQU
	 KFgUQ8W5YNOES+lBPew7OKGphfXpU+EhYqFp/y+MoCc0yFH7HiEDYprrsmWzcEdewV
	 22r+/0SjzzSaZb3ujoiBclk//Q3gT7+HvTZye8ZxHSGMLjJhZm+dAft9BzBkLAMlhZ
	 BM/3ADBxZ86bHLUBvQh++m4e5cZYVGd76lnJe2GNOHDe2WKTGFdKAWG+dLacK2kV08
	 JvOa9MWdaQWo+t5kj0qgfpxfbbVoa0TbRdzeDlfLwmuiCVR5TToCMdrgg6/6i24bjC
	 YmvMwuzxVkW4w==
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
Subject: Re: [PATCH net-next v7 4/6] net: mana: Use GIC functions to allocate global EQs
Date: Mon, 11 May 2026 19:14:04 -0700
Message-ID: <20260512021404.849840-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507191237.438671-5-longli@microsoft.com>
References: <20260507191237.438671-5-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99278518D58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-10790-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pci:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Use GIC functions to allocate global EQs

This patch replaces the inline GDMA global interrupt setup in
mana_gd_setup_dyn_irqs(), mana_gd_setup_irqs(), and mana_gd_remove_irqs()
with calls to the new mana_gd_get_gic()/mana_gd_put_gic() helpers
introduced in the preceding patch.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 5930ab817056..850afdbd9c4e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1888,30 +1888,13 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	 * further used in irq_setup()
>  	 */
>  	for (i = 1; i <= nvec; i++) {
> -		gic = kzalloc_obj(*gic);
> +		gic = mana_gd_get_gic(gc, false, &i);
>  		if (!gic) {
>  			err = -ENOMEM;
>  			goto free_irq;
>  		}
> -		gic->handler = mana_gd_process_eq_events;
> -		INIT_LIST_HEAD(&gic->eq_list);
> -		spin_lock_init(&gic->lock);
> -
> -		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> -			 i - 1, pci_name(pdev));

[Low]
Before this patch the per-queue interrupts in mana_gd_setup_dyn_irqs()
and mana_gd_setup_irqs() were named as:

    "mana_q%d@pci:%s", i - 1, pci_name(pdev)

so they appeared as mana_q0, mana_q1, ... in /proc/interrupts.

After this patch, allocation goes through mana_gd_get_gic(), which
names them using gic->msi (equal to i, not i - 1):

    snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_msi%d@pci:%s",
             gic->msi, pci_name(dev));

so the same vectors now appear as mana_msi1, mana_msi2, ...  The
mana_hwc@pci:%s name is preserved, but every per-queue vector is both
renamed (mana_q -> mana_msi) and renumbered (0-based -> 1-based).

Is this rename intentional?  The commit message describes the change
as replacing "the GDMA global interrupt setup code with the new GIC
allocation and release functions", which reads as a pure refactor.  If
the rename is intended, could it be mentioned in the changelog so that
operators relying on the mana_q prefix in /proc/interrupts are not
surprised?

> -
> -		/* one pci vector is already allocated for HWC */
> -		irqs[i - 1] = pci_irq_vector(pdev, i);
> -		if (irqs[i - 1] < 0) {
> -			err = irqs[i - 1];
> -			goto free_current_gic;
> -		}
> -
> -		err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
> -		if (err)
> -			goto free_current_gic;
>  
> -		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
> +		irqs[i - 1] = gic->irq;
>  	}
>  
>  	/*
> @@ -1933,19 +1916,11 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	kfree(irqs);
>  	return 0;
>  
> -free_current_gic:
> -	kfree(gic);
>  free_irq:
>  	for (i -= 1; i > 0; i--) {
>  		irq = pci_irq_vector(pdev, i);
> -		gic = xa_load(&gc->irq_contexts, i);
> -		if (WARN_ON(!gic))
> -			continue;
> -
>  		irq_update_affinity_hint(irq, NULL);
> -		free_irq(irq, gic);
> -		xa_erase(&gc->irq_contexts, i);
> -		kfree(gic);
> +		mana_gd_put_gic(gc, false, i);
>  	}

[Low]
Is the irq_update_affinity_hint(irq, NULL) call here still needed?

Looking at mana_gd_put_gic():

    if (!refcount_dec_and_test(&gic->refcount))
            goto out;

    irq = gic->irq;

    irq_update_affinity_hint(irq, NULL);
    free_irq(irq, gic);

When the last reference is dropped (which is the case on every caller in
this patch, since the refcount is 1 here), the helper already clears the
affinity hint before calling free_irq().  The explicit call in the caller
duplicates that work.

The duplication is harmless today because irq_update_affinity_hint() is
idempotent, but could the clearing of the affinity hint be left entirely
to mana_gd_put_gic()?  Otherwise, if these helpers are ever reused in a
context where the refcount is greater than one, the caller will clear an
affinity hint that the helper would correctly have left intact.

> @@ -1966,34 +1941,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
>  	start_irqs = irqs;
>  
>  	for (i = 0; i < nvec; i++) {
> -		gic = kzalloc_obj(*gic);
> +		gic = mana_gd_get_gic(gc, false, &i);
>  		if (!gic) {
>  			err = -ENOMEM;
>  			goto free_irq;
>  		}
>  
> -		gic->handler = mana_gd_process_eq_events;
> -		INIT_LIST_HEAD(&gic->eq_list);
> -		spin_lock_init(&gic->lock);
> -
> -		if (!i)
> -			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
> -				 pci_name(pdev));
> -		else
> -			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> -				 i - 1, pci_name(pdev));

[Low]
The same rename applies here for the non-HWC vectors (mana_q%d with
i - 1 becomes mana_msi%d with i inside mana_gd_get_gic()).  Could the
commit message note this user-visible change in /proc/interrupts?

[ ... ]

> @@ -2022,19 +1976,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
>  	kfree(start_irqs);
>  	return 0;
>  
> -free_current_gic:
> -	kfree(gic);
>  free_irq:
>  	for (i -= 1; i >= 0; i--) {
>  		irq = pci_irq_vector(pdev, i);
> -		gic = xa_load(&gc->irq_contexts, i);
> -		if (WARN_ON(!gic))
> -			continue;
> -
>  		irq_update_affinity_hint(irq, NULL);
> -		free_irq(irq, gic);
> -		xa_erase(&gc->irq_contexts, i);
> -		kfree(gic);
> +		mana_gd_put_gic(gc, false, i);
>  	}

[Low]
Same observation as in mana_gd_setup_dyn_irqs(): the explicit
irq_update_affinity_hint(irq, NULL) duplicates what
mana_gd_put_gic() already does when it drops the last reference.  Could
this call be dropped from the caller?

> @@ -2109,26 +2055,20 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
>  static void mana_gd_remove_irqs(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> -	struct gdma_irq_context *gic;
>  	int irq, i;
>  
>  	if (gc->max_num_msix < 1)
>  		return;
>  
>  	for (i = 0; i < gc->max_num_msix; i++) {
> -		irq = pci_irq_vector(pdev, i);
> -		if (irq < 0)
> -			continue;
> -
> -		gic = xa_load(&gc->irq_contexts, i);
> -		if (WARN_ON(!gic))
> +		if (!xa_load(&gc->irq_contexts, i))
>  			continue;
>  
>  		/* Need to clear the hint before free_irq */
> +		irq = pci_irq_vector(pdev, i);
>  		irq_update_affinity_hint(irq, NULL);
> -		free_irq(irq, gic);
> -		xa_erase(&gc->irq_contexts, i);
> -		kfree(gic);
> +
> +		mana_gd_put_gic(gc, false, i);
>  	}

[Low]
Same pattern in mana_gd_remove_irqs(): the comment says "Need to clear
the hint before free_irq", but the actual free_irq() now happens inside
mana_gd_put_gic(), which itself calls irq_update_affinity_hint(irq, NULL)
right before free_irq().  Could the explicit call (and comment) be
removed so that the affinity-hint clearing lives in one place?

