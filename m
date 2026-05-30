Return-Path: <linux-hyperv+bounces-11387-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKIGAf4zGmp+2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11387-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326660A5F3
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A763006967
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D1265CC2;
	Sat, 30 May 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM1ReYr+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5B246BC0;
	Sat, 30 May 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101847; cv=none; b=aQhrsFVWCWw4G6C7v5Xqk8tbRQEKEIh/pcaWcQFl3kKMHDlz1wqe8H18F7pVV9S7MXWZpc5oRFySnnStRGzjpYlHGC4aygS9vDkT4D5P+YGE3o6dK/p6TeS/Ln0nlCDtmzf323GubQER6tYt8FeFUxZsu4f5uxZnVMbIld2blNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101847; c=relaxed/simple;
	bh=9sPEbIs5wETVwQWYeneb98pkak8yKLPwNV3/ryury18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLfKk99i73qsEIqt+sLUwuSTf/TrDKb0f220lPl2z0XA5tcPeiNAeDNgMS70NZATJobU5SH3ejDnuae1f1L5HSnXBwvPpf0gAkAnz1T8ffqFw/bPg2OsMxczjT1lCa+j/nfitM8Yivm2Zj553cGMVVvc8ZVEtsTYBtz/QLrku5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM1ReYr+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65901F00893;
	Sat, 30 May 2026 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101846;
	bh=m+gB52xWkr7M9Q1iUJg7YGAJNayA9Cp04Tc4DuvxMcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GM1ReYr+0DYhyRU+VLUw1d41uOOTWx+XOdnONKfbn4STYwue/cxM/D1LFgTkkgwyD
	 mZu2ieruvSXn5/tBa4IRWR3ML0IQ005F+Y/ssV+UnGEojb5jcX64bBCS8qZkB6CQk1
	 c6H1eatPzj7XRb/iyhfAL/f+IngsFQ6+zAbdnG+eO84mpit2tl8fQgTeBG1y3V6Ug4
	 7AaPiGm79PVVEgH7xOL/7Y08r7aTNmQregulS7UdY/ifpOFX5TUflbCdYTgnoU5NSj
	 gaSSkanQPAnayIVEA68oleKzjJAuEj64k/hT8M5FPIVGDYJqQDc+WC3OovYMHXU6eY
	 Odd8rpFwt0Rjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock: keep poll shutdown state consistent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyu Zhang" <ziyuzhang201@gmail.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260519165636.62542-1-ziyuzhang201@gmail.com>
References: <20260519165636.62542-1-ziyuzhang201@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:05 +0000
Message-Id: <20260530004405.C65901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11387-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 7326660A5F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent non-atomic read-modify-write on vsk->peer_shutdown with=
out synchronization leads to lost shutdown flags, potentially hanging host =
processes.
--

commit d7feaefbab86483ded481345d096a59fb79a2b29
Author: Ziyu Zhang <ziyuzhang201@gmail.com>

vsock: keep poll shutdown state consistent

This patch updates vsock polling to use a consistent snapshot of the
peer_shutdown state to avoid race conditions between checking for
HUP/RDHUP and EOF readability. It introduces lockless READ_ONCE and
WRITE_ONCE accessors for peer_shutdown in datagram and stream sockets.

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
[ ... ]
> @@ -1542,7 +1542,9 @@ static int vmci_transport_recv_connected(struct soc=
k *sk,
>  		if (pkt->u.mode) {
>  			vsk =3D vsock_sk(sk);
> =20
> -			vsk->peer_shutdown |=3D pkt->u.mode;
> +			WRITE_ONCE(vsk->peer_shutdown,
> +				   READ_ONCE(vsk->peer_shutdown) |
> +				   pkt->u.mode);

[Severity: High]
This is a pre-existing issue, but does this non-atomic read-modify-write
sequence risk losing concurrent updates to the shutdown mask?

While vmci_transport_recv_connected() executes under lock_sock(),
vmci_transport_handle_detach() can be called from softirq context via
the queue pair detach event.

The detach event uses bh_lock_sock() without checking sock_owned_by_user()
to defer execution to the socket backlog. Because lock_sock() releases
the inner spinlock while setting sk_lock.owned=3D1, bh_lock_sock() can
successfully acquire the lock and execute concurrently.

If the softirq executes exactly between the READ_ONCE() and WRITE_ONCE()
calls here:

CPU 1 (vmci_transport_recv_connected):
    read =3D READ_ONCE(vsk->peer_shutdown);

CPU 2 (softirq detach callback):
    vmci_transport_handle_detach()
        WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);

CPU 1 (vmci_transport_recv_connected):
    WRITE_ONCE(vsk->peer_shutdown, read | pkt->u.mode);

Could CPU 1 overwrite the SHUTDOWN_MASK written by CPU 2? If the
SHUTDOWN_MASK is lost, it appears host processes blocking in poll()
could be left sleeping indefinitely because the connection closure flags
won't be fully recognized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519165636.6254=
2-1-ziyuzhang201@gmail.com?part=3D1

