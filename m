Return-Path: <linux-hyperv+bounces-11297-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO/zNVadF2rXLAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11297-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:41:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C05EB950
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439FC3035815
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E052D0C9D;
	Thu, 28 May 2026 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd+4Ghbb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18527E076
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932499; cv=none; b=mm9NE0xoQQEOWVL9beL5AI+gRrgLYZc9rxs48OYwIAim8hop8G46o95zT8kUa50X3ytIb4B3kHzF8IAsQXdHl5IIuGnK8AiS3UzZOkA0GvnOtl5VUR2GfAL/ig+dUL/hZQZly2aNJEkGN5bCftD6ePqAkc0UbR3w6zKVIQzyGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932499; c=relaxed/simple;
	bh=1NNlFY9FnQ1MOLm3iSriWaGeUI/I4tkQcsaDqoB/Ftc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WD1EyShaOdWGG2rAF/Rj/I/7MeC+o7MqUUHw3tnuEUodrn4cCo6iy4mL4ClS7zvefjn8yRFowrlWHPSx5MVEbj0QVvjyhaF0B/8B4tPpdSO5sMwNxSCDZZtvFeMCe3GQoD8Lxm20I/qcv3nSnITOM1W1lpfAU7eN7UJ6TsWAcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd+4Ghbb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A4C1F000E9;
	Thu, 28 May 2026 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779932498;
	bh=KfaWjkdQMqPjozLOhKgWZi0hHw2HAADkp8aLkx4IMKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fd+4GhbbjHlC9pdkrO2q1OzW6kzvOi4ehtvpPjp3GKxvsMQW0BYjSe4QbFyj/vgoY
	 ubDBBBX3CipKJ1T+kYtHSxYSPLcsCoEV/vwbbM/tLm9R+R09uFqJft2Q0lc9ve6y+y
	 kqfY+tjr5K3VXiEWW0vfTHEK6qG8gk9yNYVykrgRI4PnucT7cOcF1r7XfEbGjsctdN
	 fCxQDptbj8i7Tue/9DbKqFGRXdwTHRMqvI2/JsD9ryJcl3J37rOQWlk47r2Oc1ZXIT
	 pyCL1PP7F63/i5lsBPimKqvzRvMxQFXce8238P50tDD6uPCojOrU2Vl9i6H3gFUegL
	 0ttsZfv82+eKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/20] mshv: Use page tracker to manage MSHV-owned
 pages and preserve with KHO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-16-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-16-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:41:37 +0000
Message-Id: <20260528014138.16A4C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11297-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 379C05EB950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KHO radix tree is accessed without initialization if KHO is disabl=
ed, leading to API misuse and potential crashes.
- [High] Concurrent memory withdrawal during kexec tree freeze causes memor=
y corruption and use-after-free.
--

commit 9c3872dd668bb8911798d680d377645cc757d8e0
Author: Jork Loeser <jloeser@linux.microsoft.com>

mshv: Use page tracker to manage MSHV-owned pages and preserve with KHO
   =20
This commit adapts MSHV page deposit and withdrawal paths to use a tracker,
and registers these pages with KHO to preserve them across kexecs.

> diff --git a/drivers/hv/mshv_page_preserve.c b/drivers/hv/mshv_page_prese=
rve.c
> --- /dev/null
> +++ b/drivers/hv/mshv_page_preserve.c

[ ... ]

> +int __init mshv_preserve_init(void)
> +{
> +	int err;
> +
> +	if (!kho_is_enabled()) {
> +		pr_err("KHO is disabled; page deposits will fail.\n");
> +		return 0;
> +	}

[Severity: High]
If kho_is_enabled() returns false, this function returns 0 but sets no glob=
al
state to actually reject subsequent deposit requests. Does this mean
hv_call_deposit_pages() will proceed and unconditionally call
mshv_register_preserve_page(), leading to a crash when it tries to operate =
on
the uninitialized radix tree?

[ ... ]

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c

[ ... ]

> @@ -69,8 +69,16 @@ int hv_call_withdraw_memory(u64 count, int node, u64 p=
artition_id)
> =20
>  		completed =3D hv_repcomp(status);
> =20
> -		for (i =3D 0; i < completed; i++)
> -			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +		for (i =3D 0; i < completed; i++) {
> +			struct page *pg =3D pfn_to_page(output_page->gpa_page_list[i]);
> +			int res =3D mshv_unregister_preserve_page(pg);
> +
> +			WARN_ONCE(res, "Failed to unregister PFN %#llx\n",
> +				  output_page->gpa_page_list[i]);
> +
> +			/* Free regardless -- HV has already released the page */
> +			__free_page(pg);
> +		}

[Severity: High]
Does this code introduce a use-after-free and memory corruption during kexe=
c?

If the reboot notifier calls preserve_tree() and freezes the page tree,
mshv_unregister_preserve_page() will fail. However, the page is still freed
to the buddy allocator here. The concurrent preserve_tree() walk will then
visit this still-registered node and preserve the freed page, corrupting the
buddy allocator state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D15

