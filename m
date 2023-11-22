Return-Path: <linux-hyperv+bounces-1026-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44A7F4DB3
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794EB1C20956
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78184C616;
	Wed, 22 Nov 2023 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cQ5qDyv2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ABB29F;
	Wed, 22 Nov 2023 09:01:46 -0800 (PST)
Received: from localhost.localdomain (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3567820B74C2;
	Wed, 22 Nov 2023 09:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3567820B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700672506;
	bh=9wgjWP/62NvaWRr+CGCSQIegQce2mbkL4aNWuVLLmPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQ5qDyv2Rah3MoXsEFMlU8EIn49kbZ5NPUGql50qiS7Za5mSWv8lv9Vss99FM6i+h
	 BvCUBCqrAoBSX8/lWTVA/wcDN6HGodpQUlCgVH79GAT+bnyrcQhs4ZjDiLXbodRKlb
	 FItHxXC4nnexkyPpElSU/phmqHSIgFxyBu6LjFRg=
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
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
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] x86/tdx: Provide stub tdx_accept_memory() for non-TDX configs
Date: Wed, 22 Nov 2023 18:01:06 +0100
Message-Id: <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_INTEL_TDX_GUEST is not defined but CONFIG_UNACCEPTED_MEMORY=y is,
the kernel fails to link with an undefined reference to tdx_accept_memory from
arch_accept_memory. Provide a stub for tdx_accept_memory to fix the build for
that configuration.

CONFIG_UNACCEPTED_MEMORY is also selected by CONFIG_AMD_MEM_ENCRYPT, and there
are stubs for snp_accept_memory for when it is not defined. Previously this did
not result in an error when CONFIG_INTEL_TDX_GUEST was not defined because the
branch that references tdx_accept_memory() was being discarded due to
DISABLE_TDX_GUEST being set.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/include/asm/shared/tdx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 7513b3bb69b7..58cdbaac3d5b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -91,7 +91,11 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+#ifdef CONFIG_INTEL_TDX_GUEST
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+#else
+static inline bool tdx_accept_memory(phys_addr_t start, phys_addr_t end) { return false; }
+#endif
 
 /*
  * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
-- 
2.39.2


