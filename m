Return-Path: <linux-hyperv+bounces-8873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOoqJ9L1lGlzJQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8873-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 00:12:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8272151BBB
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 00:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 479333006206
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 23:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2AB2C1598;
	Tue, 17 Feb 2026 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ClUJ3Kk8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B628D8D1;
	Tue, 17 Feb 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369933; cv=none; b=LZukT4z9Ntngy+CwnBLWgu5o8ouzuF5jAYo+N0UTHKHYkLwEn2fzZvbzHYV9pUjt1kaTng763OEDkLzzIO16+qBv+rC2dQ+kXhBopklKmE5TdFAI9KzYJLpFcBNN5s3WR3hoizqXwc7s13ScXqRf5pJ0lY2bxBH38hh4QyEiQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369933; c=relaxed/simple;
	bh=oRrazVpr52XuWE2ASML/dyW1hkdt0jKmkBp4cjS/uJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQ4XI8f46P56cUilTIb9fMNUVr900VXDqMXVSJLKpVas1HbHSlD9eozNlFH+XCyFuute/q5nSYhKjBJ3ipRbcd7A8ZDVo7RYPba2MKY8qpqbXByFtPTGUeVzFYF3PAt3xrGCZuiRdrd+qx4fALq+kEocDxlQvE+I/NCtLkU8Gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ClUJ3Kk8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25A5820B6F00;
	Tue, 17 Feb 2026 15:12:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25A5820B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771369931;
	bh=jNN/NBTAKpkvKMECtStoqro1PEB3Cw73nVqoA1yX9kM=;
	h=From:To:Cc:Subject:Date:From;
	b=ClUJ3Kk8MfondxLeoQ3LpztQ42VWYc97CzeCDrNphbibWtvsthi31N1Hl5qZj7Tfr
	 3GeU0+SholVbv3KFqE93ruqdiru+eM/Qw3QS3aZBVo7ExixZqa7+4ScVOmiWIOnq/7
	 q8TuGT5nnKdi9gFJI7Wn6Bmw4wGivNaGl6LqGjKU=
From: Mukesh R <mrathor@linux.microsoft.com>
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
Subject: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used exclusively by mshv
Date: Tue, 17 Feb 2026 15:11:58 -0800
Message-ID: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8873-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8272151BBB
X-Rspamd-Action: no action

From: Mukesh Rathor <mrathor@linux.microsoft.com>

MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
has an assert intrinsic that uses interrupt vector 0x29 to create an
exception. This will cause hypervisor to then crash and collect core. As
such, if this interrupt number is assigned to a device by Linux and the
device generates it, hypervisor will crash. There are two other such
vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
Fortunately, the three vectors are part of the kernel driver space and
that makes it feasible to reserve them early so they are not assigned
later.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---

v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
v2: replace ifndef with cpu_feature_enabled() (thanks hpa and tglx)

 arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 579fb2c64cfd..88ca127dc6d4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -478,6 +478,28 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 }
 EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
 
+/*
+ * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
+ * will either crash or hang or attempt to break into debugger.
+ */
+static void hv_reserve_irq_vectors(void)
+{
+	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
+	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
+	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
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
@@ -510,6 +532,11 @@ static void __init ms_hyperv_init_platform(void)
 
 	hv_identify_partition_type();
 
+#ifndef CONFIG_X86_FRED
+	if (hv_root_partition())
+		hv_reserve_irq_vectors();
+#endif	/* CONFIG_X86_FRED */
+
 	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
 		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
-- 
2.51.2.vfs.0.1


