Return-Path: <linux-hyperv+bounces-5415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F4AAE8F9
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DF9C1B2D
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077328E57A;
	Wed,  7 May 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VsPazf3t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0C228E569;
	Wed,  7 May 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642150; cv=none; b=GGa+Z1aYmn6l9JMcsyn17TPDUEA+HdBEQnPcUZE7gYh+gJlDMp8lF0Vwm3wWdLevXdhCqOKu8G+aVK+q9e+DvTILAYpRfQF9LIp5tgoDRLviukXKjIQmwzGs5C5PSwreDxprj2edbYrm6K3LjbTq+DtKqB1h4xjjkMvXeUkc7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642150; c=relaxed/simple;
	bh=gE+2iwlrn4G3TGVcdq1jDCgq9NL358/DVWvM8vSkS2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6qyvrKAOrSV/KKtgvDKZcmOENpsHwhfvq2jciiT9d/zGzseIgiv91UzDgd7QN7+sPY5kGY//b38yXa/SYC9+k/pb7zTnR0hzm/RJl3XcAzt01NqgTqQ4AosHn2LSx/hwQ62UiCBJIIix9sdyt38SUAvQnU8h0GVzuAC5WIOGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VsPazf3t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8003E21199D0;
	Wed,  7 May 2025 11:22:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8003E21199D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746642148;
	bh=nYiOzUohqhqDsstG+D33ttx496sH8k1M2r27blTDVmU=;
	h=From:To:Cc:Subject:Date:From;
	b=VsPazf3tXyySc8ohvwfU/rzB7Oli4gRv6q6e0TUEcw1A/2DeijE+QuYOeW6UPlQ7Z
	 ZTAa5jxH1QwipnLQIyMuOHnvOhEluBkL8EZLomZTV4PQY0yMNntArS6NfT37y7JWWn
	 j9hPcXW1O1Ynk0ZAq92G1nFcmYgACDeEpue7UvwU=
From: Roman Kisel <romank@linux.microsoft.com>
To: ardb@kernel.org,
	bp@alien8.de,
	brgerst@gmail.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	dimitri.sivanich@hpe.com,
	gautham.shenoy@amd.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com,
	jpoimboe@kernel.org,
	justin.ernst@hpe.com,
	kprateek.nayak@amd.com,
	kyle.meyer@hpe.com,
	kys@microsoft.com,
	lenb@kernel.org,
	mhklinux@outlook.com,
	mingo@redhat.com,
	nikunj@amd.com,
	papaluri@amd.com,
	patryk.wlazlyn@linux.intel.com,
	peterz@infradead.org,
	rafael@kernel.org,
	romank@linux.microsoft.com,
	russ.anderson@hpe.com,
	sohil.mehta@intel.com,
	steve.wahl@hpe.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the AP startup
Date: Wed,  7 May 2025 11:22:24 -0700
Message-ID: <20250507182227.7421-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset combines two patches that depend on each other and were not applying
cleanly:
  1. Fix APIC ID and VP index confusion in hv_snp_boot_ap():
    https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/
  2. Provide the CPU number in the wakeup AP callback:
    https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/

I rebased the patches on top of the latest hyperv-next tree and updated the second patch
that broke the linux-next build. That fix that, I made one non-functional change:
updated the signature of numachip_wakeup_secondary() to match the parameter list of
wakeup_secondary_cpu().

Roman Kisel (2):
  x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
  arch/x86: Provide the CPU number in the wakeup AP callback

 arch/x86/coco/sev/core.c             | 13 ++-----
 arch/x86/hyperv/hv_init.c            | 33 +++++++++++++++++
 arch/x86/hyperv/hv_vtl.c             | 54 ++++------------------------
 arch/x86/hyperv/ivm.c                | 11 ++++--
 arch/x86/include/asm/apic.h          |  8 ++---
 arch/x86/include/asm/mshyperv.h      |  7 ++--
 arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
 arch/x86/kernel/apic/apic_noop.c     |  8 ++++-
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
 arch/x86/kernel/smpboot.c            | 10 +++---
 include/hyperv/hvgdk_mini.h          |  2 +-
 12 files changed, 76 insertions(+), 76 deletions(-)


base-commit: 9b0844d87b1407681b78130429f798beb366f43f
-- 
2.43.0


