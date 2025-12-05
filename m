Return-Path: <linux-hyperv+bounces-7975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA19CA93D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6F530A82C8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228626A1A4;
	Fri,  5 Dec 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X/r8qjhN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E534F2B9BA;
	Fri,  5 Dec 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965851; cv=none; b=sYFBkZXYL9uGDNN6ZAqrAQeG1bknjY8zStHQYrCE6JWyWXN6+b5ecLngk/9qcKzqUU+MP+zAq121kLbo/chwLbX4t+Fjxrtybg4uvr4I6MihS4p2RdDR9A8PkkXV78B5b8hCCjX1ZNCAs/s/MYj0+Dsfb3f3vRtKvvuIZiMAfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965851; c=relaxed/simple;
	bh=7gT4cZp46+eFvUhjUUYM90pX+P1tOrIijKEdBlZAHKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aROnLq7KhmgudnOdVSLtKHC+0EI1VuzozA3Erk9KhrOdYw3gUE5ISOEloHt9+GEb/5TT/N0a5eN9AqyW5sXLWrvIj9ZjXrOKRwJcu/GKLK3rodmsG2O0Tf9cTa6mGqd2pcXHquqRnIH/z90Ut4DI6r/pIgSUM1ehi7yQzJUWCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X/r8qjhN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18ADB200DFD0;
	Fri,  5 Dec 2025 12:17:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18ADB200DFD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764965849;
	bh=8a4ZAFjRMb+HnnqvWbeH9fEkrqyVwvU/z+guNCoveN8=;
	h=From:To:Cc:Subject:Date:From;
	b=X/r8qjhNdKDUMBvZL0SIUPb0aMLArAk5LfEPh3RuRmfUNHAgyHMGiNkG8EFTU5w9f
	 Vh/hEEDY2d5kk7OWk+oMFMNKCg6l2AOn8yXAaoZe25p0KqpCi3C4PyH0aSE+ZnrMre
	 SfBFHq09z2QYG6pvC4otj/b4/C6sAXtRUTorZkHg=
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
Subject: [PATCH v7 0/4] Add support for clean shutdown with MSHV
Date: Fri,  5 Dec 2025 14:17:04 -0600
Message-ID: <20251205201721.7253-1-prapal@linux.microsoft.com>
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

v7:
 - Fix Makefile condition for building mshv_common.c
 - Drop the now unnecessary CONFIG_X86_64 guards

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

Praveen K Paladugu (4):
  fixup! Drivers: hv: Introduce mshv_vtl driver
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Use reboot notifier to configure sleep state
  hyperv: Cleanly shutdown root partition with MSHV

 arch/x86/hyperv/hv_init.c       |  1 +
 arch/x86/include/asm/mshyperv.h |  2 +
 arch/x86/kernel/cpu/mshyperv.c  |  2 +
 drivers/hv/Makefile             |  2 +-
 drivers/hv/mshv_common.c        | 99 +++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |  4 +-
 include/hyperv/hvhdk_mini.h     | 40 +++++++++++++
 7 files changed, 148 insertions(+), 2 deletions(-)

-- 
2.51.0


