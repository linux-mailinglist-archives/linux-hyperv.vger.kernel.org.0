Return-Path: <linux-hyperv+bounces-1769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB687E921
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 13:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A936A1F22002
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519D37702;
	Mon, 18 Mar 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qIl1DF1h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D0537700
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Mar 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763758; cv=none; b=hM+juH4P6oe4myfYjIQsrz0BlNVK+X40nzYyr7kBg88DHCLX43dZwMKSFJeAcwjctpYCAu0BuKD6ar6T367FCL67yjoenaIXA2h/UyiJL34ecD5qNh03TtJWzGUPxgeX624crTWBTMxwXcZOKQKiYPB7aIcRdOpUxJq1lvYiEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763758; c=relaxed/simple;
	bh=wur0Y4109JJ+MMQ0bBi2Qc+tjT+TaIa62NGP55Wa/+4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OFXkEt1sShXFo6nmUtv6kvQrY5PP9SrbSHX/iGWsE2adRxSteBZLvY2JtYVYdzoPP7MxrJfkbASiDODJijXl707NaNOqB/UwAGxes8iTOv5YKP8Fw8pZKX44XyDDSPdgAq7oWhOQP7D54gIhw1+5AcZVj8td80n/TwWvOlpxfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qIl1DF1h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1190)
	id 8705C20B74C0; Mon, 18 Mar 2024 05:09:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8705C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710763754;
	bh=IA678C0lXukTk4coezVicdaTil4DJLcxj1LeLAHikDU=;
	h=From:To:Cc:Subject:Date:From;
	b=qIl1DF1hsd2ORQ9MHfx+f8uWxCCMJDXjJOQ6jVwPy9NKk4ePGyQRHbfZSrD+8xccV
	 1/J0l2RqivbtISQFvObr1oO+XbEg2FLc2sGBQXoZ5IGik+l2tJdhNy+ZGLnZlAac5S
	 WoDUzTNeeFNeDOF2dJNjeStiWsJWGj+xpwyYF6Ag=
From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org
Cc: paekkaladevi@microsoft.com,
	Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Subject: [PATCH] x86/hyperv: Cosmetic changes for hv_spinlock.c
Date: Mon, 18 Mar 2024 05:09:11 -0700
Message-Id: <1710763751-14137-1-git-send-email-paekkaladevi@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix issues reported by checkpatch.pl script for hv_spinlock.c file.
- Place __initdata after variable name
- Add missing blank line after enum declaration

No functional chagnes intended.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
---
 arch/x86/hyperv/hv_spinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 737d6f7a6155..151e851bef09 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -16,7 +16,7 @@
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 
-static bool __initdata hv_pvspin = true;
+static bool hv_pvspin __initdata = true;
 
 static void hv_qlock_kick(int cpu)
 {
@@ -64,6 +64,7 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
 {
 	return false;
 }
+
 PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
 
 void __init hv_init_spinlocks(void)
-- 
2.34.1


