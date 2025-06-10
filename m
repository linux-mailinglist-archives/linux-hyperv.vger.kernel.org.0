Return-Path: <linux-hyperv+bounces-5839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21C3AD470C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BE6179F71
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7228C2A9;
	Tue, 10 Jun 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="auAOTSOH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4A2874EA;
	Tue, 10 Jun 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599531; cv=none; b=XuulgMe3azuRICadfT5tC0sWkbJIO1t+rz3UjZF95GgYqP7NxnDpypbdpvqyo3xSQyMewZNGJ/EjJgttso95zRchuly6mvvaiGpFmomRnmRi9eFZjxWV32WOmlxliej1CkG30FFCoJ5X9CDmeBegTjnAq/Uu3id5xwNX6oBk+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599531; c=relaxed/simple;
	bh=nGXl2PDQRQ/W58aqs8ixmweJeT81nC3/xaedzcip7ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L01T0L9xbzLfyG8YKRVvwPAJC2hfxoz+eiYnY9avWcaH6UefNBpP/HNyZvm4Ffh1UpHHOXTDVbNpobdNLEB0GcuR+31OokEBzsAqAsPh+iQf9IUe1H/+GSsR+0mygsU1AEN9TPpZ7OBNdyklvg017Oak13EaR1K9bRYHEm1Ga9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=auAOTSOH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 61C5A2115180; Tue, 10 Jun 2025 16:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61C5A2115180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749599529;
	bh=N7hVPdAAjB/xqyWhZ1EbQv9ByTMZgaoTVHsW9l2uYC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auAOTSOHG4T6VJOzF8nplNmsgLj+MnowWVh2+4m2n6/JHzQRe8VeIHSDhFgcbXzVn
	 n0m7GouL959m0GQ+FEhQ4NwcR5Rr8MPu3x6UalBb3+BujZ/b/fIs6t+HX0MH1QXHeB
	 0TpdWOu6HjQqjutygkhILaQ0asqVqixQz5M3V8rQ=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 2/4] Drivers: hv: Use nested hypercall for post message and signal event
Date: Tue, 10 Jun 2025 16:52:04 -0700
Message-Id: <1749599526-19963-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When running nested, these hypercalls must be sent to the L0 hypervisor
or vmbus will fail.

Add ARM64 stubs for the nested hypercall helpers to not break
compilation (nested is still only supported in x86).

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h | 10 ++++++++++
 drivers/hv/connection.c           |  3 +++
 drivers/hv/hv.c                   |  3 +++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d3134ab6..893d6a2e8dab 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -53,6 +53,16 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 	return hv_get_msr(reg);
 }
 
+static inline u64 hv_do_nested_hypercall(u64 control, void *input, void *output)
+{
+	return U64_MAX;
+}
+
+static inline u64 hv_do_fast_nested_hypercall8(u64 control, u64 input1)
+{
+	return U64_MAX;
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..992022bc770c 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -518,6 +518,9 @@ void vmbus_set_event(struct vmbus_channel *channel)
 					 channel->sig_event, 0);
 		else
 			WARN_ON_ONCE(1);
+	} else if (hv_nested) {
+		hv_do_fast_nested_hypercall8(HVCALL_SIGNAL_EVENT,
+					     channel->sig_event);
 	} else {
 		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
 	}
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..99b73e779bf0 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -84,6 +84,9 @@ int hv_post_message(union hv_connection_id connection_id,
 						   sizeof(*aligned_msg));
 		else
 			status = HV_STATUS_INVALID_PARAMETER;
+	} else if (hv_nested) {
+		status = hv_do_nested_hypercall(HVCALL_POST_MESSAGE,
+						aligned_msg, NULL);
 	} else {
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 					 aligned_msg, NULL);
-- 
2.34.1


