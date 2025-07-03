Return-Path: <linux-hyperv+bounces-6098-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B853AF83BD
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC391CA08E6
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A12C3256;
	Thu,  3 Jul 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fk13oTkk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F592C15AA;
	Thu,  3 Jul 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582693; cv=none; b=D2GQksxQXeWk06nlw0U6HeJpVNlvOsDOMQ/KJRF+AXIVsYt4mBAH3qkRGja1ayiiqk3cCi78VAnwAexsYDc8oMT936v51K4WTPfkHzkHxm7ZzSm+5zj2WuzqFhpYsANT5jAykhgIzvzJtLsiTUjBojOHFNHietyjFKqLdbgg1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582693; c=relaxed/simple;
	bh=yo0RQYo8djmodDk2+1PRbRm10T8lvoiziD52WnSRHxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IRcmBLg63Id3gMzvj8NcJBN7rg4/pfTZmGHBCyJq3iT+1f76+cWlR4mN3aKBHcMi1MHQE0XW/AZB72KEHbdc7v0guNosNqeDleoLvw2ESXGED8KVSfGuC9Mt4Z5HpI4l+xZxT7CEVkKj+ri8vQlacaxswBTkGd0K8Ghn7oMh9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fk13oTkk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 401B42115189; Thu,  3 Jul 2025 15:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 401B42115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582692;
	bh=3VpgfDJQYn3ffptUBCYFWibfHui5iQWzNjqFNfpXPDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fk13oTkk6sLk/wXss1sCA9KIc1jX7QUcJ5Kf1vlJ5/S3GMj0FJ73jyjVUk1umEPBK
	 6f/RJ2kF6G3t5sKo7HgO2MbFN06RVUW+N0QG0oPXm6weBw39VP99+2q33kPEuhuGVX
	 UtuwKPrpaceUxwECyhLW/ECvqtOyBbgOTODjkSoE=
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
Subject: [PATCH v2 3/6] x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
Date: Thu,  3 Jul 2025 15:44:34 -0700
Message-Id: <1751582677-30930-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Accessing cpu_online_mask here is problematic because the cpus read lock
is not held in this context.

However, cpu_online_mask isn't needed here since the effective affinity
mask is guaranteed to be valid in this callback. So, just use
cpumask_first() to get the cpu instead of ANDing it with cpus_online_mask
unnecessarily.

Fixes: e39397d1fd68 ("x86/hyperv: implement an MSI domain for root partition")
Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e..e28c317ac9e8 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -192,7 +192,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct pci_dev *dev;
 	struct hv_interrupt_entry out_entry, *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	const cpumask_t *affinity;
 	int cpu;
 	u64 status;
 
@@ -204,8 +203,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	affinity = irq_data_get_effective_affinity_mask(data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	if (data->chip_data) {
 		/*
-- 
2.34.1


