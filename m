Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956C523BE4
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbiEKRvc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbiEKRvb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 13:51:31 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4D4839F;
        Wed, 11 May 2022 10:51:30 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1652670wme.3;
        Wed, 11 May 2022 10:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQGxLtNoh2A/ECrPGH0MG2WOSwIRhsRl05qWLoUIhKc=;
        b=B8V0XQ8Cg2dWrsPzvWCpgHYnWDsBL+V6f1lY389lJW5m8hubKSZ6D1uuzAimSf6tpY
         7t2eDTfMZSeaVOEOj723+LuQOHrmZkkGbmtroduY00CXphLRofGH000xeC/+uFFNS86X
         7BWGwLxI+rRXKmMafqpmhZXVYpqTATWb/qUNVE4OHa4yT/rUm0xEkxkERqTU7/k3lQc7
         qMOwJHNlmJHW4nuxcd6rZhal8KNUOp3Qq+3wJ9FHTzGfKLdeK8pBZYJk3LGjgInSNt07
         5kPmDo+CuypZfCEZNPYlIbtlSXfpujjAmvDTsro/3sRv7vlvgvIQeTI8SxUfRE/rllcc
         QHGw==
X-Gm-Message-State: AOAM533vDD0yrFRRwbVKW5fgyVKhc351xx67otoAMGl5Q9B2wTG0kaZq
        9ZLXk1PuMfanHscHyJxVu8+eTedQJ6c=
X-Google-Smtp-Source: ABdhPJzzYvMP2x6heJp40ACS+Y59uZMrdJ58/WzlFFCkCHpOK55xWUK1YSFC+WBM3UBpA7NQrop7cw==
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr5990227wmj.45.1652291488581;
        Wed, 11 May 2022 10:51:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0020cd0762f37sm2236906wrz.107.2022.05.11.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:51:27 -0700 (PDT)
Date:   Wed, 11 May 2022 17:51:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        jakeo@microsoft.com, dazhan@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hyperv compose_msi_msg fixups
Message-ID: <20220511175126.ezrayygwqmrvm7ql@liuwe-devbox-debian-v2>
References: <1652282533-21502-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652282533-21502-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 11, 2022 at 09:22:11AM -0600, Jeffrey Hugo wrote:
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

Applied this version to hyperv-next. Thanks.
