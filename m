Return-Path: <linux-hyperv+bounces-11821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCoPMXarRmpMbQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11821-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:18:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38F6FBEBA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dwYo8dwq;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11821-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11821-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1639531BB0F8
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845B349CCC;
	Thu,  2 Jul 2026 17:20:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83393469EE;
	Thu,  2 Jul 2026 17:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012845; cv=none; b=apT0K2nQzlWjvuZQKYyhN0NFs749WHiPZBFpT5jH4fvjyRy/Lz1GUrR3S9GCnuTGjPAE0n+HOtKz96gdarMd/QwkbG5p0u+AvEZNGTPdDYdKKniGNnji7ZI7lwECRe/uKg+raBR7InALjuDwttlXV4HrV8MI2FZaxXhy6QnpY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012845; c=relaxed/simple;
	bh=ce1S+ZgapVXwrlV/4HcXKaBwsSjvb2yeyKQp8zbEQzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6eirg+Zw9RDCnFODPgvSjN1l9ruqIdHV/jjdfScCutb+OYwxTvdHsAFIuPKV39ghXdSREOEYCdBL/tx3W7tLoVzFvSxHFatxpuQV5HAzKigdA+eziXJTl4TYprwfZ5I7KOQwKnwTGrMFZrePXMAtY3S0G8icu8PfZhbghfu2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwYo8dwq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9551F000E9;
	Thu,  2 Jul 2026 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012843;
	bh=1Ryc/FdHtu6IBlUPS5STD/MrWkXdkwIN7N2nc5SmXDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dwYo8dwqU3HcABYcGtSJYtukWReZaiv7afjCJwdXhcical8HM7hjUyuwO6Qw5ZzTg
	 mCyBpDhMbr4zn896ykNHvuJLFN9DvP0x/r2j8Pgdpb9WznW9RxVenUCpzHt8uaOy3K
	 Zv7bNjc3ZCOHyF6RS8EN/GdEqsMu9zWbf2NX6ArTfz1ITTZjd0tDq2GjYuUlVWyApT
	 dHFr8PslOhEq5xvwj2C9oqaykMAhEsbFw+La9lzN9/vxD6PxPby8I+fyixC8x8dGvE
	 HVZyIYcyg4i8XAqij6KS/LhefLnsaNPnY6LPZ4PH3OAWcxKhs0182Riig1c6VFZm7G
	 w8U3D9iY5o+Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:20:42 +0000
Message-Id: <20260702172043.5A9551F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11821-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E38F6FBEBA

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Bitfield assignment on an uninitialized hypercall buffer element c=
auses a read of uninitialized memory, triggering a KMSAN uninit-value warni=
ng.
- [High] Missing check for an empty `iotlb_gather` causes spurious flushes =
of the entire IOTLB domain.
- [Medium] The calculation of `last_pfn` uses an unnecessarily complex form=
ula that theoretically overflows for IOVAs near the end of the 64-bit addre=
ss space.
--

commit 306d408fd1d04144672964e71dd7149937537189
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add page-selective IOTLB flush support

Adds page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
Calculates the minimal power-of-two aligned range for the target IOVA regio=
n,
falling back to a full domain flush if the page-selective flush fails.

> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> index 2541369464040..e9b104a322fd8 100644
> --- a/drivers/iommu/hyperv/iommu.c
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_d=
omain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
> =20
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, =
end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligne=
d.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long=
 end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn =3D HVPFN_DOWN(start);
> +	unsigned long last_pfn =3D HVPFN_UP(end + 1) - 1;

[Severity: Medium]
Can this calculation overflow?

If end is within the last 4095 bytes of the 64-bit address space, end + 1
would wrap around. HVPFN_UP() expands to (((x) + 4095) >> 12), which would
evaluate to 0 in that case.

Subtracting 1 would then result in ULONG_MAX, causing __fls() to compute a
mask_shift of 64 and triggering an undefined left shift by 64 in the later
ALIGN_DOWN macro.

Would it be safer to use HVPFN_DOWN(end) instead, which avoids the overflow
entirely?

> +	unsigned long mask_shift, aligned_pfn;

[ ... ]

> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> +	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
> +				  &input->iova_list[0]);

[Severity: High]
Does this code trigger an uninitialized memory read KMSAN warning?

Since iova_list is a flexible array member, sizeof(*input) evaluates to just
the header size (24 bytes). This means memset() clears the header, but leav=
es
input->iova_list[0] uninitialized.

When hv_iommu_calc_flush_range() later assigns the page_number and
page_mask_shift bitfields of the union, the compiler typically generates a
read-modify-write operation on the underlying 64-bit value. This will read
the uninitialized memory from the reused per-CPU page.

> +
> +	status =3D hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,

[ ... ]

>  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
>  				struct iommu_iotlb_gather *iotlb_gather)
>  {
> -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +	hv_flush_device_domain_list(to_hv_iommu_domain(domain), iotlb_gather);

[Severity: High]
Does this unconditionally flush the entire IOTLB domain if the gather is
empty?

If iommu_unmap() returns without unmapping anything, iotlb_gather retains i=
ts
initialized values of start =3D ULONG_MAX and end =3D 0.

Because there is no check like if (iotlb_gather->start > iotlb_gather->end)
before issuing the flush, hv_iommu_calc_flush_range() will calculate a
mask_shift of 52. This causes a spurious flush of the full 52-bit address
space instead of returning early.

> =20
>  	iommu_put_pages_list(&iotlb_gather->freelist);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D4

