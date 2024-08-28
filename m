Return-Path: <linux-hyperv+bounces-2902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA4962DD5
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F6287096
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BE1A38F3;
	Wed, 28 Aug 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="GqmQPaJi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082841A4F29;
	Wed, 28 Aug 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863319; cv=none; b=h4KOD+pgcrMsjNbd6FxyhR8P0z156ICwgB6ymDzY/8zx0BNkriAS/XJHWIlvJW2TxMiBmQZCAWFZNfph3Fkh0jkwsEdGLYhK+hOv54at7fSssMixCxNGWBHjybHPHKXnI4q38bYnCuLNrTQr/xk1babyBdmCWO+N3I2TpF6zc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863319; c=relaxed/simple;
	bh=lZe4alY/8goCqitB0n3Udlri0Gukxi56zPIDDXPOWGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awLioSx8Ffar5kio36o/YU14+/BD0QontZm9VLK8hmZwsCVF0gN2veAFymUunBoSz0cLs+IPrWxL9O/3LYcUrOYkGTnmDqf/QGEhaFyAz+2KyAaZG3OAdVOV47sWsnRwm6WJTnGZEpXA8KkZgn5CO7j2SNX/ka4ZRJNqj/PR1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=GqmQPaJi; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D7E521F8BA3;
	Wed, 28 Aug 2024 18:41:54 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724863315; bh=3MyJeyAXp+4wlHAANDM+apNaIRezL6upST4ZRE8r4ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqmQPaJi+Pg9uqPO6G+l3e63SHSxO8/HYlmSOCDGr3JTXHnRNoHrDptdYdl+7UvHb
	 dkXADw5sTbkPRlbcihyVFMTJY0RSn9pBCS9YhVRUGD8TsMUJvoTQv0CP7Sft/nu0bV
	 q+Tc2OtjCMuzhZt3oHtbpx6IqxfuDJMIG8YLNTV7lNswCKINzAMIi9Np5KCljbSaQS
	 r2YAXtd8mjIZ0tb8Re5SeOFMLBjlzYRsoa0aGNVFKgextKwzZbIfTeu9pY6Txcbejp
	 spAW96x3biapYvFvuoUX9iuR9iBSFVrkyMjLyyP6N00ZBkXF58UGYfbF6LfnuTwiQo
	 1uJR8bqZGSt3Q==
Date: Wed, 28 Aug 2024 18:41:50 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240828184150.73531dea@mordecai.tesarici.cz>
In-Reply-To: <SN6PR02MB4157F23504BEB951BB19CE9BD4952@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
	<20240828150356.46d3d3dc@mordecai.tesarici.cz>
	<SN6PR02MB4157F23504BEB951BB19CE9BD4952@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 16:30:04 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Wednesday, August 2=
8, 2024 6:04 AM
> >=20
> > On Wed, 28 Aug 2024 13:02:31 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >  =20
> > > On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote: =20
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Linux device drivers may make DMA map/unmap calls in contexts that
> > > > cannot block, such as in an interrupt handler. Consequently, when a
> > > > DMA map call must use a bounce buffer, the allocation of swiotlb
> > > > memory must always succeed immediately. If swiotlb memory is
> > > > exhausted, the DMA map call cannot wait for memory to be released. =
The
> > > > call fails, which usually results in an I/O error.
> > > >
> > > > Bounce buffers are usually used infrequently for a few corner cases,
> > > > so the default swiotlb memory allocation of 64 MiB is more than
> > > > sufficient to avoid running out and causing errors. However, recent=
ly
> > > > introduced Confidential Computing (CoCo) VMs must use bounce buffers
> > > > for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> > > > a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> > > > swiotlb memory. This large allocation reduces the likelihood of a
> > > > spike in usage causing DMA map failures. Unfortunately for most
> > > > workloads, this insurance against spikes comes at the cost of
> > > > potentially "wasting" hundreds of MiB's of the VM's memory, as swio=
tlb
> > > > memory can't be used for other purposes.
> > > >
> > > > Approach
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > > The goal is to significantly reduce the amount of memory reserved as
> > > > swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> > > > DMA map failures due to memory exhaustion. =20
> > >
> > > Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was alre=
ady
> > > meant to address? Of course the implementation of that is still young
> > > and has plenty of scope to be made more effective, and some of the id=
eas
> > > here could very much help with that, but I'm struggling a little to s=
ee
> > > what's really beneficial about having a completely disjoint mechanism
> > > for sitting around doing nothing in the precise circumstances where it
> > > would seem most possible to allocate a transient buffer and get on wi=
th it. =20
> >=20
> > This question can be probably best answered by Michael, but let me give
> > my understanding of the differences. First the similarity: Yes, one
> > of the key new concepts is that swiotlb allocation may block, and I
> > introduced a similar attribute in one of my dynamic SWIOTLB patches; it
> > was later dropped, but dynamic SWIOTLB would still benefit from it.
> >=20
> > More importantly, dynamic SWIOTLB may deplete memory following an I/O
> > spike. I do have some ideas how memory could be returned back to the
> > allocator, but the code is not ready (unlike this patch series).
> > Moreover, it may still be a better idea to throttle the devices
> > instead, because returning DMA'able memory is not always cheap. In a
> > CoCo VM, this memory must be re-encrypted, and that requires a
> > hypercall that I'm told is expensive.
> >=20
> > In short, IIUC it is faster in a CoCo VM to delay some requests a bit
> > than to grow the swiotlb.
> >=20
> > Michael, please add your insights.
> >=20
> > Petr T
> >  =20
>=20
> The other limitation of SWIOTLB_DYNAMIC is that growing swiotlb
> memory requires large chunks of physically contiguous memory,
> which may be impossible to get after a system has been running a
> while. With a major rework of swiotlb memory allocation code, it might
> be possible to get by with a piecewise assembly of smaller contiguous
> memory chunks, but getting many smaller chunks could also be
> challenging.
>=20
> Growing swiotlb memory also must be done as a background async
> operation if the DMA map operation can't block. So transient buffers
> are needed, which must be encrypted and decrypted on every round
> trip in a CoCo VM. The transient buffer memory comes from the
> atomic pool, which typically isn't that large and could itself become
> exhausted. So we're somewhat playing whack-a-mole on the memory
> allocation problem.

Note that this situation can be somewhat improved with the
SWIOTLB_ATTR_MAY_BLOCK flag, because a new SWIOTLB chunk can then be
allocated immediately, removing the need to allocate a transient pool
from the atomic pool.

> We discussed the limitations of SWIOTLB_DYNAMIC in large CoCo VMs
> at the time SWIOTLB_DYNAMIC was being developed, and I think there
> was general agreement that throttling would be better for the CoCo
> VM scenario.
>=20
> Broadly, throttling DMA map requests seems like a fundamentally more
> robust approach than growing swiotlb memory. And starting down
> the path of allowing designated DMA map requests to block might have
> broader benefits as well, perhaps on the IOMMU path.
>=20
> These points are all arguable, and your point about having two somewhat
> overlapping mechanisms is valid. Between the two, my personal viewpoint
> is that throttling is the better approach, but I'm probably biased by my
> background in the CoCo VM world. Petr and others may see the tradeoffs
> differently.

For CoCo VMs, throttling indeed seems to be better. Embedded devices
seem to benefit more from growing the swiotlb on demand.

As usual, YMMV.

Petr T

