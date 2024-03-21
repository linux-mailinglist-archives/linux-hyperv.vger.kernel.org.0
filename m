Return-Path: <linux-hyperv+bounces-1804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08D88559D
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108E0B215E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6085820A;
	Thu, 21 Mar 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cpt04Lry"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3B2AF18;
	Thu, 21 Mar 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009446; cv=none; b=AMQkccvjbtLFlCKw+V8D8itpIUEGFcRMBaOxwxfBr3+8VZbOvQwP79aRS7Sys1CczkaxNug4vwlG7gBP5YLFgOTT0gMn/o+r4lmvezzlD5hgAkCVqu7XQw7kEDSsu+ydFfw04TRAnTUR53NLFipT2sZU9VLzDdHc9usJqfBnKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009446; c=relaxed/simple;
	bh=+BH1D9XwwG7TGc7KaVa6ZJNH37YfmEFhUPnxCApI7fs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qMYPaHkrzmhbCWXM4/g2vYpRkxOp+pXtMtjsMZF8xgbq9lv0i4u704u9NabMW9j7SjiY08ZurGILJdNDkAdvYzmMaICH3sB7bx/Y8xlfo0BPyi0rpYADPaMsRGzxaTcxb2htj1v2hUYz0FXQwjCEYJL9XjUDQlg3KHus9iHsEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cpt04Lry; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8DD9920B74C1; Thu, 21 Mar 2024 01:24:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DD9920B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711009443;
	bh=XMjNN1pkCPSeOdEAarp9KWhuQJ8O/sk+OMdl/nM1iQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=Cpt04Lryi9dMUY425YRABwxLGvNwraJUnawK3PjtA13q+v5YRZuNSL5u9mHNMINWr
	 fwv2btTiNiW6Otk4KbRo2IlkGbzXE9P3APluSELafT8zJSjunIhR8rVv0lMZuLDrJm
	 /j6JrAZC4Crt9NYUrqG97xevOoZb2pj8WEphzkJQ=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH] x86/hyperv: Cosmetic changes for hv_apic.c
Date: Thu, 21 Mar 2024 01:22:05 -0700
Message-Id: <1711009325-21894-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix issues reported by checkpatch.pl script for hv_apic.c file
- Alignment should match open parenthesis
- Remove unnecessary parenthesis

No functional changes intended.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
I'm resending this patch because I have missed some email aliases in my
previous mail.

 arch/x86/hyperv/hv_apic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5fc45543e955..0569f579338b 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -105,7 +105,7 @@ static bool cpu_is_self(int cpu)
  * IPI implementation on Hyper-V.
  */
 static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
-		bool exclude_self)
+			       bool exclude_self)
 {
 	struct hv_send_ipi_ex *ipi_arg;
 	unsigned long flags;
@@ -132,8 +132,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 
-		nr_bank = cpumask_to_vpset_skip(&(ipi_arg->vp_set), mask,
-				exclude_self ? cpu_is_self : NULL);
+		nr_bank = cpumask_to_vpset_skip(&ipi_arg->vp_set, mask,
+						exclude_self ? cpu_is_self : NULL);
 
 		/*
 		 * 'nr_bank <= 0' means some CPUs in cpumask can't be
@@ -147,7 +147,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	}
 
 	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
-			      ipi_arg, NULL);
+				     ipi_arg, NULL);
 
 ipi_mask_ex_done:
 	local_irq_restore(flags);
@@ -155,7 +155,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 }
 
 static bool __send_ipi_mask(const struct cpumask *mask, int vector,
-		bool exclude_self)
+			    bool exclude_self)
 {
 	int cur_cpu, vcpu, this_cpu = smp_processor_id();
 	struct hv_send_ipi ipi_arg;
@@ -181,7 +181,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 			return false;
 	}
 
-	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+	if (vector < HV_IPI_LOW_VECTOR || vector > HV_IPI_HIGH_VECTOR)
 		return false;
 
 	/*
@@ -218,7 +218,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	}
 
 	status = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
-				     ipi_arg.cpu_mask);
+					ipi_arg.cpu_mask);
 	return hv_result_success(status);
 
 do_ex_hypercall:
@@ -241,7 +241,7 @@ static bool __send_ipi_one(int cpu, int vector)
 			return false;
 	}
 
-	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+	if (vector < HV_IPI_LOW_VECTOR || vector > HV_IPI_HIGH_VECTOR)
 		return false;
 
 	if (vp >= 64)
-- 
2.34.1


