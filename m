Return-Path: <linux-hyperv+bounces-823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7AF7E6E67
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 17:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D3FB20A0A
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C901DDF2;
	Thu,  9 Nov 2023 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EbH0kTsK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB322308
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Nov 2023 16:15:12 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 632583588;
	Thu,  9 Nov 2023 08:15:03 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
	id 909A820B74C0; Thu,  9 Nov 2023 08:15:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 909A820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699546502;
	bh=TODuuixcRLtErqip8qybtbJ+d9Czo7e1uLIBPHVy8TQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EbH0kTsKFErwQ4gtiA3IOIQQBjpes92qMHSU1zZjXoJrLQs45sUfgAoQm8FsVgh31
	 xzpgR0xXT54AtG9TZrq49fL9GmkSzfFCEi4x0UxNxprEzSpmWgXxlb4WK2lY4ORMDW
	 UH54N3QvpvKuLxTaFSyLI4FohPfV/TRUVoFUAXPQ=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com,
	tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com,
	cascardo@canonical.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	kirill.shutemov@linux.intel.com,
	sashal@kernel.org
Subject: [PATCH] x86/mm: Check cc_vendor when printing memory encryption info
Date: Thu,  9 Nov 2023 08:14:49 -0800
Message-Id: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Check the value of cc_vendor to see if we're in an Intel TDX protected VM
instead of checking for the TDX_GUEST CPU feature. The rest of the function
already uses the abstractions available in cc_platform.h to check for
confidential computing features. For Intel, cc_vendor is set from
tdx_early_init() or hv_vtom_init(), so the new code correctly handles both
cases. The previous check relied on the Linux-controlled TDX_GUEST CPU feature
which is only set in tdx_early_init().

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..d3bd39aad8b6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -44,7 +44,7 @@ static void print_mem_encrypt_feature_info(void)
 {
 	pr_info("Memory Encryption Features active:");
 
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+	if (cc_vendor == CC_VENDOR_INTEL) {
 		pr_cont(" Intel TDX\n");
 		return;
 	}
-- 
2.39.2


