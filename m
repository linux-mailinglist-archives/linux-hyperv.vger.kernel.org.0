Return-Path: <linux-hyperv+bounces-11286-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ex5AMeyVF2pNKQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11286-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:10:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4B75EB7ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D84B3027122
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A478F2B;
	Thu, 28 May 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvLuKKtu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5956472
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930508; cv=none; b=aNad7ue7QoISl7jUu6RqV8hnfQmNCaSWEB3InrUweHx5W0tjtNTE61J5r7tlnVUvMu8RBhBA4OjiGRd6RDzBgY1hVTA+vVmW8FKCNmQt8lgIpPY9A4ig1ahk48xYDSIUCXUaFiQyE1fy4rVEPsOj4FNcftUXXdWIFcMjTQ9h2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930508; c=relaxed/simple;
	bh=3BOvnR8U2l1jYiddoQTp87DNdCJJSd1qqbnydmph38A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxiocFkmZWy089qk9uecMIJMIePeQVAKvvCLpdYZBWxvxzYggnGSLgK89gxJTRSFTmgvOaC8OkrAjKPOONKpBGyFPBWFL7ftT8kYOEcbUWoAl3j5Uq/t46DTF4rPnfz1V7MJRxS40KPskOG0rAA+5z2BpzFNOZpcFvYuARSlP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvLuKKtu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A36C1F000E9;
	Thu, 28 May 2026 01:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930507;
	bh=zjxJKi6ZWHYom4uYtI2EgLRNiN+Td+93zN0lznGZd2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvLuKKtuvuRNrapF9GT+aaKBru2RBpIJ7pVF6ugRMRBawddVBlTrYWXA75L4asn7K
	 HZyj3FjuyIUByGeFPQKZwiJ5aQrnIn4lm4RFXmxnaCWQtXXnS5lDS04rh6E4mqkAKj
	 2lC0fSIJK2B7DUAB/Qif4Q4s499qeM9Qqtst+iF6DRXBqhlEOfEl7vvcv5EJ0iWQjk
	 3hkpHkwez8qG+YtspSTB21PnedBqO3dJf76i7fmvDhhBGtq3EsT9jdUHwO303wyTlQ
	 h42Twk+dG14Uw4RU+X2gFo7n7rFy0kp7fhLeC687fR0AWIhuIRUSfRETllTmrO/MAW
	 /3haSlTOAdxEg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/20] kho: store incoming radix tree in kho_in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-3-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-3-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:08:26 +0000
Message-Id: <20260528010827.2A36C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11286-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 1B4B75EB7ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing error handling leads to boot panic
--

commit 84425fcb93791aa9b9c2db978b57ed659f2c9ec2
Author: Pratyush Yadav (Google) <pratyush@kernel.org>

kho: store incoming radix tree in kho_in

This commit stores the incoming radix tree in the kho_in struct to allow
other functions to use it. It also refactors the code to use
kho_get_mem_map_phys() for retrieving the radix tree root from the FDT.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c

[ ... ]

> @@ -1395,24 +1396,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> =20
>  static int __init kho_mem_retrieve(const void *fdt)
>  {
> -	struct kho_radix_tree tree;
> -	const phys_addr_t *mem;
> -	int len;
> -
> -	/* Retrieve the KHO radix tree from passed-in FDT. */
> -	mem =3D fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
> -
> -	if (!mem || len !=3D sizeof(*mem)) {
> -		pr_err("failed to get preserved KHO memory tree\n");
> -		return -ENOENT;
> -	}
> -
> -	if (!*mem)
> -		return -EINVAL;
> -
> -	tree.root =3D phys_to_virt(*mem);
> -	mutex_init(&tree.lock);
> -	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
> +	kho_in.radix_tree.root =3D phys_to_virt(kho_get_mem_map_phys(fdt));

[Severity: High]
Can this lead to a boot panic if kho_get_mem_map_phys() fails?

If kho_get_mem_map_phys() returns 0 on failure, phys_to_virt(0) will likely=
=20
generate a non-NULL pointer. This bypasses the safety validation later when=
=20
walking the tree:

kernel/liveupdate/kexec_handover.c:kho_radix_walk_tree()
    if (WARN_ON_ONCE(!tree->root))
        return -EINVAL;

Walking the tree with this invalid address would then trigger a panic durin=
g=20
early boot.

I note this issue appears to be fixed later in the series by commit=20
80928d5942267 (kho: return virtual address of mem_map), but wanted to point=
=20
out the temporary breakage here.

> +	mutex_init(&kho_in.radix_tree.lock);
> +	return kho_radix_walk_tree(&kho_in.radix_tree,
> +				   kho_preserved_memory_reserve);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D2

