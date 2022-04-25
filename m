Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1350E47B
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiDYPgw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDYPgv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 11:36:51 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299243380;
        Mon, 25 Apr 2022 08:33:47 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id t6so17992354wra.4;
        Mon, 25 Apr 2022 08:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OQDcwFgZu/P9vx+VQN8SgQh5Ecb0LyT6OAUuz0M6w4=;
        b=4ejo69psq47xfRafXKT+ybqY29uqxJ4p476g4qUM+YXu2lYqbq/Gs5co6aFO/lcxd/
         qOU3HFYTMaua9Mnh9Lb4rkg6XModqPwp4vN74kfwi144vnzqc/53UmFIKQGMgPAcxNyQ
         TreDyzBofHA5PYepMmGRCwHythQMlH1TUgsipqUkyHwku5JMZIWs3PJjJCCCpPw9yMrl
         /Q0rlKYU9oRSRviI5tnP+xcojBuT2bJOUu5qiJEQL8CanvAw20jrI/1JN9IM8Dpr4BTj
         mT93VJnssFyoig4H4/pk0CZl5Fkt7NKPl3hV0AFnjsHGRtvFSZ1TBw3kx7YeVKbr7BBh
         1eOg==
X-Gm-Message-State: AOAM530FNG2b0VrX5crGfTH4vor7cjshMYkGqAFgXndbdvcP5RXkUwJU
        c8Am8HTM+Rf8dMC9Gm3QcXw=
X-Google-Smtp-Source: ABdhPJy33w5nmyRINYX7dcYjstdfIFot4qy6wHNJDM5nuqJqkpo7RIQBW60m1pDN7gGh2dmpAaArFw==
X-Received: by 2002:adf:f64b:0:b0:20a:c685:89ee with SMTP id x11-20020adff64b000000b0020ac68589eemr13797875wrp.366.1650900826224;
        Mon, 25 Apr 2022 08:33:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i27-20020a1c541b000000b003928e866d32sm12212227wmb.37.2022.04.25.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:33:45 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:33:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        jakeo@microsoft.com, bjorn.andersson@linaro.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Fix multi-MSI to allow more than one MSI
 vector
Message-ID: <20220425153344.lgo3kdnrbef75jcq@liuwe-devbox-debian-v2>
References: <1649856981-14649-1-git-send-email-quic_jhugo@quicinc.com>
 <2100eed4-8081-6070-beaf-7c6ba65ad9be@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2100eed4-8081-6070-beaf-7c6ba65ad9be@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 20, 2022 at 08:13:22AM -0600, Jeffrey Hugo wrote:
> On 4/13/2022 7:36 AM, Jeffrey Hugo wrote:
> > If the allocation of multiple MSI vectors for multi-MSI fails in the core
> > PCI framework, the framework will retry the allocation as a single MSI
> > vector, assuming that meets the min_vecs specified by the requesting
> > driver.
> > 
> > Hyper-V advertises that multi-MSI is supported, but reuses the VECTOR
> > domain to implement that for x86.  The VECTOR domain does not support
> > multi-MSI, so the alloc will always fail and fallback to a single MSI
> > allocation.
> > 
> > In short, Hyper-V advertises a capability it does not implement.
> > 
> > Hyper-V can support multi-MSI because it coordinates with the hypervisor
> > to map the MSIs in the IOMMU's interrupt remapper, which is something the
> > VECTOR domain does not have.  Therefore the fix is simple - copy what the
> > x86 IOMMU drivers (AMD/Intel-IR) do by removing
> > X86_IRQ_ALLOC_CONTIGUOUS_VECTORS after calling the VECTOR domain's
> > pci_msi_prepare().
> > 
> > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > ---
> 
> Ping?
> 
> I don't see this in -next, nor have I seen any replies.  It is possible I
> have missed some kind of update, but currently I'm wondering if this change
> is progressing or not.  If there is some kind of process used in this area,
> I'm not familiar with it, so I would appreciate an introduction.

I expect the PCI maintainers to pick this up. If I don't see this picked
up in this week I will apply it to hyperv-next.

Thanks,
Wei.

> 
> Thanks
> 
> -Jeff
