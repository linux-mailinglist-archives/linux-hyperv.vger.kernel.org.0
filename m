Return-Path: <linux-hyperv+bounces-7344-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B68C1165E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 302874E7C9B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1A2E6CB8;
	Mon, 27 Oct 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ejpeYjb+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25A2E62B4;
	Mon, 27 Oct 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596949; cv=none; b=HUwKozXyUladJHRwmuX9QIym5rdfHmpFxnlK1E22J4yM6PPznJOr4hzFnyxr+gldJoeng42wkaWfiMuYahxS3ZTUiozum2X+wfQGV35xmsz5Ko0I2PFb6tKpQCoSwhW8/oj/J9JdURtxv9BZGF5hRTDW2X8YhsGzO1gosZkpxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596949; c=relaxed/simple;
	bh=ziFj9J9tNMng2byA7uXG82MwzNhGkIoFlNkm3Ap108w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3no5dtZj+bb/DIoHTO8e0yoVGgT1r6874lPxWUEZE1Ts7DihpHCL0lF8XVxmPwvIlDn0EQjz1zX0w/p695HTxyAL3OkCtA1dtL5x+NK+eRSxl0Rbieg5tTRCwM0cgPilCD4IS+puuE0FVvWKm8m/9oeAvr/6+MpzUP3ww03V3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ejpeYjb+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2E472120E99;
	Mon, 27 Oct 2025 13:29:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2E472120E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761596946;
	bh=fLXJutjmFtKOwP0g7CmdM/+e45s4dqqWhJjqqMpu7f4=;
	h=From:To:Cc:Subject:Date:From;
	b=ejpeYjb+jhBBfBVtv87FaX+CjHeEKb/35EJQTU22ZDTwieXmXfoC1YdyFvIHYPebg
	 Gnjr+6q5QT/iVAjZroE0V/X/gnZ1LpIaav61Jbfrzyn1dgiydYxGnZYxTY8ReiB/Mp
	 Zp9Ijj18Lvh+m3LdsgHNEuhPNEsq+NpJe4zzyDbI=
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
Subject: [PATCH v3 0/2] Add support for clean shutdown with MSHV
Date: Mon, 27 Oct 2025 15:28:41 -0500
Message-ID: <20251027202859.72006-1-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clean shutdown of the root partition when running on MSHV
hypervisor.

v3:
 - Dropped acpi_sleep handlers as they are not used on mshv
 - Applied ordering for hv_reboot_notifier
 - Fixed build issues on i386, arm64 architectures

v2:
  - Addressed review comments from v1.
  - Moved all sleep state handling methods under CONFIG_ACPI stub
  - - This fixes build issues on non-x86 architectures.

Praveen K Paladugu (2):
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Enable clean shutdown for root partition with MSHV

 arch/x86/hyperv/hv_init.c       |   8 +++
 arch/x86/include/asm/mshyperv.h |   2 +
 drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |   4 +-
 include/hyperv/hvhdk_mini.h     |  33 ++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)

-- 
2.51.0


