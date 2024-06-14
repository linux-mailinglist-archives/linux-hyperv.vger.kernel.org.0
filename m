Return-Path: <linux-hyperv+bounces-2415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C19088E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA15F1C25633
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F222192B98;
	Fri, 14 Jun 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ9s11HB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8519149D;
	Fri, 14 Jun 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359158; cv=none; b=sXmwOG/O+0kaZqWtQK4l25/WyBfTSvA1toGFhaePosg+JLT0A+STG4azpJEbyf/ck35/cAz10i7j0Ad4NCSdibM6aDxspFqhCBNYZVZDC6tLCn/J7xy0oMWbniWE5RbkbsprDa0nBrro6gMyyo/ltMBQ9vAW6ZhMSXVi8jELbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359158; c=relaxed/simple;
	bh=MJUnStgs7sAhex0i0cDRuo1xCulV5yq1EpwC7e9PzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7mTVwCzcMVHnpyaokrLIp/smgjTcXIPE5GZQ0uwxC97tazseZJQU2TE3TYQJ9csztbslwxzFq4JHRvnVvXmkEa1eAiy72laEqmvnfda+HgCpHQ80qbnCl49wpg7HUUe1JHrH960z6be1xbV4ARC7U+InBSrf+XUG317r4o0+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ9s11HB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359156; x=1749895156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJUnStgs7sAhex0i0cDRuo1xCulV5yq1EpwC7e9PzHA=;
  b=IJ9s11HBRlWmGEkRtw6O9E/nsXMzE42fBSlHqM9cxJos5o1pIJjvKJbr
   Zt7taXucY8/o4ZlQaH4aIjzoHpR7vrY6Ghfzl4RttHUeSX44JRDxrfk6x
   vBRjC7JtjIYnwTo69DTKJqv8q1Rdjk86VNIJgoMrBeh3lruwxzz1ddfRi
   s6Lv5d7obuG8gLHDx13Ofx0pLXNc04GSGf7QLp9+HmbgwuV3YbIxqPajW
   /BeIbNk4rQN1qaJmeQC6r3Zi0K4CPTojstNC+mC20plTd7I2zzE/EDuuM
   RaX6voC87RctDvB6cQdpx9kUZJTvR689oEwSWhlbyiDXUifZjhuMLvgcS
   g==;
X-CSE-ConnectionGUID: NEEE5PPqRwm6gi04ZGgHSQ==
X-CSE-MsgGUID: v5fxDrNNSR+x3YS1crYyzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072317"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072317"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:15 -0700
X-CSE-ConnectionGUID: A3N93szQQk2jx95DeddBWw==
X-CSE-MsgGUID: MwpewbGNQ52+ME65r03WiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995802"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9B024277B; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
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
Subject: [PATCHv12 03/19] cpu/hotplug: Add support for declaring CPU offlining not supported
Date: Fri, 14 Jun 2024 12:58:48 +0300
Message-ID: <20240614095904.1345461-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
it got woke up.

Currently offlining hotplug is prevented based on the confidential
computing attribute which is set for Intel TDX. But TDX is not
the only possible user of the wake up method. The MADT wakeup can be
implemented outside of a confidential computing environment. Offline
support is a property of the wakeup method, not the CoCo implementation.

Introduce cpu_hotplug_disable_offlining() that can be called to indicate
that CPU offlining should be disabled.

This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
MADT wakeup method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 include/linux/cpuhplock.h |  2 ++
 kernel/cpu.c              | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index 431560bbd045..f7aa20f62b87 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -21,6 +21,7 @@ void cpus_read_lock(void);
 void cpus_read_unlock(void);
 int  cpus_read_trylock(void);
 void lockdep_assert_cpus_held(void);
+void cpu_hotplug_disable_offlining(void);
 void cpu_hotplug_disable(void);
 void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
@@ -36,6 +37,7 @@ static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
 static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable_offlining(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d6c28b..4c15b478e2bc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -483,6 +483,8 @@ static int cpu_hotplug_disabled;
 
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
+static bool cpu_hotplug_offline_disabled __ro_after_init;
+
 void cpus_read_lock(void)
 {
 	percpu_down_read(&cpu_hotplug_lock);
@@ -542,6 +544,14 @@ static void lockdep_release_cpus_lock(void)
 	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
+/* Declare CPU offlining not supported */
+void cpu_hotplug_disable_offlining(void)
+{
+	cpu_maps_update_begin();
+	cpu_hotplug_offline_disabled = true;
+	cpu_maps_update_done();
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -1471,7 +1481,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
+	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
+	    cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-- 
2.43.0


