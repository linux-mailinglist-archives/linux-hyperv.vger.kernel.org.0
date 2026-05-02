Return-Path: <linux-hyperv+bounces-10581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KVJ6D/EY9mmPSQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10581-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:32:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786964B29C0
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 937AC300DE3B
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1B34E745;
	Sat,  2 May 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3s86cxH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEA27A907;
	Sat,  2 May 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777735918; cv=none; b=mTOkJwO0MLAtnVFvdH3Ix7J4mVbem3+/UTBfYm1H0+2h4OmT+aW4Hdhq1xjIZYQahMNi1Onq0RC05316exbPjxGeluTGBHmdWHnaca27Kfbw6YRDg2P0bSbfHZLor3AV7nQmVjwwgbBV7xBd0aK+0jFFFoDA8klAVJOZEfWC5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777735918; c=relaxed/simple;
	bh=cZ48aUpcm/LYH4Do1T34fSyLSVwHUO5JI4d3PeiSdI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frJrxziol1pq80HHC3p5TdSxp01yp3xOM/n4wjUTSjpHJtvwfza4ITk+hqaTgSlz8fddnAubrC8oXRR4kBiOwi2Z7ic9gDP+7000BgSekcjLRmr7e6LHuWoqrZvDm0+wu0ajxPvKRfxJ08JriTCp7qGtzDBBJT5lKuUP1SfOyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3s86cxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41303C19425;
	Sat,  2 May 2026 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777735917;
	bh=cZ48aUpcm/LYH4Do1T34fSyLSVwHUO5JI4d3PeiSdI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3s86cxHaNHtLwEYL0JuhpnPUVmaD/Pl315gr7vHrw9HeN+LKdb8daxtBrAUK4F5e
	 JqW5Eh0O7+/WTiUP+7LQLxPURxK7FJ9BIftnUVYqKbW3xUg0cur7mL3EM+NTQOwxEt
	 t8GPJ0eRM+3VfaqLYLa/yerHy7vVgN2npQrHhf4yw1jtxZeUBG+gIA2RlhO3iqFux4
	 Rf70zGLHiOtJB0SPflJmDljO687nxAxfaPtnaXzrKMfg6h5+o/uZx4yDBsi5//EyoX
	 GpKBqu1QtQBgJ6EwhPJoZ0hY9JFdnoK1dlx39i2/SFdHlWU3xlo4VNPQ/r4WB73xtg
	 N31Xs80O6cLXg==
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
Subject: Re: [PATCH net-next v6 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Sat,  2 May 2026 16:26:52 +0100
Message-ID: <20260502152649.292433-5-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429221625.1841150-3-longli@microsoft.com>
References: <20260429221625.1841150-3-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 786964B29C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10581-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

I apologise for any overlap with this and the review of this
patchset available at sashiko.dev. They both seem relevant and
I'm unsure how to cleanly pass them both on.

Both Sashiko instances also flagged concerns in the remaining
patches of this patchset. But I am not forwarding them as they
seem to be lower priority, and I think I've already created
enough noise here.

---
net: mana: Query device capabilities and configure MSI-X sharing for EQs

This patch queries device capabilities early in GDMA probe and chooses
between dedicated MSI-X per vPort or a shared-MSI-X mode based on the
available vector count, introducing gc->max_num_queues_vport,
gc->msi_sharing and gc->msi_bitmap, and renaming mana_query_device_cfg()
to mana_gd_query_device_cfg() so it can be called from the GDMA layer.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128..b96859e0aec9 100644
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
> @@ -194,6 +197,40 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	if (gc->max_num_queues > gc->num_msix_usable - 1)
>  		gc->max_num_queues = gc->num_msix_usable - 1;
>  
> +	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
> +				       MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
> +	if (err)
> +		return err;

Is this the same MANA_QUERY_DEV_CONFIG that mana_probe() issues shortly
after?  mana_probe() still contains:

	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
				       MANA_MICRO_VERSION, &num_ports, &bm_hostmode);

so the same HWC round-trip runs twice on every probe with identical
arguments, both populating gc->adapter_mtu.

The commit message frames this rename as consolidation ("used at GDMA
device probe time"), but the mana_probe() call-site is not removed.  Was
one of the two call-sites meant to go away?

The relocation of debugfs_create_u16("adapter-MTU", ...) from
mana_gd_query_device_cfg() into mana_probe() only makes sense if the
function is now invoked more than once, which hints at the same
duplication.

> +
> +	if (!num_ports)
> +		return -EINVAL;
> +
> +	/*
> +	 * Adjust gc->max_num_queues returned from the SOC to allow dedicated
> +	 * MSIx for each vPort. Clamp to no less than MANA_DEF_NUM_QUEUES.
> +	 */
> +	max_num_queues = (gc->num_msix_usable - 1) / num_ports;
> +	max_num_queues = roundup_pow_of_two(max(max_num_queues, 1U));
> +	if (max_num_queues < MANA_DEF_NUM_QUEUES)
> +		max_num_queues = MANA_DEF_NUM_QUEUES;
> +
> +	/*
> +	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
> +	 * Ethernet EQs when (max_num_queues * num_ports > num_msix_usable - 1)
> +	 */
> +	max_num_queues = min(gc->max_num_queues, max_num_queues);
> +	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
> +		gc->msi_sharing = true;

Is gc->msi_sharing ever reset to false?  The only two writers are this
line and mana_gd_setup_hwc_irqs() (the !pci_msix_can_alloc_dyn branch),
and both only set it to true.  mana_gd_remove_irqs() frees msi_bitmap
and zeros max_num_msix / num_msix_usable, but does not clear
msi_sharing, and the gdma_context survives mana_gd_suspend() /
mana_gd_resume().

Once true is latched in any setup cycle, mana_gd_setup() will always
take the sharing branch on resume even if the recomputed
max_num_queues * num_ports fits within num_msix_usable - 1.  Is that
consistent with the commit message saying sharing "is only enabled when
there are not enough MSI-X vectors for dedicated allocation"?

> +
> +	/* If MSI is shared, use max allowed value */
> +	if (gc->msi_sharing)
> +		gc->max_num_queues_vport = min(gc->num_msix_usable - 1, gc->max_num_queues);
> +	else
> +		gc->max_num_queues_vport = max_num_queues;
> +
> +	dev_info(gc->dev, "MSI sharing mode %d max queues %d\n",
> +		 gc->msi_sharing, gc->max_num_queues);

Should this print gc->max_num_queues_vport rather than
gc->max_num_queues?  The block immediately above computes
gc->max_num_queues_vport and leaves gc->max_num_queues unchanged, and
mana_probe_port() sizes alloc_etherdev_mq() and apc->max_queues from
gc->max_num_queues_vport:

	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
				 gc->max_num_queues_vport);
	...
	apc->max_queues = gc->max_num_queues_vport;
	apc->num_queues = min(gc->max_num_queues_vport, MANA_DEF_NUM_QUEUES);

so the logged value does not match the per-vPort queue count the driver
actually exposes.

> +
>  	return 0;
>  }
>  
> @@ -1856,6 +1893,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)

[ ... ]

> @@ -1968,20 +2008,30 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	if (err)
>  		goto destroy_hwc;
>  
> -	err = mana_gd_query_max_resources(pdev);
> +	err = mana_gd_detect_devices(pdev);
>  	if (err)
>  		goto destroy_hwc;
>  
> -	err = mana_gd_setup_remaining_irqs(pdev);
> -	if (err) {
> -		dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
> -		goto destroy_hwc;
> -	}
> -
> -	err = mana_gd_detect_devices(pdev);
> +	err = mana_gd_query_max_resources(pdev);
>  	if (err)
>  		goto destroy_hwc;
>  
> +	if (!gc->msi_sharing) {
> +		gc->msi_bitmap = bitmap_zalloc(gc->num_msix_usable, GFP_KERNEL);
> +		if (!gc->msi_bitmap) {
> +			err = -ENOMEM;
> +			goto destroy_hwc;
> +		}
> +		/* Set bit for HWC */
> +		set_bit(0, gc->msi_bitmap);
> +	} else {
> +		err = mana_gd_setup_remaining_irqs(pdev);
> +		if (err) {
> +			dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
> +			goto destroy_hwc;
> +		}
> +	}
> +

Can the driver bring up any vPort after this change when the !msi_sharing
branch is taken?

In the dedicated branch, only gc->msi_bitmap is allocated and bit 0 is
set for HWC.  mana_gd_setup_remaining_irqs() is skipped, so no
gdma_irq_context is inserted into gc->irq_contexts for indices 1..
num_msix_usable-1.

Later, mana_create_eq() still assigns

	spec.eq.msix_index = (i + 1) % gc->num_msix_usable;

and mana_gd_register_irq() does:

	gic = xa_load(&gc->irq_contexts, msi_index);
	if (WARN_ON(!gic))
		return -EINVAL;

On a typical cloud SKU with, for example, num_msix_usable=32,
num_ports=1 and num_online_cpus=16, the new math keeps msi_sharing=false
(16 * 1 <= 31), so every EQ-create goes down this path and hits the
WARN_ON.  Doesn't that make every vPort open and every resume fail for
the common dedicated-MSI-X case?

The msi_bitmap allocated here is not consumed anywhere in this commit;
the on-demand allocation via mana_gd_get_gic() appears in the later
commit "net: mana: Allocate interrupt context for each EQ when creating
vPort" (dbbdf40a8974).  Should the bitmap and the new branch be
introduced in the same commit that actually uses them, so each commit in
the series is independently bootable?

>  	dev_dbg(&pdev->dev, "mana gdma setup successful\n");
>  	return 0;
>

