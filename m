Return-Path: <linux-hyperv+bounces-10337-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDOJHqkV6mkatwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10337-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:50:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA284524FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4FC308381C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918E3EDAA4;
	Thu, 23 Apr 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ex1bUyOf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBF3ED5DB;
	Thu, 23 Apr 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948248; cv=none; b=OXueiSZ35kihaQVSaRbF5u6IaDnxvo3EnY/75FwUBHmBC7q+2az+TIkZWpqWbrWenuHs+A/zyvIR1Sbnjpt+a9E8716zb3P3RRts1XdUEZ3ozFqtsWVh4WBZPK9FBuqdGx3TtiRnO9JY3V5Z2VKaUsngF0ThY+no/zI3PeuKFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948248; c=relaxed/simple;
	bh=QhwlyZLVHh3iKGvYP2jk7wpTpp9V2bihpmbro8Kp1gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bElM705n4zEYJ3+WD3fVhMqa1qrEqEHHuMPLrGswUrflHxu8MZWLPC3I4WJMYLLvzL0DFI4JrtiQraqgYQEp2VxFLIbWRZ6IWYBE5Uf/lkASCe7l3ARsXYZZoP1pc20HwEpn51rR3mVTNlgPkZPDaCgsjLTszGBdY7MAQK9Osxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ex1bUyOf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id BDFEE20B716F;
	Thu, 23 Apr 2026 05:44:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDFEE20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948247;
	bh=1Si2vLE+zPB6prbMPE/cdtc4huvV7tWVF4D7BT4Ap7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ex1bUyOfRJKCP+0lBVsUziVPVd+0d51ReTPSRmFbuc28vd3Nz4ptTcg4+AVNnYZM9
	 RSunynWJvpI5uw7AKMyeGLw50tlZ95+Tlt6dvDrxSPQem9Esju+nJmcsQ/kGebKLqi
	 HUTyiX+QXMF7vONKiTPx6RrGdBNVwqf9es11vYGs=
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
Subject: [PATCH v2 13/15] mshv_vtl: Add remaining support for arm64
Date: Thu, 23 Apr 2026 12:42:03 +0000
Message-ID: <20260423124206.2410879-14-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10337-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 0CA284524FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add necessary support to make MSHV_VTL work for arm64 architecture.
* Add stub implementation for mshv_vtl_return_call_init() as it's not
  required for arm64
* Handle hugepage functions by config checks, as it's x86 specific
* fpu/legacy.h header inclusion was required when x86 assembly code
  was present here, it got left when the code was moved to arch files.
  Remove it now (unrelated to arm64)

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h | 2 ++
 drivers/hv/mshv_vtl_main.c        | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 9eb0e5999f29..6f668ec68b2f 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -82,6 +82,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, b
 	return 1;
 }
 
+/* Stubbed for arm64 */
+static inline int mshv_vtl_return_call_init(void) { return 0; }
 #endif
 
 #include <asm-generic/mshyperv.h>
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index be498c9234fd..d5308956dfb6 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -23,8 +23,6 @@
 #include <trace/events/ipi.h>
 #include <uapi/linux/mshv.h>
 #include <hyperv/hvhdk.h>
-
-#include "../../kernel/fpu/legacy.h"
 #include "mshv.h"
 #include "mshv_vtl.h"
 #include "hyperv_vmbus.h"
@@ -1077,10 +1075,12 @@ static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned int ord
 			ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 		return ret;
 
+#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	case PUD_ORDER:
 		if (can_fault(vmf, PUD_SIZE, &pfn))
 			ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 		return ret;
+#endif
 
 	default:
 		return VM_FAULT_SIGBUS;
-- 
2.43.0


