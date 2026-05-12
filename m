Return-Path: <linux-hyperv+bounces-10789-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFfkEIiNAmpouQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10789-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:16:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB8518D1B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91807304E302
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7D3290BB;
	Tue, 12 May 2026 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzpIA1BR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3831A556;
	Tue, 12 May 2026 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552044; cv=none; b=sFAxdWCa9isw+ByspLaSWOght8E2OASlKwfYrhEbWKz5H3102Vbmb2NYdE2AblocdKWo/7y2D8HhVil5oyF5E986hnSPtgpyUo+mtsuI+L2GNNpoak1wCUErWpljqG/XzJ3om/M85GMKLtP4LJaYtBNR71YqZWkvyGABvrwmoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552044; c=relaxed/simple;
	bh=oSU58OcODt3HfvGZE6BigrEMWwgZlRmAHilmvR0xp2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT6n7jC/WtLzKcHneVrv3W+YNWSfM+hEhrechL5rxcP+oqTwe3r02KGJnTE5B+0ujdhuELanr8XH5DQJhrWD/ejwZU/Kq1WXtrHRjQ3bPFtRKkhRgcxVb+ljapf303lHVX18s5l4OsdhosmwR2OHyj3SQl4RRrqW5/i42t5nFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzpIA1BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACABC2BCFC;
	Tue, 12 May 2026 02:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552044;
	bh=oSU58OcODt3HfvGZE6BigrEMWwgZlRmAHilmvR0xp2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzpIA1BRkbdQZssU02TpYJgJrnaRLeJ/yXDCLz+230xdiKTRZPg4FgY8YM/LZpF6d
	 rtpbKHjjaUBvHz8T0OIRBIjIHNa+/2kDRa2j1LX2ngo7LWh/UDdK1/cos2bW/rC+2i
	 lpu71QnIdJfc9aKm2HNgLcUhLJwZTkPWlmlwlvuzYtT6p4Wo4FBmLZOoz5UFYVrP/F
	 G9MVojDc/Uel+76DibpSzRO/HGdcWKAz+UwTZC91lkrOvdMGumGW2oWnWXjuIHwg2A
	 2kDo0bj31Um3DhPC+kLnLOYDY3rE6n8+1v6gLanjHMlj9rCFb7bC0ouVNO4eBZ285w
	 /6cp65Pr0j8hg==
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
Subject: Re: [PATCH net-next v7 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Mon, 11 May 2026 19:14:03 -0700
Message-ID: <20260512021403.849804-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507191237.438671-3-longli@microsoft.com>
References: <20260507191237.438671-3-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAEB8518D1B
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
	TAGGED_FROM(0.00)[bounces-10789-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Query device capabilities and configure MSI-X sharing for EQs

This change queries device capabilities earlier during GDMA setup,
renames mana_query_device_cfg() to mana_gd_query_device_cfg(), and adds
a new gc->msi_sharing flag plus a gc->msi_bitmap to manage dedicated
vs. shared MSI-X vectors for EQs across vPorts.

A few questions below, mostly about msi_sharing state across resume and
about some wording in the commit message and in the code.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index f3316e929175..3aa96329f359 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -149,6 +149,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_query_max_resources_resp resp = {};
>  	struct gdma_general_req req = {};
> +	unsigned int max_num_queues;
> +	u8 bm_hostmode;
> +	u16 num_ports;
>  	int err;
>  
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
> @@ -197,6 +200,40 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	if (gc->max_num_queues == 0)
>  		return -ENOSPC;
>  
> +	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
> +				       MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
> +	if (err)
> +		return err;
> +
> +	if (!num_ports)
> +		return -EINVAL;

[Low]
This is the first of two back-to-back mana_gd_query_device_cfg() calls
per probe cycle. The second one happens in mana_probe() (further down
in this same patch) and also fetches num_ports and bm_hostmode from
firmware. The first caller here discards bm_hostmode; the second one
uses both.

Would it be reasonable to cache num_ports and bm_hostmode on
struct gdma_context during the first call and have mana_probe() read
them from there, instead of doing a second HWC round-trip that must
return the same values for the per-vPort math in
mana_gd_query_max_resources() to match ac->num_ports in mana_probe()?

> +
> +	/*
> +	 * Adjust gc->max_num_queues returned from the SOC to allow dedicated
> +	 * MSIx for each vPort. Clamp to no less than MANA_DEF_NUM_QUEUES.
> +	 */
> +	max_num_queues = (gc->num_msix_usable - 1) / num_ports;
> +	max_num_queues = rounddown_pow_of_two(max(max_num_queues, 1U));
> +	if (max_num_queues < MANA_DEF_NUM_QUEUES)
> +		max_num_queues = MANA_DEF_NUM_QUEUES;
> +
> +	/*
> +	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
> +	 * Ethernet EQs when (max_num_queues * num_ports > num_msix_usable - 1)
> +	 */
> +	max_num_queues = min(gc->max_num_queues, max_num_queues);

[Low]
The commit message says "The number of queues per vPort is clamped to
no less than MANA_DEF_NUM_QUEUES". After the clamp-up above, this
min() with gc->max_num_queues can bring the result back below
MANA_DEF_NUM_QUEUES whenever gc->max_num_queues is below
MANA_DEF_NUM_QUEUES (which is 16).

gc->max_num_queues was previously clamped by num_online_cpus(),
resp.max_eq/cq/sq/rq, and gc->num_msix_usable - 1, so a VM with
fewer than 16 online CPUs will end up with gc->max_num_queues_vport
below MANA_DEF_NUM_QUEUES in the non-sharing branch.

Could the commit message be reworded to describe the actual behaviour
(the per-vPort count is clamped towards MANA_DEF_NUM_QUEUES but never
exceeds the hardware maximum)?

> +	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
> +		gc->msi_sharing = true;

[Medium]
Is gc->msi_sharing ever cleared?

Walking the write sites for this flag in the series: it is set to true
unconditionally in the non-dyn branch of mana_gd_setup_hwc_irqs() (see
the hunk below), and conditionally true here. I could not find any
path that writes false, and neither mana_gd_remove_irqs() nor
mana_gd_cleanup() reset it.

The same gdma_context allocated in mana_gd_probe() survives a suspend
/ resume cycle via mana_gd_suspend() -> mana_gd_cleanup() ->
mana_gd_resume() -> mana_gd_setup(). In the dynamic MSI-X path
(pci_msix_can_alloc_dyn() true, i.e. the PF), gc->num_msix_usable is
recomputed as min(resp.max_msix, num_online_cpus() + 1), so it can
legitimately grow across suspend/resume if CPUs came online while the
guest was suspended.

If the first probe set msi_sharing=true because MSI-X was tight, but
on resume there are enough vectors for dedicated allocation, does the
flag stay stuck at true? If so:

  - gc->max_num_queues_vport is computed via the sharing branch
    min(gc->num_msix_usable - 1, gc->max_num_queues) rather than the
    dedicated max_num_queues value;
  - the if (!gc->msi_sharing) branch at the end of mana_gd_setup()
    is skipped and gc->msi_bitmap stays NULL;
  - later patches in this series that consult !gc->msi_sharing as the
    "use bitmap" predicate keep taking the shared path.

Would it be appropriate to reset gc->msi_sharing = false at the top of
mana_gd_query_max_resources() (and/or in mana_gd_setup_hwc_irqs()'s
other branch) before the conditions that may set it to true are
evaluated? This would also line up with the commit message's claim
that "MSI-X sharing among vPorts is disabled by default and is only
enabled when there are not enough MSI-X vectors for dedicated
allocation."

> +
> +	/* If MSI is shared, use max allowed value */
> +	if (gc->msi_sharing)
> +		gc->max_num_queues_vport = min(gc->num_msix_usable - 1, gc->max_num_queues);
> +	else
> +		gc->max_num_queues_vport = max_num_queues;
> +
> +	dev_info(gc->dev, "MSI sharing mode %d max queues %d\n",
> +		 gc->msi_sharing, gc->max_num_queues);

[Low, Low]
Two small wording questions on this block:

The comment above reads "Adjust gc->max_num_queues returned from the
SOC to allow dedicated MSIx for each vPort", but the code never
modifies gc->max_num_queues; it updates a local and assigns to
gc->max_num_queues_vport. Should the comment say
gc->max_num_queues_vport instead?

For the dev_info, should the printed field be gc->max_num_queues_vport
rather than gc->max_num_queues? As written, the log always shows the
hardware maximum that was already decided earlier in the function,
not the per-vPort value that the preceding logic just chose, so the
number never reflects the effect of toggling msi_sharing.

> +
>  	return 0;
>  }
>  
> @@ -1859,6 +1896,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
>  		/* Need 1 interrupt for HWC */
>  		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
>  		min_irqs = 2;
> +		gc->msi_sharing = true;
>  	}
>  

[ ... ]

