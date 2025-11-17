Return-Path: <linux-hyperv+bounces-7648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A49C6636E
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 376ED4ED33A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5D32E6AE;
	Mon, 17 Nov 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bzSY11Kn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A62882A9;
	Mon, 17 Nov 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413751; cv=none; b=keLGIC2mi3j3+S90lXtKq0BOxOuE6FX3ggsngTHGg6Hq7JGa6/8wfw3vBftHSWKTMfNCPv3ZYvrrRLm4lhvB3YhKscFYLOuAacF2xg215e7d2NjXUII8QLpku+i4KuHlNCTfEuB+zN/dI0jaF9CeKnG23XfylQh2YxuN6s7yoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413751; c=relaxed/simple;
	bh=c3GVlGNnlheONERKovWJ5AXzH2eveCzzSLxPWvREf8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/U6/p6+/53rTzLcEYJezw95odN0vuMHInfWID2yI3MuJJVzBiZWO6YhxL43ezpE7MmXFYC9B+P0mNG7Q1Z59ak2ecV9oiBYRaMBuzdihzbMWQ/bFOuLQgfDC197xBOx0KJFaVpyeb/4P8lCDEErNLm4W8q1SZdIWeoePdwA6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bzSY11Kn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E89D211083D;
	Mon, 17 Nov 2025 13:09:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E89D211083D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763413742;
	bh=9eUUUcKqV8mO3PFuz1DSaE6MrxQNHp+xF0fphdOnInE=;
	h=From:To:Cc:Subject:Date:From;
	b=bzSY11Kn8aTK/5+wBd5xQeZuHicvTKQ+Ff9KjUazPlerU/nwpA6dZeTMMvtMgYL0v
	 UybGlTUx/YB35RAwKtuvoG5mOPMuoU2zceNM8cgcIx0g7mpCqkc0M3Rfshx9thbsv2
	 CDNs3Pi0endoSjG4N/zMSlaTFs221mMjdhzZ7eZI=
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
Subject: [PATCH v5 0/3] Add support for clean shutdown with MSHV
Date: Mon, 17 Nov 2025 15:08:15 -0600
Message-ID: <20251117210855.108126-1-prapal@linux.microsoft.com>
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

 arch/x86/hyperv/hv_init.c       |  9 ++++
 arch/x86/include/asm/mshyperv.h |  4 ++
 drivers/hv/mshv_common.c        | 96 +++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |  4 +-
 include/hyperv/hvhdk_mini.h     | 40 ++++++++++++++
 5 files changed, 152 insertions(+), 1 deletion(-)

-- 
2.51.0


