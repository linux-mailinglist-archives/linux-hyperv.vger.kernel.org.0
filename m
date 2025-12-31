Return-Path: <linux-hyperv+bounces-8107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BCCEAFD5
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 02:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04E2830087BB
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Dec 2025 01:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DD1624D5;
	Wed, 31 Dec 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="phzCLllP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B7A930;
	Wed, 31 Dec 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144067; cv=none; b=NxemucPeUQv7hMbELI95PUfnQJj2fjr5oRZTpkKydU6yz9BmmGq8iq7pK1fyhwVDXO3Uc94lSy0wSBpj4dxMEDt53rcULNex4rFBkxZHUkPrMvI099+GUMhmQovipZFhC+q4nNEr1T9uoby1FMx3do17nNqTkG94cnTPdBJr90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144067; c=relaxed/simple;
	bh=23d+vFMWoKM6S3+vXI9XPP1u2lqcnAjMI7mebru09pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwQQQ9cNLQREclCaFPmcKPcqEHzvK58aIJWEqmJxPBmMLB9GtBnvw0ckTpY7CMz/0FNSSUL0+agp+LH3yNt8Sfw3xfrIzlz1uVTaAAPSxzev81ZosrGyW1hi5cjUvBTb3T0wCbki5fw64ZnVZvqYYoxrLsbb0+R97QJ6DAYKrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=phzCLllP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C91A2124E06;
	Tue, 30 Dec 2025 17:21:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C91A2124E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767144061;
	bh=Ky4TEsuttm4i2cXWpG76OQ/ZV9DxGb8VOcaWc1KOG/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=phzCLllP7MLGwP47dfCbZsonG52pj+qbDMZgriCBIIzQiqHsTvbB9U/LeYhfzg+tG
	 m/AGKN+R7mHa6Tte5JVcgRvZwfEZ1iQ1YBSlwjqTp76SaiHZv8wUxRx5FgLpJqUEgv
	 rjOySEUUPBlue8+UdknXm7xaHxJiXCnyG0/ImDEQ=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Subject: [RFC][PATCH v0] x86/hyperv: Reserve 3 interrupt vectors used exclusively by mshv
Date: Tue, 30 Dec 2025 17:21:00 -0800
Message-ID: <20251231012100.681060-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSVC compiler used to compile the Microsoft Hyper-V hypervisor currently,
has an assert intrinsic that uses interrupt vector 0x29 to create an
exception. This will cause hypervisor to then crash and collect core. As
such, if this interrupt number is assigned to a device by linux and the
device generates it, hypervisor will crash. There are two other such
vectors hard coded in the hypervisor, 0x2C and 0x2D. 

Fortunately, the three vectors are part of the kernel driver space, and
that makes it feasible to reserve them early so they are not assigned
later.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 579fb2c64cfd..19d41f7434df 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -478,6 +478,25 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 }
 EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
+/*
+ * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
+ * will crash or hang or break into debugger.
+ */
+static void hv_reserve_irq_vectors(void)
+{
+	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
+	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
+	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
+
+	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
+	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
+	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
+		BUG();
+
+	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
+		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
+}
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax, eax;
@@ -510,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+	if (hv_root_partition())
+		hv_reserve_irq_vectors();
+
 	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
 		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
-- 
2.51.2.vfs.0.1


