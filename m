Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571535137CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiD1PLk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PLi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:11:38 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8B29803;
        Thu, 28 Apr 2022 08:08:22 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id y21so3125982wmi.2;
        Thu, 28 Apr 2022 08:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TuvJXwCxTMF9s75L3H+hv+7anX+/ghGmSwT77QY4zP8=;
        b=4HVpBKwq2cPnaeoBt8UebBR6tx6SmDAA2qQe7kihgXzztJmOZHUNDVQC1Xf7ZrTdxA
         7mmGD6zcTKIkwFPS11RuwcPcd6EnlyO0urXKIIrodOhecDpWizchTbJ1BnvuubA4BJ2W
         pUf+wnAKG1Qz2zwsST9+07qUx2Ed3JPTg09zmVGYC3hp5WqYG+YDah8WjIkhrbkrtQsB
         UZe5h5SXno978FfMklmE2GPMjnGTLl3I7VL3iDjubYabdGL9vaxYuyvPEm55MJwPoLTn
         fSznsJqXMqZf2VyKCPz2H0EpBWLznkjydNOmjAbcCZotXd98TFITe/7OgR5NIne+FxdE
         aoUQ==
X-Gm-Message-State: AOAM531LucsiheyGIhIB4yfBBZznR4RK3hJ+V3hHYs9HZGzk4aNWZ7Yh
        rHWxKBMQzUJoAFxbXuW9KJCoXO/l8c4=
X-Google-Smtp-Source: ABdhPJyWmp6Skbs9TUpCJL9uBx1rklPO1cb+sQDParNc4Y7M0X4W7/LTGjpTnoK4PN2GAgyRkNmMmA==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr31116251wmc.5.1651158501549;
        Thu, 28 Apr 2022 08:08:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b00393fecce6b6sm200853wmq.23.2022.04.28.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:08:20 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:08:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, bjorn.andersson@linaro.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Message-ID: <20220428150819.xwiqqdhgrgrxcstf@liuwe-devbox-debian-v2>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
 <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
 <dec6b3a9-e988-aa10-817c-21f2d45194c9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec6b3a9-e988-aa10-817c-21f2d45194c9@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 28, 2022 at 09:06:42AM -0600, Jeffrey Hugo wrote:
> On 4/28/2022 8:58 AM, Wei Liu wrote:
> > On Wed, Apr 27, 2022 at 08:07:33AM -0600, Jeffrey Hugo wrote:
> > > In the multi-MSI case, hv_arch_irq_unmask() will only operate on the first
> > > MSI of the N allocated.  This is because only the first msi_desc is cached
> > > and it is shared by all the MSIs of the multi-MSI block.  This means that
> > > hv_arch_irq_unmask() gets the correct address, but the wrong data (always
> > > 0).
> > > 
> > > This can break MSIs.
> > > 
> > > Lets assume MSI0 is vector 34 on CPU0, and MSI1 is vector 33 on CPU0.
> > > 
> > > hv_arch_irq_unmask() is called on MSI0.  It uses a hypercall to configure
> > > the MSI address and data (0) to vector 34 of CPU0.  This is correct.  Then
> > > hv_arch_irq_unmask is called on MSI1.  It uses another hypercall to
> > > configure the MSI address and data (0) to vector 33 of CPU0.  This is
> > > wrong, and results in both MSI0 and MSI1 being routed to vector 33.  Linux
> > > will observe extra instances of MSI1 and no instances of MSI0 despite the
> > > endpoint device behaving correctly.
> > > 
> > > For the multi-MSI case, we need unique address and data info for each MSI,
> > > but the cached msi_desc does not provide that.  However, that information
> > > can be gotten from the int_desc cached in the chip_data by
> > > compose_msi_msg().  Fix the multi-MSI case to use that cached information
> > > instead.  Since hv_set_msi_entry_from_desc() is no longer applicable,
> > > remove it.
> > > 
> > > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > ---
> > >   drivers/pci/controller/pci-hyperv.c | 12 ++++--------
> > >   1 file changed, 4 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 5800ecf..7aea0b7 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -611,13 +611,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> > >   	return cfg->vector;
> > >   }
> > > -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> > > -				       struct msi_desc *msi_desc)
> > > -{
> > > -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> > > -	msi_entry->data.as_uint32 = msi_desc->msg.data;
> > > -}
> > > -
> > 
> > Instead of dropping this function, can you change the second argument to
> > take struct tran_int_desc *?
> > 
> > This way you can use the same function in hv_compose_msi_msg.
> 
> I do not see how this could be reused in hv_compose_msi_msg() with the
> proposed change of the second argument.  The hv_msi_entry type is not used
> in hv_compose_msi_msg(), nor does it look like it is applicable anywhere
> within the function.
> 
> What am I missing?

I mixed up two different types while going through the code --
hv_msi_entry and Linux's own msi_entry type. Sorry for the noise.

Wei.
