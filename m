Return-Path: <linux-hyperv+bounces-6581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1888B3360E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98ED179C27
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211002797B8;
	Mon, 25 Aug 2025 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ssQfsSnY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE69253956;
	Mon, 25 Aug 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101143; cv=none; b=qncYH0KKXHVv26yGtIEpdccNLQCSpp3wJcHcl0QQKszQaWkEU6tuguKclpzr5gwftcUCkZfJYzyx9JgdDsYKNlEMshKzJErCT784Tg/609HNYs91vWk4Cc7gnlmU6QoJq1sphH/Shfy1G1ZJod5V+G76YOfp9yoz2oFovlKMmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101143; c=relaxed/simple;
	bh=C1mhFW4EtqItRh2JEAtWzKMW9KSimWDCbUejPFlijj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NolweSSyFTksA/uP4XW7Ixf1FqoIjRB9oWpWkVBvUv1Oc+/32dOhZtqvRbr2syUQV1GTCmPGxNxAs2xKUhEVFG9Bzqv1oVkWJs0V3rgWLRP0aq/R1qOCx4iiuD6PKfb3ciIhfaH0txZgrvoou9h+iRlqAWUGejfM0TgkD1Bo8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ssQfsSnY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F0B32117594;
	Sun, 24 Aug 2025 22:52:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F0B32117594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756101140;
	bh=GqNVmV4kZeRKOSH4HZ31Q5GlpTvvo6nFonJGSLPaQmo=;
	h=From:To:Cc:Subject:Date:From;
	b=ssQfsSnYEWgGmEtPvOBcGSp8D0qIvo1cgVDOy91x5ns3tPTguvGPPIP639eFUpuRt
	 SmQ8d3uxSXK3qFvSINCnYsi0O/tI/FK7efo61tmMJcY3ZO7HmYDa5nKOuIzkyH59Oq
	 wbrEa/VW/HIv+nYSvz+rXuyOVDFrVlLj5Uuj9qlI=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Date: Mon, 25 Aug 2025 11:22:08 +0530
Message-Id: <20250825055208.238729-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
config checks were added to conditionally restrict export
of hv_hypercall_pg symbol at the same time when a usage of that symbol
was added in mshv_vtl_main.c driver. This results in missing symbol
warning when mshv_vtl_main is compiled. Change the logic to
export it unconditionally.

Fixes: 96a1d2495c2f ("Drivers: hv: Introduce mshv_vtl driver")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Omitted cc:stable tag, since mshv_vtl_main changes have not yet
landed in stable/rc kernels. I can add if required.
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 896e2913bc41..0ba9cae9ffaf 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -36,6 +36,7 @@
 #include <linux/export.h>
 
 void *hv_hypercall_pg;
+EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
 #ifdef CONFIG_X86_64
 static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
@@ -73,7 +74,6 @@ static inline void hv_set_hypercall_pg(void *ptr)
 {
 	hv_hypercall_pg = ptr;
 }
-EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 #endif
 
 union hv_ghcb * __percpu *hv_ghcb_pg;
-- 
2.34.1


