Return-Path: <linux-hyperv+bounces-9283-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDO4OdQ3sGkKhQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9283-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 16:25:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7F253541
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA4013255F30
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8582E11B8;
	Tue, 10 Mar 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg0pn7ex"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6402DCF58
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Mar 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152991; cv=none; b=Du9vfXzRE1nRCWoaNQaqrc5L6iiugn5rYe6clnr1fdQ/h+cH9QTdye8UzKw1Ewu736tvLiwa1CnBFoQMVNgpvDPhGO3X1p1bZmbHabOMNk99MaVn/lvq0pQBL3LNoTq39f4+6iyj76GSWOO9r2X5bgag942S2VySB/bfBDXp35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152991; c=relaxed/simple;
	bh=iER+Hd4+IIHZJwtIpReHWAJBLrkOCj27Ep772FXakME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBhh5sF7a8hfWr8iNPXd62ybYc3gZANl+qW8qdkPXJxj10hcPXdip1dQA0XDwi0s3t5KiltN6tJJyv3WimDkQN5Ezz26Hoq6F7P/DBDAT9lxxCMFgXqgrfOKtmf2Nv3wanRlt9X4Ov6d4Z/nOHGkhxsIa7e6ZiBVgTwQVy6p19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg0pn7ex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773152989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9Kl/AJsyijdHET1vAK8UKCGDRuKVXFmJTFZ6ZiROck=;
	b=fg0pn7exK0pdZLys4pE+CHEvQyllPJHAuczjdKM56NwotEHkWAe9AfCLwmQEvx7Sitcfrv
	8A7NQn4dMFoMcg0jz7tELcLOeknyUzLqJ0jfEhu+hot1vCORFx9hqxCVIXvSBLHoh1gUNK
	u+S4dkanH8l+X/CMzM6RRE6w5kIfaXk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-68mKelE2NYKHcD6YgGEgEg-1; Tue,
 10 Mar 2026 10:29:44 -0400
X-MC-Unique: 68mKelE2NYKHcD6YgGEgEg-1
X-Mimecast-MFC-AGG-ID: 68mKelE2NYKHcD6YgGEgEg_1773152981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 698581800359;
	Tue, 10 Mar 2026 14:29:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35D491800361;
	Tue, 10 Mar 2026 14:29:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: longli@microsoft.com
Cc: kotaranov@microsoft.com,
	erick.archer@outlook.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	decui@microsoft.com,
	schakrabarti@linux.microsoft.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next,v3,4/6] net: mana: Use GIC functions to allocate global EQs
Date: Tue, 10 Mar 2026 15:29:31 +0100
Message-ID: <20260310142931.237121-1-pabeni@redhat.com>
In-Reply-To: <20260306213302.544681-5-longli@microsoft.com>
References: <20260306213302.544681-5-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: F1A7F253541
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,outlook.com,kernel.org,vger.kernel.org,redhat.com,linux.microsoft.com,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-9283-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Use GIC functions to allocate global EQs

Replace the GDMA global interrupt setup code with the new GIC allocation
and release functions for managing interrupt contexts.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index c43fd8089e77..bdc9dc437fb7 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> @@ -2052,26 +1998,17 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
>  static void mana_gd_remove_irqs(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
> -	struct gdma_irq_context *gic;
>  	int irq, i;
>
>  	if (gc->max_num_msix < 1)
>  		return;
>
> -	for (i = 0; i < gc->max_num_msix; i++) {
> -		irq = pci_irq_vector(pdev, i);
> -		if (irq < 0)
> -			continue;
> -
> -		gic = xa_load(&gc->irq_contexts, i);
> -		if (WARN_ON(!gic))
> -			continue;
> -
> +	for (i = 0; i < (gc->msi_sharing ? gc->max_num_msix : 1); i++) {
                                                               ^^^
Does this loop condition leak GIC references when msi_sharing is false?

When msi_sharing is false, the loop only releases the GIC at index 0.
However, mana_gd_setup_dyn_irqs allocates GICs at indices 1 through nvec:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_setup_dyn_irqs() {
    for (i = 1; i <= nvec; i++) {
        gic = mana_gd_get_gic(gc, false, &i);
        ...
    }
}

Each mana_gd_get_gic call initializes the GIC with refcount=1. These GICs
at indices 1..nvec are never released because mana_gd_remove_irqs only
processes index 0 when msi_sharing is false.

The old code iterated over all gc->max_num_msix entries unconditionally:

    for (i = 0; i < gc->max_num_msix; i++) {
        ...
        gic = xa_load(&gc->irq_contexts, i);
        ...
        free_irq(irq, gic);
        xa_erase(&gc->irq_contexts, i);
        kfree(gic);
    }

This ensured every allocated GIC was freed. The new code with the
conditional loop breaks this, resulting in:

1. Leaked IRQ handlers - request_irq without matching free_irq for indices
   1..nvec
2. Leaked gdma_irq_context memory - the GIC structures are never freed
3. Leaked xarray entries - the entries remain in gc->irq_contexts

Additionally, pci_free_irq_vectors is called immediately after the loop,
which attempts to tear down MSI-X vectors while IRQ handlers at indices
1..nvec are still registered. Can this trigger warnings or use-after-free
if an interrupt fires during teardown?

The next commit in the series (4475f13983ab "net: mana: Allocate interrupt
context for each EQ when creating vPort") adds per-EQ get/put of GICs,
but the EQ teardown only drops the EQ's reference (refcount goes from 2 to
1). The base reference from mana_gd_setup_dyn_irqs remains unreleased.

>  		/* Need to clear the hint before free_irq */
> +		irq = pci_irq_vector(pdev, i);
>  		irq_update_affinity_hint(irq, NULL);
> -		free_irq(irq, gic);
> -		xa_erase(&gc->irq_contexts, i);
> -		kfree(gic);
> +
> +		mana_gd_put_gic(gc, false, i);
>  	}
>
>  	pci_free_irq_vectors(pdev);


