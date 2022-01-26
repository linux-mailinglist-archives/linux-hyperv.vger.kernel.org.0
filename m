Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB82749CF46
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiAZQLK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jan 2022 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiAZQLJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jan 2022 11:11:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB7C06161C;
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j10so9333657pgc.6;
        Wed, 26 Jan 2022 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJlQgMOdzOpMdf2t1XhINYD9th+quD5vXgXLujbMrXw=;
        b=R4Bfn186yJ2h2iAnn75qDBMXPx31A+KGAptApzHgK9YFmMr7rPTZIejMEO4GV1Izzq
         u27ZAELgpedJodaq/uQ6lnGeqUmgeyu3FOuKWIJsIvUhxpCkgELzb72CB8vjtGceqyth
         1SeTvg1CV3xjZ9OUDVsrIHcbmJN201BFEBkOlEWtPW90dwx7MbS7dg99u1YOjxBafKQB
         qpzeKD97jLFdQgo/ot3uC7Hjuv/3tNQ9/LksoxXiZ+CokPWG1g6Sn/PcNHx/mOwQ03DA
         ulEFltjT2HhW/ipjaynwoI/0orSVYpLSBuaFoJRZ0k8Ab999NsDf1rVI4Si/sQMIbMf8
         1nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJlQgMOdzOpMdf2t1XhINYD9th+quD5vXgXLujbMrXw=;
        b=gnHyCuqNEb8Q02mj0CuyglhW+AEPr+iFA3vrhkVBHCP9dNICWqqE9j33hxIr1TVnYw
         tAPuGhArv6Z32hbsKIkzBlAwg5OhmGQRs7T1VuswOFs7473GTOB/z/8b8kYZb9jzdAFY
         J3QOK3Wq0K6+piFtmr5+/4E1xhP2Z9R1qBnREavV8rpye1SkOqtDICTGB0OfkwSZbUgx
         LliSazqAJoTt0DklG0YVmCsq43ugP1XLtRwX7Q4ldYrub+0Tu0k3T1l5dEQAvcI1Pygr
         iS4Z5JOvpLEfkKJVHnrcQ/xtLB2ZkK+7eEoxHaajKI9XO5AkcfW9yBl/m5oCGEma+bzl
         KyMw==
X-Gm-Message-State: AOAM532I94jPs35IZSNtxx/defq29euJf/G3nJ9jkRR1j9eg2s5F/3My
        1Tab7PymTgfZzhszGW/ziBWE+92UAW0=
X-Google-Smtp-Source: ABdhPJzTD24IB15DhwEOQaTAU9UVRYQRs92SBHaR2aTpmWbIBqvbdG21oKDt0iSc/VgjlbVpBNKFrA==
X-Received: by 2002:a05:6a00:a20:b0:4bb:95f6:93b3 with SMTP id p32-20020a056a000a2000b004bb95f693b3mr23480200pfh.77.1643213468515;
        Wed, 26 Jan 2022 08:11:08 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:35:cf50:7507:71bb:9b04])
        by smtp.gmail.com with ESMTPSA id b9sm2555534pfm.154.2022.01.26.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:11:08 -0800 (PST)
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
Subject: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages switch
Date:   Wed, 26 Jan 2022 11:10:51 -0500
Message-Id: <20220126161053.297386-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM may fail to allocate swiotlb bounce buffer due
to there is no enough contiguous memory from 0 to 4G in some cases.
Current swiotlb code allocate bounce buffer in the low end memory.
This patchset adds a switch "swiotlb_alloc_from_low_pages" and it's
set to true by default. Platform may clear it if necessary. Devices
in Hyper-V Isolation VM may use memory above 4G as DMA memory and set
the switch to false in order to avoid no enough contiguous memory in
low end address space.

Tianyu Lan (2):
  Swiotlb: Add swiotlb_alloc_from_low_pages switch
  x86/hyperv: Set swiotlb_alloc_from_low_pages to false

 arch/x86/kernel/cpu/mshyperv.c |  1 +
 include/linux/swiotlb.h        |  1 +
 kernel/dma/swiotlb.c           | 13 +++++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

