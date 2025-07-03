Return-Path: <linux-hyperv+bounces-6095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90830AF83B7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5110C7A6363
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E77F2BF3D7;
	Thu,  3 Jul 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OZ2KEzIw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AE7263F;
	Thu,  3 Jul 2025 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582687; cv=none; b=a5mCusqiGdqCgyr/kk6hx7XLv7otjzQm6ThLJPKTGYfG4+9a93kQ1o8I608vROh9Hv/sYGmSD+HZZUKhYCRcxvCj6o+8nGICx0p/evo52kJqmw709sXKncqWYfxTw15awo1X3BwEdWS8+SpPnNcmRfAjvw2jfiztvqDtFG1PYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582687; c=relaxed/simple;
	bh=YacSKt/1SlHP9Qmsgsh0NWz9Ib5ImhEU1/rIlRZCjB0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bnLq5kC3RO/4SVzKa0XeH9gWDfnnEiPMJQGoybQgnlYf8cL1YZBUJpmIgbonFWpyBFzRrZIeSzexRjaPct0OhGdZXgdQ2VGf8gRgXyqyhzLE6/cOt/gtG8cWR2Ans5Cj6W6Qu/PPhRrZnSmqxJjS4aNOVUWqkR4whOxS+Y+GopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OZ2KEzIw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 2605421130BA; Thu,  3 Jul 2025 15:44:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2605421130BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582685;
	bh=DzpE8JONufIJxMYXOPlFuCadyw8GU1Ze2+OKvDY2+Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=OZ2KEzIwiPXPth+ZilGaG7YjgUWFVDS7JR/mbgNQvzF1eTw9fvdr2fZS9nMytKAEP
	 mnC8YBp15QaTnasgmSxyOOtQhfIlC8H8Tg93gaxCCiziujKSkIn/JDVBrFNC3Rh4na
	 AfGsYvPBevrGOE7H5a0sJ809zlFkU3V2jgRwwUr8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 0/6] Nested virtualization fixes for root partition
Date: Thu,  3 Jul 2025 15:44:31 -0700
Message-Id: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fixes for running as nested root partition on the Microsoft Hypervisor.

Address issues with vmbus. The first patch prevents the Hyper-V PCI driver
being registered on baremetal, since there's no vmbus.

The second patch changes vmbus to make hypercalls to the L0 hypervisor
instead of the L1. This is needed because L0 hypervisor, not the L1, is
the one hosting the Windows root partition with the VMM that provides
vmbus.

The 3rd patch fixes a bug where cpu_online_mask is used unnecessarily
in an interrupt chip callback.

The 4th patch fixes up error return values in hv_map/unmap_interrupt() and
their callers, and cleans up style issues.

The 5th and 6th patches fix interrupt unmasking on nested. In this
scenario, the L1 (nested) hypervisor does the interrupt mapping to root
partition cores. The vectors just need to be mapped with
MAP_DEVICE_INTERRUPT instead of affinitized with RETARGET_INTERRUPT.

Changes in v2:
- Reword commit messages for clarity (Michael Kelley, Bjorn Helgaas)
- Open-code nested hypercalls to reduce unnecessary code (Michael Kelley)
- Add patch (#3) to fix cpu_online_mask issue (Thomas Gleixner)
- Add patch (#4) to fix error return values (Michael Kelley)
- Remove several redundant error messages and checks (Michael Kelley)

Mukesh Rathor (1):
  PCI: hv: Don't load the driver for baremetal root partition

Nuno Das Neves (3):
  Drivers: hv: Use nested hypercall for post message and signal event
  x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
  x86/hyperv: Clean up hv_map/unmap_interrupt() return values

Stanislav Kinsburskii (2):
  x86: hyperv: Expose hv_map_msi_interrupt function
  PCI: hv: Use the correct hypercall for unmasking interrupts on nested

 arch/x86/hyperv/irqdomain.c         | 66 +++++++++++++++++------------
 arch/x86/include/asm/mshyperv.h     | 22 +---------
 drivers/hv/connection.c             |  7 ++-
 drivers/hv/hv.c                     |  6 ++-
 drivers/iommu/hyperv-iommu.c        | 33 ++++++---------
 drivers/pci/controller/pci-hyperv.c | 21 ++++++++-
 6 files changed, 80 insertions(+), 75 deletions(-)

-- 
2.34.1


