Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAA268AA8
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgINMGz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 08:06:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53130 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgINMEA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:04:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id q9so10366358wmj.2;
        Mon, 14 Sep 2020 05:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQKhb+LoEWMH3iW/IWOjs8QKLqVOB1NiJ5AxyQ7Kqfk=;
        b=iLXPfi8znDNnnCUJufANq55l3ecr+aTAuMiRG94wycG+zsi2ffH45ol42kQrzKopIM
         f8vx+ZXClPf6TZyRgZPEaYvT/S33FrJ8zpH/B+V66MIL+owPKBAsg4iogaQuumRGmilA
         azFLnNLdgnyz1vdWG1wiZfHgGtEXSf/njkONg+1PCpnXXKXR6q+QCE9yJV2itKR2tjZj
         nKQhqKKsAD+f2L9Yu89TuoGF/WkLAB+vJwJ6SR1DAwc7Ui1o+YQs4x0SQ1T1mVc3b2Kl
         kxhGmNIfpsu+6Iq3CKNYa6J/Yd0J4re+Gp3MFA/znh5w+XtXB3EiWiNfEIpodQXYZfPh
         woZA==
X-Gm-Message-State: AOAM531rNAL/lfwMkE/YHCyWAtgmxUpOfTV37XGeJvO7WpRa6vE1C23u
        SjS05t8cqo5IPrWWZwCexLhil/jQ/DA=
X-Google-Smtp-Source: ABdhPJyC4exb5tH9FPEHgpCc2oPxmtChwVHy+O98YyCb/lvdGd3ug+AKyFHPPC/GOi9R1huo79f6aw==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr14527644wme.122.1600084777853;
        Mon, 14 Sep 2020 04:59:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:37 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 11/18] asm-generic/hyperv: update hv_msi_entry
Date:   Mon, 14 Sep 2020 11:59:20 +0000
Message-Id: <20200914115928.83184-3-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We will soon need to access fields inside the MSI address and MSI data
fields. Introduce hv_msi_address_register and hv_msi_data_register.

Fix up one user of hv_msi_entry in mshyperv.h.

No functional change expected.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/mshyperv.h   |  4 ++--
 include/asm-generic/hyperv-tlfs.h | 28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 60afc3e417d0..a4d46ca5a0b1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -244,8 +244,8 @@ static inline void hv_apic_init(void) {}
 static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
 					      struct msi_desc *msi_desc)
 {
-	msi_entry->address = msi_desc->msg.address_lo;
-	msi_entry->data = msi_desc->msg.data;
+	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
+	msi_entry->data.as_uint32 = msi_desc->msg.data;
 }
 
 #else /* CONFIG_HYPERV */
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 2b05bed712c0..e7e80a27777b 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -469,12 +469,36 @@ struct hv_create_vp {
 	u64 flags;
 };
 
+union hv_msi_address_register {
+	u32 as_uint32;
+	struct {
+		u32 reserved1:2;
+		u32 destination_mode:1;
+		u32 redirection_hint:1;
+		u32 reserved2:8;
+		u32 destination_id:8;
+		u32 msi_base:12;
+	};
+} __packed;
+
+union hv_msi_data_register {
+	u32 as_uint32;
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 reserved1:3;
+		u32 level_assert:1;
+		u32 trigger_mode:1;
+		u32 reserved2:16;
+	};
+} __packed;
+
 /* HvRetargetDeviceInterrupt hypercall */
 union hv_msi_entry {
 	u64 as_uint64;
 	struct {
-		u32 address;
-		u32 data;
+		union hv_msi_address_register address;
+		union hv_msi_data_register data;
 	} __packed;
 };
 
-- 
2.20.1

