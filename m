Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9955CDD0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiF0PdB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jun 2022 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiF0PcM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jun 2022 11:32:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC101A390;
        Mon, 27 Jun 2022 08:31:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v126so5270755pgv.11;
        Mon, 27 Jun 2022 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCgfBJhENgb3ojrVqpq/GHPBaWKu1KifC83EuVi6Y6g=;
        b=dI9T0VKsh98NfrTIu4AWRJ/2IXmjraWq+1P1LN/hLe29wRLZaR5rvvsVpTVGGWRsLM
         oRPcmybL+9qjIg6JEHoGAgGOFL/kGAFCsWLK7WCM0XkUuNwWOox1ThAs8KlnRPUzQcWt
         lLXhKF+E22CnMCpYiFyIF3YJPLw2bIZpNYTTkS1OfiFBIkhO+xMuQ3FTM2eDbKtI6xTk
         1g/RosEGWW+aSKl566bZiWTywkleIjLQbsyLbh6bujMdhFvi6SkuXCgqzDnInJkA6X9V
         jxbkwdw0mafLIfRF2n+cmdU+c4npLFqnyiJ5MPEI7fj+2r7UycP6rBI7HtPEscl+zfdY
         9fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCgfBJhENgb3ojrVqpq/GHPBaWKu1KifC83EuVi6Y6g=;
        b=3LOTwc92XC+sGQz68weoKEH1whtkpTxUClFUWM2CZdH7yQTvgNNiDz1x+lHyE+jy+7
         gUmvqPzg3pMSm+2gKX/gf1Bz2i9QMwiXnDf+qZhApXfrMRX5c377MqL+MUicuPHs8/+d
         stypQwoA5xqWk8+Crk2VbbYuvWqVAdms4g1ESmMOymZXRlO7gPXHJi1A93PFQxh1AtRx
         L0qfB2nwuu3Gof7ktmM7kuwVYokeNYg0gXgdj4VQXtX/ulWqdKco6kQzS5c7cK9xt3z0
         EcrgV1hkDEY0JTlS476D9Bp4aF/ehhv7xUX5bCe0Ao+tppHhsw38obsvnoqKtWN2xLkU
         Bxxg==
X-Gm-Message-State: AJIora9MxRGm3jh0GvG4acycfqo98w9y3tr9bkweDimzhZ6xbV9tt5vy
        05QItMjUmoA4BmXsGiTu020=
X-Google-Smtp-Source: AGRyM1u5LW9AITaIesZzlz5OplsMuM7fKSzm3w1NSzCcIsHcbNdQtjNjluJWhAENtSD4tzySP2ykWA==
X-Received: by 2002:a05:6a00:17a8:b0:525:537a:b0df with SMTP id s40-20020a056a0017a800b00525537ab0dfmr15547134pfg.71.1656343916526;
        Mon, 27 Jun 2022 08:31:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:f0eb:a18:55d7:977b])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78f26000000b005251ec8bb5bsm7595705pfr.199.2022.06.27.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:31:55 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     corbet@lwn.net, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vkuznets@redhat.com, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of lapic entry in MADT
Date:   Mon, 27 Jun 2022 11:31:50 -0400
Message-Id: <20220627153150.106995-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627153150.106995-1-ltykernel@gmail.com>
References: <20220627153150.106995-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When initialize swiotlb bounce buffer, smp_init() has not been
called and cpu number can not be got from num_online_cpus().
Use the number of lapic entry to set swiotlb area number and
keep swiotlb area number equal to cpu number on the x86 platform.

Based-on-idea-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/acpi/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..7e13499f2c10 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -22,6 +22,7 @@
 #include <linux/efi-bgrt.h>
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
+#include <linux/swiotlb.h>
 
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
@@ -1131,6 +1132,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
+	swiotlb_adjust_nareas(max(count, x2count));
+
 	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
 					acpi_parse_x2apic_nmi, 0);
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
-- 
2.25.1

