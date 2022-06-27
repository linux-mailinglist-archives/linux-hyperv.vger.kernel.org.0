Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787C555E363
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jun 2022 15:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiF0PdC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jun 2022 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiF0PcL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jun 2022 11:32:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B371A07F;
        Mon, 27 Jun 2022 08:31:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q18so8456650pld.13;
        Mon, 27 Jun 2022 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZDC1AGRQHEGpUuB3ISkYbuot/iQPwlOXTIDim4MzLc=;
        b=O+GWloioEOJpO0XyXVRSMZTQsER89gKRWgIfzRViNiUH+wc06BhSdI/DYNimqD0H/7
         +pBzmJ7cigXalaMs2EYCeYKV+G6WBWbR7VsAdyeDZvbyF635dgSBJ9nXlWkul7FYLsu8
         gAtMXnwoSaQlBXInB76dUgvLj6KmA/5ZhOoN5PXuJRteFiHKTnGTlUuAh61yLcYZn323
         AGGQSk+5H0R6Snc1R2Toqjss7pGQnsZttUZ8diX7VWTqboNL5/2x0EEKY7FPIvyhj3+l
         8U+0xCg4eQ3aluY9uc5Aw2N+SRaH40XIYSKcjsS9Uk6Yh8XYwdhjkXZpQ/NAeL8ogA9R
         2+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZDC1AGRQHEGpUuB3ISkYbuot/iQPwlOXTIDim4MzLc=;
        b=QqGRFvPCY2XcHSHrdqmje5aY3Cn6u+jtFZfp06+llDLBu19y2Oq38IADxWdb9UuElQ
         7VihEbJVnh3Mm75TAd0zuc4kZBBiLeUNcirpD4mmpc/eJ7hZ0UdvB1YdmfokE66GZQNk
         PXou5khJJd4M6iRa5jRxSlNctWOHprHvzVMt1H4gx4f5YItfZSrjmDA6qd2DL9Mcp12R
         jqHXA4HHlLrmviIVozXapM+d7lZ3h1XjD3rz+p/Soc9qZg9z4Eb7qWKqfVoR1yfyybwA
         jhfwqN50OVn0hFDf+CQPX5AZ39Iq92AEsFbxR3TkSDln6Y6iZozTS8zOWl+PZh6gypO6
         TiuA==
X-Gm-Message-State: AJIora+o4rl4RcGjPs8P0ruJRd9y7Ot3HbJqnILvn2HLjGB2WolycIHF
        kS91AU3oz2vvv8fwjsLs2RM=
X-Google-Smtp-Source: AGRyM1sEiEhuPfofrRLQqFzFlVdXiZYLCqnhQsSu7hoQrMhPrjLPj9CQQVl/oAKCcOOKm40jQb6U7g==
X-Received: by 2002:a17:902:cec4:b0:16a:1fc3:b6e6 with SMTP id d4-20020a170902cec400b0016a1fc3b6e6mr15435957plg.129.1656343914201;
        Mon, 27 Jun 2022 08:31:54 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:f0eb:a18:55d7:977b])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78f26000000b005251ec8bb5bsm7595705pfr.199.2022.06.27.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:31:53 -0700 (PDT)
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
        kirill.shutemov@intel.com, andi.kleen@intel.com
Subject: [PATCH 0/2] swiotlb: Split up single swiotlb lock
Date:   Mon, 27 Jun 2022 11:31:48 -0400
Message-Id: <20220627153150.106995-1-ltykernel@gmail.com>
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

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significat lock contention on the swiotlb lock.

Patch 1 is to introduce swiotlb area concept and split up single swiotlb
lock.
Patch 2 set swiotlb area number with lapic number


Tianyu Lan (2):
  swiotlb: Split up single swiotlb lock
  x86/ACPI: Set swiotlb area according to the number of lapic entry in
    MADT

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/kernel/acpi/boot.c                   |   3 +
 include/linux/swiotlb.h                       |  27 +++
 kernel/dma/swiotlb.c                          | 202 ++++++++++++++----
 4 files changed, 197 insertions(+), 39 deletions(-)

-- 
2.25.1

