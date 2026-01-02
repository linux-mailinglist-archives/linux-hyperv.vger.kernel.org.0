Return-Path: <linux-hyperv+bounces-8132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1596CEF648
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 23:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 619813001BF9
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 22:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594B1547EE;
	Fri,  2 Jan 2026 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dyOui6Aw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1593A1E6C;
	Fri,  2 Jan 2026 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767391342; cv=none; b=QzIhWCydpZ3jHduK0hosmxLIiR/0POcC8XoP/KBsEKlVOiWtIdKCO8QhGxkPRVPp+BH6D5+XE4pELoeRr9kRWScYR2NqxhVPyKhZ1J3b3TToBBPVnMFgLy7Ns7oKrE576FLPnh+MYI0K8DAo+prC7BDeFKnK7Eg1n0SrdVRg1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767391342; c=relaxed/simple;
	bh=QXy6VLkNrDMaowsb6/hSzPc7LiC1wOc9VpQYPD4mQvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJVNGlxsZN6zUQc7feUjKoBce6p1Jt8L0zGVvHsaVRlVaqeMqKMxgfCGeB5tAmp1XxHQa2MkzB+i2eZNmbPGmjBX3RiyEJ+sQ/iXSHFN9SxhNbFdBO52+X7iC08mwsifr20+PQV5MxxTg2J/5e9KWecQJoj01VBx5oxeP/Yv+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dyOui6Aw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70B9C2125367;
	Fri,  2 Jan 2026 14:02:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70B9C2125367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767391340;
	bh=8Dg+F4TP5nB1N2fxDG4A+LwdJkRlm4eZGCPBvvIHdJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dyOui6Aw7U89LE/WDMCvct8LOUjS3O6nK9m9VKg96EEdrzOTY/4WRCmI5hpE84XCI
	 cvYHbzBg8/x6lJ+xCVA1A8KKLh7AeWkB2fQlO1qH56om/69xdUoDloNanOLR8UtCCN
	 k3z0VDnDX+FoCXPF4436nTx2a9phG3fhkyPU25es=
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
Subject: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used exclusively by mshv
Date: Fri,  2 Jan 2026 14:02:08 -0800
Message-ID: <20260102220208.862818-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
has an assert intrinsic that uses interrupt vector 0x29 to create an
exception. This will cause hypervisor to then crash and collect core. As
such, if this interrupt number is assigned to a device by linux and the
device generates it, hypervisor will crash. There are two other such
vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
Fortunately, the three vectors are part of the kernel driver space and
that makes it feasible to reserve them early so they are not assigned
later.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---

v1: Add ifndef CONFIG_X86_FRED (thanks hpa)

 arch/x86/kernel/cpu/mshyperv.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 579fb2c64cfd..8ef4ca6733ac 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -478,6 +478,27 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 }
 EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
+#ifndef CONFIG_X86_FRED
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
+#endif          /* CONFIG_X86_FRED */
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax, eax;
@@ -510,6 +531,11 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+#ifndef CONFIG_X86_FRED
+	if (hv_root_partition())
+		hv_reserve_irq_vectors();
+#endif  /* CONFIG_X86_FRED */
+
 	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
 		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
-- 
2.51.2.vfs.0.1


