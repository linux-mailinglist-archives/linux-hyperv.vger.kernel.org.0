Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9694D156DFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2020 04:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgBJDkP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Feb 2020 22:40:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36506 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgBJDkK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Feb 2020 22:40:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so5246876qki.3;
        Sun, 09 Feb 2020 19:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FIbpqewFhKoz647EtZl03555siYZin4B00D02clcgE=;
        b=mFNKsTXMronTqlFuBa1VlDXgCuMBsSsaqjC1ueVvSdYqCmWycg9P+ZHBPE+7XBD+I2
         c1+LmQIv90jM7gjL7zscQ7WTEuU6u3CevgXdlLy0Cs1ODwg6BWqdbj1G/fjJYwSDQLj3
         /K9xzds02XanPodmFcmJTuk9WXxGyA/13/hTdl+Cbs9JnNc4Hairoi+EOTYFt6XaAc+s
         ex6ZGMx+s4z3uZsijAkCe+nA0v9Ix+SxYBOTDpd54QVFmOEHM3Lo5uu1qxLk2C9hIfKE
         7r+IQCt1sGNycN1sY7r+wV7xnofQj216joEhI2gx03/JsWKm6JlAk2kX0nDMMehgcV37
         pyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FIbpqewFhKoz647EtZl03555siYZin4B00D02clcgE=;
        b=g2LmA8Byo9ksBdheBg+Y+fjCOYgwhHn/rkRCXIj7S2huKxISq02BX6kAbK2FITU16r
         /sng0uOYS99PxX8KRhH2mcjiOH0NnoTnLnEH3vFVqU6HMjmjWNCJQhDxigoS7ME0P5M1
         ca+uS7+6QmPfA3VuR9jTzn68ULaY04Midd/iF4DuA7vt8tPgWZS9NwRevbA8dAbMhXP/
         6PsWUO8eJkt1gpKWLp15W/o/TtnwiDzrCUGoWsBNAHbJpU559WeGjVoknFiSJE43FOAj
         8U4wF8JmsHQ/sybEokudDqpNSC5iyGtUfEAl19XHMEgBpprzlJXdE9w84ljUIwp7+oO5
         /+sw==
X-Gm-Message-State: APjAAAXVuxffLuIdmFYcCKK7POK33+k280CFvZyvYp1dfDczzERdbvKx
        XunU8azeRsPtkFwtK8YFZPM=
X-Google-Smtp-Source: APXvYqz+2/pfX0+5SgDIsX4B/zJfsLktj0AAvQvLswlJttnN861z7Z6qUr/uQTB1JioStdhOGb7GSA==
X-Received: by 2002:a37:7881:: with SMTP id t123mr8801430qkc.155.1581306009101;
        Sun, 09 Feb 2020 19:40:09 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p8sm3037881qtn.71.2020.02.09.19.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 19:40:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1A5DA21F55;
        Sun,  9 Feb 2020 22:40:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 09 Feb 2020 22:40:07 -0500
X-ME-Sender: <xms:ltBAXqjIKeDLKUelaK6mSf1Gt-EYnz5wUWsXigzQitS8S0Ljou867A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:l9BAXgEu85Nzm6lKxra9lLuonPoAZgHIVk0uadGxmZkXmzQLpa5xUw>
    <xmx:l9BAXvHB8av6AIFSZTmk8fNYe7eI1z9LYqa_CwtlF4DToN89DoHgnA>
    <xmx:l9BAXg-7iKcBPix-q05QA-WyyQHhbaGZWv3pJKfEWlzEVV_guOaRIg>
    <xmx:l9BAXhHiaf6xUOFIy4544RZ_uQ_UV3oe2Y6KhgH-31pi3n9NBpI4UDevw-U>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E6F03280062;
        Sun,  9 Feb 2020 22:40:06 -0500 (EST)
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
Subject: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Date:   Mon, 10 Feb 2020 11:39:53 +0800
Message-Id: <20200210033953.99692-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210033953.99692-1-boqun.feng@gmail.com>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a new structure (hv_msi_entry), which is also defined in the TLFS,
to describe the msi entry for HVCALL_RETARGET_INTERRUPT. The structure
is needed because its layout may be different from architecture to
architecture.

Also add a new generic interface hv_set_msi_entry_from_desc() to allow
different archs to set the msi entry from msi_desc.

No functional change, only preparation for the future support of virtual
PCI on non-x86 architectures.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 11 +++++++++--
 arch/x86/include/asm/mshyperv.h     |  8 ++++++++
 drivers/pci/controller/pci-hyperv.c |  3 +--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index a0b6a88d2f05..29336574d0bc 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -913,11 +913,18 @@ struct hv_partition_assist_pg {
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
index 6b79515abb82..81fc30240122 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/nmi.h>
+#include <linux/msi.h>
 #include <asm/io.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
@@ -240,6 +241,13 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
 
+static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+					      struct msi_desc *msi_desc)
+{
+	msi_entry->address = msi_desc->msg.address_lo;
+	msi_entry->data = msi_desc->msg.data;
+}
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 0d9b74503577..3f9b220c23ec 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1170,8 +1170,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = 1; /* MSI(-X) */
-	params->int_entry.address = msi_desc->msg.address_lo;
-	params->int_entry.data = msi_desc->msg.data;
+	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
 	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
 			   (hbus->hdev->dev_instance.b[4] << 16) |
 			   (hbus->hdev->dev_instance.b[7] << 8) |
-- 
2.24.1

