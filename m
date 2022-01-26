Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749449CF49
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiAZQLL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jan 2022 11:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiAZQLK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jan 2022 11:11:10 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED0C06161C;
        Wed, 26 Jan 2022 08:11:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n32so143415pfv.11;
        Wed, 26 Jan 2022 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tQ228U3nQXaWjV8cViOybTVc9dWTMhKsSPLFqG1IfY=;
        b=Y9o46Wo42zMqCSbsyBcmqzXIZi9mLVHoOLEBmOmxftVHauCdwprtlA5oNTyoEhv/lM
         BsJnJKmPK3FuDm9q7GcNTbfGuPI2gyypzpSXLStZAh4BYV/m12jF/hKI610tpFW96CXj
         nylvUtFW+7fRDveRi2PMMgXXpfdUS7DgSkmPCf2ipPm89TKUc4qkpVVQqTNmp57P2GhD
         j61gN7wG/Y+8tpV+/PRPug6pEJnQDVliKLf/zT5yAlL1Oj7VYBkMrh07OuWUA2wd/KvB
         1bvLa4ltZCktXMwhskOQlbGqOkNQSmYoSK62NCi4LjKMlFdWdGNMPLM9m5sCM8z+Nyy9
         7lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tQ228U3nQXaWjV8cViOybTVc9dWTMhKsSPLFqG1IfY=;
        b=z3HvPfzkPWwx7+Y5PopL785oQMbpckasXm0xrQF1mm6Xeb3DCE3rKtgsxBFtBI1kFF
         pR5PnS1MQAAnfOo7hj43i8mDuafvl/zfW563pN3cWTfxaN1TkjWTh6KzYc7UAoejoUL+
         NUL3XQ/6JJ73T7zQgA3J3MF6nxAa4Vx4XNO3LFkSU0Yx7GAd24WzpWfoqMJW0VVHo0jY
         dlGgzbgjBzk+svrEQQtwn7qN+udhW5m1CpWRod+pUlKqlvp7P1tZPGNo+cmTH2efxqMh
         lJfA61T253abx1lJmVRDVPepMk8CJHCfuVC4hUboBqQRwSWFTEFlTGae7aj+hVGfHNag
         xV/g==
X-Gm-Message-State: AOAM533ZmxVIlIufXiDEtVYLoYHXJJKULRDlon6nawfH6tZcJaHkwhsv
        0gXLvZZ5flZuPVDN2BjUiR8=
X-Google-Smtp-Source: ABdhPJx/62+0JV4W7kaGThLI9clYp04X79pUIPK2kep5k3Cto21975tua1EyydW+0edNiUOUJmpZdg==
X-Received: by 2002:a63:7549:: with SMTP id f9mr19021304pgn.259.1643213470086;
        Wed, 26 Jan 2022 08:11:10 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:35:cf50:7507:71bb:9b04])
        by smtp.gmail.com with ESMTPSA id b9sm2555534pfm.154.2022.01.26.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
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
Subject: [PATCH 2/2] x86/hyperv: Set swiotlb_alloc_from_low_pages to false
Date:   Wed, 26 Jan 2022 11:10:53 -0500
Message-Id: <20220126161053.297386-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

In Hyper-V Isolation VM, swiotlb bnounce buffer size maybe 1G at most
and there maybe no enough memory from 0 to 4G according to memory layout.
Devices in Isolation VM can use memory above 4G as DMA memory. Set swiotlb_
alloc_from_low_pages to false in Isolation VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..80a0423ac75d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -343,6 +343,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * use swiotlb bounce buffer for dma transaction.
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
+		swiotlb_alloc_from_low_pages = false;
 #endif
 	}
 
-- 
2.25.1

