Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17E50E4BF
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiDYPxE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiDYPxD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 11:53:03 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED20BA9;
        Mon, 25 Apr 2022 08:49:59 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so158641wmb.1;
        Mon, 25 Apr 2022 08:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dINFpaCbS4KzhGo60nkrcp0X5fb+XY1bioBgslMItlI=;
        b=UKvvysUHP1ODfZ4oBgPfQMz7yr93KTJJ7r5NIDTl+ysoXCIsCZ2yhWxx8yu0ZeCmo/
         8imZMdqFItCNpCOmfB4rtYMzS6gJ0ZOPi/BzjT/yG8wxAG5Nm2mTkyYy42V38+mMtvov
         fO2AqSRwA/8iKx3RQtcmdOXoD6g2C++Lw30I0QSO8T0b2fvCYyWLsXdCoJgx83TD8QvJ
         Z/SD3EnakXa6EVPGQM9ac8ZM16Bw6xYCUG8OiV/3bLAFdjS6Ey/q2rAbplNmgnsKPoem
         Duc6uU9I0zeas4ftlVo5XUk5w4QWFCB8FoFdya71oRMumw7lpQrkEW9r0O6Z5fWKnBbG
         CY7g==
X-Gm-Message-State: AOAM531iyG3Nf1WzHghTX6otEZOaEW2WtvAnNpd1tNhofV4Z7HOq+C4j
        sCiuD3lALhgQNF1ZivBJ2jY=
X-Google-Smtp-Source: ABdhPJxWqIm+ih+s8pj8ArXHDUSbPCVgSHcKX5S0d8LU9XSVFZo4TYRONo+EF4yClNue90Hli2DmXA==
X-Received: by 2002:a05:600c:348f:b0:393:dcff:f95b with SMTP id a15-20020a05600c348f00b00393dcfff95bmr14491615wmq.76.1650901797718;
        Mon, 25 Apr 2022 08:49:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0038ebcbadcedsm13816593wmn.2.2022.04.25.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:49:57 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:49:55 +0000
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
Message-ID: <20220425154955.2glxbfeln47m4cin@liuwe-devbox-debian-v2>
References: <1649856981-14649-1-git-send-email-quic_jhugo@quicinc.com>
 <2100eed4-8081-6070-beaf-7c6ba65ad9be@quicinc.com>
 <20220425153344.lgo3kdnrbef75jcq@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425153344.lgo3kdnrbef75jcq@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 25, 2022 at 03:33:44PM +0000, Wei Liu wrote:
> On Wed, Apr 20, 2022 at 08:13:22AM -0600, Jeffrey Hugo wrote:
> > On 4/13/2022 7:36 AM, Jeffrey Hugo wrote:
> > > If the allocation of multiple MSI vectors for multi-MSI fails in the core
> > > PCI framework, the framework will retry the allocation as a single MSI
> > > vector, assuming that meets the min_vecs specified by the requesting
> > > driver.
> > > 
> > > Hyper-V advertises that multi-MSI is supported, but reuses the VECTOR
> > > domain to implement that for x86.  The VECTOR domain does not support
> > > multi-MSI, so the alloc will always fail and fallback to a single MSI
> > > allocation.
> > > 
> > > In short, Hyper-V advertises a capability it does not implement.
> > > 
> > > Hyper-V can support multi-MSI because it coordinates with the hypervisor
> > > to map the MSIs in the IOMMU's interrupt remapper, which is something the
> > > VECTOR domain does not have.  Therefore the fix is simple - copy what the
> > > x86 IOMMU drivers (AMD/Intel-IR) do by removing
> > > X86_IRQ_ALLOC_CONTIGUOUS_VECTORS after calling the VECTOR domain's
> > > pci_msi_prepare().
> > > 
> > > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > ---
> > 
> > Ping?
> > 
> > I don't see this in -next, nor have I seen any replies.  It is possible I
> > have missed some kind of update, but currently I'm wondering if this change
> > is progressing or not.  If there is some kind of process used in this area,
> > I'm not familiar with it, so I would appreciate an introduction.
> 
> I expect the PCI maintainers to pick this up. If I don't see this picked
> up in this week I will apply it to hyperv-next.

Actually I will pick this up via hyperv-next, because there is another
series which will also touch this driver but at the some time depend on
vmbus changes. I can fix up any potential conflicts easily.

Thanks,
Wei.
