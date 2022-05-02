Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1A516FD4
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 May 2022 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiEBM6N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 May 2022 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiEBM6M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 May 2022 08:58:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D9E0E5;
        Mon,  2 May 2022 05:54:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x23so6936501pff.9;
        Mon, 02 May 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbEov+FhR+8nc69KMMmSEUhJy6W9UVkpDOopEtF89fc=;
        b=hUvx/25zW89ms9GhbHqU48k8kF2xs+CDUa7/+K3+2uP0ln3Nl8DQF+KgsKbdHT+oBY
         XPT70s/dZuefWTzw5Az544RpQLgfWnJgG5YjZrL1YJWgKeuf48yBgnkq8EugUx3PMwaV
         vfWPmUe0j9DvB7qnfFXrQnIXnYJGGzDHXBlssPp5FSGH3j3CKZVOt2+Pc3HrAbl/v1Kt
         b11cr7EfKdfyTgpX1HXw1erl0CfirRI+DpJeRDXV52/dcQ+ufwHKb6+4Y+PK7oftlQ+s
         VIgizyJ5YsjfYa17rpBTpvocw358t5quqZoNdsNTiYo/lL24BFtMIcnHt2NMbCtlDSFu
         fS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lbEov+FhR+8nc69KMMmSEUhJy6W9UVkpDOopEtF89fc=;
        b=FWloayBAOKkR29LrjbLJ9zHKkjY+2KSuUaBqdwIN466iAwF/asJOSB+6i0aoupRJOT
         okX+cO8RxKScDlG+8+lnzQzDBydGK2NEwfDU9991gPRX7wVuIcBh2KwLem3lwJUP91m4
         8KP7PTI77v4RVd7YahjBNTEIyoLGynaPuGsgXajpKWex/mSa3QSYO59iGqWm2CSwpJHl
         YvFJaFPzBs6MljGC8ainUeUcPbVvEfRWvAf9Kwy3eM8RGwdqzgmRU+V5XyGTEqvs0dCg
         V/GRN0Zzgrn4n57xXcc6pzIBUYLYsEqjKf8V/jaLFYoHH2KTBmpjgy4u9Kb3m5HX8t6z
         cgKw==
X-Gm-Message-State: AOAM5310JkqzZcQYinEXR21FA3Dg9aiePMZ3hz2zpgiAl9JN8QjheRA+
        vIjnhL16qcw3h6pi1/n4dNE=
X-Google-Smtp-Source: ABdhPJzXf5hMGAiB6o95CsJMVMem8LRUsG1FjHy8vj+Fb6+9Oi+3CUoVcaBLjiqSZx0wvTClo68J2w==
X-Received: by 2002:a63:2bc4:0:b0:3ab:1d76:64db with SMTP id r187-20020a632bc4000000b003ab1d7664dbmr9372414pgr.508.1651496083959;
        Mon, 02 May 2022 05:54:43 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:3:7753:ad69:7fc0:9dfc])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b0050dc76281cesm4634892pff.168.2022.05.02.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:54:43 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
Subject: [RFC PATCH V2 0/2] swiotlb: Add child io tlb mem support
Date:   Mon,  2 May 2022 08:54:34 -0400
Message-Id: <20220502125436.23607-1-ltykernel@gmail.com>
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
significant lock contention on the swiotlb lock.

This patch adds child IO TLB mem support to resolve spinlock overhead
among device's queues. Each device may allocate IO tlb mem and setup
child IO TLB mem according to queue number. The number child IO tlb
mem maybe set up equal with device queue number and this helps to resolve
swiotlb spinlock overhead among devices and queues.

Patch 2 introduces IO TLB Block concepts and swiotlb_device_allocate()
API to allocate per-device swiotlb bounce buffer. The new API Accepts
queue number as the number of child IO TLB mem to set up device's IO
TLB mem.

Tianyu Lan (2):
  swiotlb: Add Child IO TLB mem support
  Swiotlb: Add device bounce buffer allocation interface

 include/linux/swiotlb.h |  40 ++++++
 kernel/dma/swiotlb.c    | 290 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 317 insertions(+), 13 deletions(-)

-- 
2.25.1

