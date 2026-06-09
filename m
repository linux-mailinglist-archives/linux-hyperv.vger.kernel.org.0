Return-Path: <linux-hyperv+bounces-11561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKI+MW1ZKGpGCgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11561-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:20:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48838663440
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:20:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=flAMBILg;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11561-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11561-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A2A3059FC4
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3648A2DF;
	Tue,  9 Jun 2026 18:10:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F934348C46;
	Tue,  9 Jun 2026 18:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028650; cv=none; b=TCARSEYf7/tsYNl54aAQ5E3RWEEawodNAVLGcWRORyAO+tQ5DPyKx4XFvOiZ7ntlh17lCSY2LB2hmVhnbSFjJT9B6wHnwwabXuqa7O9/0nACRsbrCKdBwVIou0djBylaVH6XMnk6Xoo7Mxjdd60utsp9+JrMIiOabJK+wMPg0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028650; c=relaxed/simple;
	bh=8AFdpXutNXpzA4gvfdr/i1aouZKGWjOE8OU+2PsRlvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob3BfzvR69dwVEXC2I0Eu4Ay+wyJITqPYePHLbIsG431jtZWJUNqB0mVKqcdgCHQZ1UFdGpzRc8QNbPEKX5ncgr3z2Cb8bDNoZneBSUN6OtUiEF6qT9lkcy16PHArT4THZNR6d8EhgLzSl2s3CqzcmrQ8+qXz/uGiMUx+xnvMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=flAMBILg; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 70A1020B716A;
	Tue,  9 Jun 2026 11:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70A1020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781028631;
	bh=jmx5UcOrpux4d1MrThN9O+kCWai0Xlxr7nWB+bA954s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flAMBILgJKbjXrzYbl8Y3HanKjS+aZMiU6Py9nK9hVO3T8/Bn4kLLfOI541WKjmdJ
	 n1+qzlT4JM4ExR9QYTh0wlY6wYrPnMVe0ohWv6B6gPZrtMDzEcT+GBrWPmdAsdsA1l
	 5CYCS0kq4MrHLuyoZ5/B0jCh5uS11M1XkQpyslBI=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Tue,  9 Jun 2026 11:10:25 -0700
Message-ID: <20260609181030.2378391-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11561-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48838663440

Add struct rsi_host_call to rsi_smc.h, which represents the host call
data structure used by the Realm Management Monitor (RMM) for the
RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
and 31 general-purpose register values, aligned to 256 bytes as required
by the CCA RMM specification.

Add rsi_host_call() static inline wrapper in rsi_cmds.h that invokes
SMC_RSI_HOST_CALL with the physical address of the host call structure.
This will be used by Hyper-V guest code to route hypercalls through the
RSI interface when running inside an Arm CCA Realm.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/include/asm/rsi_cmds.h | 9 +++++++++
 arch/arm64/include/asm/rsi_smc.h  | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 2c8763876dfb7..83b4b1f598454 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -159,4 +159,13 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+static inline long rsi_host_call(phys_addr_t host_call_struct)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
+		      &res);
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index e19253f96c940..ffea93340ed7f 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -142,6 +142,12 @@ struct realm_config {
 	 */
 } __aligned(0x1000);
 
+struct rsi_host_call {
+	u16 immediate;
+	u64 gprs[31];
+} __aligned(256);
+static_assert(sizeof(struct rsi_host_call) == 256);
+
 #endif /* __ASSEMBLER__ */
 
 /*
-- 
2.45.4


