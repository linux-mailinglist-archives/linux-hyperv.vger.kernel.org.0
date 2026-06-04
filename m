Return-Path: <linux-hyperv+bounces-11491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GusKCFuxIWqBLQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11491-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 19:09:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22F642340
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 19:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z70+AGEP;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11491-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11491-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5775430B596A
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0241830C15C;
	Thu,  4 Jun 2026 17:00:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272A31E83E
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 16:59:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592400; cv=pass; b=WkQJqf161LTDHVzNMIH5LKXM3C3o+x1cdgLNob9HKUziPX5yel4raPuuk+VfuFJG5sLH/AaJiagywiub29tU52c5oX3MZxcwiWlCbKLnMu0qkk4P2VQGEIp9RQ7Nf86S2EYzEk1EplnRwoYBz/zK+yHS9tgOzMl+uQp2NAjpHFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592400; c=relaxed/simple;
	bh=aYLfMzw9PHJwFY6JBY5oV2zpZ2+xt+0iwSXoHkKmj3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6Pu1kYUFlhaCnaQmZYrHKfoNURlqj31pb5OximENHR6gytr1vHvWKmgsSf+QDbOS5DWbXc+TVdpEW2WAnuWJk+Wkdi9iOgmTtVDWKE6tfupl7rL69xusBAx7mxAfMtUgWVSXjKPoe0i+3PZRetRQLD1t2G9JPPbGUREbesEVtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z70+AGEP; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66061993294so1130197d50.3
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Jun 2026 09:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780592399; cv=none;
        d=google.com; s=arc-20240605;
        b=JLsPFEc+SsHbRZc7CSkbmsKLhi7dZLfiNz8Lu8WnNLp8U6aDrbcbHwkeq6xnwh20P3
         Y9rH+shB417R70VUA/7Lge5g7+TGAtLwCCjbwMejAAcUDOUBnMUJ8y2uFQSCD7vPMaX+
         WJrIGGUZ1KBZPDw7KmTJ7hPIB5/rKthEE0pFQKyz7UmTkRc/3lPVS3FIxhc0V4cNtHbP
         rLsmjkWUqSOhU18QQ96eTNIPKiaLT/0iOmnRaB95kxXyRURgfuHDgq9JpC5kCJUgFaHI
         zj4rMmQpvSgru9go0som8pN/ObR+w6tx9QCfnfPiFmRb25t6QGItV8BXP9Wi34rwow4f
         xIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jCmuIqZca1BHFbKewzVbW4c8gx6ri67M5ywiPVj0zA=;
        fh=D0e8sSTaVPmAgUSFERRWgkzhkCafsr+sW9jV93yuieQ=;
        b=SMV4zCwwWvL+VqCFkmzLk+CSCZSrdzXHRAsVimnQopRLB2lVFZX57wZHBLk7N2JIoc
         B6F4g+S4DAx1w9F3j/QeJJNziS5M2RUKSOcL+xzJRte6pq8hv2KPIaVrpxm0awcsCmtE
         7PP2Ak+iB+QEV4Sef/uNiq+5Tv92Kquw4LI+wALpxHOtDaDU/6tJ7XiNXpPncoo3Gryw
         C0vl71yB5wRUz0CjUYz1sGTikWBTacGOui/zk7dJyVkcnZamkzuwVTPuIemiIaLeQRVS
         7qV8E0u5OmEFSqa28mlAODoVsKYrvTKJwT+ta8QYOLXeoz4NRZfuE5Ikw3cNskpSVKIu
         1rxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780592399; x=1781197199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jCmuIqZca1BHFbKewzVbW4c8gx6ri67M5ywiPVj0zA=;
        b=Z70+AGEPa7/+r5VznX0u9GFCDDwyMqMgPFlQFqMMIB9fYB9Wx8NHUMwkqjD9l7xcT4
         WuYxh+Vw14nPKZHZqCjngMC0eMXhxYjI7aJmrNwuAp7X3nQaaFHCnlpMaB9TlO/UTFEG
         msh/fA/vdRM9zVuaMCyfT3rRuPqt6jC+aW8FH7M8jK6xTySaAC2oMMBtqzENwhqSDDAc
         TdBy6vnB0fFN5Zi2qPzJSxpuH+rfd5bBAEnOchyzdWdbtkXPTnEQTJ9O61IGQXYacOAw
         ffrmM3+eU/GU/8AwyyQa9mt2j4YzwNP58iiUpx3RvwyZd6bG2E7oBMttyxI9vCK+Bb3W
         ka5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592399; x=1781197199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jCmuIqZca1BHFbKewzVbW4c8gx6ri67M5ywiPVj0zA=;
        b=QYgbXP8frNC1MneXPMPsoeeeRSdZkKaBQCYCaXGDXDh3WRI4deflRlYW3rGN17Fq4V
         8jnXhMU88c3YSSCRffeSb7bFymQ8nZowq7JEbli/4tM93ZWyieBEWV5XHKBK/knNHYEZ
         /2PpXj9SKI1iWYUGxjbiAWWJbzgTFAh3y38l/2fZ6LLdylh49siJ87LnbSmy3JUSUtGe
         i2YE/7tNdDRUyf6QZQGBZc3uWWt5m9vXKk0q0qD7h68lpiwkOx8wcXe0HKiurl4Nohll
         DNCIco07VAM8kM6+kkZ97L7igLSmgUt1GtTIwReeqUrCSTOgXlLYrc7AMZDd1gkxiCjB
         yD7Q==
X-Gm-Message-State: AOJu0Yy5JXvVvDlSfxvsmv0FsLwA6uuG5gaxaENFst3Pg0IEGevBO46y
	3SiroT7/rjvSvJCG0s+4r0Ia2yAu6bNIJCc0aKCkn0gdrSryYUFNh2Z4z++0nj7iRIh9qZBDHgE
	XP5naoq4fsndJUo677sLOR4RPhvkBBQboWEcnUPpn8gi5
X-Gm-Gg: Acq92OEj+uhpey/oXmrsS/37DOHYzF5ZcL2EXGf+vVCJSMMtnUesdo9u5GqwrRB7UZH
	QYXvTQquB8r3LKOKaUP1YfQyAcR3Q6pfOghYWbhyCDd9gQ+Yoijr0OJDFohDciNaHgYCH3bsGn6
	Trw/Gfxtnr7llypIy8k4TMtTjBnmdAN3xt6BJQ2EnzC6pXxFie666kS5iJMzhRy8JU6+Trt6Vpp
	+73gqVwBumLcvG8xaXb5jRCqtdFUjERIP7fUYK4TDz99CH2kWvS2u3xy+mC9T1AzFIZabmlwQpM
	JDeHe2v35nc2QYBrmq+w
X-Received: by 2002:a05:690e:4191:b0:660:8253:b836 with SMTP id
 956f58d0204a3-660dbe97d54mr7489173d50.5.1780592398732; Thu, 04 Jun 2026
 09:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603163851.18058-1-leontyevantony@gmail.com> <20260604163900.A09211F00893@smtp.kernel.org>
In-Reply-To: <20260604163900.A09211F00893@smtp.kernel.org>
From: Anton Leontev <leontyevantony@gmail.com>
Date: Thu, 4 Jun 2026 19:59:56 +0300
X-Gm-Features: AVHnY4Kx6izZI2s_HEh1p5bSx_cod3KVKOkHhawTK4DW9XbpO2P58tWIhRLHIXk
Message-ID: <CAAN-wAnJWMttpbsdAHAfOJ6PyPGqLvp38oU+DqEk2FU67FWc6Q@mail.gmail.com>
Subject: Re: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11491-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C22F642340

You are right, thanks. Since 41a6328b2c55 ("hv_netvsc: Preserve
contiguous PFN grouping in the page buffer array") a pb entry
describes a full physically contiguous fragment and pb[i].len can
exceed PAGE_SIZE, while kmap_local_page() maps a single page. v3
copies page by page, splitting at native page boundaries, and was
posted as a new thread per netdev process.

=D1=87=D1=82, 4 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 19:39, <sas=
hiko-bot@kernel.org>:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The patch replaces `phys_to_virt()` with `kmap_local_page()`=
 in `netvsc_copy_to_send_buf()` to support HIGHMEM SKB fragments. However, =
`kmap_local_page()` maps exactly one page (e.g., 4096 bytes). SKB fragments=
 (such as those from TCP sends using `sk_page_frag()` or NFS) can be backed=
 by compound pages where the fragment size (`len`) exceeds a single page, o=
r where `offset + len` crosses a page boundary. The `pb` array populated by=
 `init_page_array()` contains exactly one entry per fragment, meaning `pb[i=
].len` can exceed `PAGE_SIZE`. When `memcpy(dest, src + offset, len)` is ca=
lled, it will read past the 4KB window mapped by `kmap_local_page()`. On 32=
-bit HIGHMEM systems, this accesses adjacent unmapped or unrelated fixmap s=
lots, causing a fatal page fault or memory leakage.
> --
>
> commit dfe36312b193784583b28a894f895984d7d0ebba
> Author: Anton Leontev <leontyevantony@gmail.com>
>
> hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
>
> This patch replaces phys_to_virt() with kmap_local_page() to support HIGH=
MEM
> SKB fragments that are beyond the LOWMEM boundary on 32-bit systems.
>
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 59e95341f9b1e..2038d9f5c9f9a 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> [ ... ]
> > @@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc=
_device *net_device,
> >       }
> >
> >       for (i =3D 0; i < page_count; i++) {
> > -             char *src =3D phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT=
);
> > -             u32 offset =3D pb[i].offset;
> > +             phys_addr_t paddr =3D pb[i].pfn << HV_HYP_PAGE_SHIFT;
> > +             struct page *page =3D phys_to_page(paddr);
> > +             u32 offset =3D offset_in_page(paddr) + pb[i].offset;
> >               u32 len =3D pb[i].len;
> > +             char *src =3D kmap_local_page(page);
> >
> >               memcpy(dest, (src + offset), len);
>
> [Severity: Critical]
> Will this memcpy() read beyond the 1-page mapping established by
> kmap_local_page()?
>
> If the fragment size (len) plus offset exceeds PAGE_SIZE, it seems memcpy=
()
> will read past the locally mapped window. SKB fragments can be backed by
> compound pages where the fragment size exceeds a single page, and
> init_page_array() assigns the full fragment size to pb[i].len:
>
> drivers/net/hyperv/netvsc_drv.c:init_page_array() {
>         ...
>         cur_pb->offset =3D offset_in_hvpage(offset);
>         cur_pb->len =3D skb_frag_size(frag);
>         cur_pb->pfn =3D pfn + (offset >> HV_HYP_PAGE_SHIFT);
>         ...
> }
>
> Other parts of the subsystem also document that a pb entry can cross page
> boundaries:
>
> drivers/net/hyperv/netvsc.c:netvsc_build_mpb_array() {
>         ...
>         /* Each entry in the input "pb" array must describe a contiguous =
range
>          * of guest physical memory so that the pfns are sequential if th=
e range
>          * crosses a page boundary. */
>         ...
>         for (j =3D 0; j < HVPFN_UP(offset + len); j++)
>                 mpb_entry->pfnArray[j] =3D pb[i].pfn + j;
>         ...
> }
>
> Could this regression cause a fatal page fault on 32-bit HIGHMEM guests w=
hen
> an SKB fragment crosses a page boundary, or leak unrelated fixmap memory =
if
> the adjacent slot happens to be mapped?
>
> > +             kunmap_local(src);
> >               dest +=3D len;
> >       }
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603163851.18=
058-1-leontyevantony@gmail.com?part=3D1

