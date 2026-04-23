Return-Path: <linux-hyperv+bounces-10332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFOuMMwU6mmVtgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10332-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F203452408
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62E9F302965C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5DC3EDAA5;
	Thu, 23 Apr 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NNQ3LTd5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DF1D6DB5;
	Thu, 23 Apr 2026 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948209; cv=none; b=McYmUPrkQ3Gzd/C0d1IwaEfitu/wwUgH+PKY/bQQwagC8/DGfH8BdmSI54ktfIfcI+tJaeVoRPNj2jDUvuAO6jihVBSeTR/RB13TMMq7JZlDGmbezJDeSe5AVNqsMOSec+GhG0Io74g3FBNulILygMTLXizdgrOpsBgPBiXZ50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948209; c=relaxed/simple;
	bh=7jDf0qndz1oyEM0pImsr9dMT+4Hp4mYhkZE6kVNozDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpv3VhvOkmwCYIJYjC2HnHjB1TMCLENoca++73PoibRXIurHryq6h5ng8cAcKYNvXujyHwaa3+vMYYEnvSyZ3nwmAP+JLTPZAxAa7Fp6Bqp69lanXPiSrhhFQU8o7+9yUzWYZMnuPGRxVOD0JSwH7XRoJ3oqoEvEeBARSxV2b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NNQ3LTd5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 686C520B716D;
	Thu, 23 Apr 2026 05:43:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 686C520B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948208;
	bh=AQZdLQ59S/MbqpK3C/yK6xjmEtEnqnrMolLC2gULXrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNQ3LTd5fOkxRO6d4h4FSo33AZnCbrUVpoKOERGdAyh4vOHjNxvzi28PEzhOcKJkB
	 2fn9REvjhoIut5m1/YH3p9loue9OP9qe3rH2HLhD1EJ4KFE5DrFf8h29+/qGAVusXd
	 5I9eo8NBr3Gk3/YNpx4NRc8RbqzDk+Jar1LOWwM4=
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
Subject: [PATCH v2 08/15] Drivers: hv: Move hv_call_(get|set)_vp_registers() declarations
Date: Thu, 23 Apr 2026 12:41:58 +0000
Message-ID: <20260423124206.2410879-9-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10332-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F203452408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move hv_call_get_vp_registers() and hv_call_set_vp_registers()
declarations from drivers/hv/mshv.h to include/asm-generic/mshyperv.h.

These functions are defined in mshv_common.c and are going to be called
from both drivers/hv/ and arch/x86/hyperv/hv_vtl.c. The latter never
included mshv.h, relying on implicit declaration visibility. Moving the
declarations to the arch-generic Hyper-V header makes them properly
visible to all architecture-specific callers.

Provide static inline stubs returning -EOPNOTSUPP when neither
CONFIG_MSHV_ROOT nor CONFIG_MSHV_VTL is enabled.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/mshv.h              |  8 --------
 include/asm-generic/mshyperv.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index d4813df92b9c..0fcb7f9ba6a9 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -14,14 +14,6 @@
 	memchr_inv(&((STRUCT).MEMBER), \
 		   0, sizeof_field(typeof(STRUCT), MEMBER))
 
-int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
-			     union hv_input_vtl input_vtl,
-			     struct hv_register_assoc *registers);
-
-int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
-			     union hv_input_vtl input_vtl,
-			     struct hv_register_assoc *registers);
-
 int hv_call_get_partition_property(u64 partition_id, u64 property_code,
 				   u64 *property_value);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8cdf2a9fbdfb..ef0b9466808c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -394,6 +394,32 @@ static inline int hv_deposit_memory(u64 partition_id, u64 status)
 	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
 }
 
+#if IS_ENABLED(CONFIG_MSHV_ROOT) || IS_ENABLED(CONFIG_MSHV_VTL)
+int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+
+int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+#else
+static inline int hv_call_get_vp_registers(u32 vp_index, u64 partition_id,
+					   u16 count,
+					   union hv_input_vtl input_vtl,
+					   struct hv_register_assoc *registers)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int hv_call_set_vp_registers(u32 vp_index, u64 partition_id,
+					   u16 count,
+					   union hv_input_vtl input_vtl,
+					   struct hv_register_assoc *registers)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
+
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 u8 __init get_vtl(void);
 void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
-- 
2.43.0


