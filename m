Return-Path: <linux-hyperv+bounces-11695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8exOLFANQmr6zQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11695-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:14:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8C6D639C
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QxHZOMLJ;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QxHZOMLJ;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11695-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11695-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF7E9303D55D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0D39658D;
	Mon, 29 Jun 2026 06:08:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821B3932E9
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:08:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713289; cv=none; b=KYckvSuPJBeJqoYDCP+pEFEMA4rJy852uIAB+VgXeFaCf+IoHJ2ADD6E8p4GwZYeoSCmZFpXsewGZlgMIp2Gc/gtm7g/ZvhHq9fTqgIWgvfhbzNscnUTLUWOklK8mt+I0u9qgGyFZ2WUe1IRn6TAhW0C5sZ9pPvIBouiu6o5PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713289; c=relaxed/simple;
	bh=zcDGs6CpQoLyiosUb0Uax13IVV3IZF3htq7pYx8d1BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coII7lu7UQfkBu028Hyp5W8wJWpHYw+ZYmDZzlbj33VQh1ry3a8nj21Lqid1eAmXfd4R3Qdfh0WfdtqhLyEN3WTzrxqybqzGqB5Ca/fS2q1LjUyg+9JtE74O7eXEYwW8N/3fy/KZajux4ZJaFq9yKKFteM1gPM79DGm5J/rGCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxHZOMLJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxHZOMLJ; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FAEF72F0A;
	Mon, 29 Jun 2026 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXPK35OTcxbrAHElJ+R7ax1ys2YK+EbeeL4YKvGLUyA=;
	b=QxHZOMLJWLU35HhoMaFNdFM8jjMhlRi5IROqWkUMC4D16i9JhxueMIG8s/bVolijeBfJ5g
	LYtUqnlGgWHTyvcLHiV7rC8BWy/jy+XgV6L6Q7YycxLnnbvAeVHIKHrLExLnHQ71yNq7sG
	E70E1AwBo7QpmDUpjS0ErboAYMMumck=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXPK35OTcxbrAHElJ+R7ax1ys2YK+EbeeL4YKvGLUyA=;
	b=QxHZOMLJWLU35HhoMaFNdFM8jjMhlRi5IROqWkUMC4D16i9JhxueMIG8s/bVolijeBfJ5g
	LYtUqnlGgWHTyvcLHiV7rC8BWy/jy+XgV6L6Q7YycxLnnbvAeVHIKHrLExLnHQ71yNq7sG
	E70E1AwBo7QpmDUpjS0ErboAYMMumck=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E728B779A8;
	Mon, 29 Jun 2026 06:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PTsEN8QLQmrwEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:08:04 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 27/32] x86/hyperv: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:18 +0200
Message-ID: <20260629060526.3638272-28-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11695-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-hyperv@vger.kernel.org,m:jgross@suse.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B8C6D639C

The 32-bit MSR interface rdmsr() is planned to be removed. Use the
related 64-bit variant instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/hyperv/hv_apic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index a8de503def37..95f1782d1e17 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -60,17 +60,15 @@ void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
 
 static u32 hv_apic_read(u32 reg)
 {
-	u32 reg_val, hi;
+	struct msr reg_val;
 
 	switch (reg) {
 	case APIC_EOI:
-		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
-		(void)hi;
-		return reg_val;
+		rdmsrq(HV_X64_MSR_EOI, reg_val.q);
+		return reg_val.l;
 	case APIC_TASKPRI:
-		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
-		(void)hi;
-		return reg_val;
+		rdmsrq(HV_X64_MSR_TPR, reg_val.q);
+		return reg_val.l;
 
 	default:
 		return native_apic_mem_read(reg);
-- 
2.54.0


