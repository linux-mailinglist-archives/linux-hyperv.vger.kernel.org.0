Return-Path: <linux-hyperv+bounces-7543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D16C55AC7
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 05:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED13E349668
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BFD2FF147;
	Thu, 13 Nov 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="loxMAWcz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B31917F0;
	Thu, 13 Nov 2025 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008935; cv=none; b=pNHAZflefYqzPl+C+jFUiVk/gGd3BKI+SKvpRYdObd4NBPZ7fXOOruLBuSlJX3GgK9VrG6pf0aeRmO36zRLDe3lAnLRy3T3ZPCZtryVST1IejBWrinavi0vH7GvmdcVmW18QoXTLii79ozZ85KcPuPfMOD5l4+VuqJB4T1rWsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008935; c=relaxed/simple;
	bh=zb9ctwwC3vJcUTeCQetdrK8Z4hDHpHZHrnpRCACTCPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmpTikNHRFYuWO3ooyvIPR7nxC5jQfDTM/lMZPyJfuliwC50VuC58C8QIGbmVy3vyABmFWesC6S7Jo6gyvG3Gl3nfX8z8TB4y6RuHjq+Cq6T+tgohanDzQSTB1i8W3tkRTrOq0KJqw3C8DrW8YdF0gSO5N15cCMb06OvbKcYF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=loxMAWcz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-1AYIP.redmond.corp.microsoft.com (unknown [4.213.232.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 795D72013368;
	Wed, 12 Nov 2025 20:42:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 795D72013368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763008933;
	bh=JqciPxRzBkt61liiMOa1OS2vxRfLzlC77SqEfbDb2oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loxMAWczoRWyFlEd/m/WHVdqhR1P68pCDbtvBnCJDXjGgujKinQ95rZ/Xkka5EG7s
	 brIhLGOZvnPrRUldG4mR1GAgZmk8vPH1c+L1FKYoFOJbrUbcK8o6Z88Po+fN7iT9J8
	 42zrTzGuCVyuBs9srzhO8HRbrgYzjhUlPc2Oftl8=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Naman Jain <namjain@linux.microsoft.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH v12 1/3] static_call: allow using STATIC_CALL_TRAMP_STR() from assembly
Date: Thu, 13 Nov 2025 04:41:47 +0000
Message-ID: <20251113044149.3710877-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113044149.3710877-1-namjain@linux.microsoft.com>
References: <20251113044149.3710877-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

STATIC_CALL_TRAMP_STR() could not be used from .S files because
static_call_types.h was not safe to include in assembly as it pulled in C
types/constructs that are unavailable under __ASSEMBLY__.
Make the header assembly-friendly by adding __ASSEMBLY__ checks and
providing only the minimal definitions needed for assembly, so that it
can be safely included by .S code. This enables emitting the static call
trampoline symbol name via STATIC_CALL_TRAMP_STR() directly in assembly
sources, to be used with 'call' instruction. Also, move a certain
definitions out of __ASSEMBLY__ checks in compiler_types.h to meet
the dependencies.

No functional change for C compilation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 include/linux/compiler_types.h          | 8 ++++----
 include/linux/static_call_types.h       | 4 ++++
 tools/include/linux/static_call_types.h | 4 ++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0a1b9598940d..c46855162a8a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -11,6 +11,10 @@
 #define __has_builtin(x) (0)
 #endif
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a, b) a##b
+#define __PASTE(a, b) ___PASTE(a, b)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -79,10 +83,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a,b) a##b
-#define __PASTE(a,b) ___PASTE(a,b)
-
 #ifdef __KERNEL__
 
 /* Attributes */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..cfb6ddeb292b 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -25,6 +25,8 @@
 #define STATIC_CALL_SITE_INIT 2UL	/* init section */
 #define STATIC_CALL_SITE_FLAGS 3UL
 
+#ifndef __ASSEMBLY__
+
 /*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
@@ -100,4 +102,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 5a00b8b2cf9f..cfb6ddeb292b 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -25,6 +25,8 @@
 #define STATIC_CALL_SITE_INIT 2UL	/* init section */
 #define STATIC_CALL_SITE_FLAGS 3UL
 
+#ifndef __ASSEMBLY__
+
 /*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
@@ -100,4 +102,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _STATIC_CALL_TYPES_H */
-- 
2.43.0


