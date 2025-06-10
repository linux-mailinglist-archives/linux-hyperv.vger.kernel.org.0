Return-Path: <linux-hyperv+bounces-5837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41511AD470D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D583A63A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D828C01A;
	Tue, 10 Jun 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KzWyrNuu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98EB286D62;
	Tue, 10 Jun 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599531; cv=none; b=GpM625+Pg0N/FgZXT1YhC0h5vK0BVUlQBB1kRXEyQ5xexk9HewkjyZ7vSFxGTUsw63G0LRnY9BfQxI30NVhSreBbycoTt/tlZAVp/Jpw1thY3CLQi0nUblVuruHynU2rCG7cFph/enLjXY5CY326eWGsoepy3Rypw9aSzshuCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599531; c=relaxed/simple;
	bh=VSAoBkrfh7e7VdGQnVWBbdS5pUsP4tk/wK6xLVyS/s4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=W0DOlvlK8+roYYv5Mq/6R7b7eidpQjmpcO1LE6BMH03D5FRvq6yi/bjV4mZx0vTTn8Ihzf5sVaAj4HEZN5H3AE8a0X2GnGhWlZmuIjuqugN1lbt+7mWwpfSDyUQ/uVmY4bQ3jLDk5yp1Hf67kIfFqNMOyVWX3PYPFEF9VpAFYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KzWyrNuu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 44FA32115183; Tue, 10 Jun 2025 16:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44FA32115183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749599529;
	bh=VK/ALiX0Q/HSDJU7bgnAP14qLnrVV2Yfc9+uMRERrAA=;
	h=From:To:Cc:Subject:Date:From;
	b=KzWyrNuuZHz8lCacQh64UQN+lnwou7QcYZQkjZkH1iCRFUY5F7vkGg46xrdAoilR3
	 wcF4LMmNt48BUSxcEGuCB92Fz9r/0hjLdaCcV8Gd+bv5g7+tzRV0IpNceeYqF+vZkx
	 ve/QsVCo4K0k6ni69gNM4LMc1MGY3PVCfQjeH6I8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 0/4] Nested virtualization fixes for root partition
Date: Tue, 10 Jun 2025 16:52:02 -0700
Message-Id: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fixes for running as nested root partition on the Microsoft Hypervisor.

The first patch prevents the vmbus driver being registered on baremetal, since
there's no vmbus in this scenario.

The second patch changes vmbus to make hypercalls to the L0 hypervisor instead
of the L1. This is needed because L0 hypervisor, not the L1, is the one hosting
the Windows root partition with the VMM that provides vmbus.

The 3rd and 4th patches fix interrupt unmasking on nested. In this scenario,
the L1 (nested) hypervisor does the interrupt mapping to root partition cores.
The vectors just need to be mapped with MAP_DEVICE_INTERRUPT instead of
affinitized with RETARGET_INTERRUPT.

Mukesh Rathor (1):
  PCI: hv: Do not do vmbus initialization on baremetal

Nuno Das Neves (1):
  Drivers: hv: Use nested hypercall for post message and signal event

Stanislav Kinsburskii (2):
  x86: hyperv: Expose hv_map_msi_interrupt function
  PCI: hv: Use the correct hypercall for unmasking interrupts on nested

 arch/arm64/include/asm/mshyperv.h   | 10 ++++++
 arch/x86/hyperv/irqdomain.c         | 47 +++++++++++++++++++++--------
 arch/x86/include/asm/mshyperv.h     |  2 ++
 drivers/hv/connection.c             |  3 ++
 drivers/hv/hv.c                     |  3 ++
 drivers/pci/controller/pci-hyperv.c | 21 +++++++++++--
 6 files changed, 71 insertions(+), 15 deletions(-)

-- 
2.34.1


