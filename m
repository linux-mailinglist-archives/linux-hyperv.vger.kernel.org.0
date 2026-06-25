Return-Path: <linux-hyperv+bounces-11672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p0rWHBVoPWrW2ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11672-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:40:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC16C7EA4
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=YyT1mLLb;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11672-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11672-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68BBB30C4707
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD803EE1E4;
	Thu, 25 Jun 2026 17:35:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8C3EE1C0;
	Thu, 25 Jun 2026 17:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408907; cv=none; b=nLImnil1lejCl6l4Fxcl6JNREDqXSV3exWiKN2OP+Cuv4S1lEM3m188dKs03s/kUEDv1u3yAXwP9UDsZDJRWPglWWGxq2n4ELpUyowJxB4t1MnPm9jZt1Y7Jlb7vaJVyv7DBPuJK7jGki+ZW0sLQCvNvB9XbKVQNJ3REqkg2JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408907; c=relaxed/simple;
	bh=fUUKFmrbIiUef74AOCNqccPziLzJSdWvp3e05UVA26M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsKPFCvY+XZ/nrLak8h+wwdNYpgzWci+duYG5FJruAssni8F7dHmz5vlk6/4iSm4chCL1zRIE05lI40pmvxT7sleLjWj9bL0pFJhN+pKxhAokqF4uQwy++kJFq9L3RHLUMkE1taAmqAwdzO4hQmFTFF/58A7xjaZn9SrKKcy8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YyT1mLLb; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C48220B7169;
	Thu, 25 Jun 2026 10:35:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C48220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408901;
	bh=NzRxQvPwzEBTlATkVCaj62V6KcKKHvmr0KtL0Tzs39U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyT1mLLbG0yDsWb+ub3RqfqfkOHlZeXiolq/hbqF4YXDOeLmdiv93ZqnEhoqm8oOP
	 XS+ZvAjiK7CZ5GDZPChpxbpbNigkPBEjcAxUtCiu7/RZxgVPYgUuSrUkeESXy1U/JM
	 z4XaicX08QbR1i7BFUkeqYb2msShZhvkDonjy6jk=
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
Subject: [PATCH v2 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Thu, 25 Jun 2026 10:34:55 -0700
Message-ID: <20260625173500.1995481-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11672-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48EC16C7EA4

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
 arch/arm64/include/asm/rsi_cmds.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/rsi_smc.h  |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 2c8763876dfb7..9daf8008e5da2 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -88,6 +88,28 @@ static inline long rsi_set_addr_range_state(phys_addr_t start,
 	return res.a0;
 }
 
+/**
+ * rsi_host_call - Make a Host call.
+ * @host_call_struct: IPA of host call structure
+ *
+ * This call will fail if the IPA of the host call structure:
+ * * is not aligned to 256 bytes,
+ * * is not protected / encrypted,
+ * * is RIPAS_EMPTY
+ *
+ * Returns:
+ *  On success, returns RSI_SUCCESS.
+ *  Otherwise, returns an error code.
+ */
+static inline unsigned long rsi_host_call(phys_addr_t host_call_struct)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
+		      &res);
+	return res.a0;
+}
+
 /**
  * rsi_attestation_token_init - Initialise the operation to retrieve an
  * attestation token.
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index e19253f96c940..9cc57b5be0c02 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -142,6 +142,13 @@ struct realm_config {
 	 */
 } __aligned(0x1000);
 
+struct rsi_host_call {
+	u16 immediate;
+	u8 _padding[6];
+	u64 gprs[31];
+} __aligned(256);
+static_assert(sizeof(struct rsi_host_call) == 256);
+
 #endif /* __ASSEMBLER__ */
 
 /*
-- 
2.45.4


