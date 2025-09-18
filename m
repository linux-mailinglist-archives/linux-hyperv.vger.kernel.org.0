Return-Path: <linux-hyperv+bounces-6940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B7B856D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361A87C6E1F
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3ED23AB81;
	Thu, 18 Sep 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4yV3ogY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33819DF4F
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Sep 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207669; cv=none; b=dL2yzTCHVmURr/H5L/GYLaGBDDXE8sFilrBY3SfSmLdjsocAFdJdj+dGDPeF5rip0niDmBGYB6WQKKPUhGDnazU+QNRQc4EEw++tbOaeAC5T1hxFk04M6nlA2GvxSZ6KgC6GRps4vTK2GGD10yEvu5au7gDfH4e8dZh2/74HVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207669; c=relaxed/simple;
	bh=BomCHCyONkZvBHRX7fF/vadDHImLxvWcM85cE0w357Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERDspn9HBirJ5dNKdrmtj3DC8RIE6h3nXPg11zplX7BSUZ+KGCpdOhVTDNnCzB8OPrH2b4M04eEE9RRP992OB7dvK+dMGE6/aUbJmixUEJFkzEs7wqzntmppsRx707+lGjWWl0jWcVkWQzLHrnkZRA24fNYxx+s1uKY7gUPCDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4yV3ogY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so589418a12.3
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Sep 2025 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207667; x=1758812467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DenQSoys7kFN1y2c+XZsOBbsB+gNsAG+pNB/ZQfFlnk=;
        b=V4yV3ogYSdOIJqwLNPxarnD0xpA1bdYwMk6kmWOGiKzYFXd6GGBTZy5ua+M2aoTJyZ
         XFOJLo6/WkBANTEMuWqUmssFqulrsIEZ10K6YxRRxYnKHr5RnTY++eIJdc/UQQXHAwFI
         QZdL1lTrDUd/CPWDIJEmzumqeKMEua5g31qCUpBZ2pcugQGTi/TWZL/ddv8rthnONgLq
         ECWxntgKvdPXZfxNrboHQpVjb0XRn4AsJmlnN73RouPEvdFy7qmTpDJ5lMoeGmZNWLSQ
         pZbeNALOLht/z9c8QEjv4UJKoIhqQ0cPdQF/WQUz15TqyqX6vJ3RiuB4HZ79hoIm3/Dm
         onEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207667; x=1758812467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DenQSoys7kFN1y2c+XZsOBbsB+gNsAG+pNB/ZQfFlnk=;
        b=c5Qpiz5duVM6vkNpR1ervPpFJH5ijBvSwSEwP2Bx5fs+2md84yIp15SgbrlZVdysE4
         AsL0PXeQmtimQ7fM33M/sxmCsRYpn3+3g+OzTSX7GZ1lNA4/yxNnlZwWa1npfdE+AZKD
         SjXYMOmBQgAkhEkcnwK0cJCkp3vsS/J3MBOuoTVJqLxij7d5CsEM9tyZtsHm+aFy0EB2
         p2iYRbOOWmV/HwQKALLJlvAJdWpokBiO8LuYmBFKQ9XStdXR5UV9ojBs8+T2F4ZBn7ja
         k2wEmxMzn9pKPND0Ib0VhB6Gmu1jn8N4bqvGoIETBN+OUY/UUD7MYIAV3BvimqOfv6Ja
         TqEA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DVGwbX0eTRJdtp+8kpvrN/2tlYEpoZ6oFZVqoHYjKaS1dcoHBSz1Tmgs82ZuTsiqNrEDdM0xN8scXbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7syG7/zMla1DJXDqg7vz0wVMU8pUwe+8p7EnooBJKJvk5oJr
	VPhqUTfzmEgWbzNL0Fv292lBsKn2iHlNeFMRj5GvTesCjIN3FaseKofz
X-Gm-Gg: ASbGncsvkqHrdkd8tZ1L4VCDFOvXeLyRLBQNPVCT0uSxJqshlPH3+vvEAxXAt3V1HKX
	IhGUwzbJMC8uhbzKvvF51Ybg4T2OZ9UHFH7AslIDnD++JvkZw2Au0fydMfw6WcGrzT8Q2JwNbM2
	10cUv8q4zyxeNfQRm4ag7Qz+oUZaMnLC7C1c4WZ4dm9z7q9d50+QYstOaR8AmiTFlMcIh5vn9xz
	tmZMK9PPIK9XXssYaJxR5FcSF4RIosLg8brBbWTO12Qy5crC4Dy3v8C7FSzGTJqGrp2qPHmwQCz
	iFUNqkvX5TX2TOs3dHIkphb6b3zdTOpGscCL8I92MIm8OfNTmt7IF+wHBBK00QOVgmujRH+eUag
	9+iJ8yBy2s/7cPuDQLLETzRcfuHfiF+wRhOhALTw0f1dJsrDFMU5ONuxLGq7b0MtrnsCIariVDg
	Gb
X-Google-Smtp-Source: AGHT+IE54DeGcjfuPrZxTsO8vNoW4uR5ohID4013e2OR7rn5+mNz+y3PAtrWVyE5FJja8m2BaQ/5oA==
X-Received: by 2002:a17:902:d2ca:b0:264:5c06:4d7b with SMTP id d9443c01a7336-26813903208mr75482905ad.32.1758207666525;
        Thu, 18 Sep 2025 08:01:06 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
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
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 2/5] drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Thu, 18 Sep 2025 11:00:20 -0400
Message-Id: <20250918150023.474021-3-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Secure AVIC is enabled, VMBus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject VMBus message interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c      | 5 +++++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e669053b637d..a8de503def37 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	wrmsrq(HV_X64_MSR_ICR, reg_val);
 }
 
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+	apic_update_vector(cpu, vector, set);
+}
+
 static u32 hv_apic_read(u32 reg)
 {
 	u32 reg_val, hi;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b14c5f9e0ef2..ec5d10839e0f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -307,6 +307,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	}
 
 	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
@@ -350,6 +351,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
 
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	/*
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..0f024ab3d360 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set)
+{
+}
+EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..7907c9878369 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1


