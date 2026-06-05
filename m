Return-Path: <linux-hyperv+bounces-11510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oBaeJoXJImrGdgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11510-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 15:05:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7C64860C
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 15:05:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b="PnTLJx/e";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11510-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11510-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 807AB3033D35
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D97426ECF;
	Fri,  5 Jun 2026 12:50:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549E3ED5B3;
	Fri,  5 Jun 2026 12:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663815; cv=none; b=KTMSSR0UsqLl+WMjSq8qy/30OacLYWBbZhFkyUlISZ41liGhXF8IH8+sCo+jMWpx/KfrF5ty3aL5ydv9k8BAgl+47lkj/Q3V3CjS3yfPuU5rQ+4/7Kl1tVJlIuc5EgcGZGFOQF0EjlapSom8PrtM7kHZJodA+mN8pgAJwBXkhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663815; c=relaxed/simple;
	bh=jRtpO+wC8dazUZrx4nbEqBC447nlY+2XUq+0rL2jabQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SRWVt6F4yocYkS4UhgH9i3pC5brhf0fMdbcdu2Z0fq7RerRQVoJN/PWPw4Rd1geGFQQJxkZTAwVpa4ch7uYEn1wg+STTeevl/gQmc/yuSBnAK10vFPoS64fjJJh6j04CAOumJ/hS7ImvakVMjU9wUql6FOQHt9otazJMMgr4U+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PnTLJx/e; arc=none smtp.client-ip=212.227.17.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780663811; x=1781268611; i=markus.elfring@web.de;
	bh=wznGpYgvpVfxD8dVlG08Yma1GkklJErreSF/7SXz84I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnTLJx/eEsTFA5v1heUEN/JW/Tb4vxmiv4y1ijTOJ1xiQ/mA8GKg46lVHsP0CGli
	 qcoR28ymfHzurVVmdRTyBhCTXZImsUUWT7H+zIPN8vN4cqyCCxQYsAld8c7lm79nt
	 oBUeGRQWDFzsT+xv4GESr/GmKPhROU90x43VWatJyPdyKDQ3qLGSJDvnL/QvPludk
	 EsXxiXxOX00X1uyrUpyXPrwb837LqESaYxn20+wGr1IboQ56b26yoINZwa1ICUXJr
	 zQK8bYW/CThIz62hBY/9/N+yAuemHQeyQAOuY/H9gYYYz/l1kf8qBAs5adN72MfJ+
	 Zr0SzyHRVKU7TUnRAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJnX-1wTcT40TaD-007h1Y; Fri, 05
 Jun 2026 14:50:11 +0200
Message-ID: <4f969d00-df24-4cde-8539-8cbe4a09f417@web.de>
Date: Fri, 5 Jun 2026 14:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Long Li <longli@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] hv_balloon: Simplify data output in hv_balloon_debug_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OlrK/lhufmRs96iPTBkgoq7MG0GJEubz1k1zfJndkdm06euXEOz
 qSpyyFceiqXe1H6ag7pC35WOGGDBfeurgi8USkCcVUL2NoZtow2k9tRNz69DXvqT8II5hAF
 CJ+OtoGuEwqkoeDb77g8lt9Qxgkd6+SyQwOTsn3rPLjRVVPjJLn+mWWQYm5tRdC5ICb4dsh
 t1d8Fa25SbNvIGNYmmqdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lQA3WxfO9pc=;yAa0y2u5RYKBFCUzVae8p0S2VlA
 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
 XCXifuWZxCeymL7f4U=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11510-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-hyperv@vger.kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:longli@microsoft.com,m:wei.liu@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1E7C64860C

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 14:44:54 +0200

Move the specification for a line break from a seq_puts() call
to a seq_printf() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hv/hv_balloon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 9a55f5c43307..42ce27be344d 100644
=2D-- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1862,9 +1862,7 @@ static int hv_balloon_debug_show(struct seq_file *f,=
 void *offset)
 	if (hot_add_enabled())
 		seq_puts(f, " hot_add");
=20
-	seq_puts(f, "\n");
-
-	seq_printf(f, "%-22s: %u", "state", dm->state);
+	seq_printf(f, "\n%-22s: %u", "state", dm->state);
 	switch (dm->state) {
 	case DM_INITIALIZING:
 			sname =3D "Initializing";
=2D-=20
2.54.0


