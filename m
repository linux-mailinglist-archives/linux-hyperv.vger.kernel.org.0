Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA515010D
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 06:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgBCFD0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 00:03:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41707 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBCFDZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 00:03:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id l19so10461864qtq.8;
        Sun, 02 Feb 2020 21:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWTud8x7OEQoKdUBzIWswexdHpo1+5LgfuhOzNRvQBY=;
        b=Je3IggfFJOMJPyKlJs2Q26RgeI8BKzwhWYUwEY4gEBeVY8aUpxD7JfaatuG/QPzVyi
         QTC6uC85PbWUOOYlTZMwUKvDMueLZiQuNfIT5PU3rSefJf3WgVOKgbXMW0UFG0KXzQQy
         qi8KpEu27q0Yhngm00UL5U8S6fBgkJoyihzyzi8hZ9RvVd3RnlKtjgodfQgatu5uansU
         slmwvbmPzqgTQTDf32r/pXndLhudg0FP8euKBBaefsE46CLvsZbo8vCGgudYdDE9VPKq
         UOidPibovyBJ9M29M4FY5Qn7tIYD/cedG3bbU/nqgOJ1CFB1vjiQTE29BuusDc3Hl1aW
         f3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWTud8x7OEQoKdUBzIWswexdHpo1+5LgfuhOzNRvQBY=;
        b=m4gP1rQdtt18lnWcPcSqdwOaWOhIlwKLtnZnjgd25mNVmHgCDQV9uFLA5pfX7QEMx0
         WfGEcX+aFO9lv+/5T9OQ1UGeuP+TDV/FsgS4ZiM0bIuVWUOCVWNdGxOo8UZ17BS6AWxh
         6TGuDt+1v6B5sCKdgRn5d0WC+HBiSHVmHRiOVL2sSH5GfDTVRfa9oHnLzXbo8ytVNIHr
         uQDtGnvV1kn2xBoiyoQLeI/iDgCGzqNPQCKb51dyqie5448eRJ4wP1szjyyxQzesmZkh
         KAMN8od+kq4isfo572gvdKlWtx1dNi1mIWTOBTpgQA0cDUVS1o6bCLA4dF2eyFdspl1M
         hmUA==
X-Gm-Message-State: APjAAAXW9TkR8sKjFQpbpmgCLv4CaEN2G6oa55t7Svuqx4UbdyuiEnWT
        52z/Urt04kRCqYEVOCRTHz4=
X-Google-Smtp-Source: APXvYqwboCZJ5lFuPhz/tLmhxKhBFD4U0mNl9YWEQSDdEh+OvX94B8R9XB4kbmFQ7CDo5vJUoDMLAw==
X-Received: by 2002:aed:3e0e:: with SMTP id l14mr22512050qtf.163.1580706204616;
        Sun, 02 Feb 2020 21:03:24 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o187sm8804094qkf.26.2020.02.02.21.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 21:03:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A11C121F40;
        Mon,  3 Feb 2020 00:03:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 00:03:23 -0500
X-ME-Sender: <xms:m6k3Xg9JKj5EJC6oPQCMOWm45P0a5uL3e9SAef3k6y39MSPeFr_Prw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:m6k3XszC-TSW3VNaVPvL-8gAUH2PNmZtN1gGDkMXRfnw1sknmn7bAw>
    <xmx:m6k3XguxfY6J4c_GX-a0g37BqeXVS0JBnXeZVIbQCtLxfPW6f8NorA>
    <xmx:m6k3XvzZGgX-fgqjk4zYKwH3JkCap2mv_-ir6YSyuR66ozq8WP2xOw>
    <xmx:m6k3XnS7sXeX82VmER4SNbTbi-hauoCgdPC6yeHB7UfSoZ3fAT7rJNTiR3I>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22030328005A;
        Mon,  3 Feb 2020 00:03:22 -0500 (EST)
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
Subject: [PATCH v2 3/3] PCI: hv: Introduce hv_msi_entry
Date:   Mon,  3 Feb 2020 13:03:13 +0800
Message-Id: <20200203050313.69247-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203050313.69247-1-boqun.feng@gmail.com>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a new structure (hv_msi_entry), which is also defined int tlfs, to
describe the msi entry for HVCALL_RETARGET_INTERRUPT. The structure is
needed because its layout may be different from architecture to
architecture.

Also add a new generic interface hv_set_msi_address_from_desc() to allow
different archs to set the msi address from msi_desc.

No functional change, only preparation for the future support of virtual
PCI on non-x86 architectures.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 11 +++++++++--
 arch/x86/include/asm/mshyperv.h     |  5 +++++
 drivers/pci/controller/pci-hyperv.c |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 4a76e442481a..953b3ad38746 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -912,11 +912,18 @@ struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
 
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		u32 address;
+		u32 data;
+	} __packed;
+};
+
 struct hv_interrupt_entry {
 	u32 source;			/* 1 for MSI(-X) */
 	u32 reserved1;
-	u32 address;
-	u32 data;
+	union hv_msi_entry msi_entry;
 } __packed;
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6b79515abb82..3bdaa3b6e68f 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -240,6 +240,11 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
+#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
+do {								\
+	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
+} while (0)
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 0d9b74503577..2240f2b3643e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1170,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
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

