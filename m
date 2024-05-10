Return-Path: <linux-hyperv+bounces-2087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00E8C286F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BC9287D89
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024A17277F;
	Fri, 10 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qIdV2IFH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13EB171E75;
	Fri, 10 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357188; cv=none; b=FUCDFVP8Avbz2MntZNaKvCl3fzl05V4brI7Ah4OEBbrDVjKGsKP4Q90vWw1+VtrCWvVZnzFRAZ3rCIfj5BpozpvcsP5tdf08wJJ7laEvJC184J1iDJU1fw6vbZ8L2ZpvjgpB/IXP3k0Py4zRY4eqxzJSdo+/MP/bpGUWCsYPx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357188; c=relaxed/simple;
	bh=FXGGBoauO3Lk4ufLOviTlK6WDWGfFKBDtnbfm10kDDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2q9G34Qmg4glmWND/OP9/hoZQt82SYpuDjA7PS6Mom6BM9cT7bGse61X/jH2aZUMhNDQ289BcnLIolzEmC03eQvg9r847sqt5vMCk2bnR28r71fPDw5MCLseJEgPPZxr6/3eJQFrk6emhP51i0t6bUAbt40NH7eIbJTtTRVfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qIdV2IFH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF6962091227;
	Fri, 10 May 2024 09:06:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF6962091227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357180;
	bh=YF/ExHwEfWhH0oIXFBERupTGNjq2Xrh4WeGO6DEyevg=;
	h=From:To:Cc:Subject:Date:From;
	b=qIdV2IFHQeJyChLMJhRB3Urc5XmzRcEhSbDyVnz0jSD7s2ox3bz38KmV7CLipVCNg
	 XjpGjpzKGjfm+SKFUn/o6uTdAdU+jugkBZYZgdUq9sE2V/jrAh4vsBQVUq6BvjS7Ae
	 uxU90INzrBznIaoRtSlf/v1n8jTcfdATh+fwzL2w=
From: romank@linux.microsoft.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH 0/6] arm64/hyperv: Support Virtual Trust Level boot
Date: Fri, 10 May 2024 09:04:59 -0700
Message-ID: <20240510160602.1311352-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

This set of patches enables the Hyper-V code to boot on ARM64
inside a Virtual Trust Level. These levels are a part of the
Virtual Secure Mode documented in the Top-Level Functional
Specification available at
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

Roman Kisel (6):
  arm64/hyperv: Support DeviceTree
  drivers/hv: Enable VTL mode for arm64
  arm64/hyperv: Boot in a Virtual Trust Level
  drivers/hv: arch-neutral implementation of get_vtl()
  drivers/hv/vmbus: Get the irq number from DeviceTree
  drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from DT

 arch/arm64/hyperv/Makefile          |  1 +
 arch/arm64/hyperv/hv_vtl.c          | 19 +++++++++++++
 arch/arm64/hyperv/mshyperv.c        | 40 +++++++++++++++++++++++----
 arch/arm64/include/asm/mshyperv.h   |  8 ++++++
 arch/x86/hyperv/hv_init.c           | 34 -----------------------
 arch/x86/hyperv/hv_vtl.c            |  2 +-
 arch/x86/include/asm/hyperv-tlfs.h  |  7 -----
 drivers/hv/Kconfig                  |  6 ++--
 drivers/hv/hv_common.c              | 43 +++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c              | 37 +++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 13 +++++++--
 include/asm-generic/hyperv-tlfs.h   |  7 +++++
 include/asm-generic/mshyperv.h      |  6 ++++
 include/linux/acpi.h                | 10 +++++++
 14 files changed, 180 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c

-- 
2.45.0


