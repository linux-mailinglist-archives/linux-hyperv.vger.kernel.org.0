Return-Path: <linux-hyperv+bounces-9433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD2aJHH0t2mfXQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9433-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:15:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 367432994E8
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 247CE3028E84
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D660395240;
	Mon, 16 Mar 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jDcEUB6i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D639479A;
	Mon, 16 Mar 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663241; cv=none; b=Ozr0/F4sWN8JwAQsL80NwbIz+XhRUBW2amFE45jH+2CI/iR5174eTB4bQW6GLqN2zUBJ/DX6B9BVawX53HaPV2nLiob3niO3YPHB9i7knQLPFz+B1kR8jJ3OLFpoPqhIy7BVYm7J04sUWGDPV6rd0N+x3AOUDD8y0DhJZRlr1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663241; c=relaxed/simple;
	bh=M0gnb043UzXcLdzvO+Qbu8eo8j0rmJpeCSSsA5hB2MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fajN/oyfnBoD01Bcexn9aeLYMgXCtLewRrSFRLNTGjMMn3gXYQ8CH5BPzZHCXZwMgT8vkt91/mXuD5w49ptaLMgkRwIR9Vu/Rcl6hywUZfTArFCcSPuUBnLpsouMxZWzoR3BMsqmMYFBHEKLp4XpR3mN3CXjB5CSWeuSG/cBeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jDcEUB6i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98A1E20B6F01;
	Mon, 16 Mar 2026 05:13:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98A1E20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773663240;
	bh=1tIeJ9SsYHVdstCDU1TnP5bpNkiYnZ9fn1VYje8AQcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDcEUB6im4iHNa8UvsB4S4VtwoaL8MA54GDurzLy2wS1TLb6GLd7swVaNI/GDOj3O
	 DgRGqXyFlAmfNAeDLRqe/DAoy5Ya+8ntTJ1+stBVGLZAFrGKlkQUTRptJ2qkiwZjVv
	 6HcItX5fK4bfExTmAX7cU7AX7sm8X1Uy4UYy1+1s=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	ssengar@linux.microsoft.com,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 09/11] Drivers: hv: mshv_vtl: Let userspace do VSM configuration
Date: Mon, 16 Mar 2026 12:12:39 +0000
Message-ID: <20260316121241.910764-10-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316121241.910764-1-namjain@linux.microsoft.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9433-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,reg_assoc.name:url]
X-Rspamd-Queue-Id: 367432994E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kernel currently sets the VSM configuration register, thereby
imposing certain VSM configuration on the userspace (OpenVMM).

The userspace (OpenVMM) has the capability to configure this register,
and it is already doing it using the generic hypercall interface.
The configuration can vary based on the use case or architectures, so
let userspace take care of configuring it and remove this logic in the
kernel driver.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/mshv_vtl_main.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index c79d24317b8e..4c9ae65ad3e8 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -222,30 +222,6 @@ static int mshv_vtl_get_vsm_regs(void)
 	return ret;
 }
 
-static int mshv_vtl_configure_vsm_partition(struct device *dev)
-{
-	union hv_register_vsm_partition_config config;
-	struct hv_register_assoc reg_assoc;
-
-	config.as_uint64 = 0;
-	config.default_vtl_protection_mask = HV_MAP_GPA_PERMISSIONS_MASK;
-	config.enable_vtl_protection = 1;
-	config.zero_memory_on_reset = 1;
-	config.intercept_vp_startup = 1;
-	config.intercept_cpuid_unimplemented = 1;
-
-	if (mshv_vsm_capabilities.intercept_page_available) {
-		dev_dbg(dev, "using intercept page\n");
-		config.intercept_page = 1;
-	}
-
-	reg_assoc.name = HV_REGISTER_VSM_PARTITION_CONFIG;
-	reg_assoc.value.reg64 = config.as_uint64;
-
-	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
-				       1, input_vtl_zero, &reg_assoc);
-}
-
 static void mshv_vtl_vmbus_isr(void)
 {
 	struct hv_per_cpu_context *per_cpu;
@@ -1168,11 +1144,6 @@ static int __init mshv_vtl_init(void)
 		ret = -ENODEV;
 		goto free_dev;
 	}
-	if (mshv_vtl_configure_vsm_partition(dev)) {
-		dev_emerg(dev, "VSM configuration failed !!\n");
-		ret = -ENODEV;
-		goto free_dev;
-	}
 
 	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
 	ret = hv_vtl_setup_synic();
-- 
2.43.0


