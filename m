Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041E25236F5
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiEKPTr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiEKPTq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 11:19:46 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57320D4FF;
        Wed, 11 May 2022 08:19:45 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1427519wme.4;
        Wed, 11 May 2022 08:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=llXmD2rCq1+l8jPwFHVjaI9KkiK/giTbs6qtyUFVaFE=;
        b=hqViGr2eMwvt1XQDbIyCQjIG764VWBKwuKJDuPa5kTDISu1vnn7OvnUcmNhb2Fhd9I
         +bgEVvcreZvu4b8/fH2f2ZjE+am1v1kRfjLMTWQFBhxUm1Yl9T+/hY8rY9jj+hcLiMcC
         0a1uBHuMgLflYtHmbfJc7VjhxB5sV8+DFi+q73XY8ecgrBGRtq8FV2vLnXTjQDZuz56m
         Q7uJkVCccgnncm5CoWkH1+D1lJOXwjri8iKCgeqKXpSyR92dbne9RJlpOoXN04q4PWAG
         uHqtvAgnZ7l5BAaa5lbQ9cq9mTpIS7iUMbtCW88fmzH3DdpvNloojyM9df3dnQYstwE5
         TeCA==
X-Gm-Message-State: AOAM532QjbIkQvFgRPybsz7cQGNJBmMQqYaScBDLx7q7kTx2PyhydLuk
        BtrnkSPwXN3zGDXwk49+pCI=
X-Google-Smtp-Source: ABdhPJz/IdYlaLe1v8zDU6pSmd8VWCh7Ua5p2i7f1ZEzponF7E0GJNqJnUWRh0RBxzQpyCUSwYOIGg==
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr5408256wmi.116.1652282384442;
        Wed, 11 May 2022 08:19:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p8-20020adfe608000000b0020c5253d8e6sm1882998wrm.50.2022.05.11.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:19:43 -0700 (PDT)
Date:   Wed, 11 May 2022 15:19:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, jakeo@microsoft.com,
        dazhan@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hyperv compose_msi_msg fixups
Message-ID: <20220511151942.ekxy2vodzvxzfs2e@liuwe-devbox-debian-v2>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <20220511144124.rj7inq6zy6bgbii4@liuwe-devbox-debian-v2>
 <a0e60283-a448-650f-808e-a0080ae550f7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e60283-a448-650f-808e-a0080ae550f7@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 11, 2022 at 08:47:23AM -0600, Jeffrey Hugo wrote:
> On 5/11/2022 8:41 AM, Wei Liu wrote:
> > On Mon, May 09, 2022 at 03:48:20PM -0600, Jeffrey Hugo wrote:
> > > While multi-MSI appears to work with pci-hyperv.c, there was a concern about
> > > how linux was doing the ITRE allocations.  Patch 2 addresses the concern.
> > > 
> > > However, patch 2 exposed an issue with how compose_msi_msg() was freeing a
> > > previous allocation when called for the Nth time.  Imagine a driver using
> > > pci_alloc_irq_vectors() to request 32 MSIs.  This would cause compose_msi_msg()
> > > to be called 32 times, once for each MSI.  With patch 2, MSI0 would allocate
> > > the ITREs needed, and MSI1-31 would use the cached information.  Then the driver
> > > uses request_irq() on MSI1-17.  This would call compose_msi_msg() again on those
> > > MSIs, which would again use the cached information.  Then unmask() would be
> > > called to retarget the MSIs to the right VCPU vectors.  Finally, the driver
> > > calls request_irq() on MSI0.  This would call conpose_msi_msg(), which would
> > > free the block of 32 MSIs, and allocate a new block.  This would undo the
> > > retarget of MSI1-17, and likely leave those MSIs targeting invalid VCPU vectors.
> > > This is addressed by patch 1, which is introduced first to prevent a regression.
> > > 
> > > Jeffrey Hugo (2):
> > >    PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
> > >    PCI: hv: Fix interrupt mapping for multi-MSI
> > > 
> > 
> > Applied to hyperv-next. Thanks.
> 
> Huh?  I thought you wanted a V2.  I was intending on sending that out today.
> 

Please send them out. I will apply the new version.

Thanks,
Wei.

> -Jeff
