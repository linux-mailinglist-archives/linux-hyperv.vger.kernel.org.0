Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7690268AAC
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgINMH2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 08:07:28 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40229 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgINMEA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:04:00 -0400
Received: by mail-ej1-f66.google.com with SMTP id z22so22831540ejl.7;
        Mon, 14 Sep 2020 05:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2EMorFYrbloyZ3vBTHgOEOIyWrtL7EoKHtqjNRb01I=;
        b=EU/UZyuYBO9vwQrL1xJePwjAP7Jhv9+T77Q09xDEW2yNx3YnqwZu/d+ZfKF2FKa11V
         KOiZ1J3IFxNYCQramL8LMnbRuZuzRELZFokX5UiHp7+8PxmAxpkGqOIAWyAXN8z64TNG
         khcWIU4qYv7glGEzP9fb6ePjlf4NIUz/bO4EMU+23N/icVohKhIuPed5Aru4ypFjScga
         J4tFlIQKuPR66chvOnoCfX+1zKFzvok25WDxVzx9SeH6uw0eQc80vUJk2F/WwnDfYIks
         gQzFgXNjb1MO42yyuqwmSsdiC4x7M5O3bTIQXRE2DjxmAYJh/mioesvn/zMBKwtSJ2/Z
         /1iw==
X-Gm-Message-State: AOAM532bV1uafCWuWQMCpQCqz3EmlOz231Ejyv0oF8nhuvWULiEYT/1k
        L8ffdjnZEvHKTu71BU+Xx83WoXPUkio=
X-Google-Smtp-Source: ABdhPJxO9hw1Wwb7xPWmOwlTO90CDRLUa0mPW7CxAKdL2u8XJEE5dFmtvCNRlyXzV1EMv/w7tYiLtA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr15516895wrp.396.1600084779262;
        Mon, 14 Sep 2020 04:59:39 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:38 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 13/18] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
Date:   Mon, 14 Sep 2020 11:59:22 +0000
Message-Id: <20200914115928.83184-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We will need to identify the device we want Microsoft Hypervisor to
manipulate.  Introduce the data structures for that purpose.

They will be used in a later patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 83945ada5a50..faf892ce152d 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -612,4 +612,83 @@ struct hv_set_vp_registers_input {
 	} element[];
 } __packed;
 
+enum hv_device_type {
+	HV_DEVICE_TYPE_LOGICAL = 0,
+	HV_DEVICE_TYPE_PCI = 1,
+	HV_DEVICE_TYPE_IOAPIC = 2,
+	HV_DEVICE_TYPE_ACPI = 3,
+};
+
+typedef u16 hv_pci_rid;
+typedef u16 hv_pci_segment;
+typedef u64 hv_logical_device_id;
+union hv_pci_bdf {
+	u16 as_uint16;
+
+	struct {
+		u8 function:3;
+		u8 device:5;
+		u8 bus;
+	};
+} __packed;
+
+union hv_pci_bus_range {
+	u16 as_uint16;
+
+	struct {
+		u8 subordinate_bus;
+		u8 secondary_bus;
+	};
+} __packed;
+
+union hv_device_id {
+	u64 as_uint64;
+
+	struct {
+		u64 :62;
+		u64 device_type:2;
+	};
+
+	// HV_DEVICE_TYPE_LOGICAL
+	struct {
+		u64 id:62;
+		u64 device_type:2;
+	} logical;
+
+	// HV_DEVICE_TYPE_PCI
+	struct {
+		union {
+			hv_pci_rid rid;
+			union hv_pci_bdf bdf;
+		};
+
+		hv_pci_segment segment;
+		union hv_pci_bus_range shadow_bus_range;
+
+		u16 phantom_function_bits:2;
+		u16 source_shadow:1;
+
+		u16 rsvdz0:11;
+		u16 device_type:2;
+	} pci;
+
+	// HV_DEVICE_TYPE_IOAPIC
+	struct {
+		u8 ioapic_id;
+		u8 rsvdz0;
+		u16 rsvdz1;
+		u16 rsvdz2;
+
+		u16 rsvdz3:14;
+		u16 device_type:2;
+	} ioapic;
+
+	// HV_DEVICE_TYPE_ACPI
+	struct {
+		u32 input_mapping_base;
+		u32 input_mapping_count:30;
+		u32 device_type:2;
+	} acpi;
+} __packed;
+
 #endif
-- 
2.20.1

