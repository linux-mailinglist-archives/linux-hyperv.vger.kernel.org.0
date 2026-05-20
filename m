Return-Path: <linux-hyperv+bounces-11050-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC1JJgppDWquwgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11050-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 09:55:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 992605893B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96ED73001A60
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945136494F;
	Wed, 20 May 2026 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iML8noLh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743832D7C7
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263749; cv=none; b=jS8HGlOA6/MhOOI9q6LPomi8F1+kZuxWD4U3G69F5Td0I9D30spB0VkNskZA36BHvNzesAMMqP7l99zLbyDU8U6BOXjzc5H0eKUfT1Q94cFn7/4hY9VFm1VLdgfLHDr4K4Vasqce5p+sAw/sQsjFhTCcsXnWhwyuyuQdnzsWN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263749; c=relaxed/simple;
	bh=EQAu3Bk5HxN0v7WLhIZeITL19BswIUni5vUf+ZEeE9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fuLOPquK7z2e0yzrKOHDl/vDXOoqzNMsgbAt7MxWOQVJg9MAgEnsvyBkIKgfLnf6gsbJSLd0ls+XrHz5eB3OcbMsNDBVSRtJwXV1oR3i1WrFMcG5ovY74DXLV+DIRP3likyHKKPxmtkMUNq1kOh8M0ltdQpafdLqX3guQCeAHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iML8noLh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C7E1F000E9;
	Wed, 20 May 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779263748;
	bh=qDdPO1io3/qeRF+vnUJErw0U0RdxvZQ3X96dz5zt574=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iML8noLh12XU/flCOkD91wkZzh7E2VzuMIyLCglxuT1syx8vpQKNyg0ZIVzAGzvQo
	 RLxKQGHhHWw/xfsptevXW/LtbRNENmFgoe94OZxBGt0yt48Rup9dEw7oRG5SPvnNrn
	 F0PIfWzJov7kSkw026hU1TYqYIxkJYdxDRY89fquX7HDOb59m1PoMIw2/o/J7V1eU6
	 gMZ1ihpmkzWSwS+Z+l3Q4Y1jcK/VS0x912UlGVcYC8kwSQSFQaDh3TBeuf7rm8JAbX
	 6kbZtpccyuh89vJ8zcmWUMWCxChi6YSKJ+U4S8M+UMzXaB65WIJ7Mf33UQUkEMbd6o
	 A6P4+S119FGlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers: hv: use kmalloc_array in
 mshv_root_scheduler_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Peng" <pengcan@kylinos.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260520071632.557990-1-pengcan@kylinos.cn>
References: <20260520071632.557990-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 07:55:47 +0000
Message-Id: <20260520075548.08C7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11050-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 992605893B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A CPU hotplug offline operation can lead to a NULL pointer derefer=
ence in `mshv_vp_dispatch` because user tasks can still execute on the offl=
ining CPU after the per-CPU buffers have been freed.
--

commit 182b63fe189dbbf1da723a03d972eaa7cbb71f56
Author: Can Peng <pengcan@kylinos.cn>

drivers: hv: use kmalloc_array in mshv_root_scheduler_init

Replace kmalloc() with kmalloc_array() to prevent potential overflow, as
recommended in Documentation/process/deprecated.rst.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd4..146726cc4e9ba 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2241,7 +2241,7 @@ static int mshv_root_scheduler_init(unsigned int cp=
u)
>  	outputarg =3D (void **)this_cpu_ptr(root_scheduler_output);
> =20
>  	/* Allocate two consecutive pages. One for input, one for output. */
> -	p =3D kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	p =3D kmalloc_array(2, HV_HYP_PAGE_SIZE, GFP_KERNEL);
        ^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but is there a pre-existing
issue where a CPU hotplug offline operation can lead to a NULL pointer
dereference in mshv_vp_dispatch()?

The CPU hotplug teardown callback mshv_root_scheduler_cleanup() is register=
ed
at CPUHP_AP_ONLINE_DYN. During a CPU offline operation, it frees the per-CPU
buffers and sets the pointers to NULL:

drivers/hv/mshv_root_main.c:mshv_root_scheduler_cleanup() {
    ...
    *inputarg =3D NULL;
    *outputarg =3D NULL;
    ...
}

User tasks can still execute on the offlining CPU at this high state in
the offline sequence. If a vCPU thread scheduled on the offlining CPU invok=
es
mshv_vp_dispatch() after the teardown callback has run, it unconditionally
dereferences the input buffer:

drivers/hv/mshv_root_main.c:mshv_vp_dispatch() {
    ...
    preempt_disable();
    input =3D *this_cpu_ptr(root_scheduler_input);
    ...
    memset(input, 0, sizeof(*input));
    ...
}

Does this sequence result in a NULL pointer dereference if the input buffer
pointer has already been cleared by the cleanup callback?

>  	if (!p)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520071632.5579=
90-1-pengcan@kylinos.cn?part=3D1

