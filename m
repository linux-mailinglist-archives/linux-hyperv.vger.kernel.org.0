Return-Path: <linux-hyperv+bounces-10792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AVmG/2NAmqXuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10792-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:18:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA37518D96
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA40130A4B57
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87132143F;
	Tue, 12 May 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rif4dKnu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B013126B1;
	Tue, 12 May 2026 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552053; cv=none; b=hM3sMerFaRv/rrefOZs+9T0BO7WTKa6fU7r/AQiNepiLz5ngBrEeEo6UCclF71aR59s3IvvPetrDPEDmfQuL0xMBghVXYgEFqvJv+h0ek/WSvGp7tBAKTwO8WRBQPnMhFV7TDdnstAYvLznoWgy8UVkKjA9l67kUMNQwQZ3oZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552053; c=relaxed/simple;
	bh=TzPMlc+GMzKat9s5hcjPRqQX3/78TObzdSd8cm6c6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ9rLotv3Mk3ct32QkGnWAi8L0INMfo6s/DOvd5FWKnYp5DcbxbvFaFGApAbG6kVan9swqVsEJjBlBVmRGVrnolgtyC82ELwY+/oia+skpe8xMF55dcvgi7aZSi/X8rSF5DPqfQ7NNV2qDVDqXOHqX+x6iYa9J7x+CEjYQ3Qvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rif4dKnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B47C2BCB0;
	Tue, 12 May 2026 02:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552050;
	bh=TzPMlc+GMzKat9s5hcjPRqQX3/78TObzdSd8cm6c6/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rif4dKnugqGi0gnhrj1e9lHRdSpe03ttlLdg7nzbK9NRDboQiS73VRHgVQmAOykXT
	 f+hsTADmekBayEVJY+LnoghCuYA3CqhY1Gvr/YIydglh5cY1jD/F48zbCqhJzNlGxg
	 U83VBsaZOZYUJjyEP76/rlvCV5xuCjrXaYvbGDtiRr8pepJTHIcsi92iL/G/FAPFyV
	 rbviVb0810yVvofJh96ha3z1rqgI2rDRaVX8T6dK2KnK/42FPOVEfS4y1R53ZliTOl
	 jzqLamZsVGXYLQqDKGYE64UzFKbiQBwywYqs5Ho2VT49Has/oI0DqTAOzjKk4o3sKi
	 0itXPPi2602Kw==
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
Subject: Re: [PATCH net-next v7 6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
Date: Mon, 11 May 2026 19:14:08 -0700
Message-ID: <20260512021408.850000-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507191237.438671-7-longli@microsoft.com>
References: <20260507191237.438671-7-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AA37518D96
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
	TAGGED_FROM(0.00)[bounces-10792-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: RDMA/mana_ib: Allocate interrupt contexts on EQs

This patch converts RDMA/mana_ib EQ creation to use the shared GIC
allocator (mana_gd_get_gic/mana_gd_put_gic), allowing the RDMA EQs
to share interrupt contexts with the Ethernet driver's EQs. It also
adds a new driver capability bit and sets it in the advertised flags.

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 8000ab6e8beb..0dc47540fb6f 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -749,7 +749,8 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
>  {
>  	struct gdma_context *gc = mdev_to_gc(mdev);
>  	struct gdma_queue_spec spec = {};
> -	int err, i;
> +	struct gdma_irq_context *gic;
> +	int err, i, msi;
>  
>  	spec.type = GDMA_EQ;
>  	spec.monitor_avl_buf = false;
> @@ -757,11 +758,18 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
>  	spec.eq.callback = mana_ib_event_handler;
>  	spec.eq.context = mdev;
>  	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
> -	spec.eq.msix_index = 0;
> +
> +	msi = 0;
> +	gic = mana_gd_get_gic(gc, false, &msi);

[Low]
The commit message states "The driver now supports allocating dedicated
MSI-X for each EQ", and the new capability bit added below is named
GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT. Does that description
match what this code does?

The calls here pass use_msi_bitmap=false, which appears to share an
existing gic slot (incrementing its refcount) rather than allocating a
fresh dedicated MSI-X from the bitmap:

	msi = 0;
	gic = mana_gd_get_gic(gc, false, &msi);
	...
	msi = (i + 1) % gc->num_msix_usable;
	gic = mana_gd_get_gic(gc, false, &msi);

The commit body also says "These interrupt contexts may be shared with
Ethernet EQs when MSI-X vectors are limited", which describes
sharing-with-fallback, while the flag name says "UNSHARE". Could the
changelog and flag naming be reconciled so the semantics are clear (for
example, whether the bit advertises "driver can handle unshared EQs" vs
"driver will always be unshared")?

Should the flag also be set only when the driver actually ends up
dedicated rather than advertised unconditionally?

[ ... ]

> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 6c138cc77407..d84e474309a3 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -615,6 +615,7 @@ enum {
>  #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
>  #define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
>  #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
> +#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
>  
>  /* Driver can handle holes (zeros) in the device list */
>  #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
> @@ -631,7 +632,8 @@ enum {
>  /* Driver detects stalled send queues and recovers them */
>  #define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
>  
> -#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
> +/* Driver supports separate EQ/MSIs for each vPort */
> +#define GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT BIT(19)
>  
>  /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
>  #define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)

[Low]
The subject line scopes this commit to RDMA/mana_ib, but this hunk
changes the shared header include/net/mana/gdma.h in two ways that
affect the Ethernet driver and firmware interface:

- it introduces the new GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT
  BIT(19) advertised to firmware, and
- it silently moves GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6) from
  after BIT(18) back to its numeric slot after BIT(5).

Neither change is mentioned in the changelog. Would it be clearer to
split the capability-bit addition into its own patch (or use a subject
not scoped to mana_ib), and to note the BIT(6) relocation as a separate
cleanup so bisecting firmware/Ethernet behavior changes is easier?

> @@ -659,7 +661,8 @@ enum {
>  	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
>  	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
>  	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
> -	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
> +	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
> +	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0

