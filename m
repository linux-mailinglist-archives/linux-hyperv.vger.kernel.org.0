Return-Path: <linux-hyperv+bounces-11465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zux6CateIGoq2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11465-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:04:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A863A067
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fstWTfx6;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11465-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11465-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEE4B3158AD0
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1233C81AA;
	Wed,  3 Jun 2026 16:29:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466D3E5ED7
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 16:29:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504151; cv=pass; b=mGTTP4gZxC/53IfqA9ZrBGtRYHQHqjZrdl2PGQ8VIhZ/wO4Nyb9pFluYr1rdUfYEX2EFsxWN3LAIKJu43pOVsIEho2pbuS1uO/ZCjc3hE0uRPQxfrp4q1/yE6XL9xYG/5eFCm0Qj7mawv9+fED8V8qPembhv1dhfBny4hntmNU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504151; c=relaxed/simple;
	bh=xyNkSPsQXlCChbk0bato3dv0WPNUOqGeLAR4C4A+Iv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXYEIiZnfd54iaEZdyjvow5JsSxBAl68qTnr2DNsPz4x8/1uWorwgH54tZLh8rZjRGjHJI0cfXvP3NYtLJSZDAiFhxV7P+vmwFtf5iC2JvIwK2FonGlYeSNTGyxMjzcvtVOaLgQY9n9C1Cea6oX4Uby9O57p9vo2wx0exWDxLkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fstWTfx6; arc=pass smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6605c3453f2so6161137d50.1
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jun 2026 09:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780504149; cv=none;
        d=google.com; s=arc-20240605;
        b=W9btnOpJbI9TBCqylewoLlBmhFmFHkOcQ3TNb5oHc7wDunFcLiOx+uC+RMtPeu+Int
         8ZY73BwTDbssykLL2eYl+aLX0TRPD5ugHE+hYZW4+xsVGrKsQeFat1Lybvt/4icIMx+m
         HjRxaSxXa0DB7D7Xy0ZkomJcth0f6D8jwhvhGtk7nurUDInqzAnVdewOfkrnBtZzuw8H
         ttE4S+lpbrcYkmSLNESlbnuSN//PSGGjNxVJNal1XX5HiXi9r1UwmFy1fmLhVvcIy69h
         SNHKzrEg3KIpQWte4aJvsE1hkyO8Cc3DdQNdV9QAPFmuiOk2pssVLWohHOWSMaIwLprL
         0eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWtdi4wwUR2U1Nle2qsjEO9rC1OFuVOfLjScwZBeEhc=;
        fh=D0e8sSTaVPmAgUSFERRWgkzhkCafsr+sW9jV93yuieQ=;
        b=TjncAzAdAwEoLM6Ats4ZRRJE1T0w3PulAa68GV6Fo8CXiWP/KU2s2u234vf6D7seRX
         aG/uCBagACP1zmX0OxP1cYAcsWxepKt1U6pfiOhDYlzRUhLAYokb7+EpawtQNrQl35Dj
         lTGQq4w9nzy/DrKGnQxdMXAzN+Ixm13S4BItok51QTM2/DMfovn93ccX6pg90KMv4/Ef
         00PyrKUXziQosJ6dyPqbHuuYL8eRpmRjAJ/5yTT5fJ7bZq1pJMNKmKqXTL3zhUZV5gbD
         BgWeHloqgtA/E5WzVK/37CoybsSFteyEXg+KxFYyRYcsNujXtEivB/k8WBElnDi0YkfC
         25hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504149; x=1781108949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWtdi4wwUR2U1Nle2qsjEO9rC1OFuVOfLjScwZBeEhc=;
        b=fstWTfx6HWmIH6LoqlJGMNoGz02rCgSe+DnSfYOfopt7zVP+J89cYXIznC4JLrUNg5
         6z/voKxYg9w/e4zwmURahNevRU49uLxmMjSwjblYSVSm+HUi50YghsNqp7V2jvuyptYg
         rnsuhBQmnkIBxQP/y/G7mekL/KTkXI5bXiCMTM5kvI5lQSCc+z/7IiPYscJqgHqCF5wK
         HIrd5RkRl0uWd2y13q5E55i3IGoH7IlRXN1QtBLKzj4tldNcNkKPa7OOQfQKnF+B2aBm
         9zGZB1pmqwn4iEsgA2LlpLNDSKNEkD5di4QJ3JZaRMFCotV137fObI1XQnlccaaODHw/
         KLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504149; x=1781108949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWtdi4wwUR2U1Nle2qsjEO9rC1OFuVOfLjScwZBeEhc=;
        b=KlWDYumC6Aox0QvVDi/WyxyZSTBuagw4vh4RZqQTPv29+H5slPxcX0Wvp6Y5lC7w3E
         5TY2I4VhgvyDWSSdDb1Z9raDxAWK2fqx1aelQ5kqoKbfpDygGSFO6WqTYk3d48PHrQyV
         ikcPZMsYTnCyIB3xdQ7idWL5E+lGuvuH6a4KQbr4CrgBb1qZuVT3hfh3zZPfxgh5947U
         dKpyAkouuCn74VFpnk207xOxHhiTT3W1P37/GJybJuVnmH9LE/bH45Oi/ZtUyKnUTVfm
         FcVoVcGzEK/uLLja9Yc5oLcOGOeXtjoxD3PuTzxxCLJAN9xNC92VG7kujXzw9GxG/Nfd
         t63w==
X-Gm-Message-State: AOJu0YwErXVF/idw9UAxQoJ6ANC5ci+1qgXVDwDJeDkUC+xFBb9xpm36
	gWuX88X9zcM7yyUQwwKm1Winvon5IWmCAZ/WocD7uO1A3n9nZdBFUJinn2pSLqYgAi5J6Hd7GSn
	cvvA9I+V04/XsD1Xr/YR82/eXphcHvRP5ONYufsfPi/nM
X-Gm-Gg: Acq92OHi4T+V/WdQkB5xtIFs8ceHAKC0tLLZv2TRkURNiA904X+pXAHkOFSYkPs9TBw
	nLeufximsAYxGe3ac9bx1qu44iRmTrJ0TudV9p5PLH0aQpxUvgA0snr01nwP4tJjegPDw0XC0Ub
	PPUC+0/eK1oRz1emfwK5JJz1yzZ0gFPHPMenLr2a6HdGPy/6M732XPGfNdyMl5Hl9LgPJzG0WOk
	PPCjDp0tefqkEKIsq5BQQ8B574qMFQVwkrVU/x7VmxBNgkerDlsMLpHJzY8oalWFO4Wh25sufIv
	dujBq3y+2nZk83WJYa67
X-Received: by 2002:a05:690e:408c:b0:660:ec14:ef82 with SMTP id
 956f58d0204a3-660ec14f7d6mr1656108d50.41.1780504148595; Wed, 03 Jun 2026
 09:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602155210.90987-1-leontyevanton1995@gmail.com> <20260603155344.7CE871F00893@smtp.kernel.org>
In-Reply-To: <20260603155344.7CE871F00893@smtp.kernel.org>
From: Anton Leontev <leontyevantony@gmail.com>
Date: Wed, 3 Jun 2026 19:29:05 +0300
X-Gm-Features: AVHnY4Ke1MZXYgw-YYbKoNRJAeBGxFNFOYNb53zskNp9hhlw99jeifLEkfo-iro
Message-ID: <CAAN-wAmgH9QEoj-cFjOxhytP4qC5sCgAsd9cn6cgZk1bfqznZQ@mail.gmail.com>
Subject: Re: [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
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
	TAGGED_FROM(0.00)[bounces-11465-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 651A863A067

You are right, thanks for catching this. pb[i].pfn is a Hyper-V PFN at
4K granularity, so passing it directly to pfn_to_page() is wrong where
PAGE_SIZE > 4K, and it also drops the intra-page offset. Fixed in v2 by
reconstructing the physical address and using phys_to_page() +
offset_in_page(). Built for i386 (HIGHMEM) and arm64 (64K pages).

Thanks,
Anton

=D1=81=D1=80, 3 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 18:53, <sas=
hiko-bot@kernel.org>:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Passing a Hyper-V PFN directly to `pfn_to_page()` causes out=
-of-bounds memory accesses on architectures where `PAGE_SIZE > 4KB` (e.g., =
ARM64 with 64KB pages), and loses the intra-page chunk offset.
> --
>
> commit a844fbf018cd37eedc9a1f0aea79d6235c00bec3
> Author: Anton Leontev <leontyevantony@gmail.com>
>
> hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
>
> This commit replaces phys_to_virt() with kmap_local_page() in
> netvsc_copy_to_send_buf() to map skb fragment pages. This is intended to
> fix a fatal transmit softirq fault on 32-bit x86 configurations with
> HIGHMEM, where phys_to_virt() is only valid for LOWMEM addresses.
>
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 59e95341f9b1e..6984f6c97257d 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
>
> [ ... ]
>
> > @@ -965,11 +966,13 @@ static void netvsc_copy_to_send_buf(struct netvsc=
_device *net_device,
> >       }
> >
> >       for (i =3D 0; i < page_count; i++) {
> > -             char *src =3D phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT=
);
> > +             struct page *page =3D pfn_to_page(pb[i].pfn);
> > +             char *src =3D kmap_local_page(page);
>
> [Severity: Critical]
> Does this cause out-of-bounds memory accesses on architectures with a nat=
ive
> page size greater than 4KB?
>
> The pb[i].pfn field contains a Hyper-V PFN, which always operates at 4KB
> granularity. Passing this directly to pfn_to_page() assumes it is a nativ=
e
> Linux PFN.
>
> On architectures where the native page size is larger than 4KB (such as
> ARM64 with 64KB pages), the Hyper-V PFN is significantly larger than the
> corresponding native Linux PFN. Using it with pfn_to_page() would return =
an
> invalid struct page pointer.
>
> Calling kmap_local_page() on this invalid pointer in
> netvsc_copy_to_send_buf() and subsequently reading from it could lead to
> memory corruption, out-of-bounds accesses, or kernel panics.
>
> Could this also lose the native page offset of the original 4KB chunk wit=
hin
> the larger Linux page, resulting in an incorrect read offset during the
> subsequent memcpy?
>
> >               u32 offset =3D pb[i].offset;
> >               u32 len =3D pb[i].len;
> >
> >               memcpy(dest, (src + offset), len);
> > +             kunmap_local(src);
> >               dest +=3D len;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602155210.90=
987-1-leontyevanton1995@gmail.com?part=3D1

