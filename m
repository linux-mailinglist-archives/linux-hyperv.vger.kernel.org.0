Return-Path: <linux-hyperv+bounces-11300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNEfLe6kF2oTMAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11300-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:14:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B755EBB70
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 04:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C9F3301BC14
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F092F1FEA;
	Thu, 28 May 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaFNKU4p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082932EAD1C
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934384; cv=none; b=tbyvz7yn4PDM63WqFq3QfvQ6ZdEvjrd4PJZJzvZOdoPfgjkKfyrdmlgW/2YWMXvMCx5ta9fs6wVMXdaAxrmM7NsTkBMBTK8Pzr+9KVB3OWZ23NmhVDSknBOf//Z6Rjh8rrp8Gg/Yd6kQKY2XpW/WfhiWd6tYc4p3FOT0ahj6TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934384; c=relaxed/simple;
	bh=of26+oc8YDVXe+Bk7ZpqWanvCnCpAbuynIWpPSA7QCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMQ8401LGJLOW564x+UudV3+QasKj39XCXHivO9ViUYEArfKzp9vijrQ/nfW5JArqJzFvgebYGjYNpXWzm+p0Hb6VnDhI274V3CyNXc/IWAQOjF80eA2VsF9hN9XN5F1wbd6wGHiMwwF6aHhU/hXizqK+0C0t8U7llZJp/hDwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaFNKU4p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBFA1F000E9;
	Thu, 28 May 2026 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934381;
	bh=der65Qw/Vcw9tYXTKwqwqqeZHrPh7HUvfR2JFi9Ymh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DaFNKU4pmjnJo2S+dCAepvDXCgb7UYg9cRT1YAV9ZlQjt1f3oh40Z4DF0gKUj4VA1
	 kiPXBqpLUgN5C2jQrLI2k0jyZB5BXD7WnV9PpeMZpQLviC7i/bcF+A2K5YVQhd4TNo
	 4H63/sYizJ/yPNeOYRKFD3xJeMGLn1gssnpIeeiKC/IdZm1Whep6FC6e0vjXgMlCi6
	 nGbk23Hezv5a7kBf5QcKovLWUMjeswlANzWG8rpKa46lVVel7CeotMIlTGiiibbo02
	 adoOQBPDTlUKC0ywhl+7t4Zed15v7OAkjiuN1QV3bMKwnt/thE+4qo+63XQrGM6Sjd
	 Slx/MJyqeNYNQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 18/20] mshv: Exclude Hyper-V donated pages from
 crash dump collection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-19-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-19-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 02:13:00 +0000
Message-Id: <20260528021301.4FBFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11300-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 10B755EBB70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Radix tree key encoding mismatch prevents exclusion of Hyper-V own=
ed pages during crash dump.
- [High] Failure to clear the Hyper-V crash MSR P2 when KHO is disabled or =
fails to initialize leaves a stale physical address, leading to memory corr=
uption during crash dump collection.
- [Medium] The kdump initialization path calls a KHO API without being gate=
d by `kho_is_enabled()`, violating strict KHO subsystem guidelines.
--

commit a672e76ca918e68a4de01d571d5f2e72810eec75
Author: Jork Loeser <jloeser@linux.microsoft.com>

mshv: Exclude Hyper-V donated pages from crash dump collection

Pages donated to Hyper-V must not be read during crash dump collection.
They are not ordinary RAM and accessing them can hang or corrupt the
crash kernel.

> diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_prese=
rve.c
> index bc3a3a688f5b2..e16fb946790d5 100644
> --- a/drivers/hv/mshv_page_preserve.c
> +++ b/drivers/hv/mshv_page_preserve.c

[ ... ]

> @@ -327,6 +328,57 @@ static int __init alloc_tree(void)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_CRASH_DUMP
> +static struct kho_radix_crash_tree crash_preserved_pages_tree;
> +
> +/**
> + * restore_crash_tree() - Set up the crash tree for dump-time page exclu=
sion.
> + *
> + * In the crash kernel, the old kernel's memory is not in the direct map.
> + * The old kernel stashes the radix tree root PA in Hyper-V crash MSR P2
> + * so we can retrieve it without touching the old kernel's FDT.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int __init restore_crash_tree(void)
> +{
> +	phys_addr_t root_pa;
> +
> +	root_pa =3D hv_get_msr(HV_MSR_CRASH_P2);
> +	if (!root_pa)
> +		return -ENOENT;
> +
> +	/*
> +	 * The MSR may contain stale data from a previous
> +	 * hyperv_report_panic().  Sanity-check that it looks like a
> +	 * page-aligned physical address within the architectural limit.
> +	 */
> +	if (!PAGE_ALIGNED(root_pa) || root_pa >> MAX_POSSIBLE_PHYSMEM_BITS) {
> +		pr_warn("Invalid crash tree root PA: 0x%llx\n",
> +			(unsigned long long)root_pa);
> +		return -EINVAL;
> +	}
> +
> +	return kho_radix_crash_init(&crash_preserved_pages_tree, root_pa);
> +}
> +
> +static bool mshv_vmcore_pfn_is_ram(struct vmcore_cb *cb, unsigned long p=
fn)
> +{
> +	/*
> +	 * MSHV-owned pages must not be read during crash dump collection.
> +	 * Currently all pages are registered at order 0. If higher-order
> +	 * registrations are added, this lookup will need to handle them
> +	 * (e.g. by querying multiple orders or using a range-based API).
> +	 */
> +	return !kho_radix_crash_contains_page(&crash_preserved_pages_tree,
> +					      pfn, 0);

[Severity: High]
Is the key inserted into the radix tree matched correctly here?

If pages are inserted into the tree using the raw page PFN (e.g.,
page_to_pfn()), this lookup might always miss. The
kho_radix_crash_contains_page() function internally encodes the query key
using kho_encode_radix_key(PFN_PHYS(pfn), order), which adds high-order
metadata bits.

Will this cause the crash kernel to fail to exclude Hyper-V donated pages,
treating them as normal RAM?

> +}
> +
> +static struct vmcore_cb mshv_vmcore_cb =3D {
> +	.pfn_is_ram =3D mshv_vmcore_pfn_is_ram,
> +};
> +#endif
> +
>  static struct notifier_block reboot_notifier =3D {
>  	.notifier_call =3D reboot_cb,
>  	.priority =3D 0,
> @@ -347,6 +399,24 @@ int __init mshv_preserve_init(void)
>  {
>  	int err;
> =20
> +#ifdef CONFIG_CRASH_DUMP
> +	if (is_kdump_kernel()) {
> +		/*
> +		 * Crash kernel only needs the pfn_is_ram callback to exclude
> +		 * MSHV-owned pages from the dump.  No page restoration, no
> +		 * reboot notifier =E2=80=94 the crash kernel reboots after collection.
> +		 */
> +		err =3D restore_crash_tree();
> +		if (err) {
> +			pr_err("Could not set up crash page tree: %d; MSHV pages may appear i=
n dump\n",
> +			       err);
> +			return 0;
> +		}
> +		register_vmcore_cb(&mshv_vmcore_cb);
> +		return 0;
> +	}
> +#endif
> +

[Severity: Medium]
Should this path be gated by kho_is_enabled() as well?

The KHO subsystem documentation mandates checking kho_is_enabled() at the
entry point of any code path that uses KHO APIs. Here, restore_crash_tree()
(which calls the KHO API kho_radix_crash_init()) is invoked before checking
if KHO is enabled.

>  	if (!kho_is_enabled()) {
>  		pr_err("KHO is disabled; page deposits will fail.\n");
>  		return 0;

[Severity: High]
If the system kexecs into a new kernel where KHO is disabled (or initializa=
tion
fails), this function returns early without clearing the HV_MSR_CRASH_P2 MS=
R.

Since Hyper-V crash MSRs persist across kexecs, could the new kernel leave a
stale physical address in P2?

If this new kernel panics, the kdump kernel will read the stale MSR. Because
the address is page-aligned and within bounds, it passes sanity checks in
restore_crash_tree(), and kho_radix_crash_init() will recursively map and
parse the arbitrary memory as a radix tree.

By executing node->table[i] =3D (u64)(uintptr_t)child, might this actively =
write
virtual addresses into the crashed kernel's physical memory, corrupting the
crash dump or triggering panics in the kdump kernel due to mapping invalid
addresses?

>  	}
> =20
>  	err =3D restore_tree();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D18

