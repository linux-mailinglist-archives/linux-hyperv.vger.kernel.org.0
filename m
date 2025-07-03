Return-Path: <linux-hyperv+bounces-6097-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A9AF83BC
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314C74E3CFE
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B622C1788;
	Thu,  3 Jul 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EcAR4NuW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C782C159A;
	Thu,  3 Jul 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582693; cv=none; b=nAGibLLls/uX+YYciOPB1sf4DeueCtDPoTOGVbQETaT09RgDycMn4A7sOcTrRHtL/s+wUiz5UJ0wWHChU6Hxmaue0Wz+VkBUNBtc1ObBCfP8biyJ4lUSw8ttStmN0NSPi18GHKJQovTJ+d/Eq4W69kZuB9Ox0ejOMWuYVDU0p5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582693; c=relaxed/simple;
	bh=Xkcr7RGizw2oQjQ1SwC5idPHGqWiAMXaJ1ege7+PEGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pAdFFBbRcwhrzqaU5xqTP/true8b+KjA/zbGEyAXm9/641AaB3TNxuXDDZ1QB3NkmrnbvOKKvVURHGldRajdOxlNhPbJlm5DSPZoXYry+7DElx0bXrVLd2mlZlaTlb/EYzxSgP0EKnNEzs9nVTbqF4SMlucXtf388W3rP9jo+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EcAR4NuW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id AA101211518E; Thu,  3 Jul 2025 15:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA101211518E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582691;
	bh=ejh03XwHi8XDCLlghgIiwbsg6jskRGIuuAKzLCeBRKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcAR4NuW3QI7k24XLVV+tA58bvaDDeUsu+DP5/F/nMID4kNfofCnY9JTEX3afeRtb
	 fN+6khLyaXxQOH8SJzOGvfGJIYM44Y5Xa7kWUFGc08ixcQM1WDHvL6cSwUwpBJN+L1
	 XGTiHzx0djTqDp1u58VqI9EB9xOs265BfVK9Qseg=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
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
Subject: [PATCH v2 2/6] Drivers: hv: Use nested hypercall for post message and signal event
Date: Thu,  3 Jul 2025 15:44:33 -0700
Message-Id: <1751582677-30930-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
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
 drivers/hv/connection.c         |  7 +++++--
 drivers/hv/hv.c                 |  6 ++++--
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5ec92e3e2e37..e00a8431ef8e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -111,12 +111,6 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
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
@@ -164,13 +158,6 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
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
@@ -222,13 +209,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
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
index be490c598785..47c93cee1ef6 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -518,8 +518,11 @@ void vmbus_set_event(struct vmbus_channel *channel)
 					 channel->sig_event, 0);
 		else
 			WARN_ON_ONCE(1);
-	} else {
-		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
+	} else if (hv_nested) {
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


