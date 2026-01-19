Return-Path: <linux-hyperv+bounces-8365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F06D3AFD1
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EDC430055A8
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BEB38E118;
	Mon, 19 Jan 2026 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjmeC9q7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159C38E10D
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Jan 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838387; cv=none; b=dEzxbZ/w5YxP/37WNskeFYOcy/bf1Ec/fLHoSSGK5g0qHJx6MV2KJaqXrY6PDQM1mqjfBZ+NlAfwLImmK0d48+iDrAtuo2Kkbhby5QVqRcw3fOmCa3hfGC6rHjtoK66S1MrQxhH0+66xekxxL0QyIFG55JtlY29f4eXmfiuaA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838387; c=relaxed/simple;
	bh=ul1iBwV17n5WsyCmr/KCxFbChBqQIKDCJp2OvGvZe/g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Bi4/hRRMpZwmIKgRFO4AvQactIIgTcGrX0eXEuAodjbhEcnjgqXnCLFkzPoKFW+iQaY1FWWI4rSlm4ljHFnDhuwu+Y2lGT73nxRKMdAalbxqNr3PnrEIlNNzVmxfwzQ1n4DlXlBpdVf6ZnGzsjyBULyFcZcecKjvWy3KjyMjoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjmeC9q7; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so2595985b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Jan 2026 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768838386; x=1769443186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MU79p+y/0COiaT48U0qEL3YPxlYifFAsQFE8p7qpyKQ=;
        b=BjmeC9q7twZiQpjxIyHxpywnCiMhpTSQbvOmLJ4oKtje5OtEg5R5Cgc6SdaU+kYxsy
         JaurHCTsldWBbRkgG1Psz/xRhgLq40EHGnafUe18pj0SNQlgyY9H18UyoFtYbUEvGUs2
         +NM0MoVQlYogvzKO+xA89KThEj2bCQPeg+s0ruh3RLNAivWOJwCM1Cm6WMGjypErs1KP
         GBp6gShRMn46i3RjeBxg/Khjsbs7tmPPZjmSWsFW8zCmZpoI+vTeN4Txm0ZouIH1o5gR
         isMhYtbW5qHpH7jkJgNwcKkH9uEh114NIkwjusTItToRIaHbMROB7M70g+ZTZooEbl60
         EVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838386; x=1769443186;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU79p+y/0COiaT48U0qEL3YPxlYifFAsQFE8p7qpyKQ=;
        b=Xx38UTkPP3S5wC4Wv0wqSQ4P++QNX004trHr1UVEmSOQY1Xwrh1e6SDgPTgULYLQ5U
         epoIp60hhLRBsK3XZiJ6jhdy5HqEZSHdFQVfYAEoGXawDk2nhV6Gj426fMKFYu+JsOFy
         aQquSIa2/AkGKan8djkMthVhfq4J79oPwaJy+J8Og5P7EBjAbR2MivDpSqdEiyvI+ZR0
         d1bihwAx1XUiZnY3gFBrZTsJU3POC8d9RNl37fOFxXMr4UqFwScFve6USx9nzIOIKf1l
         Qe5SpJvLiYkFnVuwyBXp0tVCj4gCpMIMFmvtRmeG0yrX6F2lt0vWrvGvSgVLCjQjBddM
         Wddg==
X-Forwarded-Encrypted: i=1; AJvYcCWsDrBOgninWZdPpk0D04+Sae09GiGeCbyZ/6hBydh62vdGxWyZnSEgvoPVMLDxlStkp8gsD9ken17oG3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkCpD+iW35CKHrd6/tg4eXO9oNFs92jkdmsMXkF9zzILGRKN7
	fC95xgaGA+M+ZEgrvLdl0HHKuM3The6CE1KTnwXFvo592d9uu7h+hD4y
X-Gm-Gg: AY/fxX6urTQSEmJRogYwIlaOg2hLqYnho8rAEYute1ews/3eITJxCxCuzhLQ5jGhIN6
	kYxhhIg8C74J4PA7dYvSTsVn89mE0szjS3cTYgtm4ruM7Xi50DV4krIr08EQac1+ph+O8BxRi8u
	85q8ivfNyDezErMqzc2XJgc3e3WWz0CshuQiobGd+7BYLzLh4NoAwwRmxjin3gvif7sysoFP1ve
	NkOMl4nogBAOI3vDYGJkmtzdboNiqDBHWz/QFnAlmQQBPivS+TCp0i8vnmz0TjTqQ8N8xsZF8OA
	+gdEc13f2vIUQiQR5JFPBm/KwZZw0LqYAVpvxSzcNr/sGhPPcFEh3/eqo5+dqVy49A10P7ekTs1
	nONTOpOyYl/HycUzTMO93XNgcboUlXnbKIsQX+0HjtF3Bo86G+R2nr26sPKkSNIy3cLd58/f3Ua
	8b8TcbMgUicA65i7gFmXQX+naURx+LcvFHgPNn413gO7yzcIOvVoiFnZ26gdmtRDdfTA==
X-Received: by 2002:a05:6a21:d8a:b0:342:2a1b:870f with SMTP id adf61e73a8af0-38dff368227mr9950468637.20.1768838385667;
        Mon, 19 Jan 2026 07:59:45 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf3791e5sm8120403a12.31.2026.01.19.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:59:45 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Use memremap()/memunmap() instead of ioremap_cache()/iounmap()
Date: Mon, 19 Jan 2026 07:59:37 -0800
Message-Id: <20260119155937.46203-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

When running with a paravisor and SEV-SNP, the GHCB page is provided
by the paravisor instead of being allocated by Linux. The provided page
is normal memory, but is outside of the physical address space seen by
Linux. As such it cannot be accessed via the kernel's direct map, and
must be explicitly mapped to a kernel virtual address.

Current code uses ioremap_cache() and iounmap() to map and unmap the page.
These functions are for use on I/O address space that may not behave as
normal memory, so they generate or expect addresses with the __iomem
attribute. For normal memory, the preferred functions are memremap() and
memunmap(), which operate similarly but without __iomem.

At the time of the original work on CoCo VMs on Hyper-V, memremap() did not
support creating a decrypted mapping, so ioremap_cache() was used instead,
since I/O address space is always mapped decrypted. memremap() has since
been enhanced to allow decrypted mappings, so replace ioremap_cache() with
memremap() when mapping the GHCB page. Similarly, replace iounmap() with
memunmap(). As a side benefit, the replacement cleans up 'sparse' warnings
about __iomem mismatches.

The replacement is done to use the correct functions as long-term goodness
and to clean up the sparse warnings. No runtime bugs are fixed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311111925.iPGGJik4-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 14de43f4bc6c..ca992ca6394c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -103,9 +103,9 @@ static int hyperv_init_ghcb(void)
 	 */
 	rdmsrq(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
 
-	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+	/* Mask out vTOM bit and map as decrypted */
 	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
-	ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!ghcb_va)
 		return -ENOMEM;
 
@@ -277,7 +277,7 @@ static int hv_cpu_die(unsigned int cpu)
 	if (hv_ghcb_pg) {
 		ghcb_va = (void **)this_cpu_ptr(hv_ghcb_pg);
 		if (*ghcb_va)
-			iounmap(*ghcb_va);
+			memunmap(*ghcb_va);
 		*ghcb_va = NULL;
 	}
 
-- 
2.25.1


