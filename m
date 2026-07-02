Return-Path: <linux-hyperv+bounces-11819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x05NMqmoRmrDbAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11819-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:06:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176A6FBD7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:06:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O0qgfFuf;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11819-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11819-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517A331F2EE9
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9631F98B;
	Thu,  2 Jul 2026 17:08:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA43331EB9;
	Thu,  2 Jul 2026 17:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012128; cv=none; b=hw+OfqgH/xJMMvVRBfoDxFuOtWinYCwgvvb/k/FgCAF1CCMy/BtPCoCBUAc1z9dET7Gl/joRz0T0nCWlwO3cSndie3Dj5PKl4LZpPsfXOVILVmZTyiA13a0emI29YnH8xFt/EQeVs5Kq6OjQzalov8mk2m48xa9sAjPO+yFSqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012128; c=relaxed/simple;
	bh=wgC036mottjZzxDpnXROa86MUIAcVqsoBCPIB11K4Hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BirRyxYYbFD7zxHX/tObIekC2D4rfRoxy/4UUOCwqekS01uCHaPMze9T/t2gzZP1Dh7AP20sO93o2mOYsk8c0Lm1hTKYpa2/l7oAMAEm0LKTY1XV9SovG2ylKgymT4BS/dGaKlfNb3SasOAqMCzoo/qs9kTDDPHPWcs1EXN5wNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0qgfFuf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEF91F000E9;
	Thu,  2 Jul 2026 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012126;
	bh=e3qY9FSRbuloe9ihT5Gc6jvFAv42+7rMgkKp5Y0K1hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0qgfFuf/yBymQPlLM7H7BPzXS/rl1fc1OvhiwZyDuK2bgEallCoz2lVjN+WRZWcr
	 +BrkcBjxG5yiC1BpwHP0oeXTim+F5VXT2A5drc6JDBO7a8Sc98bVEccHRxNypeLBSj
	 fhTwIopSHY8DSOaiA7X+ub9ru/Zmv8R7ts/wnyrG1P9QtQO/sv7bH7NOw+sLu/2PPs
	 xyvWptqfjsJ1uG9VFt638mK+SlowRak5VFeWoZYF/StNQuzIt4Ppu5gHl/Ib92c+u5
	 wkLO1kVtjmMQZVUllDHnX3vUU2v3gi35Ztz8BULHqXD2gjeI4Kc0UIDoZNX+EqtoLC
	 B+uNqveGuwctg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:08:45 +0000
Message-Id: <20260702170846.7DEF91F000E9@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11819-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3176A6FBD7B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Undefined behavior when calculating `aperture_end` if the hypervis=
or returns `max_iova_width >=3D 64`.
- [High] Unconditional overwrite of `x86_init.iommu.iommu_init` causes hard=
ware IOMMUs (VT-d/AMD) to fail initialization.
--

commit fdcb0264dfd6bd1cb7c3c4676b8a796ad8a85e4a
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
This driver implements stage-1 IO translation within the guest OS and
integrates with the Linux IOMMU core using Hyper-V hypercalls.

> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 55a8b6de2865a..094f9f7ddb728 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -578,6 +578,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev =3D x86_init.timers.setup_percpu_clockev;
>  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev;
> =20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init =3D hv_iommu_init;

[Severity: High]
The assignment to x86_init.iommu.iommu_init must be conditionally guarded to
prevent hardware IOMMU initialization failures.

Will this unconditional overwrite break hardware IOMMUs?

Initial boot sequence logic and IOMMU detection parameters are validated.

If pci_iommu_alloc() previously detected a hardware IOMMU (like VT-d/AMD) a=
nd
set iommu_detected=3D1, overwriting the pointer with hv_iommu_init() ensures
failure since hv_iommu_init() immediately aborts when iommu_detected=3D=3D1.

> +#endif
> +
>  	hv_apic_init();

[ ... ]

> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> new file mode 100644
> index 0000000000000..2541369464040
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c

[ ... ]

> @@ -509,6 +509,16 @@ static void __init hv_init_iommu_device(struct hv_io=
mmu_dev *hv_iommu,
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) << hv_iommu->max_iova_width) - 1,

[Severity: High]
The max_iova_width value must be bounds-checked against the maximum 64-bit
integer width before performing the bitwise shift.

Does this code overflow the 64-bit shift limit?

Standard processing applied to the hypercall response.

If an untrusted hypervisor responds to HVCALL_GET_IOMMU_CAPABILITIES with
max_iova_width >=3D 64, shifting ((u64)1) directly by that amount results in
undefined behavior and unpredictable IOVA aperture sizing.

> +		.force_aperture =3D true,
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D3

