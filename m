Return-Path: <linux-hyperv+bounces-11295-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG41D62bF2ohLAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11295-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:34:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 902655EB92C
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA0C3047246
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B501A6823;
	Thu, 28 May 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCGj4Wo2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D0175A9C
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932074; cv=none; b=P7IC6GYLdcDnqOgipdWFctDjvn++BDgJGEG6pNZsvqZpmcdg6uQI6dau0+nfGCQeCufE2yCgCqpbNKPCYgR0MhZOi3z+90kS670rEKGWZIgQt1/vj3teY8/jSxT3/OWQ3SoVV+5vJa+3+o3S2FupW7Et6SmdShWA4cLfPMKzI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932074; c=relaxed/simple;
	bh=WZuaRYHxsBlHfdebi8CZnULKDh3AUu/KEt3DcA4a6gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkV/bxKl2CBViY5iiisnxIOaIwHsnLXUgsnMB7kg45n5t8FcsTjlRiF18rn/emCb6dZ9qmOERP/KOk7wwE5tZbtz0TNKH1osBpJC3+8Obh48/MzjaBUvBRTqm7RPgmWE6qtmEIFjrnez5nQrAbUlJZaslOOu20lD/Ch0xZaKF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCGj4Wo2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46901F000E9;
	Thu, 28 May 2026 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779932073;
	bh=wCz6YtZx4YVWuO2qD2rdmDSfzW5nOSH7VHdu5OGUILg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cCGj4Wo2fxlp1XToO55JfNOYxKmfo8yQixEnbE7EZrEg8uf7oJDIHDCtVZW36ZXEU
	 JO8/7dNzYvOu2yigME1cwSVQn6Izy4JnqJZxtoWSf6lXJNshk06xcQJprH0KhdLz4p
	 xSF5RwYpxcysgj3Vj2muzbTkgog5O8StVkowFB/RVrVV2Jnrq57Yj8AH83WsYF6DWx
	 M/j5DDhiRjAJ0vCLe0MU6wuntOQzaCFA4pmwFkjMBIFuznZwrVFuAzB7APGbZQE9Xt
	 PPd8XiZUpVWIQ9NZK8Tze30RLhuPegDSxu7UTxEwzd3rf0HUrfXHS2hBv2xcrL7MZx
	 mfNe624rJKAbg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 17/20] hyperv: Reserve crash MSR P2 for page
 preservation root PA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jork Loeser" <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260528004204.1484584-18-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-18-jloeser@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 01:34:32 +0000
Message-Id: <20260528013432.E46901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11295-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 902655EB92C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing the overwrites of crash MSR P2 in panic paths can leak a =
stale KHO root PA to the crash kernel if KHO is currently disabled.
- [Medium] The commit message incorrectly describes the register shifts on =
x86, hiding the undocumented removal of `regs->ax` from the crash report.
--

commit a2f7e475a7dfd02f8ed395438172d715377b9152
Author: Jork Loeser <jloeser@linux.microsoft.com>

hyperv: Reserve crash MSR P2 for page preservation root PA

This commit reserves the crash MSR P2 to pass the KHO radix tree root
physical address to the crash kernel for MSHV page exclusion. It updates
the panic reporting paths to stop overwriting P2 and shifts the remaining
register values accordingly.

>     Move IP/PC to P3 and SP to P4 in hyperv_report_panic() on both x86
>     and ARM64. Remove the P2 write from hv_kmsg_dump().

[Severity: Medium]
Does this description accurately reflect the changes on x86?

On x86, SP was already assigned to P4, so it is not moved. Additionally,
moving IP to P3 overwrites the previous contents of P3 (regs->ax), entirely
dropping it from the crash report.

Could the commit message be updated to explicitly mention this loss of
diagnostic data?

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -185,9 +185,9 @@ void hyperv_report_panic(struct pt_regs *regs, long e=
rr, bool in_die)
>  	 */
>  	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P0, err);
>  	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P1, guest_id);
> -	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P2, regs->pc);
> -	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->sp);
> -	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, 0);
> +	/* P2 is reserved for the KHO preserved-pages tree root PA */

[Severity: High]
Could skipping the overwrite of P2 leak a stale KHO root physical address
to the crash kernel if KHO is currently disabled?

If a KHO-enabled kernel writes a valid radix tree root PA to P2 and then
kexecs into a KHO-disabled kernel, the KHO-disabled kernel might not clear
the MSR during its initialization.

If this KHO-disabled kernel later panics, leaving P2 untouched here means
the crash kernel will read the stale PA from P2. Since the memory at the
stale PA was likely reused, could walking it as a valid KHO radix tree
cause a page fault and break crash dump collection?

> +	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P3, regs->pc);
> +	hv_set_vpreg(HV_REGISTER_GUEST_CRASH_P4, regs->sp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528004204.1484=
584-1-jloeser@linux.microsoft.com?part=3D17

