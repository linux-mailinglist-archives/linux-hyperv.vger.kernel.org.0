Return-Path: <linux-hyperv+bounces-2877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9159603CB
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1871C21494
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FB136E21;
	Tue, 27 Aug 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="pq1t7xe6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85820328;
	Tue, 27 Aug 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745664; cv=none; b=A7ZZMgaL7+04KMVR7ZxSTCuFMR6ervg7xmMpAFg4pREZQNBsgi/HWfl3cVcMrsAXJklwlDU/sb0xGFpll71R+h0HfiUddhc/xBzmGp1kUdXZ676odimZ68Ea5nJ1TYCt/2wbBhRPo+TyFDvTRgUkI3OH9AdxmW5WtFWzNfXLUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745664; c=relaxed/simple;
	bh=XeuKHYphwj6HEB8Fy7aHZAKGom5ZSuFWmNc9MuomPmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTJA+7hY1FueXz+LmSQ+EikbMtTRgjoxq6iclxKuQmA12W6xMI3wtCW7H2+ZyXsUUJ0MfhXY7jeeYGD1xPEqzM9eAbUyoe6AXh5wcjaDuhjTJxHeihz+gJ06tqV4cTaH8XIDjIJIFJZf9Uft0k6ir7omPXX0+ydTVOGHFMG9hSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=pq1t7xe6; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 405871F5F37;
	Tue, 27 Aug 2024 10:00:58 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724745658; bh=gTsz4OLuUenCez/Nx0yB83T9U09ihDAGrzP/1JubWmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pq1t7xe6FE1ajRU0n1PIq3R0gO1GVYddI2phd9r8voNaVUl1hVZCcMkdAtwXygweV
	 ubQch50HX9nRGZuSq2WaOoIyzOf8JRlfxP3DsxcsgNJRwa29w/uCwJhCoPCTk+giRq
	 Ob+JY9iTxQE0nkQRJp+MjLSF5mUWl6g4W/qQ5UFLBoGiRi25nGiKRAnEbTSucAQ23t
	 Li5T+VY6hbL127O+5EkAOruj2eel+5WtjGBrPgnvfsLOdYVDgcqq8jhiWKaHIMhEi+
	 leVYLJJkH7xnfpUmFRyn8mdp5aSg7zsrHzJIfXms3JVY5ILYZwXLozpWs1/eHtuI+/
	 Jm5Qur/0EyZ0w==
Date: Tue, 27 Aug 2024 10:00:53 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240827100053.2f5c3403@mordecai.tesarici.cz>
In-Reply-To: <SN6PR02MB41571FA9E40ECA5954001A57D4942@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240823084458.4394b401@meshulam.tesarici.cz>
	<SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240824220556.0e2587d5@meshulam.tesarici.cz>
	<SN6PR02MB41577933B499309EA3CE4DDBD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240826212803.3e11d2f9@meshulam.tesarici.cz>
	<SN6PR02MB41571FA9E40ECA5954001A57D4942@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 00:26:36 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Monday, August 26, =
2024 12:28 PM
> >=20
> > On Mon, 26 Aug 2024 16:24:53 +0000
> > Michael Kelley <mhklinux@outlook.com> wrote:
> >  =20
> > > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Saturday, Augus=
t 24, 2024 1:06 PM =20
> > > >
> > > > On Fri, 23 Aug 2024 20:40:16 +0000
> > > > Michael Kelley <mhklinux@outlook.com> wrote:
> > > > =20
> > > > > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Thursday, A=
ugust 22, 2024 11:45 PM
> > > > >[...] =20
> > > > > > > Discussion
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > * Since swiotlb isn't visible to device drivers, I've specifi=
cally
> > > > > > > named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE =
or
> > > > > > > something swiotlb specific. While this patch set consumes MAY=
_BLOCK
> > > > > > > only on the DMA direct path to do throttling in the swiotlb c=
ode,
> > > > > > > there might be other uses in the future outside of CoCo VMs, =
or
> > > > > > > perhaps on the IOMMU path. =20
> > > > > >
> > > > > > I once introduced a similar flag and called it MAY_SLEEP. I cho=
se
> > > > > > MAY_SLEEP, because there is already a might_sleep() annotation,=
 but I
> > > > > > don't have a strong opinion unless your semantics is supposed t=
o be
> > > > > > different from might_sleep(). If it is, then I strongly prefer
> > > > > > MAY_BLOCK to prevent confusing the two. =20
> > > > >
> > > > > My intent is that the semantics are the same as might_sleep(). I
> > > > > vacillated between MAY_SLEEP and MAY_BLOCK. The kernel seems
> > > > > to treat "sleep" and "block" as equivalent, because blk-mq has
> > > > > the BLK_MQ_F_BLOCKING flag, and SCSI has the
> > > > > queuecommand_may_block flag that is translated to
> > > > > BLK_MQ_F_BLOCKING. So I settled on MAY_BLOCK, but as you
> > > > > point out, that's inconsistent with might_sleep(). Either way will
> > > > > be inconsistent somewhere, and I don't have a preference. =20
> > > >
> > > > Fair enough. Let's stay with MAY_BLOCK then, so you don't have to
> > > > change it everywhere.
> > > > =20
> > > > >[...] =20
> > > > > > > Open Topics
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > 1. swiotlb allocations from Xen and the IOMMU code don't make=
 use
> > > > > > > of throttling. This could be added if beneficial.
> > > > > > >
> > > > > > > 2. The throttling values are currently exposed and adjustable=
 in
> > > > > > > /sys/kernel/debug/swiotlb. Should any of this be moved so it =
is
> > > > > > > visible even without CONFIG_DEBUG_FS? =20
> > > > > >
> > > > > > Yes. It should be possible to control the thresholds through
> > > > > > sysctl. =20
> > > > >
> > > > > Good point.  I was thinking about creating /sys/kernel/swiotlb, b=
ut
> > > > > sysctl is better. =20
> > > >
> > > > That still leaves the question where it should go.
> > > >
> > > > Under /proc/sys/kernel? Or should we make a /proc/sys/kernel/dma
> > > > subdirectory to make room for more dma-related controls? =20
> > >
> > > I would be good with /proc/sys/kernel/swiotlb (or "dma"). There
> > > are only two entries (high_throttle and low_throttle), but just
> > > dumping everything directly in /proc/sys/kernel doesn't seem like
> > > a good long-term approach.  Even though there are currently a lot
> > > of direct entries in /proc/sys/kernel, that may be historical, and not
> > > changeable due to backwards compatibility requirements. =20
> >=20
> > I think SWIOTLB is a bit too narrow. How many controls would we add
> > under /proc/sys/kernel/swiotlb? The chances seem higher if we call it
> > /proc/sys/kernel/dma/swiotlb_{low,high}_throttle, and it follows the
> > paths in source code (which are subject to change any time, however).
> > Anyway, I don't want to get into bikeshedding; I'm fine with whatever
> > you send in the end. :-)
> >=20
> > BTW those entries directly under /proc/sys/kernel are not all
> > historical. The io_uring_* controls were added just last year, see
> > commit 76d3ccecfa18.
> >  =20
>=20
> Note that there could be multiple instances of the throttle values, since
> a DMA restricted pool has its own struct io_tlb_mem that is separate
> from the default. I wrote the code so that throttling is independently
> applied to a restricted pool as well, though I haven't tested it.

Good point. I didn't think about it.

> So the typical case is that we'll have high and low throttle values for t=
he
> default swiotlb pool, but we could also have high and low throttle
> values for any restricted pools.
>=20
> Maybe the /proc pathnames would need to be:
>=20
>    /proc/sys/kernel/dma/swiotlb_default/high_throttle
>    /proc/sys/kernel/dma/swiotlb_default/low_throttle
>    /proc/sys/kernel/dma/swiotlb_<rpoolname>/high_throttle
>    /proc/sys/kernel/dma/swiotlb_<rpoolname>/low_throttle

If a subdirectory is needed anyway, then we may ditch the dma
directory idea and place swiotlb subdirectories directly under
/proc/sys/kernel.

> Or we could throw all the throttles directly into the "dma" directory,
> though that makes for fairly long names in lieu of a deeper directory
> structure:
>=20
>    /proc/sys/kernel/dma/default_swiotlb_high_throttle
>    /proc/sys/kernel/dma/default_swiotlb_low_throttle
>    /proc/sys/kernel/dma/<rpoolname>_swiotlb_high_throttle
>    /proc/sys/kernel/dma/<rpoolname_>swiotlb_low_throttle
>=20
> Thoughts?

I have already said I don't care much as long as the naming and/or
placement is not downright confusing. If the default values are
adjusted, they will end up in a config file under /etc/sysctl.d, and
admins will copy&paste it from Stack Exchange.

I mean, you're probably the most interested person on the planet, so
make a choice, and we'll adapt. ;-)

Petr T

