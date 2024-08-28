Return-Path: <linux-hyperv+bounces-2888-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5E961E19
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 07:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B56B1F24A8D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FE14B96E;
	Wed, 28 Aug 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="2A3vENwm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040E7F7CA;
	Wed, 28 Aug 2024 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822168; cv=none; b=MFonw/kv00IoTqSyZqW9iS82cBB1mSjz/81Bl3GlWRgDQk0s3WqiQsxj0jrc6T6JPyuJApu3WKVwK27GwATrre5wvDkFJS+lxOIq+MdEgO6Qpxl3RWRTB9aEv69h9q5zLxoIDMx+jvJ6xt6KbWhU3G9TaWy8rEZ1bn8hjTM0E50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822168; c=relaxed/simple;
	bh=6qhXRzKsK9p2z8WH7e0mY+BuINu9v2vjbAykO4GMhIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxPldndfGOEj5R+X4o1Lsl/iSx/KzL7vBsRlVRkDy6HTC/3f8v6IVFnsXx2W7xVj780wC/sA2dqrJv8jXtY1QKWMMQUR4dOgN9Ml8Izi8lHC0Ub3QEGSzMc48uAuEuD9cq/liHzO7KhLibBo5YGWT3vfhR4FNeJl9E+iAOylS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=2A3vENwm; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C996D1F9182;
	Wed, 28 Aug 2024 07:15:55 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724822156; bh=rWHvUa9BCo3b2+TaKpVzF7XSwOb4cg0tBQGpt2tEfQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2A3vENwmCH5KAKaCrOl0QHIgazofDMhQN8Ve2DKmxNFnRk5Z+zSAyEYlacVMIO0o1
	 sCmyJF3+5+viqVuRVDCCVKJ6OCAMDI65gZDSCrBuf3AUcKGp/gPFHT2ME+YzixeAkb
	 /Xwf6yHmHn30G0jh1mg+E92Z7lwhiDEMtJfBhjfpoBRVIzTG8tRGe3I0HxfJLkO+em
	 BraJvYmqOUmzlOM9E4q9/GaIUJWuDSBkL2ZAHeiUt/6k+jcqiZHRbVIB40qjpRa4jQ
	 LXRNfXh4OaeNwYYLvXW5bvgvHDKW8izE23nrjkwHfyTgpDwLKwsfZ87NmBjfVgyjXI
	 5Zy76aRunyyeQ==
Date: Wed, 28 Aug 2024 07:15:54 +0200
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
Message-ID: <20240828071554.433b3308@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41577B7C11ECF060FC3FB8FDD4942@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-2-mhklinux@outlook.com>
	<20240823094101.07ba5e0f@meshulam.tesarici.cz>
	<SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240827175536.004785f3@mordecai.tesarici.cz>
	<SN6PR02MB41577B7C11ECF060FC3FB8FDD4942@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 17:30:59 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Tuesday, August 27,=
 2024 8:56 AM
> >=20
> > On Fri, 23 Aug 2024 20:41:15 +0000
> > Michael Kelley <mhklinux@outlook.com> wrote:
> >  =20
> > > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, August =
23, 2024 12:41 AM =20
> > > >
> > > > On Thu, 22 Aug 2024 11:37:12 -0700
> > > > mhkelley58@gmail.com wrote: =20
> > >[...] =20
> > > > > @@ -71,12 +72,15 @@
> > > > >   *		from each index.
> > > > >   * @pad_slots:	Number of preceding padding slots. Valid only in =
the first
> > > > >   *		allocated non-padding slot.
> > > > > + * @throttled:  Boolean indicating the slot is used by a request=
 that was
> > > > > + *		throttled. Valid only in the first allocated non-padding slo=
t.
> > > > >   */
> > > > >  struct io_tlb_slot {
> > > > >  	phys_addr_t orig_addr;
> > > > >  	size_t alloc_size;
> > > > >  	unsigned short list;
> > > > > -	unsigned short pad_slots;
> > > > > +	u8 pad_slots;
> > > > > +	u8 throttled; =20
> > > >
> > > > I'm not sure this flag is needed for each slot.
> > > >
> > > > SWIOTLB mappings should be throttled when the total SWIOTLB usage is
> > > > above a threshold. Conversely, it can be unthrottled when the total
> > > > usage goes below a threshold, and it should not matter if that happ=
ens
> > > > due to an unmap of the exact buffer which previously pushed the usa=
ge
> > > > over the edge, or due to an unmap of any other unrelated buffer. =20
> > >
> > > I think I understand what you are proposing. But I don't see a way
> > > to make it work without adding global synchronization beyond
> > > the current atomic counter for the number of uI'm sed slabs. At a min=
imum
> > > we would need a global spin lock instead of the atomic counter. The s=
pin
> > > lock would protect the (non-atomic) slab count along with some other
> > > accounting, and that's more global references. As described in the
> > > cover letter, I was trying to avoid doing that. =20
> >=20
> > I have thought about this for a few days. And I'm still not convinced.
> > You have made it clear in multiple places that the threshold is a soft
> > limit, and there are many ways the SWIOTLB utilization may exceed the
> > threshold. In fact I'm not even 100% sure that an atomic counter is
> > needed, because the check is racy anyway. =20
>=20
> Atomic operations are expensive at the memory bus level, particularly
> in high CPU count systems with NUMA topologies. However,

Sure, the CPU must ensure exclusive access to the underlying memory and
cache coherency across all CPUs. I know how these things work...

> maintaining an imprecise global count doesn't work because the
> divergence from reality can become unbounded over time. The
> alternative is to sum up all the per-area counters each time a
> reasonably good global value is needed, and that can be expensive itself
> with high area counts. A hybrid might be to maintain an imprecise global
> count, but periodically update it by summing up all the per-area counters
> so that the divergence from reality isn't unbounded.

Yes, this is what I had in mind, but I'm not sure which option is
worse. Let me run a micro-benchmark on a 192-core AmpereOne system.

> > Another task may increase
> > (or decrease) the counter between atomic_long_read(&mem->total_used)
> > and a subsequent down(&mem->throttle_sem).
> >=20
> > I consider it a feature, not a flaw, because the real important checks
> > happen later while searching for free slots, and those are protected
> > with a spinlock.
> >  =20
> > > If you can see how to do what you propose with just the current
> > > atomic counter, please describe. =20
> >=20
> > I think I'm certainly missing something obvious, but let me open the
> > discussion to improve my understanding of the matter.
> >=20
> > Suppose we don't protect the slab count with anything. What is the
> > worst possible outcome? IIUC the worst scenario is that multiple tasks
> > unmap swiotlb buffers simultaneously and all of them believe that their
> > action made the total usage go below the low threshold, so all of them
> > try to release the semaphore.
> >=20
> > That's obviously not good, but AFAICS all that's needed is a
> > test_and_clear_bit() on a per-io_tlb_mem throttled flag just before
> > calling up(). Since up() would acquire the semaphore's spinlock, and
> > there's only one semaphore per io_tlb_mem, adding an atomic flag doesn't
> > look like too much overhead to me, especially if it ends up in the same
> > cache line as the semaphore. =20
>=20
> Yes, the semaphore management is the problem. Presumably we want
> each throttled request to wait on the semaphore, forming an ordered
> queue of waiters. Each up() on the semaphore releases one of those
> waiters. We don=E2=80=99t want to release all the waiters when the slab c=
ount
> transitions from "above throttle" to "below throttle" because that
> creates a thundering herd problem.
>
> So consider this example scenario:
> 1) Two waiters ("A" and "B") are queued the semaphore, each wanting 2 sla=
bs.
> 2) An unrelated swiotlb unmap frees 10 slabs, taking the slab count
> from 2 above threshold to 8 below threshold. This does up() on
> the semaphore and awakens "A".
> 3) "A" does his request for 2 slabs, and the slab count is now 6 below
> threshold.
> 4) "A" does swiotlb unmap.  The slab count goes from 6 below threshold ba=
ck
> to 8 below threshold, so no semaphore operation is done. "B" is still wai=
ting.
> 5) System-wide, swiotlb requests decline, and the slab count never goes a=
bove
> the threshold again. At this point, "B" is still waiting and never gets a=
wakened.
>=20
> An ordered queue of waiters is incompatible with wakeups determined solely
> on whether the slab count is below the threshold after swiotlb unmap. You
> would have to wait up all waiters and let them re-contend for the slots t=
hat
> are available below the threshold, with most probably losing out and going
> back on the semaphore wait queue (i.e., a thundering herd).

Ah, right, the semaphore must be released as many times as it is
acquired. Thank you for your patience.

> Separately, what does a swiotlb unmap do if it takes the slab count from =
above
> threshold to below threshold, and there are no waiters? It should not do =
up()
> in that case, but how can it make that decision in a way that doesn't race
> with a swiotlb map operation running at the same time?

Hm, this confirms my gut feeling that the atomic counter alone would
not be sufficient.

I think I can follow your reasoning now:

1. Kernels which enable CONFIG_SWIOTLB_THROTTLE are likely to have
   CONFIG_DEBUG_FS as well, so the price for an atomic operation on
   total_used is already paid.
2. There are no pre-existing per-io_tlb_mem ordering constraints on
   unmap, except the used counter, which is insufficient.
3. Slot data is already protected by its area spinlock, so adding
   something there does not increase the price.

I don't have an immediate idea, but I still believe we can do better.
For one thing, your scheme is susceptible to excessive throttling in
degenerate cases, e.g.:

1. A spike in network traffic temporarily increases swiotlb usage above
   the threshold, but it is not throttled because the network driver
   does not use SWIOTLB_ATTR_MAY_BLOCK.
2. A slow disk "Snail" maps a buffer and acquires the semaphore.
3. A fast disk "Cheetah" tries to map a buffer and goes on the
   semaphore wait queue.
4. Network buffers are unmapped, dropping usage below the threshold,
   but since the throttle flag was not set, the semaphore is not
   touched.
5. "Cheetah" is unnecessarily waiting for "Snail" to finish.

You may have never hit this scenario in your testing, because you
presumably had only fast virtual block devices.

I'm currently thinking along the lines of waking up the semaphore
on unmap whenever current usage is above the threshold and there is a
waiter.

As a side note, I get your concerns about the thundering herd effect,
but keep in mind that bounce buffers are not necessarily equal. If four
devices are blocked on mapping a single slot, you can actually wake up
all of them after you release four slots. For SG lists, you even add
explicit logic to trigger the wakeup only on the last segment...

BTW as we talk about the semaphore queue, it reminds me of an issue I
had with your proposed patch:

> @@ -1398,6 +1431,32 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  	dev_WARN_ONCE(dev, alloc_align_mask > ~PAGE_MASK,
>  		"Alloc alignment may prevent fulfilling requests with max mapping_size=
\n");
> =20
> +	if (IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) && attrs & DMA_ATTR_MAY_BLOCK) {
> +		unsigned long used =3D atomic_long_read(&mem->total_used);
> +
> +		/*
> +		 * Determining whether to throttle is intentionally done without
> +		 * atomicity. For example, multiple requests could proceed in
> +		 * parallel when usage is just under the threshold, putting
> +		 * usage above the threshold by the aggregate size of the
> +		 * parallel requests. The thresholds must already be set
> +		 * conservatively because of drivers that can't enable
> +		 * throttling, so this slop in the accounting shouldn't be
> +		 * problem. It's better than the potential bottleneck of a
> +		 * globally synchronzied reservation mechanism.
> +		 */
> +		if (used > mem->high_throttle) {
> +			throttle =3D true;
> +			mem->high_throttle_count++;
> +		} else if ((used > mem->low_throttle) &&
> +					(mem->throttle_sem.count <=3D 0)) {
                                              ^^^^^^^^^^^^^^^^^^

Is it safe to access the semaphore count like this without taking the
semaphore spinlock? If it is, then it deserves a comment to explain why
you can ignore this comment in include/linux/semaphore.h:

/* Please don't access any members of this structure directly */

Petr T

> +			throttle =3D true;
> +			mem->low_throttle_count++;
> +		}
> +		if (throttle)
> +			down(&mem->throttle_sem);
> +	}
> +
>  	offset =3D swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
>  	size =3D ALIGN(mapping_size + offset, alloc_align_mask + 1);
>  	index =3D swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &p=
ool);

