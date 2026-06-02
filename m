Return-Path: <linux-hyperv+bounces-11450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAyeOOCyHmr7JAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11450-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 12:39:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFF62CBCB
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71F73088E3B
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955943C199A;
	Tue,  2 Jun 2026 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU2X4vFO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8236E38737B
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jun 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396093; cv=none; b=sXJtQU2KPLEdv3P8fwxV/QKrDSZCtHOYZx/C4ARmOu38sMHyBlSFbx7RLYo5yKZuw2HVXel1vwI4L5n02HLVPtWc1x2CfV1HTJxGf64IREVTCuhwcZSkBEAIBkC7C2T+8Cx3ejViFR3cgwtEJpDuIJbcIWpViC2ZEgNvLHaZ5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396093; c=relaxed/simple;
	bh=zNlXKC6TRo+mvxPto0dQyCYmARuHvPU+1/gxhiSkHUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uE4WpD8Z9qRbQLaM9j8AosNzprqIiNOFhNb/68fIV3cbSXX/eWTxoXfPBQp49HYox9dyCnVCjF3RSJrrd6woFq9jc1FkUlldOZq3/Qj0eHzGF3ImdO+V2lhotd9oEZnoN3RAKDIVkP4RctbApzWNPe9lJp44h/gBQ1rlpKO9rDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU2X4vFO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83AD1F00893;
	Tue,  2 Jun 2026 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396092;
	bh=VscXahS2O1bPKvOFAxUN737uwZI5dZoq3VPDGVqMuwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NU2X4vFOhvFRzdFUS0HDFMHge5QnO2TAypnBNOZhU70l1dBGjIMOGth9PyEZntiKi
	 CKgBoYpCG8rNiDwcKkxgyrdIYW/Mkl0t4A15JolzGatVsjsEHG2x4w4PIspH1qC4Ki
	 t27w+3Dig+mp0oIkfxscPQuT5CFO67AyzRKH7KmYygzGn6iwyrcI9nUsqXGV9Zl/Eo
	 EloW3ymGf2j9QJm8DdJVgatsArXukzZzOY38BCoFBKbDjLs1G/R8/oQnrTKXuXr9IE
	 cCT2JhYF9EvBbkiMGkmdLM/yCFGlEh6sOROJKgff+gL+1sMctT+Q56fKEcpfpyeze/
	 17nnuBltLsUKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shradha Gupta" <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 10:28:11 +0000
Message-Id: <20260602102811.A83AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4EEFF62CBCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11450-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check for xa_store() leads to resource leak and pote=
ntial kernel oops on allocation failure.
--

commit 853688f50dc4ca56dd74698a3ecfdfeaf857e716
Author: Shradha Gupta <shradhagupta@linux.microsoft.com>

net: mana: Optimize irq affinity for low vcpu configs

This patch optimizes irq affinity in the mana driver for low vCPU
environments. When the number of allocated irqs is greater than the vCPU
count, it ensures that queue irqs are spread across all available vCPUs
to prevent softirq handling imbalances.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev =
*pdev, int nvec)
>  	 * first CPU sibling group since they are already affinitized to HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <=3D num_online_cpus())
> -		skip_first_cpu =3D true;
> +	if (gc->num_msix_usable <=3D num_online_cpus()) {
> +		err =3D irq_setup(irqs, nvec, gc->numa_node, true);
> +		if (err) {
> +			cpus_read_unlock();
> +			goto free_irq;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error handling
path for goto free_irq, is there a potential resource leak if xa_store()
fails earlier in the function?

When setting up the irqs in mana_gd_setup_dyn_irqs(), we call xa_store()
with GFP_KERNEL:

    xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);

However, the return value is not checked. If this allocation fails, the gic
pointer is not saved. If a subsequent operation like irq_setup() fails and
we jump to the free_irq label, the cleanup loop attempts to retrieve it:

    gic =3D xa_load(&gc->irq_contexts, i);
    if (WARN_ON(!gic))
        continue;

Because the store failed, xa_load() will return NULL, causing the loop
to continue without calling free_irq() or kfree(gic). Could this result
in an un-freed irq handler that might trigger a panic later if the
module is unloaded and the hardware raises an interrupt?

> +		}
> +	} else {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601102749.1768=
304-1-shradhagupta@linux.microsoft.com?part=3D1

