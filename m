Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D64AF16E
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiBIMXZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 07:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBIMXY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 07:23:24 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1FC05CBB4;
        Wed,  9 Feb 2022 04:23:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k17so2098539plk.0;
        Wed, 09 Feb 2022 04:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaNAnkJHSrjZ0Ymtt0aSkScJLuMHMgg0pqapqtDp4Dg=;
        b=kG2jKtGn8FULF5Ds5XfJZeSjKGW8Z8VsxO88USCD/ONYRvH1ZbCv1iMkOxl1JMSf8+
         eheKtiPIHZsWTNp3HZ21/r/rjz3rQbSWpwXeHM9DNwCNmzVpWkhUySynBc/IKb4XyIoM
         08SUYZ+uS4lmGwcnmBPZIByJ5c9MwXzg3b/UVBRT9m+3qnWRAeSXVFCcbGOGh4b3s69x
         mPmGSShDHb9qmiD3OpblYzRIj5dZYn/mW4GGBp9VaIvQ8iCHks9MVNAUwJ12yt5o8D+F
         sJc80rONtY8+GYo3q3BQPp+cSBsR4WhMTrzuOaLZFzME/o92PFFpl9e/0BH6QF2XJUDx
         s7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaNAnkJHSrjZ0Ymtt0aSkScJLuMHMgg0pqapqtDp4Dg=;
        b=yaOttJbPXxBud1O2f0Ks3zpPY3HzVh5wjDbcL3/EsY+P54uNOw5xpE43uDyp7VnaU9
         Ha9Uvo5VELjWGXSdPGJTNFLHJdTvmuoZWM77qN7SwyscGT9sScDf7FHGVW8CKI98X0o3
         USJ9QTxdz0hr07ZT8uikcmXnjPNREvMojV+FtRDLE6MvgyfWcbqLlbfwcWVhtn8UKsmF
         s+769Bqca+2dx3rW3iR8V+c2HYC4vcPsWb+NUiTIHQ9/7AigRqJTFWEKg7I1zS4zBqno
         xyJ/li6tkhkSmuf4uz8YXVe++bD7IawWH04X9dSv12Whk8MYL7vJdl5d69RzGPeQps3j
         n/AA==
X-Gm-Message-State: AOAM531ojUMMYJivvYRjDyH5uqW+6XwQ9VjdTcuH76yGN5eGb2oRv8ah
        W++sDUqjFwn+aCHLUMPQHY8=
X-Google-Smtp-Source: ABdhPJy3B8Zxcj0qnCCCdhXCsjncbSBovC/HETIu1yprqv435k5YpCYPC9/wJY8qtxvGP2tJK79sSA==
X-Received: by 2002:a17:90b:1e42:: with SMTP id pi2mr2281656pjb.176.1644409405570;
        Wed, 09 Feb 2022 04:23:25 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
        by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 04:23:25 -0800 (PST)
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
Subject: [PATCH V2 0/2] x86/hyperv/Swiotlb: Add swiotlb_set_alloc_from_low_pages() switch function.
Date:   Wed,  9 Feb 2022 07:23:00 -0500
Message-Id: <20220209122302.213882-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hyper-V Isolation VM may fail to allocate swiotlb bounce buffer due
to there is no enough contiguous memory from 0 to 4G in some cases.
Current swiotlb code allocates bounce buffer in the low end memory.
This patchset adds a new function swiotlb_set_alloc_from_low_pages()
to control swiotlb bounce buffer from low pages or no limitation.
Devices in Hyper-V Isolation VM may use memory above 4G as DMA memory
and switch swiotlb allocation in order to avoid no enough contiguous
memory in low pages.

Tianyu Lan (2):
  Swiotlb: Add swiotlb_alloc_from_low_pages switch
  x86/hyperv: Make swiotlb bounce buffer allocation not just from low
    pages

 arch/x86/kernel/cpu/mshyperv.c |  1 +
 include/linux/swiotlb.h        |  1 +
 kernel/dma/swiotlb.c           | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.25.1

