Return-Path: <linux-hyperv+bounces-11647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0bTCMgYrNmo58QYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11647-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Jun 2026 07:54:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3D46A8618
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Jun 2026 07:54:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Zp1KzPVA;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11647-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11647-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 744683008FD1
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Jun 2026 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C87F1FE471;
	Sat, 20 Jun 2026 05:54:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A2AD00;
	Sat, 20 Jun 2026 05:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934848; cv=none; b=PZFptIQk92XdZYT1KYdZgS8rH1zOwYf6ov/K59AH/b09azbVNvax8H2FL8GnDMYxYc56vknSBStYR/ecie2J3TWdkmC5MvVYvowdavTie4kmeJfS/OdklbVwfghbSJ3bBm9B58c1Y20r9jgLLiJEVdRtoobxbpSoZ+XqC172hRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934848; c=relaxed/simple;
	bh=r3HUleWjSLSWjHs+Po/2UHPAB1IL0ZB3XemC7YIONHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mx0Osv9jXLuH9ljAz8rPrCVFgYErrj1EXI/qhYSmh3WGcCjFFtNuO7iKQ6JhoecBlYsOLJT+hysdqgaxGOUfEbaCgOkXQaGbYJesEJfPmy2G7HaZ4+8owTy2hYWaeeqOO15oD/aBJi7oft8v4RCi3hF7KGE/4G6jZ5sgNjLtsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp1KzPVA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564C1F000E9;
	Sat, 20 Jun 2026 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781934847;
	bh=sByWLIJaTIALxs6GR8Fv7ykcvn/to37QCJAb0wX8OnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zp1KzPVAhogWZ5zy8m2LVTRQm6jxWpYxbsqhhZov7bwqSuIjuWixgNoTdhGJEHomw
	 DhByoWf+MJdz7+bgAMmVkprrEgsAxL2QeTd/Uir9pzREnd06r/3Y+0edM4i91P7K/U
	 npQCHROeEi2toorh87jGEzsd1q+Bifo0bN1vCdLmfYibdvzdoLXvwoE/QMQwlxZR14
	 x++51MNzA4upI9x5/OXxX5aufvPYJF3MLcaEX3edrzfnGFm+zcxEU9VOnFrUTIIGBS
	 bfL1WmE0nFmK5x31sg9vpY5faW/djJSBFH0IjGmuH31LZDGrOZKlXvBsnPmcpWgNaj
	 BhnpUKyLpv9Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: Fall back to standard MTU when PF
 reports adapter_mtu of 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erni Sri Satya Vennela" <ernis@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260619055348.467224-1-ernis@linux.microsoft.com>
References: <20260619055348.467224-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 05:54:06 +0000
Message-Id: <20260620055406.C564C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11647-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA3D46A8618

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting error handling bug in XDP set path leaves apc->bpf_pro=
g pointing to a freed BPF program, leading to a Use-After-Free/Double Free.
--

commit 425f6bf5274f2172e13cdc649ea2288d8dc1ad72
Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0

This commit fixes a regression for older PF firmware versions by allowing
an adapter_mtu of 0 to fall back to the standard ETH_FRAME_LEN. It also
updates MTU bounds checks for XDP limits.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net=
/ethernet/microsoft/mana/mana_bpf.c
> index b5e9bb184a1dd..53308e139cbe9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> @@ -237,7 +237,8 @@ static int mana_xdp_set(struct net_device *ndev, stru=
ct bpf_prog *prog,
>  		bpf_prog_put(old_prog);
> =20
>  	if (prog)
> -		ndev->max_mtu =3D MANA_XDP_MTU_MAX;
> +		ndev->max_mtu =3D min_t(unsigned int, MANA_XDP_MTU_MAX,
> +				      gc->adapter_mtu - ETH_HLEN);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
to mana_xdp_set(), I noticed a pre-existing issue on an error path earlier
in this function.

Earlier in mana_xdp_set(), the program is assigned:

    apc->bpf_prog =3D prog;

If the port is up, it then allocates rx buffers:

    err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
    if (err) {
        ...
        return err;
    }

If mana_pre_alloc_rxbufs() fails, it returns directly rather than jumping
to the err_dealloc_rxbuffs label. This bypasses the cleanup step that
restores apc->bpf_prog =3D old_prog.

Since the networking core frees the bpf program on error, does this leave
apc->bpf_prog pointing to a freed program?

If mana_xdp_set() is called again later, could fetching old_prog lead to a
use-after-free or double-free when calling bpf_prog_put(old_prog)?

>  	else
>  		ndev->max_mtu =3D gc->adapter_mtu - ETH_HLEN;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619055348.4672=
24-1-ernis@linux.microsoft.com?part=3D1

