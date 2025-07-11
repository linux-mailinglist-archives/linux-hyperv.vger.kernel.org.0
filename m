Return-Path: <linux-hyperv+bounces-6193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BBAB02468
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA917B033
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7441DF751;
	Fri, 11 Jul 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BcKyRt95"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6C1D63E8;
	Fri, 11 Jul 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261542; cv=none; b=AVz43Qi5hM/lYhtMUvqswttfy7pZZJJMr0szclVhzlOkWNl9hJ7IJIBG3lFgoTwLO5ZeqRVMFvipr2pyI5ZUD/jrPoxLAUqR/Hj9lxNgFpvwumIeequ7lVXRTKLLbM0ZIvGIDVrUUC3913HnJ7fEfm1lQ9JUdGz9nA2thIbWbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261542; c=relaxed/simple;
	bh=J5kuogw9IQfPgbT4RfUmgOjGf7U9ruaXcd4WAnF06BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NAx5YfQwSvHqPiOa71yYSuaO8AdNfQVJV5ALUQZZuXp5l6y3HyNESvYwAjcxgkfW/1m5FXfHJm6Qc8Dcd/erdlM2fWrQfnpmjLZsCyD2Xv6JvV202K0JtJpUgSyCr7pBT/ClC+HoWw4rjUUzm/RrSFq/2YJj9x4V9yt2T2ZnKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BcKyRt95; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 955732115802; Fri, 11 Jul 2025 12:18:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 955732115802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752261535;
	bh=UMFPZ8IrMjqiIE9bHcG8tr3UGU/I4RiiuVq8nzCqZJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcKyRt95LY91swi1TdKcoT+mfHyF8tYy50XkcwH3KV167LODNbEpbYPioy6kFWxCO
	 dF+ZYckPR0PiLgpf/y5W1z7ynyZJ3RLJDs1ZQ32UnXd3dI/ndJe/RFCCgk2J9ThxGg
	 69MVy8hY5lgivpclVpsy5xpMjZp+LNQPaEVhusq8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 1/3] Drivers: hv: Use nested hypercall for post message and signal event
Date: Fri, 11 Jul 2025 12:18:50 -0700
Message-Id: <1752261532-7225-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When running nested, these hypercalls must be sent to the L0 hypervisor
or VMBus will fail.

Remove hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
altogether and open-code these cases, since there are only 2 and all
they do is add the nested bit.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 20 --------------------
 drivers/hv/connection.c         |  5 ++++-
 drivers/hv/hv.c                 |  6 ++++--
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index e1752ba47e67..ab097a3a8b75 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -112,12 +112,6 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	return hv_status;
 }
 
-/* Hypercall to the L0 hypervisor */
-static inline u64 hv_do_nested_hypercall(u64 control, void *input, void *output)
-{
-	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
-}
-
 /* Fast hypercall with 8 bytes of input and no output */
 static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 {
@@ -165,13 +159,6 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 	return _hv_do_fast_hypercall8(control, input1);
 }
 
-static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
-{
-	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
-
-	return _hv_do_fast_hypercall8(control, input1);
-}
-
 /* Fast hypercall with 16 bytes of input */
 static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 {
@@ -223,13 +210,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	return _hv_do_fast_hypercall16(control, input1, input2);
 }
 
-static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u64 input2)
-{
-	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
-
-	return _hv_do_fast_hypercall16(control, input1, input2);
-}
-
 extern struct hv_vp_assist_page **hv_vp_assist_page;
 
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..1fe3573ae52a 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -519,7 +519,10 @@ void vmbus_set_event(struct vmbus_channel *channel)
 		else
 			WARN_ON_ONCE(1);
 	} else {
-		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
+		u64 control = HVCALL_SIGNAL_EVENT;
+
+		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
+		hv_do_fast_hypercall8(control, channel->sig_event);
 	}
 }
 EXPORT_SYMBOL_GPL(vmbus_set_event);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..b14c5f9e0ef2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -85,8 +85,10 @@ int hv_post_message(union hv_connection_id connection_id,
 		else
 			status = HV_STATUS_INVALID_PARAMETER;
 	} else {
-		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
-					 aligned_msg, NULL);
+		u64 control = HVCALL_POST_MESSAGE;
+
+		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
+		status = hv_do_hypercall(control, aligned_msg, NULL);
 	}
 
 	local_irq_restore(flags);
-- 
2.34.1


