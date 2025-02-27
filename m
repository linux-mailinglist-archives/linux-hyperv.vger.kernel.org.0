Return-Path: <linux-hyperv+bounces-4144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2BEA48ACC
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C327A6CEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3467271834;
	Thu, 27 Feb 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lOuYeJA3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878831CEAA3;
	Thu, 27 Feb 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692852; cv=none; b=t6KRDreC/hNIiP86TRB93Ldhh+3SzOCX0m1vgb2oxs6hYd/hWKzxl5IN+2DUaN4jviGszk4GpFqCrEbiEutdjdhWONMYcCeFmX3meGln6A+VKcxPVcOvNBI+5GNhs3Xogjy1f+wwZEbUEIq2EMGmNJLFC1HOlsHdOIeyuTSBrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692852; c=relaxed/simple;
	bh=9FCDbYrZ+pmLez9tTc/X4RjK/3Ba6W2VlI1SDaCLe6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bj9KmvAbgJ237bjSdL5hO/QgAwb4S5JAceSX7gHl/5MB1DvGOdet61HMU6GPggbVX53XI5MPsQ/dfC2g4/fqtuiUxW3mhAwIL+HWGZ3lvMNTU7TVhj/p6qmUOJxHd6nxjsngo/aVGgMdYcne0oDws868U75cJbTqWNSTuGGbjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lOuYeJA3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEEFE210D0F6;
	Thu, 27 Feb 2025 13:47:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEEFE210D0F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740692849;
	bh=rcuQi3g5qOU/R6HpYnilX9s27PZ0U7+hs5GNfw7R11o=;
	h=From:To:Cc:Subject:Date:From;
	b=lOuYeJA3wBuNFJXaLyLBjKveedBeayr2PRDzbXq9jo3SkrrE4oGh927cZidbIRsq4
	 yJUDiXl3oIfnYBPrY3FrvY9rYEMSAbRWe+6gFPT0IdnYvW99sLfBzP1PrnjPcJOFFl
	 F9+/eL65hBUmr+rNlIvPdnZRFoh4iREb6n10tcDU=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 0/2] x86/hyperv: VTL mode reboot fixes
Date: Thu, 27 Feb 2025 13:47:26 -0800
Message-ID: <20250227214728.15672-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch defines a specialized machine emergency restart
callback not to write to the physical address of 0x472 which is
what the native_machine_emergency_restart() does unconditionally.

I first wanted to tweak that function[1], and in the course of
the discussion it looked as the risks of doing that would
outweigh the benefit: the bare-metal systems have likely adopted
that behavior as a standard although I could not find any mentions
of that magic address in the UEFI+ACPI specification.

The second patch removes the need to always supply "reboot=t"
to the kernel command line in the OpenHCL bootloader[2]. There is
no other option at the moment; when/if it appears the newly added
callback's code can be adjusted as required.

[1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
[2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139

[V3]:
    - Added verbs to the patch titles.
      ** Thank you, Ingo!**

[V2]: https://lore.kernel.org/linux-hyperv/97010881-4b5e-4fb7-b8b3-b6c9e440e692@linux.microsoft.com/
    - Fixed the warning from the kernel robot about using C23.
      ** Thank you, kernel robot!**

    - Tightened up wording in the comments and the commit
      descriptions.
      ** Thank you, Saurabh!**

    - Dropped the CC: stable tag as there is no specific commit
      this patch series fixes.
      ** Thank you, Saurabh!**

[V1]: https://lore.kernel.org/linux-hyperv/20250117210702.1529580-1-romank@linux.microsoft.com/

Roman Kisel (2):
  x86/hyperv: Add VTL mode emergency restart callback
  x86/hyperv: Add VTL mode callback for restarting the system

 arch/x86/hyperv/hv_vtl.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)


base-commit: 3a7f7785eae7cf012af128ca9e383c91e4955354
-- 
2.43.0


