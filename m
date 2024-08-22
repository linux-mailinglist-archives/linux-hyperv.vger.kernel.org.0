Return-Path: <linux-hyperv+bounces-2802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62595BE51
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FC11F23A4F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38B1D0488;
	Thu, 22 Aug 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URXXgAY5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DE41C63;
	Thu, 22 Aug 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351867; cv=none; b=QJfniyHEMhwNtruv06nxH3KDEglny4Pts5Ebic7q2KrTj9KIcNWSSK9bUYzPvoZ5heDsOq1ZFSISRDYAKMh1kQOe1a3UpOkkjxyAP5xMuunHNx/gTXTn6Dfl17F/JAE6pIIm4Y1WRdB9FOx6pkoljPfT5hXlMPCTPdNFB9WuaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351867; c=relaxed/simple;
	bh=P19DGvRJHfXvmgQ7mc0QBm4YZAqPf12PUHoT4LyDy0Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ekqnLfTTExnkcwZPisCbmywFfBil7P2WXhM6obk1sFGZrHxP9bPVt1POnkPysdG1ZTfxcC95KcPpptH83T4hzoG1dsvkq0e+7JIx3ojGDmEh24tz8PAXFXR7/NkRo2HGlonllmUCVVmzKlIUGnxcm8RdCKtDUrQT6gHws9Xr/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URXXgAY5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201f7fb09f6so10519175ad.2;
        Thu, 22 Aug 2024 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351865; x=1724956665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=URXXgAY5UfWrZ7huz9snz80TaHCzm6gWn7uBtXka6+gVcC7xjznBILQglidXX7mUrM
         +pNb27CIigY5hCWFF9kbFBjE1nZfdxrSOcNIbltliO9yQQc7dpzpQduPHllaSmyYsIIt
         ot9vLn5n/YfRUNWCBdl0h8RL6AUpUsfNpQ+e2ti2GS8Ogme4/W1BvR/2MXpgk9QzVUSK
         fEFyF362rq9TRz+u/EK2KUx7VYAMo8/YdVoKg/n9lv9WmhuS+gzZu6XoNoPA9YXrquDu
         OB3wBanyFsrfmLFOHp+Zr5GO3wBcmJr4GfmIBCA7/JVkBMlfe6VLX3CLwLeAh0vUzYlh
         3F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351865; x=1724956665;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOaQTtxsk58SbDoLn+PAUGwK+8hE4FRojXrJ9dN8wyI=;
        b=iJTCSVTGk027HZb+bYM7qO+59MZ5vRtldV7ZgrSYTnJhmR1gRtJDw+FKURe89axjwc
         NwBx1zXa4P0lmfEq7nHACqXftfMMmGuUjbX2/d6Qy/aKNmS1RqhxCPMX3rlu8Y8m197h
         zlAnrv/WvmGr5/eS0t9u2ZY27IRfC+g2OKu4bQw8SJwPzIPCQ3f9H5PmKL7jEE5LpgzQ
         SFoXrr+KSAS46YrVInYj93xhGSw+XXuHTmTqVs6JW2pYNuKN8xCxjhH/ZR2BWN0ZvbrT
         qLVzElCmqG9vB0d4KUdBgL7XFmAt5/Qrg4QSvIFgDI3/zd22qJI9NUbVqIDrAz1Mib3R
         /UpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA5HJcvba5fvnr+OpRe1g/YW0sWJ3ha5sqbsoptidjx06cQPQWAFl+LRgfAYv/IBIBtbi0LxK9683YDak3@vger.kernel.org, AJvYcCW/TLNh3IgqIhpyLz6iinsVTsZkHLZmN5PAmJr+Nv3ta7WfxuzWRcgQfBoR0mizEb7I44a5rVdZYNDxhnQ=@vger.kernel.org, AJvYcCWH9JfBFCdsOlOanAtXRRDuUjyYRj26kjO5dH5Ret8BYo+NpkEUGMd9993z9/MLg5FPiRN6+UqzdYJneA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Wg2gn/uqPuIVChyjs2TJ4BQckB3FVq8HZAoPylN084qMyvNX
	0JXCtlT6DVajSQIBJ+ar4PFwcEeBNdARx0j710qTPusXG1OBUSYb
X-Google-Smtp-Source: AGHT+IEl3He9Aim4HWajrK80+KqOIG9qzlUskCayv41SgJM9s3grubdRM7QHgHTRWUeXewRIkkN6lw==
X-Received: by 2002:a17:902:d48c:b0:202:32cf:5db1 with SMTP id d9443c01a7336-20388b6a84cmr38489205ad.44.1724351865300;
        Thu, 22 Aug 2024 11:37:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:44 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 0/7] Introduce swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:11 -0700
Message-Id: <20240822183718.1234-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Background
==========
Linux device drivers may make DMA map/unmap calls in contexts that
cannot block, such as in an interrupt handler. Consequently, when a
DMA map call must use a bounce buffer, the allocation of swiotlb
memory must always succeed immediately. If swiotlb memory is
exhausted, the DMA map call cannot wait for memory to be released. The
call fails, which usually results in an I/O error.

Bounce buffers are usually used infrequently for a few corner cases,
so the default swiotlb memory allocation of 64 MiB is more than
sufficient to avoid running out and causing errors. However, recently
introduced Confidential Computing (CoCo) VMs must use bounce buffers
for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
swiotlb memory. This large allocation reduces the likelihood of a
spike in usage causing DMA map failures. Unfortunately for most
workloads, this insurance against spikes comes at the cost of
potentially "wasting" hundreds of MiB's of the VM's memory, as swiotlb
memory can't be used for other purposes.

Approach
========
The goal is to significantly reduce the amount of memory reserved as
swiotlb memory in CoCo VMs, while not unduly increasing the risk of
DMA map failures due to memory exhaustion.

To reach this goal, this patch set introduces the concept of swiotlb
throttling, which can delay swiotlb allocation requests when swiotlb
memory usage is high. This approach depends on the fact that some
DMA map requests are made from contexts where it's OK to block.
Throttling such requests is acceptable to spread out a spike in usage.

Because it's not possible to detect at runtime whether a DMA map call
is made in a context that can block, the calls in key device drivers
must be updated with a MAY_BLOCK attribute, if appropriate. When this
attribute is set and swiotlb memory usage is above a threshold, the
swiotlb allocation code can serialize swiotlb memory usage to help
ensure that it is not exhausted.

In general, storage device drivers can take advantage of the MAY_BLOCK
option, while network device drivers cannot. The Linux block layer
already allows storage requests to block when the BLK_MQ_F_BLOCKING
flag is present on the request queue. In a CoCo VM environment,
relatively few device types are used for storage devices, and updating
these drivers is feasible. This patch set updates the NVMe driver and
the Hyper-V storvsc synthetic storage driver. A few other drivers
might also need to be updated to handle the key CoCo VM storage
devices.

Because network drivers generally cannot use swiotlb throttling, it is
still possible for swiotlb memory to become exhausted. But blunting
the maximum swiotlb memory used by storage devices can significantly
reduce the peak usage, and a smaller amount of swiotlb memory can be
allocated in a CoCo VM. Also, usage by storage drivers is likely to
overall be larger than for network drivers, especially when large
numbers of disk devices are in use, each with many I/O requests in-
flight.

swiotlb throttling does not affect the context requirements of DMA
unmap calls. These always complete without blocking, even if the
corresponding DMA map call was throttled.

Patches
=======
Patches 1 and 2 implement the core of swiotlb throttling. They define
DMA attribute flag DMA_ATTR_MAY_BLOCK that device drivers use to
indicate that a DMA map call is allowed to block, and therefore can be
throttled. They update swiotlb_tbl_map_single() to detect this flag and
implement the throttling. Similarly, swiotlb_tbl_unmap_single() is
updated to handle a previously throttled request that has now freed
its swiotlb memory.

Patch 3 adds the dma_recommend_may_block() call that device drivers
can use to know if there's benefit in using the MAY_BLOCK option on
DMA map calls. If not in a CoCo VM, this call returns "false" because
swiotlb is not being used for all DMA I/O. This allows the driver to
set the BLK_MQ_F_BLOCKING flag on blk-mq request queues only when
there is benefit.

Patch 4 updates the SCSI-specific DMA map calls to add a "_attrs"
variant to allow passing the MAY_BLOCK attribute.

Patch 5 adds the MAY_BLOCK option to the Hyper-V storvsc driver, which
is used for storage in CoCo VMs in the Azure public cloud.

Patches 6 and 7 add the MAY_BLOCK option to the NVMe PCI host driver.

Discussion
==========
* Since swiotlb isn't visible to device drivers, I've specifically
named the DMA attribute as MAY_BLOCK instead of MAY_THROTTLE or
something swiotlb specific. While this patch set consumes MAY_BLOCK
only on the DMA direct path to do throttling in the swiotlb code,
there might be other uses in the future outside of CoCo VMs, or
perhaps on the IOMMU path.

* The swiotlb throttling code in this patch set throttles by
serializing the use of swiotlb memory when usage is above a designated
threshold: i.e., only one new swiotlb request is allowed to proceed at
a time. When the corresponding unmap is done to release its swiotlb
memory, the next request is allowed to proceed. This serialization is
global and without knowledge of swiotlb areas. From a storage I/O
performance standpoint, the serialization is a bit restrictive, but
the code isn't trying to optimize for being above the threshold. If a
workload regularly runs above the threshold, the size of the swiotlb
memory should be increased.

* Except for knowing how much swiotlb memory is currently allocated,
throttle accounting is done without locking or atomic operations. For
example, multiple requests could proceed in parallel when usage is
just under the threshold, putting usage above the threshold by the
aggregate size of the parallel requests. The threshold must already be
set relatively conservatively because of drivers that can't enable
throttling, so this slop in the accounting shouldn't be a problem.
It's better than the potential bottleneck of a globally synchronized
reservation mechanism.

* In a CoCo VM, mapping a scatter/gather list makes an independent
swiotlb request for each entry. Throttling each independent request
wouldn't really work, so the code throttles only the first SGL entry.
Once that entry passes any throttle, subsequent entries in the SGL
proceed without throttling. When the SGL is unmapped, entries 1 thru
N-1 are unmapped first, then entry 0 is unmapped, allowing the next
serialized request to proceed.

Open Topics
===========
1. swiotlb allocations from Xen and the IOMMU code don't make use of
throttling. This could be added if beneficial.

2. The throttling values are currently exposed and adjustable in
/sys/kernel/debug/swiotlb. Should any of this be moved so it is
visible even without CONFIG_DEBUG_FS?

3. I have not changed the current heuristic for the swiotlb memory
size in CoCo VMs. It's not clear to me how to link this to whether the
key storage drivers have been updated to allow throttling. For now,
the benefit of reduced swiotlb memory size must be realized using the
swiotlb= kernel boot line option.

4. I need to update the swiotlb documentation to describe throttling.

This patch set is built against linux-next-20240816.

Michael Kelley (7):
  swiotlb: Introduce swiotlb throttling
  dma: Handle swiotlb throttling for SGLs
  dma: Add function for drivers to know if allowing blocking is useful
  scsi_lib_dma: Add _attrs variant of scsi_dma_map()
  scsi: storvsc: Enable swiotlb throttling
  nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
  nvme: Enable swiotlb throttling for NVMe PCI devices

 drivers/nvme/host/core.c    |   4 +-
 drivers/nvme/host/nvme.h    |   2 +-
 drivers/nvme/host/pci.c     |  18 ++++--
 drivers/nvme/host/tcp.c     |   3 +-
 drivers/scsi/scsi_lib_dma.c |  13 ++--
 drivers/scsi/storvsc_drv.c  |   9 ++-
 include/linux/dma-mapping.h |  13 ++++
 include/linux/swiotlb.h     |  15 ++++-
 include/scsi/scsi_cmnd.h    |   7 ++-
 kernel/dma/Kconfig          |  13 ++++
 kernel/dma/direct.c         |  41 +++++++++++--
 kernel/dma/direct.h         |   1 +
 kernel/dma/mapping.c        |  10 ++++
 kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
 14 files changed, 227 insertions(+), 36 deletions(-)

-- 
2.25.1


