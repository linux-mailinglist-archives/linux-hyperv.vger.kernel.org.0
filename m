Return-Path: <linux-hyperv+bounces-2896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9396282C
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B658B1C23822
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2017838A;
	Wed, 28 Aug 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="UxgrDlqj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA9537F5;
	Wed, 28 Aug 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850248; cv=none; b=IJ49m/NfwIdmfFn+xgYJ1/6H0aPKiTfjhABa+S1Zp5YwB42S+pHZd+rNSdiQOJem68K+YfDvTq6Bai5E6Bo86c438G6YyyHN9EzvZGrcr19gZVyt2c9RIp5jvJdaz9Pvo7UVIqfQF3Ja425q1th3Q/nQi6jaLmPL7DPbQK1Wxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850248; c=relaxed/simple;
	bh=eIFWJnnAkEgyXg29iirfM5KJoJGi1BEJ91e5R2V/odg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unNv9brpyD2Fh2ua365TE5oiA1LrRSIfvZLY8TMKUr77UrvZorsRyNjWvz/qQcq41nMB3gXQSJ6NdfKbFQUNmSmnQjG9aDqi9l6paclGSi6aWgcFOG463boqz3ZU/U1IHboyG3WupGyPkfWv+FBwrQywC0EbGie7m5iI80D1om0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=UxgrDlqj; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 86D131F8271;
	Wed, 28 Aug 2024 15:04:01 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724850241; bh=3Vqr2fZUfLOM+B3Ne+7VT9mnLrdqdBH/WIKDFPQWeXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UxgrDlqjgvzOYqiQlbrUgEnTR7bKPjukXPM4NFseUr/EVOvXLhoEuiqojfBBawAdB
	 RfaXgKQC0k2t2+dxrkTF+kuBVceJq5NHdLJTpT4wn/fr881r7MSZP1myhqiOJI/jof
	 OJxzFU+Bg0WZMGXxm2f5ZbEc1MbEKaXmxXjvrMbzPNj1Urk7FzRH6KvKFZX7LHn+b4
	 i7mv5SVRK33IjXoB2wSPHaRwTPsLBOlt7cpF0SVUb9P4c4pGduYtGweGp7AckOkviI
	 a+TRfOIBNnT0s1CPZjnKCQQXofBSupy8KkfwTafKlBXyhzzH4OqiDW1IEkg86RLpfc
	 xAWxQaCMag6hw==
Date: Wed, 28 Aug 2024 15:03:56 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240828150356.46d3d3dc@mordecai.tesarici.cz>
In-Reply-To: <efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 13:02:31 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > Background
> > ==========
> > Linux device drivers may make DMA map/unmap calls in contexts that
> > cannot block, such as in an interrupt handler. Consequently, when a
> > DMA map call must use a bounce buffer, the allocation of swiotlb
> > memory must always succeed immediately. If swiotlb memory is
> > exhausted, the DMA map call cannot wait for memory to be released. The
> > call fails, which usually results in an I/O error.
> > 
> > Bounce buffers are usually used infrequently for a few corner cases,
> > so the default swiotlb memory allocation of 64 MiB is more than
> > sufficient to avoid running out and causing errors. However, recently
> > introduced Confidential Computing (CoCo) VMs must use bounce buffers
> > for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> > a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> > swiotlb memory. This large allocation reduces the likelihood of a
> > spike in usage causing DMA map failures. Unfortunately for most
> > workloads, this insurance against spikes comes at the cost of
> > potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
> > memory can't be used for other purposes.
> > 
> > Approach
> > ========
> > The goal is to significantly reduce the amount of memory reserved as
> > swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> > DMA map failures due to memory exhaustion.  
> 
> Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was already 
> meant to address? Of course the implementation of that is still young 
> and has plenty of scope to be made more effective, and some of the ideas 
> here could very much help with that, but I'm struggling a little to see 
> what's really beneficial about having a completely disjoint mechanism 
> for sitting around doing nothing in the precise circumstances where it 
> would seem most possible to allocate a transient buffer and get on with it.

This question can be probably best answered by Michael, but let me give
my understanding of the differences. First the similarity: Yes, one
of the key new concepts is that swiotlb allocation may block, and I
introduced a similar attribute in one of my dynamic SWIOTLB patches; it
was later dropped, but dynamic SWIOTLB would still benefit from it.

More importantly, dynamic SWIOTLB may deplete memory following an I/O
spike. I do have some ideas how memory could be returned back to the
allocator, but the code is not ready (unlike this patch series).
Moreover, it may still be a better idea to throttle the devices
instead, because returning DMA'able memory is not always cheap. In a
CoCo VM, this memory must be re-encrypted, and that requires a
hypercall that I'm told is expensive.

In short, IIUC it is faster in a CoCo VM to delay some requests a bit
than to grow the swiotlb.

Michael, please add your insights.

Petr T

> > To reach this goal, this patch set introduces the concept of swiotlb
> > throttling, which can delay swiotlb allocation requests when swiotlb
> > memory usage is high. This approach depends on the fact that some
> > DMA map requests are made from contexts where it's OK to block.
> > Throttling such requests is acceptable to spread out a spike in usage.
> > 
> > Because it's not possible to detect at runtime whether a DMA map call
> > is made in a context that can block, the calls in key device drivers
> > must be updated with a MAY_BLOCK attribute, if appropriate. When this
> > attribute is set and swiotlb memory usage is above a threshold, the
> > swiotlb allocation code can serialize swiotlb memory usage to help
> > ensure that it is not exhausted.
> > 
> > In general, storage device drivers can take advantage of the MAY_BLOCK
> > option, while network device drivers cannot. The Linux block layer
> > already allows storage requests to block when the BLK_MQ_F_BLOCKING
> > flag is present on the request queue. In a CoCo VM environment,
> > relatively few device types are used for storage devices, and updating
> > these drivers is feasible. This patch set updates the NVMe driver and
> > the Hyper-V storvsc synthetic storage driver. A few other drivers
> > might also need to be updated to handle the key CoCo VM storage
> > devices.
> > 
> > Because network drivers generally cannot use swiotlb throttling, it is
> > still possible for swiotlb memory to become exhausted. But blunting
> > the maximum swiotlb memory used by storage devices can significantly
> > reduce the peak usage, and a smaller amount of swiotlb memory can be
> > allocated in a CoCo VM. Also, usage by storage drivers is likely to
> > overall be larger than for network drivers, especially when large
> > numbers of disk devices are in use, each with many I/O requests in-
> > flight.
> > 
> > swiotlb throttling does not affect the context requirements of DMA
> > unmap calls. These always complete without blocking, even if the
> > corresponding DMA map call was throttled.
> > 
> > Patches
> > =======
> > Patches 1 and 2 implement the core of swiotlb throttling. They define
> > DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
> > indicate that a DMA map call is allowed to block, and therefore can be
> > throttled. They update swiotlb_tbl_map_single() to detect this flag and
> > implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
> > updated to handle a previously throttled request that has now freed
> > its swiotlb memory.
> > 
> > Patch 3 adds the dma_recommend_may_block() call that device drivers
> > can use to know if there's benefit in using the MAY_BLOCK option on
> > DMA map calls. If not in a CoCo VM, this call returns "false" because
> > swiotlb is not being used for all DMA I/O. This allows the driver to
> > set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
> > there is benefit.
> > 
> > Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
> > variant to allow passing the MAY_BLOCK attribute.
> > 
> > Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
> > is used for storage in CoCo VMs in the Azure public cloud.
> > 
> > Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.
> > 
> > Discussion
> > ==========
> > * Since swiotlb isn't visible to device drivers, I've specifically
> > named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
> > something swiotlb specific. While this patch set consumes MAY_BLOCK
> > only on the DMA direct path to do throttling in the swiotlb code,
> > there might be other uses in the future outside of CoCo VMs, or
> > perhaps on the IOMMU path.
> > 
> > * The swiotlb throttling code in this patch set throttles by
> > serializing the use of swiotlb memory when usage is above a designated
> > threshold: i.e., only one new swiotlb request is allowed to proceed at
> > a time. When the corresponding unmap is done to release its swiotlb
> > memory, the next request is allowed to proceed. This serialization is
> > global and without knowledge of swiotlb areas. From a storage I/O
> > performance standpoint, the serialization is a bit restrictive, but
> > the code isn't trying to optimize for being above the threshold. If a
> > workload regularly runs above the threshold, the size of the swiotlb
> > memory should be increased.
> > 
> > * Except for knowing how much swiotlb memory is currently allocated,
> > throttle accounting is done without locking or atomic operations. For
> > example, multiple requests could proceed in parallel when usage is
> > just under the threshold, putting usage above the threshold by the
> > aggregate size of the parallel requests. The threshold must already be
> > set relatively conservatively because of drivers that can't enable
> > throttling, so this slop in the accounting shouldn't be a problem.
> > It's better than the potential bottleneck of a globally synchronized
> > reservation mechanism.
> > 
> > * In a CoCo VM, mapping a scatter/gather list makes an independent
> > swiotlb request for each entry. Throttling each independent request
> > wouldn't really work, so the code throttles only the first SGL entry.
> > Once that entry passes any throttle, subsequent entries in the SGL
> > proceed without throttling. When the SGL is unmapped, entries 1 thru
> > N-1 are unmapped first, then entry 0 is unmapped, allowing the next
> > serialized request to proceed.
> > 
> > Open Topics
> > ===========
> > 1. swiotlb allocations from Xen and the IOMMU code don't make use of
> > throttling. This could be added if beneficial.
> > 
> > 2. The throttling values are currently exposed and adjustable in
> > /sys/kernel/debug/swiotlb. Should any of this be moved so it is
> > visible even without CONFIG_DEBUG_FS?
> > 
> > 3. I have not changed the current heuristic for the swiotlb memory
> > size in CoCo VMs. It's not clear to me how to link this to whether the
> > key storage drivers have been updated to allow throttling. For now,
> > the benefit of reduced swiotlb memory size must be realized using the
> > swiotlb= kernel boot line option.
> > 
> > 4. I need to update the swiotlb documentation to describe throttling.
> > 
> > This patch set is built against linux-next-20240816.
> > 
> > Michael Kelley (7):
> >    swiotlb: Introduce swiotlb throttling
> >    dma: Handle swiotlb throttling for SGLs
> >    dma: Add function for drivers to know if allowing blocking is useful
> >    scsi_lib_dma: Add _attrs variant of scsi_dma_map()
> >    scsi: storvsc: Enable swiotlb throttling
> >    nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
> >    nvme: Enable swiotlb throttling for NVMe PCI devices
> > 
> >   drivers/nvme/host/core.c    |   4 +-
> >   drivers/nvme/host/nvme.h    |   2 +-
> >   drivers/nvme/host/pci.c     |  18 ++++--
> >   drivers/nvme/host/tcp.c     |   3 +-
> >   drivers/scsi/scsi_lib_dma.c |  13 ++--
> >   drivers/scsi/storvsc_drv.c  |   9 ++-
> >   include/linux/dma-mapping.h |  13 ++++
> >   include/linux/swiotlb.h     |  15 ++++-
> >   include/scsi/scsi_cmnd.h    |   7 ++-
> >   kernel/dma/Kconfig          |  13 ++++
> >   kernel/dma/direct.c         |  41 +++++++++++--
> >   kernel/dma/direct.h         |   1 +
> >   kernel/dma/mapping.c        |  10 ++++
> >   kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
> >   14 files changed, 227 insertions(+), 36 deletions(-)
> >   


