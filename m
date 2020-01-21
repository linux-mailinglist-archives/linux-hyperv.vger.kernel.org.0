Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B84143579
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 02:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAUB51 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 20:57:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44863 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAUB50 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 20:57:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so1058719qkb.11;
        Mon, 20 Jan 2020 17:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zp9pXzXxZy3achdV2CKavPI4QEGNGMfLx4MphoQ6/EA=;
        b=Lrm+kBQTL+UiY47Mgl8AQG5y3y4ypGdgY5zBfPHtshLNyd8bEtSCyFMII4deXDMz99
         XKDfCfiFxqPk57De4Nj93s5j+uq35W1kc1NMOu+THP3ltuj1QVZcfdF7MuSwOuNLShX+
         xvT0eoNPd2RMLbDq34yRqcFa9MlilFJTYn0Q//KQxRmhmSvZTLb1HleV+iFmkcFMtknL
         8BPZOHBr8EpvZAQ217wV3jxop5eh5IhzNFVZowtLiXZN2P/FVMT4jKRvx0QOA/zDM9YG
         kGR8jk8arZjRNF8pk03R5mRpUN7KbvxljcTUKm5UL3UoVR4hWmjq0yrjbCVZDe53ZxUO
         Aylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zp9pXzXxZy3achdV2CKavPI4QEGNGMfLx4MphoQ6/EA=;
        b=IN8XuMedLsAWLqBcKfPREWT+X4mgKyy3yqQybWAwtq9bS5t8Z3K0WNKwyTK/eyTIMv
         NGjX6WtYgx6AOzIdGhYuDlnUdWx/KkgfEtDAzm1pa6rs3KuLlA2Q11ipTgv9LuNjETn9
         b8Io1GVwKtfHdZ/EO2o1nznE0+VdtcBNDIX+NX9U5nfb2psFt/8luKCHHrmF67ghGLru
         Pfdfaw21fbfest/ezOsTM91z1onpFaMEq9MrgY1Wg9eNkgJ2G46Mys4aibJKaJvESWug
         WLQN/MhElYRJSeuZ9GN4pdDG3W2XxSLI2OVqhzZIQWI06OcXryY7vpZz3qTfFfJAOYxd
         zIbQ==
X-Gm-Message-State: APjAAAVGv+anQcEMCuXo316hc00lD5p39+P/7MSSDfja//9gJ3YVBUJI
        3yxx+sXBW4uvyPSv5+G1u3Y=
X-Google-Smtp-Source: APXvYqzeOM2OlZmacEs3O6gcGlnuHDmEqKxJA/7yDAxiAUsYojYDqsEHh0Je/JnWYT+CQd/o2e37wQ==
X-Received: by 2002:a37:ad0e:: with SMTP id f14mr2404351qkm.213.1579571845733;
        Mon, 20 Jan 2020 17:57:25 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l25sm16327637qkk.115.2020.01.20.17.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 17:57:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8BE6121E95;
        Mon, 20 Jan 2020 20:57:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Jan 2020 20:57:24 -0500
X-ME-Sender: <xms:hFomXl5RgAC-1QhfHdO37KCiFZX6C8t0-ufFKKKlVkTGZcR8xFw-TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudejgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hFomXqUQN7h4n3JWSBKBULCJBa9t0MUIhtZDzoKmm4VR7xt03Wdf8g>
    <xmx:hFomXp1cAIs54aPRA8uVmDqnsdCpKSxbJQ8IWJhhjiCABHZfJ6ZIIg>
    <xmx:hFomXn0A4_Gxk2U4ZqqLp1oAGhcLgNVqJ7eUDlxAM73gwGCcjTARUg>
    <xmx:hFomXuW1PVJBq_CEsaUZDV3XnCgeQci2BBWoVO438eonFqE0FBOX6fHH2ng>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09C503060986;
        Mon, 20 Jan 2020 20:57:23 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS)
Subject: [PATCH 2/2] pci: hyperv: Move retarget related struct definitions into tlfs
Date:   Tue, 21 Jan 2020 09:57:13 +0800
Message-Id: <20200121015713.69691-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121015713.69691-1-boqun.feng@gmail.com>
References: <20200121015713.69691-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For future support of virtual PCI on non-x86 architecture.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 38 +++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  8 ++++++
 drivers/pci/controller/pci-hyperv.c | 38 +++--------------------------
 3 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b9ebc20b2385..debe017ae748 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -912,4 +912,42 @@ struct hv_tlb_flush_ex {
 struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
+
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		u32 address;
+		u32 data;
+	} __packed;
+};
+
+struct hv_interrupt_entry {
+	u32 source;			/* 1 for MSI(-X) */
+	u32 reserved1;
+	union hv_msi_entry msi_entry;
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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6b79515abb82..d13319d82f6b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -240,6 +240,14 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
+#if IS_ENABLED(CONFIG_PCI_HYPERV)
+#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
+do {								\
+	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
+} while (0)
+
+#endif /* CONFIG_PCI_HYPERV */
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index aacfcc90d929..2240f2b3643e 100644
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
@@ -1200,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = 1; /* MSI(-X) */
-	params->int_entry.address = msi_desc->msg.address_lo;
-	params->int_entry.data = msi_desc->msg.data;
+	hv_set_msi_address_from_desc(&params->int_entry.msi_entry, msi_desc);
+	params->int_entry.msi_entry.data = msi_desc->msg.data;
 	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
 			   (hbus->hdev->dev_instance.b[4] << 16) |
 			   (hbus->hdev->dev_instance.b[7] << 8) |
-- 
2.24.1

