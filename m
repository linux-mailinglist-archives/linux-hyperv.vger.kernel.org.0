Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85EC30DDD1
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhBCPP0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:15:26 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51866 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbhBCPFb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:31 -0500
Received: by mail-wm1-f45.google.com with SMTP id m2so5866043wmm.1;
        Wed, 03 Feb 2021 07:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHDz3iIV5n6XQTRqm5AjoptlDcjURqmul15yV2T30Po=;
        b=fe6tL+mpWgPHM2k1U2l2piNuKt/ZU2RcjgpMapyh71mZrbH0/hjPiLD7BbPbuvJJqf
         hRiUZdOp2ssEmyav/BdwtoLmvWxNlH20gl3Sl3dH/yKVgoimYLyT6p/n2l2K7jyUmEeu
         SiwzL9tHrycmcq0IJ8Xakr5Uewy8Zxq2iQLZwlpY5euwWBmnX5G4DS6IoIlDsKO81UGR
         2ieIfU9QmZhaEWoP1t+ANEk5k0NhgoJm0zoBCD/6uMj/0k7A68BIyjs9FcXWUU9typ0s
         VQIh3DgXy6285UCoMPAegxHub8FXlBAf85I/v7HT7mygVPuHSSUkUZkZ1Yzk8XpWcN9q
         ldTg==
X-Gm-Message-State: AOAM531eYpRlZuufaGKZREEpia7JA4O/Qw5z0ebcoMV1jYsk6f29PJaW
        AhY5TghHdDT3O6WxBn9ETiPuqEjkWbM=
X-Google-Smtp-Source: ABdhPJzwkBHGVxOk7rfacDfATl2XTu3uy85q3dwEZjvioDzYxjMkoIPyGbkuyyrJdxM+xF7WZ5ETSw==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr3341162wmf.12.1612364686079;
        Wed, 03 Feb 2021 07:04:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:45 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI COMPONENT ARCHITECTURE
        (ACPICA)),
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA))
Subject: [PATCH v6 08/16] ACPI / NUMA: add a stub function for node_to_pxm()
Date:   Wed,  3 Feb 2021 15:04:27 +0000
Message-Id: <20210203150435.27941-9-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is already a stub function for pxm_to_node but conversion to the
other direction is missing.

It will be used by Microsoft Hypervisor code later.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v6: new
---
 include/acpi/acpi_numa.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index a4c6ef809e27..40a91ce87e04 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
 {
 	return 0;
 }
+static inline int node_to_pxm(int node)
+{
+	return 0;
+}
 #endif				/* CONFIG_ACPI_NUMA */
 
 #ifdef CONFIG_ACPI_HMAT
-- 
2.20.1

