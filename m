Return-Path: <linux-hyperv+bounces-11507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OMiUC9edImoTbAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11507-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 11:58:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE226471EA
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 11:58:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bUSPhh70;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11507-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11507-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C17B53015722
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E63D25DC;
	Fri,  5 Jun 2026 09:58:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D583DB623;
	Fri,  5 Jun 2026 09:58:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653510; cv=none; b=BpOrH9nD0pwQ5Dl4csp2FYYB65Cj7wrG0UAUKT4NlC3VvQ8Ea3zuytwSfjy1frKoES/HbfPnLAngfpO7qNrx9jaoks76g9JsGpRgBmK/ICwXAX3m9I0MX3o8e5+qi7IQ5Sqt05PHj8nHcgk+fCl0vzED/AP9kev/tA9gRriTryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653510; c=relaxed/simple;
	bh=BygzOHjyOSVkTSgh+MomBExcBs0K0x/aVyJqUeMqedQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8Xs96oa6OVGzR/+IJ79SF9ZtU8/P9FJukzVcl3Lc5A5vNNqlQ9LR1VevEe8xDllWjb+VhImWZRYIns5SuceuGD0FddoLxxEmvOV969OuHWTVWdAMw1kHulErCMygD4ii435o7Qmb6UOwL57qc1srRNcIsbw6A4QNKC1LqmmZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUSPhh70; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA721F00899;
	Fri,  5 Jun 2026 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653508;
	bh=CfjJRZvGv/J/Gdx8pRfL5H61jiVMi14GAzOli9zBpRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUSPhh70wDXrzWrGJKDhxnwvII7x1SqYku/ZpS+6ADPXdEeaqZc18uHszWCPJh280
	 che0T1v+O23NoDqdvmnUc7c9sBy2r+3s9W+0NNpGUEIA4MVfxh4hIguSyLR4V47Sbt
	 lxSFiVu9VpITT22iTmsUOqsM0gU1YMWhnW/FLQJgG3TSQ96BK9MOyBiCkRrjn3MBFS
	 aoSg91WzqldRMayNZ8ZOlwP1OgU94chS5PPvZG9CcFzCKcbtxAb5AxiKmFT6KD+GeG
	 DQ+svCKtqUeJwyI9Hk/pkWgBx03W72/tnDiHllf9geLlDAw4rNo2b6aDrcaQ55xvSZ
	 8yGnZqGHN7ZDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ptp: vmclock: Use hw_cycles from snapshot for
 precise TSC pairing
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260604095755.64849-4-dwmw2@infradead.org>
References: <20260604095755.64849-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:58:28 +0000
Message-Id: <20260605095828.7DA721F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11507-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.co.uk:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAE226471EA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory read / Undefined Behavior in `vmclock_g=
et_crosststamp()`
--

commit 9639c73bd7986c7a2cf17a27c0bf79db7385ce83
Author: David Woodhouse <dwmw@amazon.co.uk>

ptp: vmclock: Use hw_cycles from snapshot for precise TSC pairing

When the system clocksource is kvmclock or Hyper-V, vmclock_get_crosststamp=
()
previously fell through to get_cycles(). This patch uses hw_cycles from
ktime_get_snapshot_id() when available, giving a perfect pairing for the
device time calculation.

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> index d6a5a533164aa..eebdcd5ebc080 100644
> --- a/drivers/ptp/ptp_vmclock.c
> +++ b/drivers/ptp/ptp_vmclock.c
[ ... ]
> @@ -140,6 +140,10 @@ static int vmclock_get_crosststamp(struct vmclock_st=
ate *st,
>  			if (sts->pre_sts.cs_id =3D=3D st->cs_id) {
>  				cycle =3D sts->pre_sts.cycles;
>  				sts->post_sts =3D sts->pre_sts;
> +			} else if (sts->pre_sts.hw_csid =3D=3D st->cs_id &&
> +				   sts->pre_sts.hw_cycles) {

[Severity: High]
This is a pre-existing issue, but by adding these checks, does this code
evaluate uninitialized stack memory?

Looking at ptp_sys_offset_extended() in drivers/ptp/ptp_chardev.c, the
struct ptp_system_timestamp sts is allocated on the stack but not
zero-initialized.

When ptp_read_system_prets(&sts) calls ktime_get_snapshot_id(), it sets
systime_snapshot->valid =3D false and returns early in failure cases (e.g.,
if an invalid or unavailable AUX clock ID is passed).

In these cases, the cs_id, hw_csid, and hw_cycles fields remain uninitializ=
ed
stack garbage.

vmclock_get_crosststamp() evaluates these branch conditions without first
checking if sts->pre_sts.valid is true.

Although the sample is eventually discarded by ptp_sys_offset_extended()
because sts.pre_sts.valid is false, branching on uninitialized stack memory
is undefined behavior and can trigger KMSAN warnings.

Could a check for sts->pre_sts.valid be added before evaluating these field=
s?

> +				cycle =3D sts->pre_sts.hw_cycles;
> +				sts->post_sts =3D sts->pre_sts;
>  			} else {
>  				cycle =3D get_cycles();
>  				ptp_read_system_postts(sts);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095755.6484=
9-1-dwmw2@infradead.org?part=3D3

