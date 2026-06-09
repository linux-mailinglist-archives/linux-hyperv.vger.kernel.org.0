Return-Path: <linux-hyperv+bounces-11569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pykHEgBcKGrTCgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11569-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:31:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C817663560
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="aQ//6KQD";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11569-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11569-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903BC301DCCB
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EC3CF20F;
	Tue,  9 Jun 2026 18:27:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB7331ED3
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:27:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029641; cv=none; b=Ky8hUuQ0Txn4kt0NHQLlOllD3/2B+gfFxmL7iqJkMz8CSpWcSgno5NzMSd5FDQ/yXbdce3FAAu5s1F8K2a+EYv7Lfh7S34VHQWxc9EGzD6BD97tUSWkhhudr4W8kH+qDLuh1OGHej9dq7Z1ge1Qe7oZk4oAJMM5ooUCP3CPH6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029641; c=relaxed/simple;
	bh=FeCtmda/y4fCoD47jOQAdETiqgoa4NjFqq24WsF2D7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4nTgWljN6Uqec17Ax7wQ4Dbwq15xbvzqPi8Rfuhgj2rUNQtihE7Tssu0KIDR/Dt7QQLRMIOI3ID8Wi0/hz6Np8w0DM4GQAQaCXd2iY3Q82wqsifaZAYGWj509ZKed95JRihzvHg7PygBdn7NmmOQMeDjU/v612YDErR+MEjnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ//6KQD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD51F00893;
	Tue,  9 Jun 2026 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029640;
	bh=IZIWF7HpSyTBs9x3InVG7ESg7Jp+eCnzKAtWgJbW3Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQ//6KQDx+/vms5wX70zNjqMBD48cf+AwTPZGp9pgQux70GW721HpeIzCNrs2LmcL
	 jEZRyKOoeyB7P3rDwmy/l8G75iUFvjOhmoAaaoFsdaK970/7ybc5DB+k1+v361W9Yw
	 CgcRkwILRGETm+42oB9l5KswQXuGMYHTVXalUNL6RmBZ9XydOxZc/rX98TnqIhAX37
	 escFRmJi4s08/k3tt3Q6yvaM2DM0Hj6GB0Sd7ssP/ZBkNvw2GP+hA85Isf9gGWseIL
	 X6dKX8aFzXLdLj+SCpqkzlHcRo73tr3gfEjSiUNggja42OREaEJ9IkSkqbeKVDX9jW
	 kXzQUoNxdLu+g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] Drivers: hv: Mark shared memory as decrypted
 for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-5-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-5-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:27:19 +0000
Message-Id: <20260609182720.48BD51F00893@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11569-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C817663560

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Calling `set_memory_decrypted()` on a `HV_HYP_PAGE_SIZE` kmall=
oc buffer causes out-of-bounds memory decryption or silent failure when `PA=
GE_SIZE > 4096`.
- [High] Passing an MTE-tagged `kmalloc` pointer directly to `set_memory_de=
crypted()` without untagging it causes address validation failures and brea=
ks CPU initialization.
--

commit 3df67c547c1f3625047cb1aee50d949f7179dd45
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

Drivers: hv: Mark shared memory as decrypted for CCA Realms

In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
to be marked as decrypted (shared) for confidential VM isolation types.
This is already done for SNP and TDX isolation; extend the same handling
to Arm CCA Realm guests so that the host hypervisor can access the
shared hypercall buffers.

[ ... ]

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac6167891..010c7d98b5de1 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -499,7 +499,8 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
> =20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {
>  			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);

[Severity: Critical]
Will this decrypt out-of-bounds memory or fail if PAGE_SIZE is larger than
4096 bytes on ARM64?

The buffer mem is allocated in hv_common_cpu_init() as 1 or 2 Hyper-V
4KB pages:

mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);

However, set_memory_decrypted() expects pgcount to be the number of system
pages. On ARM64 kernels configured with 16KB or 64KB pages, passing pgcount
will decrypt 16KB-128KB of memory, potentially overrunning the 4KB or
8KB allocation and exposing unrelated adjacent slab memory to the hyperviso=
r.

Additionally, if the kmalloc buffer is not aligned to the system PAGE_SIZE,
set_memory_decrypted() will trigger a WARN_ON(!PAGE_ALIGNED(addr)) and sile=
ntly
return 0 without decrypting anything, leaving the hypercall page encrypted.

[Severity: High]
Does this code handle MTE tags correctly when passing mem to
set_memory_decrypted()?

On ARM64 with MTE enabled (CONFIG_KASAN_HW_TAGS), kmalloc_array() returns
an MTE-tagged pointer. The ARM64 set_memory_decrypted() implementation
validates the address using __is_lm_address(addr):

arch/arm64/mm/pageattr.c:__set_memory_enc_dec() {
    ...
    if (!__is_lm_address(addr))
        return -EINVAL;
    ...
}

Because __is_lm_address() performs software-side arithmetic without strippi=
ng
the tag, the MTE tag bits cause an arithmetic wrap-around. This evaluates
to false, returning -EINVAL and failing the CPU initialization process.

>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
>  				return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D4

