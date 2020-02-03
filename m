Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3E150112
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 06:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgBCFDY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 00:03:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40239 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBCFDY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 00:03:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so10480588qto.7;
        Sun, 02 Feb 2020 21:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYlLiIyZ6xtWSqRHGwj68GlwyY+LYYPTXp6jcsCn+f4=;
        b=IrF2YhevpTkVJpyh9y4p2B/CLmvflLLrQnU0pce24ImrE6OdK3eSj6cpzNhLpjRf2G
         uoBW7ahXPhYIokI+kUKf+oRdBvCUOjBCrOPeWaUuCwZXupGVDfeA4OHHmB3A/DQQZoTd
         UWcI+LCOhWIjJEcCbRJN55mOq6tDb94gd4hwD/dbr2WJjJ0O6If6mO4iavPbMVEerk9v
         0tKpECNgOFcqQfdmIgD2N1i3KDDPKFO7j0mIyaLF4JTg24ztcFrkQ+s7z0c9PeaQSB6c
         mIgt+rf3lA7kUJZmDfp4MpROaIF7U7pjSeOtqxYsAhXP+v2eMNqVudyZ66yIAzNdVX0z
         jSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYlLiIyZ6xtWSqRHGwj68GlwyY+LYYPTXp6jcsCn+f4=;
        b=sNLu3dTVyLpebcQbcEBv6jC4shGuonbiZkidVP9G+Ze3HR29D5KRudVn40R5MRw1Nm
         3U0jOFkJut1ImnQ2dGQOcb7PsOYoTv1Jgrl20euzxg4xrTqD6Oht3hBgRl/VOdvRM5Fo
         7eoZB/6/PVUFfKESTbJ+sHG6e2elWYKYavWEGstTEYd+cAhoLKuR35guRYfClrHT5CNJ
         KTo6AokJT6GlPoipKI+xGubbKFyCTSAk1PS50eBk+SXvtsdZdtqIkiej3/rrlYiuptmr
         hwil+QltCPeGaHH/0CYNJO7f+qEXENdCjCPAKNCtM62nkl6YUz1IpTUMrRiWgtpzZY3b
         00Rg==
X-Gm-Message-State: APjAAAXf/XEtDlcYDVAXPVwDjYdXph1RHGy/CQSy6PbeqjLapaubdpZc
        ylx/MOBJobMCKe2zLY3l3KQ=
X-Google-Smtp-Source: APXvYqw/JSotvpKLRqau3UsOI7GqVAKcDFDEyfckUo5K3AA2BM1FkGqlALOh4m1g+OgHRDNXjnNEuQ==
X-Received: by 2002:ac8:704:: with SMTP id g4mr22114298qth.197.1580706202773;
        Sun, 02 Feb 2020 21:03:22 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 135sm8837749qkl.68.2020.02.02.21.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 21:03:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8519F21F40;
        Mon,  3 Feb 2020 00:03:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 00:03:21 -0500
X-ME-Sender: <xms:mak3XgcyHJ-FHN-KXqn1rRMZozZQhbcbhS4odZa_FiDy0dgtsuaagw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecu
    kfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mak3XmeMjOUEtH951eeh_F7aXNvylSBWXjUOU5gqI2r8pK0wvZ2nuw>
    <xmx:mak3Xsg-m4WVDsGDpSijgBbaG4zQ3DoVs2J40RPkF_zCBE1YTnuSLw>
    <xmx:mak3XqR04Lzl0uXzimXsvU6X1YY1xvR01w_vDzkG0uc9GVT4xIbYUA>
    <xmx:mak3XtmTvx3hcCSM359e_5-vI5d4QRCnq4OJ4FxpNJXjLJV9UQoIm6iEzFk>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01AFD3060134;
        Mon,  3 Feb 2020 00:03:20 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 2/3] PCI: hv: Move retarget related structures into tlfs header
Date:   Mon,  3 Feb 2020 13:03:12 +0800
Message-Id: <20200203050313.69247-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203050313.69247-1-boqun.feng@gmail.com>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, retarget_msi_interrupt and other structures it relys on are
defined in pci-hyperv.c. However, those structures are actually defined
in Hypervisor Top-Level Functional Specification [1] and may be
different in sizes of fields or layout from architecture to
architecture. Therefore, this patch moves those definitions into x86's
tlfs header file to support virtual PCI on non-x86 architectures in the
future.

Besides, while I'm at it, rename retarget_msi_interrupt to
hv_retarget_msi_interrupt for the consistent name convention, also
mirroring the name in TLFS.

[1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 31 ++++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 34 ++---------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 739bd89226a5..4a76e442481a 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -911,4 +911,35 @@ struct hv_tlb_flush_ex {
 struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
+
+struct hv_interrupt_entry {
+	u32 source;			/* 1 for MSI(-X) */
+	u32 reserved1;
+	u32 address;
+	u32 data;
+} __packed;
+
+/*
+ * flags for hv_device_interrupt_target.flags
+ */
+#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
+#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
+
+struct hv_device_interrupt_target {
+	u32 vector;
+	u32 flags;
+	union {
+		u64 vp_mask;
+		struct hv_vpset vp_set;
+	};
+} __packed;
+
+/* HvRetargetDeviceInterrupt hypercall */
+struct hv_retarget_device_interrupt {
+	u64 partition_id;
+	u64 device_id;
+	struct hv_interrupt_entry int_entry;
+	u64 reserved2;
+	struct hv_device_interrupt_target int_target;
+} __packed __aligned(8);
 #endif
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index aacfcc90d929..0d9b74503577 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -406,36 +406,6 @@ struct pci_eject_response {
 
 static int pci_ring_size = (4 * PAGE_SIZE);
 
-struct hv_interrupt_entry {
-	u32	source;			/* 1 for MSI(-X) */
-	u32	reserved1;
-	u32	address;
-	u32	data;
-};
-
-/*
- * flags for hv_device_interrupt_target.flags
- */
-#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
-#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
-
-struct hv_device_interrupt_target {
-	u32	vector;
-	u32	flags;
-	union {
-		u64		 vp_mask;
-		struct hv_vpset vp_set;
-	};
-};
-
-struct retarget_msi_interrupt {
-	u64	partition_id;		/* use "self" */
-	u64	device_id;
-	struct hv_interrupt_entry int_entry;
-	u64	reserved2;
-	struct hv_device_interrupt_target int_target;
-} __packed __aligned(8);
-
 /*
  * Driver specific state.
  */
@@ -482,7 +452,7 @@ struct hv_pcibus_device {
 	struct workqueue_struct *wq;
 
 	/* hypercall arg, must not cross page boundary */
-	struct retarget_msi_interrupt retarget_msi_interrupt_params;
+	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
 
 	/*
 	 * Don't put anything here: retarget_msi_interrupt_params must be last
@@ -1178,7 +1148,7 @@ static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct irq_cfg *cfg = irqd_cfg(data);
-	struct retarget_msi_interrupt *params;
+	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
 	cpumask_var_t tmp;
-- 
2.24.1

