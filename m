Return-Path: <linux-hyperv+bounces-7212-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75306BDAA98
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA1E54E7AEF
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0183002D5;
	Tue, 14 Oct 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VMy7oeX9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE06288C2C;
	Tue, 14 Oct 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460121; cv=none; b=LT/G6ljoNEWWzfEbgaLEwBNYuJnfhk7o40IVrfY+7tRx9e+KTE6EAUcc+GODs3Z1NVTljh2p6cOe3MMhRZoPM7jXNZnFFP6dWKKaMHkrMszz8UnNB9wWEaTDnp27DvufeORGom64qfHVZs+uhKfnr61PxxT5io5AUPpj11LhJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460121; c=relaxed/simple;
	bh=dX+NdGds4pEOkv5gqv7at8Te5J3Eqk+otWSM/g55zEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmqYPwjnMoha8JwDKs03J9rUFQWybK9OWo4bbZ40R/CXNSXyNfZEPcKqchrpMXTDY5p/PJ5Z9BLYL916KBBdBlxFoD/vLZJ1Y3RCZBm/5JixgJHVJuJnXsXNN7eUwjha8aYbY7SvJ7mJ/kKnzvecqE2IU/aKKsy8spVNW5DLiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VMy7oeX9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (syn-072-191-074-189.res.spectrum.com [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFCEA2065969;
	Tue, 14 Oct 2025 09:41:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFCEA2065969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760460119;
	bh=WgFncpfCyGYrmqcRcpxtUeub4K8uCX4qpGAD1kKuOlw=;
	h=From:To:Cc:Subject:Date:From;
	b=VMy7oeX93iOhDsxKPHu0Zd5rSUf+xz6D817tBDb7BQC+jF1WXLXRKh8/RI5OCYj5P
	 bLpcpxdQj1cZTjTRFgWT1qtudbHKdBBJE8h2i4HIIauSszUvQAldNcSiXnatfLmYUz
	 84I16WXNHAX932x55mF5GpSFvtq4llmtUsMwZCDo=
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
Subject: [PATCH v2 0/2] Add support for clean shutdown with MSHV
Date: Tue, 14 Oct 2025 11:41:19 -0500
Message-ID: <20251014164150.6935-1-prapal@linux.microsoft.com>
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

v2:
  - Addressed review comments from v1.
  - Moved all sleep state handling methods under CONFIG_ACPI stub
  - - This fixes build issues on non-x86 architectures.

Moving the declartion of `hv_sleep_notifiers_register` to
arch/x86/include/asm/mshyperv.h, required the use of CONFIG_X86 stub
within hv_common.c. As this sleep configuration is dependent on ACPI,
I moved all the methods under CONFIG_ACPI to keep the code cleaner,
without introducing CONFIG_X86 stub.


Praveen K Paladugu (2):
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Enable clean shutdown for root partition with MSHV

 arch/x86/hyperv/hv_init.c       |   7 ++
 arch/x86/include/asm/mshyperv.h |   1 +
 drivers/hv/hv_common.c          | 119 ++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |   4 +-
 include/hyperv/hvhdk_mini.h     |  33 +++++++++
 5 files changed, 163 insertions(+), 1 deletion(-)

-- 
2.51.0


