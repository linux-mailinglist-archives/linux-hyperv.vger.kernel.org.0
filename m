Return-Path: <linux-hyperv+bounces-2894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D206396267D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5251F23B32
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC97172BA8;
	Wed, 28 Aug 2024 12:02:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4916CD2A;
	Wed, 28 Aug 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846574; cv=none; b=eOb0LJd7vY7M5U0lHR0Y8SecfNvfoG7XJ6QBSpRb6SSjzOWv+sJNXaoh3LxISL5+Prx5OdttZqHY4tcWZizLcl66fVf1ioB9lOyKYFas6TWCTbVGSosRJiaSjYKrpzMVC+Sa3iC19VhnRUekl5u+7+QRkXfDsP5TjLt3lsDzkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846574; c=relaxed/simple;
	bh=GV+R85tycGY3Ozigrbe3J1zpTJoK33VMYMatOrJvs0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rGFwALrCQulbHcevgfiBlV1rabQfsC8CViDMgKXi4dKHp99CUQEcuoG5dicUn1iTZzhaN85qNA4Q+SjRaNK/mGoGnBe+0ww3VWyfsqnoos5ia+1GIauD6ujIIU1G0OldK8zvaw3yeKu72RQB49AQbzGluZt8RVv3TDsdD9nn0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B67AFDA7;
	Wed, 28 Aug 2024 05:03:16 -0700 (PDT)
Received: from [10.57.15.188] (unknown [10.57.15.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0133F762;
	Wed, 28 Aug 2024 05:02:43 -0700 (PDT)
Message-ID: <efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
Date: Wed, 28 Aug 2024 13:02:31 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
To: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, hch@lst.de,
 m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240822183718.1234-1-mhklinux@outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Background
> ==========
> Linux device drivers may make DMA map/unmap calls in contexts that
> cannot block, such as in an interrupt handler. Consequently, when a
> DMA map call must use a bounce buffer, the allocation of swiotlb
> memory must always succeed immediately. If swiotlb memory is
> exhausted, the DMA map call cannot wait for memory to be released. The
> call fails, which usually results in an I/O error.
> 
> Bounce buffers are usually used infrequently for a few corner cases,
> so the default swiotlb memory allocation of 64 MiB is more than
> sufficient to avoid running out and causing errors. However, recently
> introduced Confidential Computing (CoCo) VMs must use bounce buffers
> for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> swiotlb memory. This large allocation reduces the likelihood of a
> spike in usage causing DMA map failures. Unfortunately for most
> workloads, this insurance against spikes comes at the cost of
> potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
> memory can't be used for other purposes.
> 
> Approach
> ========
> The goal is to significantly reduce the amount of memory reserved as
> swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> DMA map failures due to memory exhaustion.

Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was already 
meant to address? Of course the implementation of that is still young 
and has plenty of scope to be made more effective, and some of the ideas 
here could very much help with that, but I'm struggling a little to see 
what's really beneficial about having a completely disjoint mechanism 
for sitting around doing nothing in the precise circumstances where it 
would seem most possible to allocate a transient buffer and get on with it.

Thanks,
Robin.

> To reach this goal, this patch set introduces the concept of swiotlb
> throttling, which can delay swiotlb allocation requests when swiotlb
> memory usage is high. This approach depends on the fact that some
> DMA map requests are made from contexts where it's OK to block.
> Throttling such requests is acceptable to spread out a spike in usage.
> 
> Because it's not possible to detect at runtime whether a DMA map call
> is made in a context that can block, the calls in key device drivers
> must be updated with a MAY_BLOCK attribute, if appropriate. When this
> attribute is set and swiotlb memory usage is above a threshold, the
> swiotlb allocation code can serialize swiotlb memory usage to help
> ensure that it is not exhausted.
> 
> In general, storage device drivers can take advantage of the MAY_BLOCK
> option, while network device drivers cannot. The Linux block layer
> already allows storage requests to block when the BLK_MQ_F_BLOCKING
> flag is present on the request queue. In a CoCo VM environment,
> relatively few device types are used for storage devices, and updating
> these drivers is feasible. This patch set updates the NVMe driver and
> the Hyper-V storvsc synthetic storage driver. A few other drivers
> might also need to be updated to handle the key CoCo VM storage
> devices.
> 
> Because network drivers generally cannot use swiotlb throttling, it is
> still possible for swiotlb memory to become exhausted. But blunting
> the maximum swiotlb memory used by storage devices can significantly
> reduce the peak usage, and a smaller amount of swiotlb memory can be
> allocated in a CoCo VM. Also, usage by storage drivers is likely to
> overall be larger than for network drivers, especially when large
> numbers of disk devices are in use, each with many I/O requests in-
> flight.
> 
> swiotlb throttling does not affect the context requirements of DMA
> unmap calls. These always complete without blocking, even if the
> corresponding DMA map call was throttled.
> 
> Patches
> =======
> Patches 1 and 2 implement the core of swiotlb throttling. They define
> DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
> indicate that a DMA map call is allowed to block, and therefore can be
> throttled. They update swiotlb_tbl_map_single() to detect this flag and
> implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
> updated to handle a previously throttled request that has now freed
> its swiotlb memory.
> 
> Patch 3 adds the dma_recommend_may_block() call that device drivers
> can use to know if there's benefit in using the MAY_BLOCK option on
> DMA map calls. If not in a CoCo VM, this call returns "false" because
> swiotlb is not being used for all DMA I/O. This allows the driver to
> set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
> there is benefit.
> 
> Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
> variant to allow passing the MAY_BLOCK attribute.
> 
> Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
> is used for storage in CoCo VMs in the Azure public cloud.
> 
> Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.
> 
> Discussion
> ==========
> * Since swiotlb isn't visible to device drivers, I've specifically
> named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
> something swiotlb specific. While this patch set consumes MAY_BLOCK
> only on the DMA direct path to do throttling in the swiotlb code,
> there might be other uses in the future outside of CoCo VMs, or
> perhaps on the IOMMU path.
> 
> * The swiotlb throttling code in this patch set throttles by
> serializing the use of swiotlb memory when usage is above a designated
> threshold: i.e., only one new swiotlb request is allowed to proceed at
> a time. When the corresponding unmap is done to release its swiotlb
> memory, the next request is allowed to proceed. This serialization is
> global and without knowledge of swiotlb areas. From a storage I/O
> performance standpoint, the serialization is a bit restrictive, but
> the code isn't trying to optimize for being above the threshold. If a
> workload regularly runs above the threshold, the size of the swiotlb
> memory should be increased.
> 
> * Except for knowing how much swiotlb memory is currently allocated,
> throttle accounting is done without locking or atomic operations. For
> example, multiple requests could proceed in parallel when usage is
> just under the threshold, putting usage above the threshold by the
> aggregate size of the parallel requests. The threshold must already be
> set relatively conservatively because of drivers that can't enable
> throttling, so this slop in the accounting shouldn't be a problem.
> It's better than the potential bottleneck of a globally synchronized
> reservation mechanism.
> 
> * In a CoCo VM, mapping a scatter/gather list makes an independent
> swiotlb request for each entry. Throttling each independent request
> wouldn't really work, so the code throttles only the first SGL entry.
> Once that entry passes any throttle, subsequent entries in the SGL
> proceed without throttling. When the SGL is unmapped, entries 1 thru
> N-1 are unmapped first, then entry 0 is unmapped, allowing the next
> serialized request to proceed.
> 
> Open Topics
> ===========
> 1. swiotlb allocations from Xen and the IOMMU code don't make use of
> throttling. This could be added if beneficial.
> 
> 2. The throttling values are currently exposed and adjustable in
> /sys/kernel/debug/swiotlb. Should any of this be moved so it is
> visible even without CONFIG_DEBUG_FS?
> 
> 3. I have not changed the current heuristic for the swiotlb memory
> size in CoCo VMs. It's not clear to me how to link this to whether the
> key storage drivers have been updated to allow throttling. For now,
> the benefit of reduced swiotlb memory size must be realized using the
> swiotlb= kernel boot line option.
> 
> 4. I need to update the swiotlb documentation to describe throttling.
> 
> This patch set is built against linux-next-20240816.
> 
> Michael Kelley (7):
>    swiotlb: Introduce swiotlb throttling
>    dma: Handle swiotlb throttling for SGLs
>    dma: Add function for drivers to know if allowing blocking is useful
>    scsi_lib_dma: Add _attrs variant of scsi_dma_map()
>    scsi: storvsc: Enable swiotlb throttling
>    nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
>    nvme: Enable swiotlb throttling for NVMe PCI devices
> 
>   drivers/nvme/host/core.c    |   4 +-
>   drivers/nvme/host/nvme.h    |   2 +-
>   drivers/nvme/host/pci.c     |  18 ++++--
>   drivers/nvme/host/tcp.c     |   3 +-
>   drivers/scsi/scsi_lib_dma.c |  13 ++--
>   drivers/scsi/storvsc_drv.c  |   9 ++-
>   include/linux/dma-mapping.h |  13 ++++
>   include/linux/swiotlb.h     |  15 ++++-
>   include/scsi/scsi_cmnd.h    |   7 ++-
>   kernel/dma/Kconfig          |  13 ++++
>   kernel/dma/direct.c         |  41 +++++++++++--
>   kernel/dma/direct.h         |   1 +
>   kernel/dma/mapping.c        |  10 ++++
>   kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
>   14 files changed, 227 insertions(+), 36 deletions(-)
> 

