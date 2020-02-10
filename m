Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410B5156DF3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2020 04:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBJDkL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Feb 2020 22:40:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40632 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgBJDkJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Feb 2020 22:40:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so5222451qkl.7;
        Sun, 09 Feb 2020 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8h5VsF3OjOh8Qi5/AzA/qGpUS3Vn4vEIDA3DU9bJh8=;
        b=Rl0lTSbEjeXdxQiqlcu9+KT40vHjEHpujjrzHiwl+8vfEjSj1ufw46i7BZsO6p8LZC
         3JHsfhd3JW+7dRpd2qqbaBImxVv7df8Ol3S+TF/o+obZ2tU9zh3IHc1Cl9XrzBuFUKOt
         1rS1vGhRV+hgmRxZgxjcyosLObHq3g9rOkQ3UZR/fFPOwJrPZ+76Ard78+OtV2pbm6fD
         t9q/QmkSfbnTfSGNni7T49wINkb7FY5c2lLKktdNLRgwOe0sfGfXtGlOL2F4F/ig9ukB
         Iau0C3JFZ6o2RBwxtEQO1b3U4SLSfM9kMi+pCgS6q4CK8I/GB/7n5nj/CtDg7e34XmbW
         z6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8h5VsF3OjOh8Qi5/AzA/qGpUS3Vn4vEIDA3DU9bJh8=;
        b=FRQyYEuT40Zg958MYTKvpylJ66oCthTY6esYk30VnWbcKGuqpOT63ErW6YmdwC2Nid
         P2QKGiBdNqPOXQlcN9/49ZamvZsVPeHuuR1kkWlrhBP8JDgQQe/ohHV+xu7UcZ9Sozwa
         ZyO9nOuUp0xukvkkENNGzLS2s7aTRP3bQJQxai5ZxDe4FanDnGFO2LxnZI8gLMVORkrJ
         3ZHBAe7374GeE4tdMwpzL0ykz/PgzDVa8kCxPbLboTGXJlKrAn7zgSjW/UPVZ/EerQ6d
         +vecQCfOsmFimJfFuMvb4mQiVLY+bac/rmT2izEUKQB6xyIkOsBqaho3aK6jBGamPvhu
         Pa2Q==
X-Gm-Message-State: APjAAAUtzeWUlB0qn2nPGh1mZa2TFgxfREKiqgkDfBYiukL/SxXfya4/
        eczZXqfRzhhcm5VCuitMM1U=
X-Google-Smtp-Source: APXvYqwwL/ocfBXYIDI8PrkokJlolucpauqGjneJdmdhc9hbuIgUGxE9twubCS8UJYHwpyI/OhNG3Q==
X-Received: by 2002:a05:620a:1366:: with SMTP id d6mr4293044qkl.230.1581306008057;
        Sun, 09 Feb 2020 19:40:08 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y21sm5408681qto.15.2020.02.09.19.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 19:40:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5F99221F6D;
        Sun,  9 Feb 2020 22:40:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 09 Feb 2020 22:40:05 -0500
X-ME-Sender: <xms:lNBAXkXy3AJaiK32Z3YtSANz9_6NEg5nO94AjuIOFsJjwhvRJjrcKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecu
    kfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lNBAXktU-z9WB2B22sZPjaJ4WVyy_N2I04uaJrETkyZp8GZytVFiMQ>
    <xmx:lNBAXkOSLPM2BYoW7whOY_46wQq3oeB5Ie-wZ_WGEy_Hwu-vnzvevw>
    <xmx:lNBAXsoTgxjnHsYkS_sei2Qnx4OyNSklWA15QHuJSnAWD_fEUQN9qA>
    <xmx:ldBAXhcXS6IzmE1VkT2PRUfyrO257eKWWW7zYVgpD-dJoExz7cK0XShEzpo>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A59530600DC;
        Sun,  9 Feb 2020 22:40:04 -0500 (EST)
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
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v3 2/3] PCI: hv: Move retarget related structures into tlfs header
Date:   Mon, 10 Feb 2020 11:39:52 +0800
Message-Id: <20200210033953.99692-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210033953.99692-1-boqun.feng@gmail.com>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
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
architecture. Let's move those definitions into x86's tlfs header file
to support virtual PCI on non-x86 architectures in the future. Note that
"__packed" attribute is added to these structures during the movement
for the same reason as we use the attribute for other TLFS structures in
the header file: make sure the structures meet the specification and
avoid anything unexpected from the compilers.

Additionally, rename struct retarget_msi_interrupt to
hv_retarget_msi_interrupt for the consistent naming convention, also
mirroring the name in TLFS.

[1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 31 ++++++++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 34 ++---------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index dffed0e10a68..a0b6a88d2f05 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -912,4 +912,35 @@ struct hv_tlb_flush_ex {
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
+	u64 partition_id;		/* use "self" */
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

