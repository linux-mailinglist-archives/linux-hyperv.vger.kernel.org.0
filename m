Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0BB143575
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 02:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAUB50 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 20:57:26 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:36811 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAUB50 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 20:57:26 -0500
Received: by mail-qv1-f46.google.com with SMTP id m14so738121qvl.3;
        Mon, 20 Jan 2020 17:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcK6+k4NPCaHQAFm8eczg75luSkAiQcyUrbpqr9lrkE=;
        b=TFMZ1ye1VsisRnpp/XkYTziAP2KieqghVHvxO0bEoRzwZkxOELHccM2EaOLHzfxzSS
         yQmynKhshOeTfaTe8TvnSjjtMxY1yiqSAYsuAJcl/J0rqoYVuFMc4/DNoZ7xtSMwKXnK
         PFHew10IrghPTURZRIztLm4wGCBTAHndnlyUOdd+jKAkC4nMYFpe5JgSa4Hw+u81nV6Z
         odtU+WQxduZZm9ZGkUkyN7yFTscdR494uMfrWkIwj65Yf7MLr3iSqEZVbYAkVD7q9JLK
         nJbJ0t/SF20ldxNFhgEtE5oW21KBJW5reAYbvua0ZUnkZao7cdF6pDqE5kLpdxK6YY9y
         0I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcK6+k4NPCaHQAFm8eczg75luSkAiQcyUrbpqr9lrkE=;
        b=PkDvMs6gHGJ51XFqhaUrJ6EtaY/GtnwaeV3sMI6yHpgnGc7TkRLCoV1NoCwTWNMY4o
         vIrUovW1CHlilWOTVHT9G2la1KyIEt0vN2r2vK3GyQZHbOxp9DlqBkUg1JttkyM51lzO
         mNkQ+/lrlmGtdP9OGb/nRvXIlPbYN3sO1U3ccLrTDBmCEiNy9mCrLxmeOCYDCPeftf26
         Wh5VIak5n5K3pf/tpdxR/VLFkn0yfh1H7eXsW3Vo593MxiGaFJ6iHQmiICrE/8rNcZ+Y
         mpQiIYcymzhzkRJ+TNHKew03h/8l78jFXkX4xd+DcZGIz1vV9JbcpivBTkqn9h30YIto
         xHtA==
X-Gm-Message-State: APjAAAUpNGXdwyt+IUO8mnaQDS6dq+eOTXp1dd8cj+ss4qSqYF0nYHRG
        pFkVt/IDHiyegGHJnDk71zE=
X-Google-Smtp-Source: APXvYqz2qQhdvMDN6jWI02qZ0EeiwvYP68iv4OB+DcQuRSncdDzJwzP3msTovzV6dXk3TXVV3OiQcQ==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr2671484qvb.202.1579571845113;
        Mon, 20 Jan 2020 17:57:25 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 201sm16820373qkf.10.2020.01.20.17.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 17:57:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3AAFE21C39;
        Mon, 20 Jan 2020 20:57:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Jan 2020 20:57:23 -0500
X-ME-Sender: <xms:glomXmCGQmJImzaVOB34wnbWzwJKlQE3wCA0kCd1ikrI9FH7QBkPmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudejgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduhe
    ehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:glomXoszPZaP4qAThPnmAkARaqQakUEK40vrEVfITDYOSuOMGZEULQ>
    <xmx:glomXvfCIRgJeLfcX50jryWVPUk1DlylG6QBYPP4zamRTLHOUOmtiw>
    <xmx:glomXt3rDyyufNK8oYKAmkGe7Km61moHUoMv0bSON8Lz071_DL94Ng>
    <xmx:g1omXowr8CaOz8WseZrrxlVWmvrvjJW1ZmaFCjll20sk6QZKDWf6BUpCmKw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FE6B3060986;
        Mon, 20 Jan 2020 20:57:21 -0500 (EST)
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
Subject: [PATCH 1/2] pci: hyperv: x86: Move hypercall related definitions into tlfs header
Date:   Tue, 21 Jan 2020 09:57:12 +0800
Message-Id: <20200121015713.69691-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For future support of virtual PCI on non-x86 platform.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 4 ++++
 drivers/pci/controller/pci-hyperv.c | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 5f10f7f2098d..b9ebc20b2385 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -376,6 +376,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
@@ -405,6 +406,9 @@ enum HV_GENERIC_SET_FORMAT {
 	HV_GENERIC_SET_ALL,
 };
 
+/* Declare standard hypercall field values. */
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

