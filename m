Return-Path: <linux-hyperv+bounces-7853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD9C8C1B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F9F3A1CC9
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 21:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E63191D8;
	Wed, 26 Nov 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hWqcMW5d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10623ABA9;
	Wed, 26 Nov 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193823; cv=none; b=IYzFlCi7N5zoE0jiYpZ48mYgZI2bjBJAkkY/pJJ6E03GCwFarml2To5+Z6pwvnYyQ0GOFmQV6Np2q4ixjpsv6mkXSH+V3YBhJvGSvKE21Hc4Xjwi+paO3qpyZhMC/Gqi60OB1VjZ65LxCtsPcYmFCcbLOZHWYHC4tNvqCm/iXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193823; c=relaxed/simple;
	bh=LkwXJIpVlGZi/5+F7EE1Nw6CKREkxju+KsxE7t1M90s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxXq/iaig4chzt0sSd7yOUx8rfiXVkhZLMoz6u6ga3w9ozmLaSN4DlOJWqmJ5/5IVccNcKuCHyU6LO0MY2HwG5llVTREDnWlaDYk5KJrJO1TWuhJTf3WCybST3ozYeb/vLOxy4KmJxIrzxvBichs3hK2z22QvQIIpEPnkt+zEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hWqcMW5d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC892200E9E1;
	Wed, 26 Nov 2025 13:50:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC892200E9E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764193821;
	bh=/eNPsQWuHdybpWfX5FvULrTmySUbAgLASK/1g1PMRVA=;
	h=From:To:Cc:Subject:Date:From;
	b=hWqcMW5diCeLdl2Qxozgz5qZia99taoXsf/Wh9Cr5p4M9cqXr+cLtlVnDoVOR9l1B
	 fkXgLMcTDnwBFcjYfPm71Xlz/DqflO9tsbCWAuPy3ImEGkbebqYt99GM0Ht7Su+ToM
	 zJYjXT8NizfI9L/zkWZDEsWyTL3mtLCzHlnezEuM=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Subject: [PATCH v6 0/3] Add support for clean shutdown with MSHV
Date: Wed, 26 Nov 2025 15:49:50 -0600
Message-ID: <20251126215013.11549-1-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clean shutdown of the root partition when running on
MSHV Hypervisor.

v6:
 - Fixed build errors, by adding CONFIG_X86_64 guard
 - Moved machine_ops hook definition to ms_hyperv_init_platform
 - Addressed review comments in v5

v5:
 - Fixed build errors
 - Padded struct hv_input_set_system_property for alignment
 - Dropped CONFIG_ACPI stub

v4:
 - Adopted machine_ops to order invoking HV_ENTER_SLEEP_STATE as the
   last step in shutdown sequence.
 - This ensures rest of the cleanups are done before powering off

v3:
 - Dropped acpi_sleep handlers as they are not used on mshv
 - Applied ordering for hv_reboot_notifier
 - Fixed build issues on i386, arm64 architectures

v2:
  - Addressed review comments from v1.
  - Moved all sleep state handling methods under CONFIG_ACPI stub
  - - This fixes build issues on non-x86 architectures.


Praveen K Paladugu (3):
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Use reboot notifier to configure sleep state
  hyperv: Cleanly shutdown root partition with MSHV

 arch/x86/hyperv/hv_init.c       |  1 +
 arch/x86/include/asm/mshyperv.h |  4 ++
 arch/x86/kernel/cpu/mshyperv.c  |  2 +
 drivers/hv/mshv_common.c        | 98 +++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |  4 +-
 include/hyperv/hvhdk_mini.h     | 40 ++++++++++++++
 6 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.51.0


