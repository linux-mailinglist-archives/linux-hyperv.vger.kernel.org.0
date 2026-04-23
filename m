Return-Path: <linux-hyperv+bounces-10336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHk6JJQU6mmytQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10336-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:46:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FE4523A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4A63044DDA
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAEA3EDAA3;
	Thu, 23 Apr 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oIKRO7GJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F120382281;
	Thu, 23 Apr 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948241; cv=none; b=Lqhxli35e3ohL53iuLJZMTjaz6KJNF4/J37+PUDEwYVU8F86rTTH2fCWemz5IpSbiXK5XAy7+ZbMSreS9ng1leFOOHaA7FflnpgDX2plLhKOGzn8CrzoFCadsXNy8K9nChh+0uu5vE7vEmgA17Ipllmj6eb7dhDrHI1rRbtDBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948241; c=relaxed/simple;
	bh=Yl2tqtoe6+sXbirM1ZqrVjc/Ixhrns5ByeitkyVRDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzeHfcN3SJEg6H5EYhKxZtZT6L62a+SiTxP/n0Jg18X5sOcApcWclxJeReCv+nhEjmMIgFj9S0acrZev6TelLMpW+pPz1/UTxYQyWB/FAcIpA4xP7mQVgVpCRYZEC1AeFFUN/s+eLn4lkpEDIEJlYFPXSQvcEh6pl1CNX6IhyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oIKRO7GJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id D685E20B7172;
	Thu, 23 Apr 2026 05:43:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D685E20B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948240;
	bh=wwtrSevDXsiP4ai9nAki7ynEwNWhGDuPbqk73+Idwtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIKRO7GJl2Gm7dcJrQHwiTxm2axwxWGppTMKxuLoDn+EPRMGbsJTNvawOzU+7GVf6
	 vGvJcp2InOpXQHjLPEyByEnJuHw/OzOgIomchpySoIozcjj1QsjJdx4US2BOrqF9fz
	 6IASXptBiFTXx75DHr9XFAiKATMW22wSzKTDOqmE=
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 12/15] mshv_vtl: Move VSM code page offset logic to x86 files
Date: Thu, 23 Apr 2026 12:42:02 +0000
Message-ID: <20260423124206.2410879-13-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423124206.2410879-1-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10336-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org,mailbox.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B83FE4523A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VSM code page offset register (HV_REGISTER_VSM_CODE_PAGE_OFFSETS)
is x86 specific, its value configures the static call used to return
to VTL0 via the hypercall page. Move the register read from the common
mshv_vtl_get_vsm_regs() into the x86 mshv_vtl_return_call_init(),
which is the sole consumer of the offset.

Change mshv_vtl_return_call_init() from taking a u64 parameter
to taking no arguments, and rename mshv_vtl_get_vsm_regs() to
mshv_vtl_get_vsm_cap_reg() since it now only fetches
HV_REGISTER_VSM_CAPABILITIES.

No functional change on x86. This prepares the common driver code for
ARM64 where VSM code page offsets do not apply.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c        | 19 +++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  4 ++--
 drivers/hv/mshv_vtl_main.c      | 24 +++++++++++++-----------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index f3ffb6a7cb2d..7c10b34cf8a4 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -293,10 +293,25 @@ EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
 
 DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
 
-void mshv_vtl_return_call_init(u64 vtl_return_offset)
+int mshv_vtl_return_call_init(void)
 {
+	struct hv_register_assoc vsm_pg_offset_reg;
+	union hv_register_vsm_page_offsets offsets;
+	int ret;
+
+	vsm_pg_offset_reg.name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
+
+	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				       1, input_vtl_zero, &vsm_pg_offset_reg);
+	if (ret)
+		return ret;
+
+	offsets.as_uint64 = vsm_pg_offset_reg.value.reg64;
+
 	static_call_update(__mshv_vtl_return_hypercall,
-			   (void *)((u8 *)hv_hypercall_pg + vtl_return_offset));
+			   (void *)((u8 *)hv_hypercall_pg + offsets.vtl_return_offset));
+
+	return 0;
 }
 EXPORT_SYMBOL(mshv_vtl_return_call_init);
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b4d80c9a673a..b48f115c1292 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -286,14 +286,14 @@ struct mshv_vtl_cpu_context {
 #ifdef CONFIG_HYPERV_VTL_MODE
 void __init hv_vtl_init_platform(void);
 int __init hv_vtl_early_init(void);
-void mshv_vtl_return_call_init(u64 vtl_return_offset);
+int mshv_vtl_return_call_init(void);
 void mshv_vtl_return_hypercall(void);
 void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
 int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, bool shared);
 #else
 static inline void __init hv_vtl_init_platform(void) {}
 static inline int __init hv_vtl_early_init(void) { return 0; }
-static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
+static inline int mshv_vtl_return_call_init(void) { return 0; }
 static inline void mshv_vtl_return_hypercall(void) {}
 static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 #endif
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 4c9ae65ad3e8..be498c9234fd 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -79,7 +79,6 @@ struct mshv_vtl {
 };
 
 static struct mutex mshv_vtl_poll_file_lock;
-static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
 static union hv_register_vsm_capabilities mshv_vsm_capabilities;
 
 static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
@@ -203,21 +202,19 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
 	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
 }
 
-static int mshv_vtl_get_vsm_regs(void)
+static int mshv_vtl_get_vsm_cap_reg(void)
 {
-	struct hv_register_assoc registers[2];
-	int ret, count = 2;
+	struct hv_register_assoc vsm_capability_reg;
+	int ret;
 
-	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
-	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
+	vsm_capability_reg.name = HV_REGISTER_VSM_CAPABILITIES;
 
 	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
-				       count, input_vtl_zero, registers);
+				       1, input_vtl_zero, &vsm_capability_reg);
 	if (ret)
 		return ret;
 
-	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
-	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
+	mshv_vsm_capabilities.as_uint64 = vsm_capability_reg.value.reg64;
 
 	return ret;
 }
@@ -1139,13 +1136,18 @@ static int __init mshv_vtl_init(void)
 	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
 	init_waitqueue_head(&fd_wait_queue);
 
-	if (mshv_vtl_get_vsm_regs()) {
+	if (mshv_vtl_get_vsm_cap_reg()) {
 		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
 		ret = -ENODEV;
 		goto free_dev;
 	}
 
-	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
+	ret = mshv_vtl_return_call_init();
+	if (ret) {
+		dev_err(dev, "mshv_vtl_return_call_init failed: %d\n", ret);
+		goto free_dev;
+	}
+
 	ret = hv_vtl_setup_synic();
 	if (ret)
 		goto free_dev;
-- 
2.43.0


