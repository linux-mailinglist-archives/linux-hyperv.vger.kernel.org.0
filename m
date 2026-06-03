Return-Path: <linux-hyperv+bounces-11464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2woIJbRQIGp/0wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11464-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 18:05:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012D6398A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 18:05:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rtk2PLdM;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11464-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11464-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEF37309E762
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697D3D9680;
	Wed,  3 Jun 2026 15:53:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F403A8724
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 15:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502026; cv=none; b=dx900ci0wWGTuPQWT32NkfLIULUknXRpEeO2DTkn6gwSzAV83MokTFlS+5K+Ihnlk2j5A8dqySstZ/WDDsXozvUnU8bkVXABR7aPz3kBSJyTlz1kd3+1bznp7SDqDLtsxUFzWMSUs5TFC/i24nimcDkaPMIa93EeXgRSh5R1Szk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502026; c=relaxed/simple;
	bh=SVwU+nu7ixI47o89wJ2RIIynJntH8QrnGxE+InZJ9zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kw4gf5ieHhC9jlEEH2ZwxKzp5jJ/NcUgZE+WE6bmw3C6xZAJk41vypgT7o5wIIT4jXE4DHJiDU9I3BU1vBJocThUxT36jm7+Vc8W0T1z6dxZAD/2qftW+FtPePRRgXrhLupAaCAtFGizAy4cQWuUMWGAtuCCVJ8EGDDjvaHJN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtk2PLdM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE871F00893;
	Wed,  3 Jun 2026 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502024;
	bh=EDK8TO9gTpCROTADql/d+/pzHmi5vX95UgcTw6KpUoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rtk2PLdMuPb5tFQD94+JX/+2/83R14PvjWSRlGTH7TeJkK2MmtCmzqznoV9u0evP4
	 C7QfvUo+tTYAJ4bhfiyFT4+8VyBe+emgGeocu1ZVG/yJhx4ayvT109gecPFcmOsd1o
	 M+hMLg3/BCEsqhsSfFeoiI+UwTqAxe4ita/L4d7tgnZ0ynNbw0drYswnoIkJAL+MTn
	 5nz3AyhEYZqdhdunlxXWD1896wpvwWQmwJ+Vf4+lL0GLZQailFcN8vqJjOX5rPWb4J
	 ECg7yVW+MYCpbpscQP5LcEIW2DvzZah2GNcEIJHTHT5DnWLvtBqATKasspLHgK8fdY
	 wpXA/RHXuk3Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: LeantionX <leontyevantony@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260602155210.90987-1-leontyevanton1995@gmail.com>
References: <20260602155210.90987-1-leontyevanton1995@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:53:44 +0000
Message-Id: <20260603155344.7CE871F00893@smtp.kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11464-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3012D6398A3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Passing a Hyper-V PFN directly to `pfn_to_page()` causes out-o=
f-bounds memory accesses on architectures where `PAGE_SIZE > 4KB` (e.g., AR=
M64 with 64KB pages), and loses the intra-page chunk offset.
--

commit a844fbf018cd37eedc9a1f0aea79d6235c00bec3
Author: Anton Leontev <leontyevantony@gmail.com>

hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

This commit replaces phys_to_virt() with kmap_local_page() in
netvsc_copy_to_send_buf() to map skb fragment pages. This is intended to
fix a fatal transmit softirq fault on 32-bit x86 configurations with
HIGHMEM, where phys_to_virt() is only valid for LOWMEM addresses.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..6984f6c97257d 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c

[ ... ]

> @@ -965,11 +966,13 @@ static void netvsc_copy_to_send_buf(struct netvsc_d=
evice *net_device,
>  	}
> =20
>  	for (i =3D 0; i < page_count; i++) {
> -		char *src =3D phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
> +		struct page *page =3D pfn_to_page(pb[i].pfn);
> +		char *src =3D kmap_local_page(page);

[Severity: Critical]
Does this cause out-of-bounds memory accesses on architectures with a native
page size greater than 4KB?

The pb[i].pfn field contains a Hyper-V PFN, which always operates at 4KB
granularity. Passing this directly to pfn_to_page() assumes it is a native
Linux PFN.

On architectures where the native page size is larger than 4KB (such as
ARM64 with 64KB pages), the Hyper-V PFN is significantly larger than the
corresponding native Linux PFN. Using it with pfn_to_page() would return an
invalid struct page pointer.

Calling kmap_local_page() on this invalid pointer in
netvsc_copy_to_send_buf() and subsequently reading from it could lead to
memory corruption, out-of-bounds accesses, or kernel panics.

Could this also lose the native page offset of the original 4KB chunk within
the larger Linux page, resulting in an incorrect read offset during the
subsequent memcpy?

>  		u32 offset =3D pb[i].offset;
>  		u32 len =3D pb[i].len;
> =20
>  		memcpy(dest, (src + offset), len);
> +		kunmap_local(src);
>  		dest +=3D len;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602155210.9098=
7-1-leontyevanton1995@gmail.com?part=3D1

