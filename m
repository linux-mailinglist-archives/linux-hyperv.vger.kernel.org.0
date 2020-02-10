Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3D156DFC
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2020 04:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJDkP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Feb 2020 22:40:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46087 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBJDkK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Feb 2020 22:40:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id e21so141389qtp.13;
        Sun, 09 Feb 2020 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vaUfZ3vd9HQfy5hm3J3nHvIU5a5fojBakofme2e8oDo=;
        b=e6sFDqmhOxEJ5WN3dMK5O2omGe2qI/ckFjkz7TG5EHoTJaMjVjSxsVjaEzq+dIH2dP
         w2kHoOxt3NP+4W7jhSAU2Ak0WanA0vP3NaxXxfxurjQWqnbzJXGX41uFSFb8MQM99Hwh
         CZCXJelEPKHMGM5M4KULanWS9Q8gatSTEv9Qjd+dP5QwweblbgozGls58yBwSWVQak5q
         /8wsKGupBTSMi6vpqS+M00LlJcnkFBvyTTPtRkjmX6mkNppVnYD//X452gDJlNzIx61l
         KAQlublxOtb0E1pFy/oHyx4ErHCEvPMRKRP5wDM7o3do6nfX8Fm9ohAKuTi0BnqHkJJP
         1pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaUfZ3vd9HQfy5hm3J3nHvIU5a5fojBakofme2e8oDo=;
        b=H/X+WClMDR/c+WkB6i1LOgBJQ0MnqbyLpZt6lCZvnbnJLQNWKnCXtHowUtIWiDn/bx
         DQKsc+colNWAUSp/TbaatZtsLBDfdOE902x9y/HfIJL/Fb2tekfVJfV8bzU4bSYygUMm
         JG1Olh68X+UMEnAKzbhXDlx5BCRuRAYgtGp+3CwSfrlGv5fOVUJAChi7udlwrKHm2iNM
         SmZHZIapnQYR9n/8es9KflUuo6I3hSmoGBlZrgBPyJpZJdj1tc5g8aY+J9jlXMnvh6sF
         jjZePLDNhIhAzv7dQ1oUrY2GSwN8SJQ8II8/Fbpf7Xua+pk44TI6kmvram8+NdxkW9IX
         dY8w==
X-Gm-Message-State: APjAAAU6T+9sGkHYU3AMvR4v9hRw4ShE4S73s94Ql9Cay9wYiQksF6mZ
        9oyMiPJGLHhokNa1vDMb49Y=
X-Google-Smtp-Source: APXvYqxBiHAep5MJI98kbIEFyI4HgXXqB+cY4d6mZ5eiVFz7gYqYnW9wYxuDxMafvk5DPcRdKwSO7w==
X-Received: by 2002:ac8:176f:: with SMTP id u44mr8056958qtk.379.1581306008555;
        Sun, 09 Feb 2020 19:40:08 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y28sm5216125qkj.44.2020.02.09.19.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 19:40:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5E73B21F69;
        Sun,  9 Feb 2020 22:40:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 09 Feb 2020 22:40:05 -0500
X-ME-Sender: <xms:ktBAXqH5lYWrrSWSU11mtDQjIxdHtQ99Fe23LYKxXJ_-i_wd1R8g6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ktBAXgcGMucie6gcwqvZb3VdWzzL5Hn2V3RH5aCLihLCs6Ymv9L1XQ>
    <xmx:ktBAXrbk21Exo0fXGeDB7ZE9b8Ah5q9d_vDby8a6IzKthdGhiusQnw>
    <xmx:ktBAXrrGkRO-FeqDFhjQbrjb3KGD4sD73KS9J2PLOTomIVFEdr-8fg>
    <xmx:ldBAXhHH4Oc8uI7DnRoUE2VuWKxv_LW0GArZOoy6j4uOe_Wi3nCFiRm2Ces>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C8EC3280069;
        Sun,  9 Feb 2020 22:40:02 -0500 (EST)
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
Subject: [PATCH v3 1/3] PCI: hv: Move hypercall related definitions into tlfs header
Date:   Mon, 10 Feb 2020 11:39:51 +0800
Message-Id: <20200210033953.99692-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210033953.99692-1-boqun.feng@gmail.com>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF are defined
in pci-hyperv.c. However, similar to other hypercall related
definitions, it makes more sense to put them in the tlfs header file.

Besides, these definitions are arch-dependent, so for the support of
virtual PCI on non-x86 archs in the future, move them into arch-specific
tlfs header file.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 3 +++
 drivers/pci/controller/pci-hyperv.c | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 92abc1e42bfc..dffed0e10a68 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -376,6 +376,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
@@ -405,6 +406,8 @@ enum HV_GENERIC_SET_FORMAT {
 	HV_GENERIC_SET_ALL,
 };
 
+#define HV_PARTITION_ID_SELF                    ((u64)-1)
+
 #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc..aacfcc90d929 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -406,12 +406,6 @@ struct pci_eject_response {
 
 static int pci_ring_size = (4 * PAGE_SIZE);
 
-/*
- * Definitions or interrupt steering hypercall.
- */
-#define HV_PARTITION_ID_SELF		((u64)-1)
-#define HVCALL_RETARGET_INTERRUPT	0x7e
-
 struct hv_interrupt_entry {
 	u32	source;			/* 1 for MSI(-X) */
 	u32	reserved1;
-- 
2.24.1

