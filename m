Return-Path: <linux-hyperv+bounces-2857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E395DFF3
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 22:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889841C20BBF
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FC7DA65;
	Sat, 24 Aug 2024 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="fR6UW6h8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09C7404B;
	Sat, 24 Aug 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529961; cv=none; b=qZy6NDV8Sx/pRqiL5KqUIg9gwUqJc4tfHuUfhhbdGsR1B3i4lxAl4lFjSHxS1H58QL3/gFkGwuDH6Jn8rge1NsmA0qJMJZnccsk/boNflu6d6NwEOnmKaj6CHwn4mNRUX2uP05MaDf3cYPzMZhpPeD9/QFlB1OQpUAmGzhrt/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529961; c=relaxed/simple;
	bh=lMTeCQzH6kMmHX/l9Jn3JQcO/hHSZcBoRk4fs+/yiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDj6jfqDAOREqDdoZvChW0332suyzy0indJF/0EC6uWkJT39xbuGG+X9S8mys3QqkUA40mPSGCjvXxkrtpGwUvQcCR6Wy67qiGxrg34aQ1HtKItdO4lGo4NP+mPT3ZOgFmUqH/13tu24akXL5fGwA1Kr4ArcIUA8wkN7L1VUhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=fR6UW6h8; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B2CB31F36F1;
	Sat, 24 Aug 2024 22:05:57 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724529958; bh=6q+DC9qEi4FRPHzOR4JhQ0nGEEP7YVA8G4HC6P+cUdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fR6UW6h84uQyCzzVZNSO0UWSzM5bGYLmY1G76UqvJUBOJXPzsISmYl/OWFY5HBXxV
	 MDkPHxv+1rabIGBdc8lw/KrqFnp/+ThasVMTP9xmaTAKfphiA5FYFaRYqZryLtfndw
	 4ovWnUZkv06IGKawoXxwJNia+R34Y4769D8oG3m/FOI55O0qbXjSJ/h67h7etOWn0M
	 v31Al/bNYDgPvfI/md3dxAMfx+MVdGYmt+hR7GQqe/Md97Rrv4aCWfr0lt57YdbqhO
	 RQdS3uf6P9OlV1AQFLcx67uZ9cQi+2nqE3iwduF6NypvU0JZ6jalCuhtKb0gsuCq6t
	 ah3J7uG9R0cog==
Date: Sat, 24 Aug 2024 22:05:56 +0200
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
Message-ID: <20240824220556.0e2587d5@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240823084458.4394b401@meshulam.tesarici.cz>
	<SN6PR02MB415758F12C59E6CA67227DCFD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 20:40:16 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Thursday, August 22=
, 2024 11:45 PM
>[...]
> > > Discussion
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > * Since swiotlb isn't visible to device drivers, I've specifically
> > > named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
> > > something swiotlb specific. While this patch set consumes MAY_BLOCK
> > > only on the DMA direct path to do throttling in the swiotlb code,
> > > there might be other uses in the future outside of CoCo VMs, or
> > > perhaps on the IOMMU path. =20
> >=20
> > I once introduced a similar flag and called it MAY_SLEEP. I chose
> > MAY_SLEEP, because there is already a might_sleep() annotation, but I
> > don't have a strong opinion unless your semantics is supposed to be
> > different from might_sleep(). If it is, then I strongly prefer
> > MAY_BLOCK to prevent confusing the two. =20
>=20
> My intent is that the semantics are the same as might_sleep(). I
> vacillated between MAY_SLEEP and MAY_BLOCK. The kernel seems
> to treat "sleep" and "block" as equivalent, because blk-mq has
> the BLK_MQ_F_BLOCKING flag, and SCSI has the=20
> queuecommand_may_block flag that is translated to
> BLK_MQ_F_BLOCKING. So I settled on MAY_BLOCK, but as you
> point out, that's inconsistent with might_sleep(). Either way will
> be inconsistent somewhere, and I don't have a preference.

Fair enough. Let's stay with MAY_BLOCK then, so you don't have to
change it everywhere.

>[...]
> > > Open Topics
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. swiotlb allocations from Xen and the IOMMU code don't make use
> > > of throttling. This could be added if beneficial.
> > >
> > > 2. The throttling values are currently exposed and adjustable in
> > > /sys/kernel/debug/swiotlb. Should any of this be moved so it is
> > > visible even without CONFIG_DEBUG_FS? =20
> >=20
> > Yes. It should be possible to control the thresholds through
> > sysctl. =20
>=20
> Good point.  I was thinking about creating /sys/kernel/swiotlb, but
> sysctl is better.

That still leaves the question where it should go.

Under /proc/sys/kernel? Or should we make a /proc/sys/kernel/dma
subdirectory to make room for more dma-related controls?

Petr T

