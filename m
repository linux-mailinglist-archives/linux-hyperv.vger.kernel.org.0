Return-Path: <linux-hyperv+bounces-11702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U1VBDsQYQmqS0AkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11702-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 09:03:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0326D6B0E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 09:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fZ1Ujojy;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fZ1Ujojy;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11702-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11702-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8E4D307CD53
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954F3B47EE;
	Mon, 29 Jun 2026 06:56:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5E2C2360
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:56:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716186; cv=none; b=WE9Q3oqaOjV7QFtHz8Z3iW7zBcwAdQUbLBVsk3PLuXBG/N+0gHzxDaodsuyUSlpOKkKjMSnauK7wnS3F97cI/ykDVrtH75Lj+XdIY0SxomaC8zlGIycneu33ii4CuFlmXEWG6y16W6MJkHpM9RPhPt8FO9iSgMVpR8GhO6x8qMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716186; c=relaxed/simple;
	bh=8IIZrd//25j4YR+57PmNv8C3RHMtTZNIgkaMld62H6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+RjBw56QReRIEY/p+G/S/0Kkk4Hq88/R+tTsOGFdE0eGeidfogbxHSJxCNCurm/+RVEyUcqA+xBOfpSPDvaBStnj/pahfyMN6lJBa9U04lPDiMi7ZdSrced6Ku+d7q6qwbfmNPPyDkBoVtVaQ8+WDQRGtG4Iq6AzNw9yUgMlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZ1Ujojy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZ1Ujojy; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6FCD75D0F;
	Mon, 29 Jun 2026 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZISdsO4tS1HYtt389XqwCLy1XlYy1EGwYtxAQJSbvu0=;
	b=fZ1Ujojy61n2f3PXe8bKe8wngualNNaJL8FY6HYelt8Nxf20iVBEKaEY8b51RVzt1g2zJO
	B5eb/Y1Q8SRU4Ca5vIDbHMNhricx5ynfsPIbOVAOs8hIrjTdia3hA57aAX3kBI5/TrJanz
	MVxAxI2B/Wbo6txcFzwrlDtNLvgOA90=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZISdsO4tS1HYtt389XqwCLy1XlYy1EGwYtxAQJSbvu0=;
	b=fZ1Ujojy61n2f3PXe8bKe8wngualNNaJL8FY6HYelt8Nxf20iVBEKaEY8b51RVzt1g2zJO
	B5eb/Y1Q8SRU4Ca5vIDbHMNhricx5ynfsPIbOVAOs8hIrjTdia3hA57aAX3kBI5/TrJanz
	MVxAxI2B/Wbo6txcFzwrlDtNLvgOA90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CA49779A8;
	Mon, 29 Jun 2026 06:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6Y6ERUXQmq3QQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:56:21 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 06/18] x86/hyperv: Switch from __rdmsr() to native_rdmsrq()
Date: Mon, 29 Jun 2026 08:55:32 +0200
Message-ID: <20260629065544.3643253-7-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629065544.3643253-1-jgross@suse.com>
References: <20260629065544.3643253-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80
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
	TAGGED_FROM(0.00)[bounces-11702-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-hyperv@vger.kernel.org,m:jgross@suse.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:lkp@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD0326D6B0E

The __rdmsr() helper will be changed soon, so don't use it directly
outside of msr.h. Switch to native_rdmsrq() in HyperV related code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602182222.WEBLSQRj-lkp@intel.com/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch (kernel test robot)
---
 arch/x86/hyperv/hv_crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 5ffcc23255de..28ee76e18d9b 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -217,9 +217,9 @@ static void hv_hvcrash_ctxt_save(void)
 	native_store_gdt(&ctxt->gdtr);
 	store_idt(&ctxt->idtr);
 
-	ctxt->gsbase = __rdmsr(MSR_GS_BASE);
-	ctxt->efer = __rdmsr(MSR_EFER);
-	ctxt->pat = __rdmsr(MSR_IA32_CR_PAT);
+	ctxt->gsbase = native_rdmsrq(MSR_GS_BASE);
+	ctxt->efer = native_rdmsrq(MSR_EFER);
+	ctxt->pat = native_rdmsrq(MSR_IA32_CR_PAT);
 }
 
 /* Add trampoline page to the kernel pagetable for transition to kernel PT */
-- 
2.54.0


