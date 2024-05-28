Return-Path: <linux-hyperv+bounces-2235-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000F8D17C5
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B961287A2A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95616D9D0;
	Tue, 28 May 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOWb9H92"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B616D9B3;
	Tue, 28 May 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890155; cv=none; b=BrRagzGb7CZZeRS/Nf4J6c29+McT81xYSzwmW7YGaZfmx1x/UvwY47iT3MhLI4kEInX0sii3j+RdGMMe3zemnk4xkahCgvSl5lnZA06q/Hu58Z9bgHmUxO3bOpVPlo85tMz9QzPp/gF8c5Pia5bKTgqiFwoCZeq8DRsmjKQh7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890155; c=relaxed/simple;
	bh=20gmqRJLZ1DrMXHP1I23O7bcTlns6n1UTqdinHS1U3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+hJ1JMt+WwuRyhGuJI3va5JnTgYVkiVNKtYPkUJESUQI3S+a9Eb8BM0UfT/0ssV8KHSYbKSeDfM7Xb7TkEnKl+GDYDFewqEUw1jStt93Wy72wvYyXjf3peyyJQ+wRD4C9R4bJo3TMg3UPPogpvdUVmIOOlYrS1OrZNzrLN72wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOWb9H92; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890154; x=1748426154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20gmqRJLZ1DrMXHP1I23O7bcTlns6n1UTqdinHS1U3c=;
  b=kOWb9H92jHYQBemG6pD2YIWZSIhcF59mtIfqgIu0cAiA57R6HqYoDN9q
   KpSzl6MfZGNV8qqCfqSAYC+tJ5NaqFfhuvAa7Ww4dHsp/0NjSc7KzNjGQ
   diMR/tvvLJ/taLAq3QM2qy4Km1C0mBs3NY7n6dxSsstgfejyiGRWB7MJs
   ZJn2CtaJXjOMS8uLtfZEpnv0dLKoOcBa8VlrH/IpOPDRDBfNIGijct2Cs
   SjEgsGNvkGERS3Ev4hLSOvyp8hMvUML47x9sJR5zbHvMD3Q2P20lwbndI
   e2iunDFvpOBJP945HI9N/X9j1ERxBWgyoBUR0Cun5pHcrEkpHV3z9pqYi
   g==;
X-CSE-ConnectionGUID: k3Iby6kFQVmV8EF0uJZODg==
X-CSE-MsgGUID: zfWQXM42TAuZGHwLhitIdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13097821"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13097821"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:47 -0700
X-CSE-ConnectionGUID: DN595e/5TnyhTE3kO5c0KA==
X-CSE-MsgGUID: nqm/7/BSQo2t1bnUcgj8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34951820"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 02:55:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 18C18A56; Tue, 28 May 2024 12:55:27 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv11 16/19] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Tue, 28 May 2024 12:55:19 +0300
Message-ID: <20240528095522.509667-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the helper is defined, it is called instead of halt() to stop the CPU
at the end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able
to wake it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/process.c  | 7 +++++++
 arch/x86/kernel/reboot.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a35936b512fe..ca073f40698f 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -35,6 +35,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..f63f8fd00a91 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+#ifdef CONFIG_SMP
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+#endif
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 097313147ad3..513809b5b27c 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -880,6 +880,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
+
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+
 	/* Assume hlt works */
 	halt();
 	for (;;)
-- 
2.43.0


