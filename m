Return-Path: <linux-hyperv+bounces-2813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2595C5BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DA91C223CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AE13A3ED;
	Fri, 23 Aug 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="m+oNvj+r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03A136658;
	Fri, 23 Aug 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395505; cv=none; b=c9yyY7g2en7CoakLYpUM8opNJ8rAblbINPIcc/ifhpZR9k2bJrewaioCh/YxxUDdBbN7nEpimPswFc4Tnmm3KS5421bOAS79E1oIFqQ0T1OQUK18QQkdfS5OIwzRJfNi0urfaNvcDO2g3XiyAFI6ZkS4e6MctWmei1UTSGWuTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395505; c=relaxed/simple;
	bh=n5w5STDIKBrH5BubdexcNZwBz1GAe2cXVs576fIf/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQzsftATMPtyEk4Hlz+fZqZZsqE2rAO23+LsbU3pLPKLKzSyTiebVzGlyuRD6Lh0sECS7zI/ayUf7vonIqYa0UtXmBlZzNgpsThwffFE+rKEKbADJGP7vaZUqMmDKrsfbUjsGyVqdnapfV9IpDiHKgujh2/9+JY5mOtG5kvnGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=m+oNvj+r; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 325621F0E0F;
	Fri, 23 Aug 2024 08:45:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724395500; bh=9V5utoLf6bmkMdrbH1+WyxcBdLMBEm+3n6EWW0ovKL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+oNvj+r0uc1qqcfJumE/6tDrCcNBltWTLtQ5T4T3I9bwwwgeR6hERL10ng6PxRNv
	 GlkOlkgyIroaW9yXQKNL7Pl9HCrMwUqD7HXrexBmL0DcOTnCfm1O9zLPOENj+/nrf8
	 nC+5bsPpOjzhqnCDSKlHRNjqyueYXdMUa4G3+bSxYRWYgVMKifACjFOVhboc3ugq49
	 wEURHkpgXZeFb0KsWoPgNfANyTY6kq3VFAdTcFgPbXeGCWxwxSnp9jtgToFF8Fu8tn
	 Vciw/zRXNiGs3aqZpwRY9rcpG99xjLlM1NCH9qD/5C5dmZ9taJ7vFz5m3qV6u+dIXP
	 vj6VahIZpWLUQ==
Date: Fri, 23 Aug 2024 08:44:58 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240823084458.4394b401@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

upfront, I've had more time to consider this idea, because Michael
kindly shared it with me back in February.

On Thu, 22 Aug 2024 11:37:11 -0700
mhkelley58@gmail.com wrote:

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

FTR most I/O errors are recoverable, but the recovery usually takes
a lot of time. Plus the errors are logged and usually treated as
important by monitoring software. In short, I agree it's a poor choice.

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

It may be worth mentioning that page encryption state can be changed by
a hypercall, but that's a costly (and non-atomic) operation. It's much
faster to copy the data to a page which is already unencrypted (a
bounce buffer).

> Approach
> ========
> The goal is to significantly reduce the amount of memory reserved as
> swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> DMA map failures due to memory exhaustion.
> 
> To reach this goal, this patch set introduces the concept of swiotlb
> throttling, which can delay swiotlb allocation requests when swiotlb
> memory usage is high. This approach depends on the fact that some
> DMA map requests are made from contexts where it's OK to block.
> Throttling such requests is acceptable to spread out a spike in usage.
> 
> Because it's not possible to detect at runtime whether a DMA map call
> is made in a context that can block, the calls in key device drivers
> must be updated with a MAY_BLOCK attribute, if appropriate.

Before somebody asks, the general agreement for decades has been that
there should be no global state indicating whether the kernel is in
atomic context. Instead, if a function needs to know, it should take an
explicit parameter.

IOW this MAY_BLOCK attribute follows an unquestioned kernel design
pattern.

> When this
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

The system can also handle network packet loss much better than I/O
errors, mainly because lost packets have always been part of normal
operation, unlike I/O errors. After all, that's why we unmount all
filesystems on removable media before physically unplugging (or
ejecting) them.

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

I once introduced a similar flag and called it MAY_SLEEP. I chose
MAY_SLEEP, because there is already a might_sleep() annotation, but I
don't have a strong opinion unless your semantics is supposed to be
different from might_sleep(). If it is, then I strongly prefer
MAY_BLOCK to prevent confusing the two.

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

With CONFIG_SWIOTLB_DYNAMIC, this could happen automatically in the
future. But let's get the basic functionality first.

> * Except for knowing how much swiotlb memory is currently allocated,
> throttle accounting is done without locking or atomic operations. For
> example, multiple requests could proceed in parallel when usage is
> just under the threshold, putting usage above the threshold by the
> aggregate size of the parallel requests. The threshold must already be
> set relatively conservatively because of drivers that can't enable
> throttling, so this slop in the accounting shouldn't be a problem.
> It's better than the potential bottleneck of a globally synchronized
> reservation mechanism.

Agreed.

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

Yes. It should be possible to control the thresholds through sysctl.

> 3. I have not changed the current heuristic for the swiotlb memory
> size in CoCo VMs. It's not clear to me how to link this to whether the
> key storage drivers have been updated to allow throttling. For now,
> the benefit of reduced swiotlb memory size must be realized using the
> swiotlb= kernel boot line option.

This sounds fine for now.

> 4. I need to update the swiotlb documentation to describe throttling.
> 
> This patch set is built against linux-next-20240816.

OK, I'm going try it out.

Thank you for making this happen!

Petr T

