Return-Path: <linux-hyperv+bounces-11630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ndkLKiiMWrRogUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11630-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 21:23:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA63694F4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 21:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X6qMgX2a;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11630-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11630-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D953124EB7
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2026 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46433DB332;
	Tue, 16 Jun 2026 19:22:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7523D890D;
	Tue, 16 Jun 2026 19:22:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637745; cv=none; b=cDjwiRBTTk9BOdGp8Gt3CpBVpxJoqEN9YLB4rwFGXxoirP+qWpb/p2O+DuOeRyh3WZrvetjjarENfcaD3tDud9QAc4vuyq8APO7ho4Devnbq4bN953BV0UoNAYiaTVCa14BwlHQqocW4tM+iu3bj2HU61x58GbGfOurzytjjtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637745; c=relaxed/simple;
	bh=LBWjJkWxgOTS7GFKeyRpsyqFSw2cMteViY1IEQ7OAR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m806S0pd17m2c9de/1XL/oEHm7B5GqFFf7/gHIvMwDggl5XBzr+FUBDMLwitbjILGbB2dUo9P6U3lvGB5t/EbqGFko6MskEmKTTFithGxs32UR3WaDTRPXUxCtH7lxw63TyM1pJSQfvoZ/YjMffFqMBf3I/5cuMlgkNrKs2ZuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6qMgX2a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A2E1F000E9;
	Tue, 16 Jun 2026 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781637744;
	bh=vlCIInpka7FIjsx/AbmM1/Zseulxf9DwTuUmI6KKg7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X6qMgX2amBjvifKWxbmeUCk17XrMjtb1plfACc93T5qq7HZgbFPQfg65nWljEcPxe
	 0GbVAIgX1P4TYGW4qVDueThJcnTizQ6ShB1S5XxAgrEHMkieb8PQrTc5qagJXLklIf
	 TuZSiVffDcDIKXucKTI8QDPMzDYFJfNXXzqKzEmhDW6ipwfwc38dYLoW55jp/It2cK
	 lKzHnoqQPNGfRTtnuhSr175E0bGjXcbJL9+lcJpn4a92tQPW33ANGullPtOwbGZzO/
	 LdFvrSXMgvbKLG5Jwp8YvWrE8XMJhHmGhjK+Ki9FWqPwoiVrX0YfLaQOUUF3+e4lJO
	 gYm4z8HZAcxjA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1] PCI: Remove pcie_flr() and convert all callers
 to use pcie_reset_flr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260615192200.3489-1-alifm@linux.ibm.com>
References: <20260615192200.3489-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:22:23 +0000
Message-Id: <20260616192223.74A2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11630-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FA63694F4F

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Unchecked VF FLR failure introduces a reliable DMA Use-After-F=
ree (UAF) in the MANA driver during queue teardown.
- [High] Replacing `pcie_flr()` with `pcie_reset_flr()` silently breaks Fun=
ction Level Reset (FLR) for all SR-IOV Virtual Functions (VFs) across multi=
ple drivers.
- [High] Silent FLR failure in PCI reset quirks causes the kernel to block =
for 20 seconds during device teardown or initialization.
- [Low] The patch breaks the kernel build because it missed converting a ca=
ller of `pcie_flr()` in the `ixgbe` driver.

Pre-existing issues:
- [Critical] An unbounded MMIO read loop causes an infinite loop and hard l=
ockup if the PCIe device is hot-unplugged or encounters a fatal hardware er=
ror.
--

commit e494ba565a5af359d72294da06691da5e6507322
Author: Farhan Ali <alifm@linux.ibm.com>
Subject: PCI: Remove pcie_flr() and convert all callers to use pcie_reset_f=
lr()

This patch removes the unconditional pcie_flr() function and converts its
remaining callers to use pcie_reset_flr(). This ensures validation checks,
such as verifying FLR support in the device capabilities, are applied
consistently across the kernel.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
>  	int ret;
> =20
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
> =20
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;

[Severity: High]
According to the PCIe Base Specification, SR-IOV Virtual Functions do not
report FLR capability in their Device Capabilities register, so this check
will fail for VFs.=20

Is this a regression that inadvertently breaks FLR for VFs that previously
relied on pcie_flr() bypassing this check? Callers that ignore the return
value will silently skip resetting the hardware.


> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/=
ethernet/intel/ixgbe/ixgbe_main.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[ ... ]
> @@ -8319,7 +8319,7 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_ada=
pter *adapter)
>  		if (status_reg !=3D IXGBE_FAILED_READ_CFG_WORD &&
>  		    status_reg & PCI_STATUS_REC_MASTER_ABORT) {
>  			ixgbe_bad_vf_abort(adapter, vf);
> -			pcie_flr(vfdev);
> +			pcie_reset_flr(vfdev, PCI_RESET_DO_RESET);
>  		}

[Severity: Low]
Does this patch introduce a build regression by missing another caller in
ixgbe_main.c?=20

Searching the tree might reveal that ixgbe_io_error_detected() still calls
the now-removed pcie_flr(), which would cause a build failure when compiling
with CONFIG_IXGBE.


> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -3306,7 +3306,8 @@ static int mana_dealloc_queues(struct net_device *n=
dev)
>  			}
>  			if (atomic_read(&txq->pending_sends)) {
>  				err =3D
> -				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
> +				    pcie_reset_flr(to_pci_dev(gd->gdma_context->dev),
> +						   PCI_RESET_DO_RESET);
>  				if (err) {
>  					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
>  						   err,

[Severity: Critical]
If pcie_reset_flr() returns -ENOTTY for VFs, the FLR fails and this loop
breaks early.=20

Will the driver then proceed to unmap and free active SKB buffers in the
subsequent loop:

mana_dealloc_queues() {
        ...
        for (i =3D 0; i < apc->num_queues; i++) {
                txq =3D &apc->tx_qp[i].txq;
                while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
                        mana_unmap_skb(skb, apc);
                        dev_kfree_skb_any(skb);
                }
        ...
}

Since the hardware wasn't reset and remains active, can this lead to a DMA
use-after-free regression as the hardware continues to process the freed
memory?


> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -4207,7 +4209,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev,=
 bool probe)
>  	val =3D val | HINIC_VF_FLR_PROC_BIT;
>  	iowrite32be(val, bar + HINIC_VF_OP);
> =20
> -	pcie_flr(pdev);
> +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
> =20
>  	/*
>  	 * The device must recapture its Bus and Device Numbers after FLR

[Severity: High]
If pcie_reset_flr() returns -ENOTTY without actually issuing a reset to the
hardware, will the firmware ever clear the HINIC_VF_FLR_PROC_BIT?=20

Looking at the rest of reset_hinic_vf_dev(), it appears the code will
subsequently spin in a busy-wait loop for the full 20-second timeout
waiting for that bit to clear:

reset_hinic_vf_dev() {
        ...
        do {
                val =3D ioread32be(bar + HINIC_VF_OP);
                if (!(val & HINIC_VF_FLR_PROC_BIT))
                        goto reset_complete;
                msleep(20);
        } while (time_before(jiffies, timeout));
        ...
}

Could this regression silently block the thread for 20 seconds during
device teardown?


> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
[ ... ]
> @@ -802,7 +802,7 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	pcie_flr(pdev);
> +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
>  	err =3D pci_enable_device_mem(pdev);

[Severity: Critical]
This is a pre-existing issue, but while reviewing this driver's PCIe
handling, does the interrupt handler have an unbounded loop on PCIe
disconnect?

In netc_timer_handle_etts_event(), the code continuously reads a
memory-mapped register:

netc_timer_handle_etts_event() {
        ...
        while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)=
) {
                ...
        }
        ...
}

If the device is removed or experiences a fatal error, the MMIO read will
return all 1s (0xFFFFFFFF). Because 0xFFFFFFFF masked with the bit is
always true, would this loop spin infinitely and cause a hard lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615192200.3489=
-1-alifm@linux.ibm.com?part=3D1

