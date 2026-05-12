Return-Path: <linux-hyperv+bounces-10794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL8TKT+NAmpouQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10794-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:15:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E9518CB3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5456930095C5
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169B3358C6;
	Tue, 12 May 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV5YH/cu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE373112D0;
	Tue, 12 May 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552076; cv=none; b=lCS1cFDzTp8qR7mcC4n0nxIXmXY8OjySOb9RZBYnwmG7vbRHSdwCYEB0wnSeTlpqUsDbUQoECJoSej6T053fiWuO+95tC64oxTYj9VYJLfaQ3ARWJTvk2yrL7X8r+IpS9DSJBsh1+8KjaLQm76vR68SWKjOwRKCPWb8rzHxP28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552076; c=relaxed/simple;
	bh=Wx8G3463DDT01gfT3VriWq79eK5UV9JoQSE6blIPLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZHdgzoZMq9HCqpRr54K6BiM9KzTXU5w5qJCTpgqZNXBQqTWNLdz6GUYgPwfrdA5txww8vms36jioBZ4lOrj6OvyRN/xErjNfKuuNsgb2TOszl2mBhgdrLxkOs3v1IxEPcwOPOpZLkQ3nlZFC/bD63+UzC2Cy7XCbRgJ/DfQPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV5YH/cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D64C2BCB0;
	Tue, 12 May 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552076;
	bh=Wx8G3463DDT01gfT3VriWq79eK5UV9JoQSE6blIPLpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qV5YH/cu5J0U431PMdHo7P6ja8YrI7RfJ08NFRJ8OC/15qeZ+8vygQYUm1BQm9Bal
	 +Nc8UynRScDB1XbbaQD+EB77W+q2ej4OZCyj1LXzQQ14tMBpBlowCGwYp2oG21g77J
	 9o5r+oYhvn4A0txqzHxOlXm259PRw+eArAdwPZDHaTucCzORx0ZKP1IdQPNg5afo6T
	 rmmht0ZQWKba18X+SWmV3T6I2EHomqiSDPdmPGxs0nHFlJ9G6R/Qzq+QybmcP8fBYz
	 4YO24UigfLykG1p5/55agWb+/6HU2UNTqcPmJhzk08fcFFXioltez90UYhw4XwTfBi
	 7eF+nm9/bUQMQ==
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
Date: Mon, 11 May 2026 19:14:34 -0700
Message-ID: <20260512021434.850127-1-kuba@kernel.org>
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
X-Rspamd-Queue-Id: A38E9518CB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-10794-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pci:email]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Use GIC functions to allocate global EQs

This commit replaces the GDMA global interrupt setup code with the new GIC
allocation and release functions to manage interrupt contexts via refcounting.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 81bf379283663..72a67b0b2b5d4 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1918,30 +1918,13 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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

Does moving the name generation into mana_gd_get_gic() unintentionally change
the IRQ names exposed in /proc/interrupts?

In mana_gd_get_gic(), the names are now generated as "mana_msi%d" using the
raw MSI index:

	if (!gic->msi)
		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
			 pci_name(dev));
	else
		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_msi%d@pci:%s",
			 gic->msi, pci_name(dev));

This could break userspace tooling (like irqbalance or monitoring scripts) that
might rely on parsing the "mana_q*" pattern to bind network queues.

[ ... ]

> @@ -1963,19 +1946,11 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
>  	kfree(irqs);
>  	return err;

[ ... ]

> @@ -2139,26 +2085,20 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
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

Is it safe to unconditionally call irq_update_affinity_hint() in these cleanup
paths?

Now that IRQs can be shared and are reference counted via mana_gd_put_gic(),
unconditionally clearing the affinity hint here could disrupt the routing for
any remaining active users sharing this IRQ. mana_gd_put_gic() already clears
the affinity hint internally when the refcount reaches zero.

Also, since the "if (irq < 0)" check was removed in mana_gd_remove_irqs(), if
pci_irq_vector() returns a negative error like -EINVAL, we would pass a
negative value to irq_update_affinity_hint(), which expects an unsigned int.

