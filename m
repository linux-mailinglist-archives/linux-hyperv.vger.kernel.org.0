Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F7150114
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 06:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgBCFDa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 00:03:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41226 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgBCFDY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 00:03:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id u19so5348573qku.8;
        Sun, 02 Feb 2020 21:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHvPKoaqKtkykZLxCi4TerZ2d6tP9SE0xIIPoaJM2Ow=;
        b=eccQdPSpf1llC7YR5VHHJlf0LJ2SN0WsloaRrCae1eSinKOwjkW30fDu9dVrkM/b0X
         tc5czCv5b2qsqo4/y8zD7jti3aTAVsOiK1vlfWLdLFpdhLaiQ87xOGP8C+Rw5KXILatY
         ZJNmj3gj3Xb9fFMI8+f5ERHG1z0U123/t8ix8s9U/bfD+vy89yDS24hDb0AnyH2aBI9D
         XQjYre6nGFbNHhLGv6lfth2q13VZtFoZTHvidTcOB0xs+0my0Iq3Sb4rixgU08mWUhLT
         Me8f/RKenDIINNa75WEzQniaZH8tnXRn11UCDGzK1bG3xuAk3ktpkVgJtvIOKngImihB
         G4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHvPKoaqKtkykZLxCi4TerZ2d6tP9SE0xIIPoaJM2Ow=;
        b=FtUTwn1SuMrO1rUd6VY69vYQeehC29xWVylaN128Ot8st8vHozHXCMsNdxGD+edH5H
         /pWjHfEeAmFxa8zuUkHLg0p6mdTFBtyp3euI8Ezvd1DMTbHNrQk/OrXH+oXsbOtUjOTt
         vwvJPidHHZ3tWgnGq4JputEMDGxySYdWEeqsYTmTHWIuIt1hqbDWIeOkpIeFBXh9iR73
         krsYNov1GR63X5CL9LS4q1PXyUdy25RTKln/ShxC+nv7DkN6tX2QcSeuHF29fjNZ5sAv
         WX+ykPD3ftNPWm6ZUROnO4UECgga+1CMxPASg0ACaxSePXoKyYFANpfDKcLh9iFQ0Rhj
         r+sQ==
X-Gm-Message-State: APjAAAULdgJz+D3UCnBoJmdW/XokXwb85UEec6Mjrb9xZK5fo/9ZUfMG
        RdG3cUv8Hkrs+yk0VFHvHbQ=
X-Google-Smtp-Source: APXvYqzKk8N4hCeJ6CJD5TAcL/7v4lfU/s9T8nK42KRRAuCr9IO1YEQgEqAT7joW06yw2CkvdCgQig==
X-Received: by 2002:a37:a744:: with SMTP id q65mr22115703qke.391.1580706201772;
        Sun, 02 Feb 2020 21:03:21 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g6sm9311219qtp.53.2020.02.02.21.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 21:03:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 33B3E21EEB;
        Mon,  3 Feb 2020 00:03:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 00:03:19 -0500
X-ME-Sender: <xms:l6k3XqLvV7p5_9WEE4ijQInGUfaeDkGrIxj-Gopqvh5xrgL5qo6mEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfggfgsedt
    keertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:l6k3Xo1lUECvj0i7npwxRp2S9fZxkwXWI6nxXbvx1pEafg3L4_Y3CA>
    <xmx:l6k3XvI_ImMOnuA1Ko0f298f9xhLD07zzizUHL82Gl3WslEcexJxtA>
    <xmx:l6k3Xtn0YP31nZqgxKE_3GaEO4To5uI-Jk_IA8jiLGu3jjmi2ydbCw>
    <xmx:l6k3XuAWvO1bCYjflTM7KSIyGC-HNkZHtzihlje1YTexrtrrBtjE58oYyQE>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D14F30600DC;
        Mon,  3 Feb 2020 00:03:18 -0500 (EST)
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
Subject: [PATCH v2 1/3] PCI: hv: Move hypercall related definitions into tlfs header
Date:   Mon,  3 Feb 2020 13:03:11 +0800
Message-Id: <20200203050313.69247-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203050313.69247-1-boqun.feng@gmail.com>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF are defined
in pci-hyperv.c. However, similar to other hypercall related definitions
, it makes more sense to put them in the tlfs header file.

Besides, these definitions are arch-dependent, so for the support of
virtual PCI on non-x86 archs in the future, move them into arch-specific
tlfs header file.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 3 +++
 drivers/pci/controller/pci-hyperv.c | 6 ------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 5f10f7f2098d..739bd89226a5 100644
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

