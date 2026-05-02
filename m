Return-Path: <linux-hyperv+bounces-10578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG7/ALoT9mnMSAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10578-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:09:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EB4B292B
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A93300E39F
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F036E477;
	Sat,  2 May 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg9+d/4X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FB28488F;
	Sat,  2 May 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777734533; cv=none; b=r8pdo7bXMNkHPSwucM9jHNk00o3X0Ys6QXCPNV7gv+umIOz0m1fgyBUyLbnSL8t8r8b0UArNltauEIu3T/uAJX8RtK/kLai7br710bp/b7+GdGPBN5DepkVhrIMhE+nY+1pZkV+Pv9hHDKLEAks/JE85WWQpMuIhyiDDM4fRzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777734533; c=relaxed/simple;
	bh=e+xLXGdEYxLgZ323ptVAsu7s9bXYjwxYRgM/sQDjECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA6JfkpFNZtp/L50JW7zMFpxW1ecQNqtnsf+Bli8aruaUk1vx2yGTxIr6rfKzfjjAOQGR4ACc4IpOO3oMyxb4m97NxmsoPtpqaDWnNPshsxnBS6NHD97G295biLHXVW26nYObomVIIdP8b2vaq1mPlyq5xdGBctr+upyAC3gLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg9+d/4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800A5C19425;
	Sat,  2 May 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777734532;
	bh=e+xLXGdEYxLgZ323ptVAsu7s9bXYjwxYRgM/sQDjECo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg9+d/4XKgn65KJcALgx52hjbibflVP0oUjGuv13JKvvrSYRXT1nA67xqiIpEySnl
	 n/2WJJ3/TTOXGejPzue/9waKnO3gDiLPIXoNM3gCxJtpugPnfB9jT3bJYhBBUpev/Q
	 WVYRyAXtoAN6uIgrQ0pySakeKxbdYOCWZWa1MdbsqYoJe/OtvDPGY+7dgE2Poyy6cG
	 pnHEsi0J5uEg/C0IC7jId3amRmYVMLKL4YOHBouvSHJS23eUZbAmIeASV7fXPG2jtz
	 bpp2huuzeopVNuDAHffhaLzsej3iJDbiKFiDkwJSIHDf9mW57PgPzvdMcJDGF0iQE5
	 KtOCKnlOsTpOw==
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
Date: Sat,  2 May 2026 16:08:35 +0100
Message-ID: <20260502150835.281887-1-horms@kernel.org>
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
X-Rspamd-Queue-Id: A22EB4B292B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10578-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: mana: Query device capabilities and configure MSI-X sharing for EQs

When querying the device, this adjusts the max number of queues to allow
dedicated MSI-X vectors for each vPort, clamping to no less than
MANA_DEF_NUM_QUEUES. MSI-X sharing among vPorts is disabled by default
and enabled only when there are not enough vectors. It also renames
mana_query_device_cfg() to mana_gd_query_device_cfg().

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> +	/*
> +	 * Adjust gc->max_num_queues returned from the SOC to allow dedicated
> +	 * MSIx for each vPort. Clamp to no less than MANA_DEF_NUM_QUEUES.
> +	 */
> +	max_num_queues = (gc->num_msix_usable - 1) / num_ports;
> +	max_num_queues = roundup_pow_of_two(max(max_num_queues, 1U));

Does rounding up here inflate max_num_queues and unnecessarily force MSI-X
sharing?

For example, if there are 63 usable MSIs and 2 ports, the division yields 31.
Rounding up gives 32. The subsequent check below:

> +	/*
> +	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
> +	 * Ethernet EQs when (max_num_queues * num_ports > num_msix_usable - 1)
> +	 */
> +	max_num_queues = min(gc->max_num_queues, max_num_queues);
> +	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
> +		gc->msi_sharing = true;

would then evaluate to true (32 * 2 > 63) and force the driver into MSI-X
shared mode. This seems to contradict the intent to use dedicated MSI-X
whenever possible.

Would it be better to use rounddown_pow_of_two() instead to ensure the
calculated queues fit within the available dedicated vectors?

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

If msi_sharing is disabled, we allocate the msi_bitmap but skip calling
mana_gd_setup_remaining_irqs(). 

Since mana_gd_setup_hwc_irqs() only allocates a single vector for the hardware
channel when dynamic allocation is supported, does this leave the device
without interrupts for its Ethernet queues?

If so, it seems this could lead to queue creation failures when the driver
attempts to map uninitialized vectors. I notice this is fixed in a later patch
in the series ("net: mana: Allocate interrupt context for each EQ when
creating vPort"), but does leaving it out here break bisectability?

