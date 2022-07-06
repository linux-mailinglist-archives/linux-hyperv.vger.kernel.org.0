Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050C15692DA
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGFTvY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFTvY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 15:51:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C19165BD;
        Wed,  6 Jul 2022 12:51:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z41so20609634ede.1;
        Wed, 06 Jul 2022 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Uniy8LBcxVwi6NUSTS6A3GCA+91o6vI7rMz3Wtdlk=;
        b=qiUwOsPCNmCmsMJzHRsMCaqHx/A29XFx+rEtXjpqLg05bj73vgI77R8nubnEYJ+G4/
         p3lABAQJJTZVJuLPfbcf0/Fbe8CGrKSC202O5G+CGOx6Ltsc0jTW4ZBsabqe1nhSvicM
         hGITTa5Eqvo/4HZ2OLE8sSJ1r0Z5cDjhIo9poy31FT4uT+YeMzQBou6F7hhhgFNb0vJB
         gmaOFBXvzYhqf5RoSr/SXJ6AaRWj15Xso85XVvRCE/8azbqlsFTr9Nc43wazo2H6U4Up
         0lZgKwKvQDF3FBwGEZ7WpsN1gQthA4oR2esJEp+LJQ6WbXe6sXLmZpHrG7GEeW8fjJtk
         O26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Uniy8LBcxVwi6NUSTS6A3GCA+91o6vI7rMz3Wtdlk=;
        b=ZIGmxIEubLkKXLb+eTYSKjKHL8M6MXjG83IwLUdAk1BK0emtnWC+cBMGbOHCMOwl8a
         MUYEd+ylgoHgdPn7M6mcXJXSQfllOfC2XNi5mbaH1r4WMwlerOT4g745ufaPFzo/ESZS
         gocvOz/h5QCFMN6fBQfN6BIfRUdPndDsUEKfxic1TZvfIbgg61C8uSiOpkj+x3X4rtAX
         cy1IPtpTXlsInbLaYZivsaWPUMpZhBN6Ru5iQ+Vyim1D3xOsqBF1OxGHS7E9RbCHZ9yz
         FvbbKP+oDB6pCnemy8MCUOONkD6R3R0BPNVD7f+3c+TxIKnTWWQ8oBrlihTcB7jNXH9c
         gplQ==
X-Gm-Message-State: AJIora9p6HsBzRNihhfsAtqAlFqrvxNVEM1eGUPwiVFz+xiBJpQPZcSv
        SLS8Fvp9YmToju6loElkYkw=
X-Google-Smtp-Source: AGRyM1tL5OpzeEvjnryKM1zyCU6rO5tLkN/wI78MRbQT2J+6bNMgnN1GnuVvmU0S8Pptetfi9UCRhA==
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id i11-20020a05640242cb00b0043a5df2bb5dmr23876112edc.36.1657137080986;
        Wed, 06 Jul 2022 12:51:20 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-199-193.retail.telecomitalia.it. [79.49.199.193])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1968127ejc.225.2022.07.06.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:51:20 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        x86@kernel.org, "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 0/2] dma_direct_{alloc,free}() for Hyper-V IVMs
Date:   Wed,  6 Jul 2022 21:50:25 +0200
Message-Id: <20220706195027.76026-1-parri.andrea@gmail.com>
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

Through swiotlb_unencrypted_base.

P.S.  I'm on vacation for the next couple of weeks starting next Monday;
Dexuan/Michael should be able to address review feedback in that period.

Andrea Parri (Microsoft) (2):
  swiotlb,dma-direct: Move swiotlb_unencrypted_base to direct.c
  dma-direct: Fix dma_direct_{alloc,free}() for Hyperv-V IVMs

 arch/x86/kernel/cpu/mshyperv.c |  6 +++---
 include/linux/dma-direct.h     |  2 ++
 include/linux/swiotlb.h        |  2 --
 kernel/dma/direct.c            | 38 +++++++++++++++++++++++++++++++++-
 kernel/dma/swiotlb.c           | 12 +++++------
 5 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.25.1

