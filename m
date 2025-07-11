Return-Path: <linux-hyperv+bounces-6192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C9B02466
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EE93BFD41
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4171E04BD;
	Fri, 11 Jul 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tLAD1uEP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D111917ED;
	Fri, 11 Jul 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261542; cv=none; b=m/MK40ycleYLtKJWs67e2lsh1ssv+mfvuiY96abHDOgYxZUamDYwdYjOO547iOLaeQ+BtX+vt10sMfo6uYAK4kdZFaJJecSbQ9e/isU5ozfCHQ1DzfB+UiTi0bzY6eGFwRvKRBwLY9qnSLWZbDVXT2gduzinifhmJDNbBTAymlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261542; c=relaxed/simple;
	bh=tDx8/omPQu8w7hsv60PF6Yj0dR3kGBL8t6YQhWyVx1o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cmqaJRhtGeNlyiofVJs8amrMyntFP4Cd6XQ9teCO6YfkBPrjx7ilUTM5lK3lppBFHzfOO3X7WXxkVU2IB7GcHWqSxhQtEtaAwTHn56CkY/tTE9Tq+3N/61xGZkVuFF6r33L/AUxjUHk8uobTfA/HGkPtxH6d8SjgEAEari9Avho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tLAD1uEP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 8495121151BB; Fri, 11 Jul 2025 12:18:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8495121151BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752261535;
	bh=aAe39mLA5/fPJxqo8iO/ISlY7rAtO3PyDDUS3k0p3cI=;
	h=From:To:Cc:Subject:Date:From;
	b=tLAD1uEPz9Axn6TCbuWFL94QgYLEMSZssf7UtNswEAI7frs1J2XLdUbMyIL5WnsUD
	 jm94PAdBbd9Cw78unAxNu5fqd0P9b4uaQkxd1cUXRMTXZdK62neOtURdi61158EYz5
	 yqtNTTHR3FZ/Gs7IzXPy1sboX+jw6Y7m/jwcajEE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
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
Subject: [PATCH v3 0/3] Nested virtualization fixes for root partition
Date: Fri, 11 Jul 2025 12:18:49 -0700
Message-Id: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fixes for running as nested root partition on the Microsoft Hypervisor.

The first patch changes vmbus to make hypercalls to the L0 hypervisor
instead of the L1. This is needed because L0 hypervisor, not the L1, is
the one hosting the Windows root partition with the VMM that provides
vmbus.

The 2nd and 3rd patches fix interrupt unmasking on nested. In this
scenario, the L1 (nested) hypervisor does the interrupt mapping to root
partition cores. The vectors just need to be mapped with
MAP_DEVICE_INTERRUPT instead of affinitized with RETARGET_INTERRUPT.

Changes in v3:
- Remove 3 patches (#1,#3,#4 from v2) which were merged already (Wei Liu)
- Fix bug in #1 introduced in v2 (Michael Kelley)
- Improve commit message in #2 (Michael Kelley)
- Document return value of hv_map_msi_interrupt() in #2 (Michael Kelley)

Changes in v2:
- Reword commit messages for clarity (Michael Kelley, Bjorn Helgaas)
- Open-code nested hypercalls to reduce unnecessary code (Michael Kelley)
- Add patch (#3) to fix cpu_online_mask issue (Thomas Gleixner)
- Add patch (#4) to fix error return values (Michael Kelley)
- Remove several redundant error messages and checks (Michael Kelley)

Nuno Das Neves (1):
  Drivers: hv: Use nested hypercall for post message and signal event

Stanislav Kinsburskii (2):
  x86/hyperv: Expose hv_map_msi_interrupt()
  PCI: hv: Use the correct hypercall for unmasking interrupts on nested

 arch/x86/hyperv/irqdomain.c         | 40 +++++++++++++++++++++--------
 arch/x86/include/asm/mshyperv.h     | 22 ++--------------
 drivers/hv/connection.c             |  5 +++-
 drivers/hv/hv.c                     |  6 +++--
 drivers/pci/controller/pci-hyperv.c | 18 +++++++++++--
 5 files changed, 55 insertions(+), 36 deletions(-)

-- 
2.34.1


