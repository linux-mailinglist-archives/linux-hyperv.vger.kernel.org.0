Return-Path: <linux-hyperv+bounces-2881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5F961363
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119EA1C22F35
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6DA1C9DF7;
	Tue, 27 Aug 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Yr2QCciq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BA1C93B6;
	Tue, 27 Aug 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774149; cv=none; b=K0hMV99yFzuo2GVH8J750K372+n6EedjcI2ABie2mPEFp7Pzg0E+z7iT2wYe9SXeoWTAojCil6162Hq0oT+TexOJI3W4ezaAhUZ3kx3xvy5NLQ28BJbXHz6/0hUU7r8JPjq5r5iU/qVHCjLwpPpFaEhIRDmnflgL28xswY8+IUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774149; c=relaxed/simple;
	bh=cBO2FyArKD0hhv02lTcB1TMtG8oLlZwbkjkc6NN/N60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYjX67ChNJjIq4r8CpgdOavmCsUNXe/1fMCqJVft1564gU0o9pRRxjOuisXIFiulKaOfjvGfx6W1CyeWeEqPp738BN9sAg3MfAPvaCM0NOavUdOkKgmC/MaqV99wliihruHaxX4yHb/KTr+kSAOS1YyD3FsuXRfKaD/PsaApQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Yr2QCciq; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BB8E91F64C8;
	Tue, 27 Aug 2024 17:55:41 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724774142; bh=Kgt1rDhB3tqHgknqxyoONMHMo+OxvdM/AzWNdimoAOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yr2QCciqpjJLdknVeRsD7PsgDs/BjCz1fzFb54yBUI3dAxCIH/yC8BaQmC7/rIZta
	 R4kjf3UbLQCx1HLrAE4H2MgHezkcmPDFZQZ9nmLAlnCgcG7tHoQyc+4tzcXxmxeGY7
	 trJ1BuKWBR09O0Y0zhR9kjieTqui1PosnMmSEtljfZmWeWRlO47Ec6PMVNuitXt+Tm
	 ZbHUJnds5/jNYa0TE/npvMr4Rh6uHf2OuRT36H8OkM3E45X4PNypdTIftik36Eqlf5
	 UAsu0FwczQ62eO0gD/RQm/Whj1+48funVWiYx6oo8oGD4OY2icw65WKNjg03OqWYJY
	 hzHJcftv+yBNQ==
Date: Tue, 27 Aug 2024 17:55:36 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
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
Subject: Re: [RFC 1/7] swiotlb: Introduce swiotlb throttling
Message-ID: <20240827175536.004785f3@mordecai.tesarici.cz>
In-Reply-To: <SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-2-mhklinux@outlook.com>
	<20240823094101.07ba5e0f@meshulam.tesarici.cz>
	<SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 20:41:15 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, August 23, =
2024 12:41 AM
> >=20
> > On Thu, 22 Aug 2024 11:37:12 -0700
> > mhkelley58@gmail.com wrote:
>[...]
> > > @@ -71,12 +72,15 @@
> > >   *		from each index.
> > >   * @pad_slots:	Number of preceding padding slots. Valid only in the =
first
> > >   *		allocated non-padding slot.
> > > + * @throttled:  Boolean indicating the slot is used by a request tha=
t was
> > > + *		throttled. Valid only in the first allocated non-padding slot.
> > >   */
> > >  struct io_tlb_slot {
> > >  	phys_addr_t orig_addr;
> > >  	size_t alloc_size;
> > >  	unsigned short list;
> > > -	unsigned short pad_slots;
> > > +	u8 pad_slots;
> > > +	u8 throttled; =20
> >=20
> > I'm not sure this flag is needed for each slot.
> >=20
> > SWIOTLB mappings should be throttled when the total SWIOTLB usage is
> > above a threshold. Conversely, it can be unthrottled when the total
> > usage goes below a threshold, and it should not matter if that happens
> > due to an unmap of the exact buffer which previously pushed the usage
> > over the edge, or due to an unmap of any other unrelated buffer. =20
>=20
> I think I understand what you are proposing. But I don't see a way
> to make it work without adding global synchronization beyond
> the current atomic counter for the number of uI'm sed slabs. At a minimum
> we would need a global spin lock instead of the atomic counter. The spin
> lock would protect the (non-atomic) slab count along with some other
> accounting, and that's more global references. As described in the
> cover letter, I was trying to avoid doing that.

I have thought about this for a few days. And I'm still not convinced.
You have made it clear in multiple places that the threshold is a soft
limit, and there are many ways the SWIOTLB utilization may exceed the
threshold. In fact I'm not even 100% sure that an atomic counter is
needed, because the check is racy anyway. Another task may increase
(or decrease) the counter between atomic_long_read(&mem->total_used)
and a subsequent down(&mem->throttle_sem).

I consider it a feature, not a flaw, because the real important checks
happen later while searching for free slots, and those are protected
with a spinlock.

> If you can see how to do what you propose with just the current
> atomic counter, please describe.

I think I'm certainly missing something obvious, but let me open the
discussion to improve my understanding of the matter.

Suppose we don't protect the slab count with anything. What is the
worst possible outcome? IIUC the worst scenario is that multiple tasks
unmap swiotlb buffers simultaneously and all of them believe that their
action made the total usage go below the low threshold, so all of them
try to release the semaphore.

That's obviously not good, but AFAICS all that's needed is a
test_and_clear_bit() on a per-io_tlb_mem throttled flag just before
calling up(). Since up() would acquire the semaphore's spinlock, and
there's only one semaphore per io_tlb_mem, adding an atomic flag doesn't
look like too much overhead to me, especially if it ends up in the same
cache line as the semaphore.

Besides, this all happens only in the slow path, i.e. only after the
current utilization has just dropped below the low threshold, not if
the utilization was already below the threshold before freeing up some
slots.

I have briefly considered subtracting the low threshold as initial bias
from mem->total_used and using atomic_long_add_negative() to avoid the
need for an extra throttled flag, but at this point I'm not sure it can
be implemented without any races. We can try to figure out the details
if it sounds like a good idea.

Petr T

