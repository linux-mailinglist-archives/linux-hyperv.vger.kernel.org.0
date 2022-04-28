Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9A51369F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiD1ORt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348098AbiD1ORs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:17:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E095B714A;
        Thu, 28 Apr 2022 07:14:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so4484318plh.1;
        Thu, 28 Apr 2022 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCLwNfkt8IkQwQwgXeFCHqx3e0FBGJobOavs3qCFjyE=;
        b=GE2h5rv5yNN4+7vkguJ2Fs9FpsVIhiTfyGcCgE7FFlDs7vtxejc0u1OXVkDMpWSpY5
         dPso+ae+h9Ubany5Nbo8AV9rGptAD7NUxqzWOXzcYLSAX77gbMKbS2SPpise1cqEJ7PF
         YEH7XUWWVudC88Wq+WjW6srlVdmfU1ZTwZJK+sDFiZwmHFCqnWmF/f02yj238C8n3/m5
         eNFA8e5mnXqWtbdwEEXlq2PU8+3hzL8XhZld2iq/aHXWicnDlj8s66wCKUhB/y4bmcjI
         z1MCL6R0jhwhmGiEt5SQI+rAWNifmU4J8NgbSqNarF0FhzIqOd13nSFwEwlc0T5yXR3c
         YClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCLwNfkt8IkQwQwgXeFCHqx3e0FBGJobOavs3qCFjyE=;
        b=pBKyeHUA1Lpm7+qK08PgAA4Inkx8paywCQupDt55/ohYN72nGqE5gyVZNFku0q2wu2
         BH+XcvOjJ1HzQqaFMe4Xv4F5pllIj1YtfQ6Q/kjUZx5C6HodqYPQkp6g5JCpCVRDJ4RR
         Nr7zkFPF2KzjHo2z/IdH2G9Q8oW2PPQuhZJUNCg521uxKuS258NvRG9QZ3fWxMbWYjxm
         plcjStn505TmeOvrUmF+j+2XLzYaS2S+L7SI5TEqYp7NPQB9tGRthKCfxjrtod9CeMZs
         C4mcQ2mA8C+GD8RQ/DckSUClzJyMo20nUioSqswMNNa7z2DJsq7dCTB3bszf6KxU4c3V
         UWfA==
X-Gm-Message-State: AOAM5327GVzDG/68DMYMT9nP9fxLj3sSC/r6GPXTkIoIpLK/wpmh4XVp
        mrRW1LCjA+JGOE9YIaldJro=
X-Google-Smtp-Source: ABdhPJwpmHijuE7ZXlhdSTBhFqZEOROLYSOTgh9Uo7dkFKloVMWxiGYHSLCXstNQSnnAEy9YkBvoEQ==
X-Received: by 2002:a17:903:22c6:b0:15d:45d8:8f8a with SMTP id y6-20020a17090322c600b0015d45d88f8amr11088920plg.31.1651155273140;
        Thu, 28 Apr 2022 07:14:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:de19:84:6ee0:6f2e])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm65331pfl.15.2022.04.28.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:14:32 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
Subject: [RFC PATCH 0/2] swiotlb: Introduce swiotlb device allocation function 
Date:   Thu, 28 Apr 2022 10:14:27 -0400
Message-Id: <20220428141429.1637028-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
significant lock contention on the swiotlb lock.

This patchset splits the swiotlb into individual areas which have their
own lock. When there are swiotlb map/allocate request, allocate io tlb
buffer from areas averagely and free the allocation back to the associated
area.

Patch 2 introduces an helper function to allocate bounce buffer
from default IO tlb pool for devices with new IO TLB block unit
and set up IO TLB area for device queues to avoid spinlock overhead.
The area number is set by device driver according queue number.

The network test between traditional VM and Confidential VM.
The throughput improves from ~20Gb/s to ~34Gb/s  with this patchset.

Tianyu Lan (2):
  swiotlb: Split up single swiotlb lock
  Swiotlb: Add device bounce buffer allocation interface

 include/linux/swiotlb.h |  58 +++++++
 kernel/dma/swiotlb.c    | 340 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 362 insertions(+), 36 deletions(-)

-- 
2.25.1

