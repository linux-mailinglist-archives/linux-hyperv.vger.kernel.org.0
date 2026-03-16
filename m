Return-Path: <linux-hyperv+bounces-9430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OaNBjj0t2mfXQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9430-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:14:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61D299491
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94EA8302197C
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7A393DC2;
	Mon, 16 Mar 2026 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kCmKGzvY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D726D4DD;
	Mon, 16 Mar 2026 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663218; cv=none; b=lMNuEi0HUR4PGpbIS7CrcFI8MhJ+M5K+WoNpd8sS9selhLtnG/rgRv1IO05eGZNHncsxb0foK9e3ozMRAImlOQBTHJB+M7IZNIqhMZzxPYCPxSI4if4tQujnAIEC4HIXgaXcSNoWgCb5qv81Q2gN4fqT4QZ6IKcCDbXWzB1A5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663218; c=relaxed/simple;
	bh=qCyY3pKjxPVQikljorU7QNeL/LYi64ZDGCIxpmrYkuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZoeBeT+TmtfOVYgG/w0/VpIutoo4TrZEX4gwqpo4J1SN46WYrYz1RXGLAIBxlfZSkLW2BBvIf5YPh5Qj4cb5wNIWZCgHK0I+iKgp5RCP8wHI64n++frsMyxFrQflccEC3ng/R9s2u6SBM8pkMfwYewO6mEd+2ib3Q5yOZSa2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kCmKGzvY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE44A20B700D;
	Mon, 16 Mar 2026 05:13:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE44A20B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773663217;
	bh=qxNzXROiVNr7+UUfLEumcf/CNbcQ/TPD3rd4fIb/4jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCmKGzvYncQUiJWqt/Z+9Vj+di6RNMWorU0zQ9qy98ppbIh3yfCTkOqXutmuqfRuQ
	 OoH54gVCHkASeGsnZT/6YU3F/B9laj8xfw9AUZW00PHzw1Qk8Fp19j9waS1QC/2cKz
	 Y4hKnRWh7cuVVoAHR6tNkmU20pZZ+K6ceIejoD4g=
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
Subject: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral in MSHV_VTL
Date: Mon, 16 Mar 2026 12:12:36 +0000
Message-ID: <20260316121241.910764-7-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9430-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: BB61D299491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Generalize Synthetic interrupt source vector (sint) to use
vmbus_interrupt variable instead, which automatically takes care of
architectures where HYPERVISOR_CALLBACK_VECTOR is not present (arm64).

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/mshv_vtl_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index b607b6e7e121..91517b45d526 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -234,7 +234,7 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
 	union hv_synic_sint sint;
 
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = vmbus_interrupt;
 	sint.masked = false;
 	sint.auto_eoi = hv_recommend_using_aeoi();
 
@@ -753,7 +753,7 @@ static void mshv_vtl_synic_mask_vmbus_sint(void *info)
 	const u8 *mask = info;
 
 	sint.as_uint64 = 0;
-	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.vector = vmbus_interrupt;
 	sint.masked = (*mask != 0);
 	sint.auto_eoi = hv_recommend_using_aeoi();
 
-- 
2.43.0


