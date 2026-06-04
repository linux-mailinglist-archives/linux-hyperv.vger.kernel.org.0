Return-Path: <linux-hyperv+bounces-11492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id haVjOsG2IWrqMAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11492-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 19:32:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A42C64250F
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 19:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RhNMk4M1;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11492-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11492-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E2C300D148
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D937205C;
	Thu,  4 Jun 2026 17:25:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B147ECFA
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 17:25:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593951; cv=none; b=iQuRTbYChhVgvtab3WjjHI2vegv2IXBUI/ONDzgsbZBBShv6WwDBoevTYpLviQUNqiP0VGxkS4NRuSL/95loSZX3PtF2k2hSBL1yN9bCx75CC8W3UI7Kjb7NcdbnL7cEdEse8CHOkbSrDmWGu3MjaId6tLPRdxbbgBHDa87uM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593951; c=relaxed/simple;
	bh=uFvCx508CsbvR47UFVJPBghrH3d2h1nGC6Cr+X0YvwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJLvWAK8aonKx5zFom36HsMEhTTLreDt7GSSi8RdYQ0U6j77Ku3moBhLXWvQFrP5ihvfdNTFupQ2j+1RYpExjdYXIEu0Z/9lRfEqFgQVBOr1LDb5ir6jDIWczotwXq7JT2tC60EgUklw4ZA2kN9MEOUEHYLSzZ8r1hBwEDS6eD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhNMk4M1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942F41F00893;
	Thu,  4 Jun 2026 17:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780593949;
	bh=MRAcPqvWT7jxOLKZZYYgLxgifRTkrZsyvjxQQww/koA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhNMk4M1O+hDH8kDdWAnwbrJP8a3ZotqIBQrtGJgb7noLaGQVSlZ95SlXJOd2oxz3
	 XfriRVd7syifjl7+DJ+NU5ZzFgJdbuqHs4bBHdwhh8OGsbtX44/D0s24MsWJrBgWW6
	 qSyRvE6XpT+4Ur73LT/pcYHLF+7hbfEzchg9LqvVfbNLOmxmsETowP3D2bjucnvKGp
	 CXb0sVOwvIdS8UnLu9jk5ur80C4JLztEOUlCgHC4gb/a0k7OZsIBjfEK7bFmouax5s
	 CBqfs3FYeeqSFvt5HyXXtnu9QUTRtq51NsieEenhL/IUMcJ39cRSZk5CUuTn85ZQb2
	 UX2vJH7OFXhrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] hv_netvsc: use kmap_local_page in
 netvsc_copy_to_send_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Leontev" <leontyevantony@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260603172543.19230-1-leontyevantony@gmail.com>
References: <20260603172543.19230-1-leontyevantony@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:25:49 +0000
Message-Id: <20260604172549.942F41F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11492-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A42C64250F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] `memcpy()` overruns the single-page mapping created by `kmap_l=
ocal_page()` when an SKB fragment spans multiple pages.

Pre-existing issues:
- [High] Concurrent writers to the per-channel `tx_stats.syncp` will corrup=
t the statistics seqcount, deadlocking readers on 32-bit systems.
--

commit f885c2ff3318238c254b9deff5078d8c10f79e15
Author: Anton Leontev <leontyevantony@gmail.com>

hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

This commit replaces phys_to_virt() with kmap_local_page() to safely access
highmem SKB fragments on 32-bit systems, preventing page faults.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 59e95341f9b1e..2038d9f5c9f9a 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
[ ... ]
> @@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_d=
evice *net_device,
>  	}
> =20
>  	for (i =3D 0; i < page_count; i++) {
> -		char *src =3D phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
> -		u32 offset =3D pb[i].offset;
> +		phys_addr_t paddr =3D pb[i].pfn << HV_HYP_PAGE_SHIFT;
> +		struct page *page =3D phys_to_page(paddr);
> +		u32 offset =3D offset_in_page(paddr) + pb[i].offset;
>  		u32 len =3D pb[i].len;
> +		char *src =3D kmap_local_page(page);
> =20
>  		memcpy(dest, (src + offset), len);

[Severity: Critical]
Does this memcpy() risk overrunning the single-page mapping?

kmap_local_page() creates a temporary thread-local virtual mapping of exact=
ly
one native page (4096 bytes on x86). However, the length of the fragment (l=
en)
can exceed a single page.=20

For example, init_page_array() maps the entire linear skb->data into a sing=
le
hv_page_buffer entry, and skb_headlen() can exceed 4096 bytes with jumbo
frames or GRO/TSO packets.

If pb[i].len + offset > PAGE_SIZE, this will read beyond the mapped 4096-by=
te
window and access unmapped fixmap slots, potentially triggering a page fault
on the transmit softirq path.

> +		kunmap_local(src);
>  		dest +=3D len;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can concurrent writers to the per-channel
tx_stats.syncp corrupt the statistics seqcount?

Looking at netvsc_ndoxdp_xmit() in drivers/net/hyperv/netvsc_bpf.c, it sele=
cts
a transmit queue using q_idx =3D smp_processor_id() % queues and updates th=
e stats:

drivers/net/hyperv/netvsc_bpf.c:netvsc_ndoxdp_xmit() {
    ...
    tx_stats =3D &nvsc_dev->chan_table[q_idx].tx_stats;
    u64_stats_update_begin(&tx_stats->syncp);
    tx_stats->xdp_xmit +=3D count;
    u64_stats_update_end(&tx_stats->syncp);
    ...
}

If num_online_cpus() > real_num_tx_queues, multiple CPUs can simultaneously
execute XDP transmit for the same queue.

Additionally, the NAPI TX completion path independently updates the same
syncp on the CPU bound to the VMBus interrupt:

drivers/net/hyperv/netvsc.c:netvsc_send_tx_complete() {
    ...
    tx_stats =3D &net_device->chan_table[q_idx].tx_stats;
    u64_stats_update_begin(&tx_stats->syncp);
    tx_stats->packets +=3D packet->total_packets;
    tx_stats->bytes +=3D packet->total_bytes;
    u64_stats_update_end(&tx_stats->syncp);
    ...
}

Since u64_stats_update_begin() does not use locks, concurrent updates could
leave the seqcount odd forever. This would cause readers like ndo_get_stats=
64()
to spin infinitely in u64_stats_fetch_retry(), deadlocking the CPU on 32-bit
systems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603172543.1923=
0-1-leontyevantony@gmail.com?part=3D1

