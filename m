Return-Path: <linux-hyperv+bounces-2903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58F963142
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E081C2097A
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A01AC435;
	Wed, 28 Aug 2024 19:50:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EBE1ABEDA;
	Wed, 28 Aug 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874629; cv=none; b=YOdXC8fcWuAXeBBEUNJ4x10RhUhWfhnSNL99mSpU9N0P3qSzBg91sodtACZkDseUsuXpMXoJ1Cp2hIk5Hk2Ke6/tfYuVlFkALggSoDD9tDxAQoomq8p7nUnzoSuKKlE83KtObp7CrlsfLnNaOZLr4qBRalaC7WIPclR+v2QJAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874629; c=relaxed/simple;
	bh=J5uLwfIH0C5JMzfyTNRjXZlVW+LbfOQyjRaqBUfyWGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ+JqbJt4HbfXY5pypZqMqVdM+kbQG4MUjSf0/50wk45wOaje4a+wSDw988Lr9ydy91pF2N+bfhlO9Quz1Ta18CJ8pRaWxuXsrKtMpcnyQGXCwT6Ru5DBctnG5vzau3tF2gWAF5Rl4F85I4kTT8GzBCe0/YGeL3RbKwv6H8nG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CDDDA7;
	Wed, 28 Aug 2024 12:50:52 -0700 (PDT)
Received: from [10.57.15.188] (unknown [10.57.15.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269DF3F762;
	Wed, 28 Aug 2024 12:50:23 -0700 (PDT)
Message-ID: <bb7dd4ca-948f-4af7-b2ac-3ca02e82699f@arm.com>
Date: Wed, 28 Aug 2024 20:50:21 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240822183718.1234-1-mhklinux@outlook.com>
 <efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
 <20240828150356.46d3d3dc@mordecai.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240828150356.46d3d3dc@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-28 2:03 pm, Petr Tesařík wrote:
> On Wed, 28 Aug 2024 13:02:31 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> Background
>>> ==========
>>> Linux device drivers may make DMA map/unmap calls in contexts that
>>> cannot block, such as in an interrupt handler. Consequently, when a
>>> DMA map call must use a bounce buffer, the allocation of swiotlb
>>> memory must always succeed immediately. If swiotlb memory is
>>> exhausted, the DMA map call cannot wait for memory to be released. The
>>> call fails, which usually results in an I/O error.
>>>
>>> Bounce buffers are usually used infrequently for a few corner cases,
>>> so the default swiotlb memory allocation of 64 MiB is more than
>>> sufficient to avoid running out and causing errors. However, recently
>>> introduced Confidential Computing (CoCo) VMs must use bounce buffers
>>> for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
>>> a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
>>> swiotlb memory. This large allocation reduces the likelihood of a
>>> spike in usage causing DMA map failures. Unfortunately for most
>>> workloads, this insurance against spikes comes at the cost of
>>> potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
>>> memory can't be used for other purposes.
>>>
>>> Approach
>>> ========
>>> The goal is to significantly reduce the amount of memory reserved as
>>> swiotlb memory in CoCo VMs, while not unduly increasing the risk of
>>> DMA map failures due to memory exhaustion.
>>
>> Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was already
>> meant to address? Of course the implementation of that is still young
>> and has plenty of scope to be made more effective, and some of the ideas
>> here could very much help with that, but I'm struggling a little to see
>> what's really beneficial about having a completely disjoint mechanism
>> for sitting around doing nothing in the precise circumstances where it
>> would seem most possible to allocate a transient buffer and get on with it.
> 
> This question can be probably best answered by Michael, but let me give
> my understanding of the differences. First the similarity: Yes, one
> of the key new concepts is that swiotlb allocation may block, and I
> introduced a similar attribute in one of my dynamic SWIOTLB patches; it
> was later dropped, but dynamic SWIOTLB would still benefit from it.
> 
> More importantly, dynamic SWIOTLB may deplete memory following an I/O
> spike. I do have some ideas how memory could be returned back to the
> allocator, but the code is not ready (unlike this patch series).
> Moreover, it may still be a better idea to throttle the devices
> instead, because returning DMA'able memory is not always cheap. In a
> CoCo VM, this memory must be re-encrypted, and that requires a
> hypercall that I'm told is expensive.

Sure, making a hypercall in order to progress is expensive relative to 
being able to progress without doing that, but waiting on a lock for an 
unbounded time in the hope that other drivers might release their DMA 
mappings soon represents a potentially unbounded expense, since it 
doesn't even carry any promise of progress at all - oops userspace just 
filled up SWIOTLB with a misguided dma-buf import and now the OS has 
livelocked on stalled I/O threads fighting to retry :(

As soon as we start tracking thresholds etc. then that should equally 
put us in the position to be able to manage the lifecycle of both 
dynamic and transient pools more effectively - larger allocations which 
can be reused by multiple mappings until the I/O load drops again could 
amortise that initial cost quite a bit.

Furthermore I'm not entirely convinced that the rationale for throttling 
being beneficial is even all that sound. Serialising requests doesn't 
make them somehow use less memory, it just makes them use it... 
serially. If a single CPU is capable of queueing enough requests at once 
to fill the SWIOTLB, this is going to do absolutely nothing; if two CPUs 
are capable of queueing enough requests together to fill the SWIOTLB, 
making them take slightly longer to do so doesn't inherently mean 
anything more than reaching the same outcome more slowly. At worst, if a 
thread is blocked from polling for completion and releasing a bunch of 
mappings of already-finished descriptors because it's stuck on an unfair 
lock trying to get one last one submitted, then throttling has actively 
harmed the situation.

AFAICS this is dependent on rather particular assumptions of driver 
behaviour in terms of DMA mapping patterns and interrupts, plus the 
overall I/O workload shape, and it's not clear to me how well that 
really generalises.

> In short, IIUC it is faster in a CoCo VM to delay some requests a bit
> than to grow the swiotlb.

I'm not necessarily disputing that for the cases where the assumptions 
do hold, it's still more a question of why those two things should be 
separate and largely incompatible (I've only skimmed the patches here, 
but my impression is that it doesn't look like they'd play all that 
nicely together if both enabled). To me it would make far more sense for 
this to be a tuneable policy of a more holistic SWIOTLB_DYNAMIC itself, 
i.e. blockable calls can opportunistically wait for free space up to a 
well-defined timeout, but then also fall back to synchronously 
allocating a new pool in order to assure a definite outcome of success 
or system-is-dying-level failure.

Thanks,
Robin.

