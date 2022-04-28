Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092A5137C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbiD1PKO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiD1PKM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:10:12 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A826AD3;
        Thu, 28 Apr 2022 08:06:57 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id i5so7147780wrc.13;
        Thu, 28 Apr 2022 08:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKMP+EtRM+p5Z61cKXGNkLBY2OQzaYGe/odfhWFTzTE=;
        b=lL/W2QhieTtlW4ylcdztuka6Jg+Vvommz2CmilB2qnSKrJXqRptsWhQUtIpLesLTAD
         w8JDcXaeJdKYIbVqSA/MOk0tQGVPcIvn69sUMX5SR2xlfga7C968dyhf2TBl8AchX+zi
         B6TVPmpRSoVjFHZOpOcm++eh29MDMIPQhOaCS+OvwqmGTMlGACuD8wk3271c9EMzHJav
         ln9MDRbTcyrnkapjeML/maHX15BPEQOi9b4UHwXwlwsoi60i7uvGG3CPyh/x6kK55S9G
         hdmU2nom3mgoitJCYT65pLWs7TAgouKQE+lvxrtVfgDfaOgTc5GXLxubcSLb816ITdcn
         ltHw==
X-Gm-Message-State: AOAM532U0wKyyiH58ReVYH/xnZ/DBHQ+V5sm0wIMyFnnxizq6VvrRr4W
        R2ysa449d9dkgxnv0l+S0wlt2ppK/yw=
X-Google-Smtp-Source: ABdhPJwP3MsRl8DEbO5rY3vrEfY6CzgUNktfd0NpPcsppKB4VLQLPqtZoN3sjeei0JwGSHOKEK3Kgw==
X-Received: by 2002:a5d:648a:0:b0:20a:e388:7f2b with SMTP id o10-20020a5d648a000000b0020ae3887f2bmr12094998wri.443.1651158415771;
        Thu, 28 Apr 2022 08:06:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r184-20020a1c2bc1000000b00392af6f0ab0sm192671wmr.18.2022.04.28.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:06:55 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:06:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        bjorn.andersson@linaro.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Message-ID: <20220428150653.xqpigo5cvy7k4zek@liuwe-devbox-debian-v2>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
 <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 28, 2022 at 02:58:24PM +0000, Wei Liu wrote:
> On Wed, Apr 27, 2022 at 08:07:33AM -0600, Jeffrey Hugo wrote:
> > In the multi-MSI case, hv_arch_irq_unmask() will only operate on the first
> > MSI of the N allocated.  This is because only the first msi_desc is cached
> > and it is shared by all the MSIs of the multi-MSI block.  This means that
> > hv_arch_irq_unmask() gets the correct address, but the wrong data (always
> > 0).
> > 
> > This can break MSIs.
> > 
> > Lets assume MSI0 is vector 34 on CPU0, and MSI1 is vector 33 on CPU0.
> > 
> > hv_arch_irq_unmask() is called on MSI0.  It uses a hypercall to configure
> > the MSI address and data (0) to vector 34 of CPU0.  This is correct.  Then
> > hv_arch_irq_unmask is called on MSI1.  It uses another hypercall to
> > configure the MSI address and data (0) to vector 33 of CPU0.  This is
> > wrong, and results in both MSI0 and MSI1 being routed to vector 33.  Linux
> > will observe extra instances of MSI1 and no instances of MSI0 despite the
> > endpoint device behaving correctly.
> > 
> > For the multi-MSI case, we need unique address and data info for each MSI,
> > but the cached msi_desc does not provide that.  However, that information
> > can be gotten from the int_desc cached in the chip_data by
> > compose_msi_msg().  Fix the multi-MSI case to use that cached information
> > instead.  Since hv_set_msi_entry_from_desc() is no longer applicable,
> > remove it.
> > 
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 5800ecf..7aea0b7 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -611,13 +611,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> >  	return cfg->vector;
> >  }
> >  
> > -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> > -				       struct msi_desc *msi_desc)
> > -{
> > -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> > -	msi_entry->data.as_uint32 = msi_desc->msg.data;
> > -}
> > -
> 
> Instead of dropping this function, can you change the second argument to
> take struct tran_int_desc *?
> 
> This way you can use the same function in hv_compose_msi_msg.
> 

Never mind. I think I mixed things up. Sorry for the noise.
