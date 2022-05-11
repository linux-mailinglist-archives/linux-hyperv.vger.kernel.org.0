Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97B5235CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiEKOlx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiEKOlw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 10:41:52 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8962124;
        Wed, 11 May 2022 07:41:51 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1358671wme.3;
        Wed, 11 May 2022 07:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=raSRRTCAVGSx3TYDCF2KseubaUXW02wZiWAl7TPOzDs=;
        b=mq1rz1X+YQh2fcPq+AIQHeVM/QqY7++9HXLrtiBSmzyLi0w92GD/pwfEEMVA3SxLTe
         pOD9n385lQapFQ2Q7oUpHnaztxWDemPfjcaWdSQxvf+8yz71+xrljpZ4VlnuGrPrjZsv
         U8L2eS/46u2nBhrjYtELpIewwwF/GJiHCjNFGuPoKB2OiOvF5VrTiQnMR2v0TDNEpk25
         t/K2ZBr0BEcVrTQQLGDeN3BM+OfYX3JWn0A7nEiVhKT/MpKdj/LMIGN8T/MAB1mFOiWR
         fF85CSAmVq+77ppUshx+XAvM5puEMLcbUomjdW9fX+sSftegngNfeQbVYLclrOXWFE0R
         N+KQ==
X-Gm-Message-State: AOAM531WeJBGgE7tPnG8CZmzIZEgiY6Y6joJdbS6/mvjRcPb39vq4Jku
        7eCVrRJyrPSxacwMIZVdq9c=
X-Google-Smtp-Source: ABdhPJz5fmaX4Xe+GcXRLoVZXNKjCRiu5LoxVTskT4iU3Dwc852RhmKZ/z+ZT7+gBP8EmIvzaiyaTg==
X-Received: by 2002:a05:600c:2844:b0:393:f6fb:5897 with SMTP id r4-20020a05600c284400b00393f6fb5897mr5332055wmb.66.1652280109603;
        Wed, 11 May 2022 07:41:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0020c5253d907sm1825838wrs.83.2022.05.11.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:41:49 -0700 (PDT)
Date:   Wed, 11 May 2022 14:41:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        jakeo@microsoft.com, dazhan@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hyperv compose_msi_msg fixups
Message-ID: <20220511144124.rj7inq6zy6bgbii4@liuwe-devbox-debian-v2>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 09, 2022 at 03:48:20PM -0600, Jeffrey Hugo wrote:
> While multi-MSI appears to work with pci-hyperv.c, there was a concern about
> how linux was doing the ITRE allocations.  Patch 2 addresses the concern.
> 
> However, patch 2 exposed an issue with how compose_msi_msg() was freeing a
> previous allocation when called for the Nth time.  Imagine a driver using
> pci_alloc_irq_vectors() to request 32 MSIs.  This would cause compose_msi_msg()
> to be called 32 times, once for each MSI.  With patch 2, MSI0 would allocate
> the ITREs needed, and MSI1-31 would use the cached information.  Then the driver
> uses request_irq() on MSI1-17.  This would call compose_msi_msg() again on those
> MSIs, which would again use the cached information.  Then unmask() would be
> called to retarget the MSIs to the right VCPU vectors.  Finally, the driver
> calls request_irq() on MSI0.  This would call conpose_msi_msg(), which would
> free the block of 32 MSIs, and allocate a new block.  This would undo the
> retarget of MSI1-17, and likely leave those MSIs targeting invalid VCPU vectors.
> This is addressed by patch 1, which is introduced first to prevent a regression.
> 
> Jeffrey Hugo (2):
>   PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
>   PCI: hv: Fix interrupt mapping for multi-MSI
> 

Applied to hyperv-next. Thanks.
