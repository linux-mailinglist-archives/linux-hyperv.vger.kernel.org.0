Return-Path: <linux-hyperv+bounces-9572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JXZOa5bvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9572-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBC2D20BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2BF305AD4E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595293F7AA1;
	Thu, 19 Mar 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6teRfWR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982F368965
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951916; cv=none; b=ayD82bhdLNbvvl1WBqwwgmw8UbdphzLccyPXamgPILuQuh3GhRyCwGBb0Jn46cAJMEft6VwvbE4DvNi17Lcc5PVtG5TQ90qw4dbHu1O6WG+e2+uoaL59Jj+Gm50O4D3qczV5/R+04eco6vTUxco+nKikmAf4xJYaT4qZdLYHijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951916; c=relaxed/simple;
	bh=fOaxI4a9O9ZitgJOIJd8IzNIghJki8aARNy/4nIflX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjqcpPXXYC6U9Dpxf33jNZ9G0wlBJ2tD8hbezu2KoiE84ZwolYMs/TtJCkkCXi0+pko7JnLJq4Jk/q7xvH639FpOu/EB7Li8EH6yIEsHawf/iK5Kh3cIZnmIKbwx+8gW0zyhN3bSMULrmuelLFR3JJoabq4D0LZLCBCOPijBbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6teRfWR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1709499f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951913; x=1774556713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5zdEYd/uvoFNbHGnpenV/SzN2i18O/Jqi/TfRevxQI=;
        b=h6teRfWRq4pX2rH56/bG7Sr1dbq1qvClBlyU7tRKRuViKrRK7DLx9p4lxq4IrAHIKb
         AkmnxACusvyy0ZTrNDUbBwKO7cnhWxJXvlywbjpV0y/0JT+wY1TFSdEUqoYmd7sFVPyI
         +Io62mWdZzAxtqfCkiMEb5HZHOJVXJ32JKLzXbxEcto8bVkT/LtymeBv+IUXvpB2ZC29
         HsVq0TsFkrOTx+Oqujfzn9RgUw2JbYFmU43AZAU7dcGojZzIlbW/vQs6z2SvsinBoP19
         BA4LRYK7jXqEgzCzU4Ax2j2eh3cgRvLHjjZRYQh4xl3MY+iSI0VLhY4ncmEU1h6TuMgi
         AqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951913; x=1774556713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5zdEYd/uvoFNbHGnpenV/SzN2i18O/Jqi/TfRevxQI=;
        b=LweVyajr9aZbD//wRF7UrC7Ue6b3oQ5VTKnkSmZlXeQJ5vjwVmTVi/SVihS2D2mE81
         WCvW9pNHDIqh3auqms3NUdJ/ZHyln1LbhyAkZLM+jcVtYhdEFMtHDFBXaShC2BAwOAOe
         3jp1tX8lDQf3965GdlRnIMWHyydcF/GbBr8o5xeWcmsajrR3xk28WWpgTsIAFxVsH/18
         jfp3DnUO2GhL0FGcmy3MHlGd8QiCztN+ETJemLg7fdADa/j77JPm9RymV1eg2eShL9dQ
         QLDsZD2XnJDO3Bv5+c4kwAinhIMuOjaxUflbAbSVl1D6Whsz4D0BJHWXerULn8Shj5rR
         sd/w==
X-Gm-Message-State: AOJu0Yx90JxU3fq6mlLHF6bP8Y100cTamypNigU/zzVTJxLkgVnnBU4F
	Y2LzE8Qq2J1IEXmHt9VAyGl77zLt30kvaPwjsztOIhqbziYXpbZtqndLSCQrq8LMM3c=
X-Gm-Gg: ATEYQzynQXouw6nthJy1ejuqAokNBerLDPVcr9xCcc2/dqb3QRKC5bdYXcjxrsBelON
	67iFgbkq+tp6HvoRFDzWEIZlmjqNHqOUndC+sJdLApDNKSoi+yfWDbbZDpy0yrqIazVb2fNqleC
	A7CHvZdNBsSNa5fDsFpQNomJSFytouvC9lvkrTnMt3VOkEZAdWxe0IFD7gQM8FxsbEB/Ea1CCmc
	era12HT1BC2991XNivD7VV8sJr74zRl3iSG6fL0UjoQxPa7YYbWoeVL8CgKhWhWsDJFoRizAjZQ
	my+l9XDjVIFUtups+Z/uqVyaeTymznxou3u8U1YWOzIUbxgOZkG47aDgXVwerfMsdk8jfJ36n+V
	ZieNcrOjTvmo3f7LFp93gGJUMJeR8Iza4mnu3benEOeiu68d/sDSIO+91B7IlgWb5AxAdwjklkw
	BoPsZDqEfpmuKU8eZprmqHNirElMenJNcSSEfX0hUkaFAO/jQj
X-Received: by 2002:a05:6000:42c1:b0:439:df59:abc5 with SMTP id ffacd0b85a97d-43b576fcf8bmr5707125f8f.12.1773951912626;
        Thu, 19 Mar 2026 13:25:12 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:11 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH v4 00/55] drivers: hv: dxgkrnl: Driver for Hyper-V virtual compute device
Date: Thu, 19 Mar 2026 20:24:14 +0000
Message-ID: <20260319202509.63802-1-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9572-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.937];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38EBC2D20BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces the dxgkrnl driver, which provides Linux
support for virtual compute devices (vGPUs) paravirtualized by a Windows
Hyper-V host. The primary use case is Windows Subsystem for Linux (WSL2),
where the driver enables GPU-accelerated workloads inside Linux containers
running on Windows.

The driver creates /dev/dxg, a miscdevice that user-space API libraries
(such as the open-source libdxg) use to communicate with virtual GPU
adapters via IOCTLs implementing a subset of the WDDM/MCDM D3DKMT
interface. Physical GPU access is performed entirely on the Windows host;
the guest driver communicates over Hyper-V VMBus channels.

Key characteristics:
 - Self-contained under drivers/hv/dxgkrnl/
 - Depends only on CONFIG_HYPERV, DMA_SHARED_BUFFER, SYNC_FILE
 - Supports multiple vGPU adapters per VM
 - DMA fence integration via dxgsyncfile (SYNC_FILE)
 - Supports compute-only accelerators (AI/ML workloads) as well as
   full graphics adapters

Changes since v3 (posted March 2022):
 - Replace deprecated one-element arrays [1] with C99 flexible arrays []
 - Replace %px with %p in trace macros
 - Remove unnecessary braces from single-statement if blocks
 - Remove LINUX_VERSION_CODE guard for max_pkt_size (added in 5.15,
   well before any target kernel for this submission)
 - Remove linux/version.h include (no longer needed)
 - Fix whitespace issues flagged by checkpatch
 - Replace non-debug DXG_ERR do{}while(0) macro with direct dev_err call
 - Change -EBADE to -ENODEV for global channel duplicate detection
   (as requested by Greg KH in v3 review)
 - Remove MODULE_VERSION (not recommended for in-tree drivers)
 - Add explanatory comment to guid_to_luid() cast
 - Additional features and fixes developed in the WSL2 fork:
   * dxgsyncfile: DMA fence / sync file integration
   * D3DKMTEnumProcesses, D3DDKMTIsFeatureEnabled, D3DKMTInvalidateCache
   * Compute-only adapter support
   * pin_user_pages for DMA-accessible memory
   * Retry logic for VMBus ring buffer full condition
   * Various synchronization and memory safety fixes

Regarding the dxgglobal singleton raised in v3 review:
The design reflects a host architecture constraint: each Hyper-V VM has
exactly one global VMBus channel offered by the host, regardless of how
many vGPU adapters are present. The dxgglobal structure encapsulates this
VM-level state (global channel, adapter list, process list, host event
tracking). Per-adapter state is separately managed in dxgadapter objects.
This design was previously explained in the v3 thread; the architecture
matches the Hyper-V GPU-PV protocol which is fixed by the host side.

The patches apply on top of v6.6-lts. The user-space library (libdxg)
that communicates with this driver is available at:
  https://github.com/microsoft/libdxg

The full WDDM compute stack (OpenCL, oneAPI, OpenVINO) is available
open-source via Intel's compute-runtime project.

Iouri Tarassov (iourit@linux.microsoft.com) is the primary author and
maintainer of this driver.

Eric Curtin (1):
  drivers: hv: dxgkrnl: Fix checkpatch issues and address reviewer
    feedback

Hideyuki Nagase (1):
  drivers: hv: dxgkrnl: Fix crash at hmgrtable_free_handle

Iouri Tarassov (53):
  drivers: hv: dxgkrnl: Driver initialization and loading
  drivers: hv: dxgkrnl: Add VMBus message support, initialize VMBus
    channels.
  drivers: hv: dxgkrnl: Creation of dxgadapter object
  drivers: hv: dxgkrnl: Opening of /dev/dxg device and dxgprocess
    creation
  drivers: hv: dxgkrnl: Enumerate and open dxgadapter objects
  drivers: hv: dxgkrnl: Creation of dxgdevice objects
  drivers: hv: dxgkrnl: Creation of dxgcontext objects
  drivers: hv: dxgkrnl: Creation of compute device allocations and
    resources
  drivers: hv: dxgkrnl: Creation of compute device sync objects
  drivers: hv: dxgkrnl: Operations using sync objects
  drivers: hv: dxgkrnl: Sharing of dxgresource objects
  drivers: hv: dxgkrnl: Sharing of sync objects
  drivers: hv: dxgkrnl: Creation of paging queue objects.
  drivers: hv: dxgkrnl: Submit execution commands to the compute device
  drivers: hv: dxgkrnl: Share objects with the host
  drivers: hv: dxgkrnl: Query the dxgdevice state
  drivers: hv: dxgkrnl: Map(unmap) CPU address to device allocation
  drivers: hv: dxgkrnl: Manage device allocation properties
  drivers: hv: dxgkrnl: Flush heap transitions
  drivers: hv: dxgkrnl: Query video memory information
  drivers: hv: dxgkrnl: The escape ioctl
  drivers: hv: dxgkrnl: Ioctl to put device to error state
  drivers: hv: dxgkrnl: Ioctls to query statistics and clock calibration
  drivers: hv: dxgkrnl: Offer and reclaim allocations
  drivers: hv: dxgkrnl: Ioctls to manage scheduling priority
  drivers: hv: dxgkrnl: Manage residency of allocations
  drivers: hv: dxgkrnl: Manage compute device virtual addresses
  drivers: hv: dxgkrnl: Add support to map guest pages by host
  drivers: hv: dxgkrnl: Removed struct vmbus_gpadl, which was defined in
    the main linux branch
  drivers: hv: dxgkrnl: Remove dxgk_init_ioctls
  drivers: hv: dxgkrnl: Creation of dxgsyncfile objects
  drivers: hv: dxgkrnl: Use tracing instead of dev_dbg
  drivers: hv: dxgkrnl: Implement D3DKMTWaitSyncFile
  drivers: hv: dxgkrnl: Improve tracing and return values from copy from
    user
  drivers: hv: dxgkrnl: Fix synchronization locks
  drivers: hv: dxgkrnl: Close shared file objects in case of a failure
  drivers: hv: dxgkrnl: Added missed NULL check for resource object
  drivers: hv: dxgkrnl: Fixed dxgkrnl to build for the 6.1 kernel
  drivers: hv: dxgkrnl: Added support for compute only adapters
  drivers: hv: dxgkrnl: Added implementation for D3DKMTInvalidateCache
  drivers: hv: dxgkrnl: Handle process ID in D3DKMTQueryStatistics
  drivers: hv: dxgkrnl: Implement the D3DKMTEnumProcesses API
  drivers: hv: dxgkrnl: Implement D3DDKMTIsFeatureEnabled API
  drivers: hv: dxgkrnl: Implement known escapes
  drivers: hv: dxgkrnl: Fixed coding style issues
  drivers: hv: dxgkrnl: Fixed the implementation of
    D3DKMTQueryClockCalibration
  drivers: hv: dxgkrnl: Retry sending a VM bus packet when there is no
    place in the ring buffer
  drivers: hv: dxgkrnl: Add support for locking a shared allocation by
    not the owner
  drivers: hv: dxgkrnl: Fix build breaks when switching to 6.6 kernel
    due to hv_driver remove callback change.
  drivers: hv: dxgkrnl: Fix build breaks when switching to 6.6 kernel
    due to removed uuid_le_cmp
  drivers: hv: dxgkrnl: Implement D3DKMTEnumProcesses to match the
    Windows implementation
  drivers: hv: dxgkrnl: Use pin_user_pages instead of get_user_pages for
    DMA accessible memory
  drivers: hv: dxgkrnl: Do not print error messages when virtual GPU is
    not present

 MAINTAINERS                      |    7 +
 drivers/hv/Kconfig               |    2 +
 drivers/hv/Makefile              |    1 +
 drivers/hv/dxgkrnl/Kconfig       |   28 +
 drivers/hv/dxgkrnl/Makefile      |    5 +
 drivers/hv/dxgkrnl/dxgadapter.c  | 1367 ++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h     | 1042 ++++++
 drivers/hv/dxgkrnl/dxgmodule.c   |  971 +++++
 drivers/hv/dxgkrnl/dxgprocess.c  |  348 ++
 drivers/hv/dxgkrnl/dxgsyncfile.c |  481 +++
 drivers/hv/dxgkrnl/dxgsyncfile.h |   33 +
 drivers/hv/dxgkrnl/dxgvmbus.c    | 3992 +++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h    |  910 +++++
 drivers/hv/dxgkrnl/hmgr.c        |  567 +++
 drivers/hv/dxgkrnl/hmgr.h        |  112 +
 drivers/hv/dxgkrnl/ioctl.c       | 5648 ++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.c        |   38 +
 drivers/hv/dxgkrnl/misc.h        |   96 +
 include/uapi/misc/d3dkmthk.h     | 1794 ++++++++++
 19 files changed, 17442 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.c
 create mode 100644 drivers/hv/dxgkrnl/dxgsyncfile.h
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h
 create mode 100644 include/uapi/misc/d3dkmthk.h


