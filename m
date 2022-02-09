Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180144AF16A
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiBIMX0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 07:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiBIMXZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 07:23:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF318C05CBBF;
        Wed,  9 Feb 2022 04:23:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u12so578306plf.13;
        Wed, 09 Feb 2022 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHeTaNHwKSwgi47qQAMrwwvH4JdfELhdvY0tFE0Qdgg=;
        b=S4UvQ+/nM+8fNSw1PE4f+4FCLumVlciBxAOJ92AgHiZW5Ix90CFkrXBfCJanEy1u1i
         h327fu0yGbej2+hz5q+Zr0jyauX4+htYZAfhTLDCwNO2q1P4ImBDYBAkWo7RPHALengd
         kDUQWdymGHyVPMuDDkXrx08iNMBIZlw8riENN2e+BqMa+rRIHJdTVFbay4OuPv2cWXVJ
         Go/F0Wn7BvcSKRVOMdKi65o/pnm3jzVTWYQdyW5blerbNx580YsOv35CvZnKjZQwwd94
         n94rOuGsjXEn3fK3r+Ugv5VolUI/8ppVsMa0ccRAf15Vg5NteIKxqt7svtTCD3RALfd7
         MJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHeTaNHwKSwgi47qQAMrwwvH4JdfELhdvY0tFE0Qdgg=;
        b=HqBfLU4eyFcBrv477lhlO5aDb28ZNipZeJQeiA57EDzBCzHos6AlSHDZ2snqvtaRXH
         6iFT/zrIEV2+gFqd4MKQ0M5Gabo3xQ7vZOobcgG52U48KCPwb9LUEgfpQYcDZBZgqqtJ
         QX1QBZk2CmD9j52XSjINoA4b9nsFa+bpjKC2JWIkpQnRE6YATXTruZ/YvTHlcZQkgQA5
         /6velqeDks6bIhlk6HRW40rrMl8k/mZrH4YssakAbgkxmyrN9xMBqt0YplnrZ/o+SByt
         GwuPQOjDwEk98vovhSy1jZ7aLQsN8FEyIOXroe9oriebRqoUrAJbUR8CvmqbLrWDHX5F
         xIIQ==
X-Gm-Message-State: AOAM533Gt8JW5NU25aT0S6xsK0xXqMrPX9hopegK7mU7mtQouB53xplq
        lFF0lFoSeNs31+BqV6hlAQk=
X-Google-Smtp-Source: ABdhPJwVRhlS8xFIf1Zk17POR18zyrDa+Pemk4xck9NefmzGyh/YFa/RyzlAaK6sHR+JvpUJrSy0lg==
X-Received: by 2002:a17:902:b185:: with SMTP id s5mr2181136plr.123.1644409407053;
        Wed, 09 Feb 2022 04:23:27 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
        by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 04:23:26 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: [PATCH V2 2/2] x86/hyperv: Make swiotlb bounce buffer allocation not just from low pages
Date:   Wed,  9 Feb 2022 07:23:02 -0500
Message-Id: <20220209122302.213882-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209122302.213882-1-ltykernel@gmail.com>
References: <20220209122302.213882-1-ltykernel@gmail.com>
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

In Hyper-V Isolation VM, swiotlb bnounce buffer size maybe 1G at most
and there maybe no enough memory from 0 to 4G according to memory layout.
Devices in Isolation VM can use memory above 4G as DMA memory and call
swiotlb_alloc_from_low_pages() to allocate swiotlb bounce buffer not
limit from 0 to 4G.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..50ba4622c650 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -343,6 +343,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * use swiotlb bounce buffer for dma transaction.
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
+		swiotlb_set_alloc_from_low_pages(false);
 #endif
 	}
 
-- 
2.25.1

