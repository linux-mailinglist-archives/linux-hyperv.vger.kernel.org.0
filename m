Return-Path: <linux-hyperv+bounces-9317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPxgEnlEsWlCtAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9317-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:31:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31099262381
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 11:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AD3630820BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D303CFF68;
	Wed, 11 Mar 2026 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILwUB2HI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEC3CFF61
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224848; cv=none; b=qKnW9PHbtm0ujcdnS7Rh+RPZIjqiog9l1Mg8tfmiUQyRgrmmivw5J2iZg3lWentnZOl77nNbiQ5dQpjTX4NYhXJ7VZ7L8KSEaJW5cjTind9o2HIo9U9dHUeU7c1nacVOrSHBcWvQyWXflUp0uWKb40/KZRLpaxx6OPnTf+7s8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224848; c=relaxed/simple;
	bh=BzgOogABOyBb/WGajn2wLIW6HIFSPr3foHo0O0EAQmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/Ity4dOUU05G3cg6Bc0/oWjXKG5nxmqGvKWOAN0lV48/L0+zwFfgir/MVerEa3v8SCS+JBucaguYk2tF1Ud64BEz85cAS7x5TlimuROLVVwANjsgRVMt5oj+97qIHv7aut7b5dDyeSHA49JHtqp8+nYAzMvs4jfg5E5LBwyK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILwUB2HI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48532925a4bso19686395e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2026 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773224844; x=1773829644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17QnM279YVAZDc+GbW/vG0+BIwjApbI1DlxazgkOlrY=;
        b=ILwUB2HIJed2QnoBLmWpsY+JbIuMMbBT6gBe+jwxflh40bCFJp8bOpB/fqK4FaD+do
         m4KiuuInpeuT77biCfZD1dZptxNJnrMi2jokmZadHhTZHWr9A1HxOCFTOIqutD4J218W
         Re4uT0BbU73gyc8enPUc/X00ILI1VgN580BlFsXog8Urt0Nix5Huw5By4tzcUpWu9pIu
         ru1NjTISA95oMJ4sgWpjl8nJLxNBBobT9bRe/zKHKSTWOQnR/c+3tnc7GnPek7PIOK79
         SOu0lhLKUvsvtgX7YE5DOFxSYB4Ea25lz3Kbm0f/yTVho9yTXaU287srxUDHQvEIXbT5
         Y+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224844; x=1773829644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17QnM279YVAZDc+GbW/vG0+BIwjApbI1DlxazgkOlrY=;
        b=iG6BXquTD5CTWldw7GNFsmnXHro3i1rQ9OX/p5xTXjkokHhP/7hw2ziTgz5IkLlOTQ
         VvmWmHJJHGP+bsZbOf/VWsz5KPtrMraHpliZpvU2QuMhClp3aTERDGjMinw1Jm19Zp+I
         gbQG4MylXZ/9J2v3sHZRNZfaol8v+mcs0UiLCDx+A3vxmaF97c1Smn5cFSiCOS2zLd/r
         2OxGwfK0N78V6eZc1eo6inza0pAm2Qxeqf3JGbNwTZgxWz6HF8yWA0B/7MYQ7WB2Gbjd
         623C9lcmt3aJO46U5yp2vJR3BwAjieaYhD2vpvKLBGHU17ph0iz0FmxkLxZOHTR68m7l
         0shw==
X-Gm-Message-State: AOJu0Yxg1Ruga191V7NDwBcNkMV0V9YNaj5n+rgi/CAZTShOjHFu9N6z
	bXNN/NqzWlUXl8FPHSs+JxSx0UIlC/wAgKqko9MgFc+J3NaIRpcX0nxWyd/0JOv9aVM=
X-Gm-Gg: ATEYQzzaeoKaOFWDDvMclYNnn9R6AKB57f0ap/wcfoM28lbHiJqiaQMYHcplAVjaAau
	bhu8/vIMBh8pcUMvGgvAjsqtfebFTweuSoCPO2RBeP/zkljFy7Qt5H0f4KQl0juf0lsdvAcZ4ws
	2Vd1+w1Y0cx+dQHXjaAr1m6WF01mkk0nYnYX6/sGFmUOmeyhGzadm+jbJrW+d/GdkYDSZNjZiFX
	ussqXT0U5feZdhfXOnAVFQ+Kha60a2+v4xW1NWcwG/YgJEpEQkMVdtEvEyvq+GSU1gTx5kcYPmm
	G1tJNpvN00BblLt3ENT3pi5MfD+llbPUyJZ17MdZgBIGYBUY59j3U132Jg5r6nF20MYgjd+MePJ
	VKXjf0O/VQNctM1RaFaeyNjx+g1/khu5DB7ZyiDaSQC7yszZeRsq9rVUZVwAoHxDdNWRhvvskg4
	mqk4qx5WNqX5Kva2IjokT5VhZOV2LA3Qo79TcL4zQaGKsHFseYiHts3hBpzeOWtFP5KHo5Jhux2
	ZRDUvv6vyEzCoIRBballxyeTdsMSxXdqckeMeEnneRE
X-Received: by 2002:a05:600c:a46:b0:485:3026:2b8b with SMTP id 5b1f17b1804b1-4854b12bfd2mr30525435e9.29.1773224843940;
        Wed, 11 Mar 2026 03:27:23 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm44534915e9.6.2026.03.11.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:21 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -hyperv 2/3] x86/hyperv: Use current_stack_pointer to avoid asm() in hv_hvcrash_ctxt_save()
Date: Wed, 11 Mar 2026 11:25:59 +0100
Message-ID: <20260311102658.215693-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311102658.215693-1-ubizjak@gmail.com>
References: <20260311102658.215693-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31099262381
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,alien8.de,linux.intel.com,zytor.com];
	TAGGED_FROM(0.00)[bounces-9317-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use current_stack_pointer to avoid asm() when saving %rsp to the
crash context memory in hv_hvcrash_ctxt_save(). The new code is
more readable and results in exactly the same object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/hyperv/hv_crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index 2c7ea7e70854..d0f95a278fdb 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -199,7 +199,7 @@ static void hv_hvcrash_ctxt_save(void)
 {
 	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
 
-	asm volatile("movq %%rsp,%0" : "=m"(ctxt->rsp));
+	ctxt->rsp = current_stack_pointer;
 
 	ctxt->cr0 = native_read_cr0();
 	ctxt->cr4 = native_read_cr4();
-- 
2.53.0


