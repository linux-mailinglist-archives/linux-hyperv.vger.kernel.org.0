Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10224783754
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 03:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjHVBWn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Aug 2023 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjHVBWk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Aug 2023 21:22:40 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA631123;
        Mon, 21 Aug 2023 18:22:38 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bf1935f6c2so26452505ad.1;
        Mon, 21 Aug 2023 18:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692667358; x=1693272158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4XMj6NCEe6Vw86vn80CV6xa830vO2fpeQEV9NovfxU=;
        b=kuLXc8zg+iUYY6rwMVDghw9elJlZlaXB2Pw9kzkvOlsQMI5RopnGbOCi8fv3qU1kkd
         A4+Jvoi9C+yxo13F01UGMll7wDwUfadas326RKZY5ew4LL/sJSTsr4aaFu4nq4cqPErE
         x3JBIS4hCJ+yrH0ghlk45jLLzKK5uBDWiB+trGTmi9a6LJSe10OG3jYlEaT4EsPK/c5c
         IEJ99V2LYX9nKHJkVSfTL5keJ6h3vr7EAi1KuOJBlVTyaTV+e2cjcWayIU2guLwJRNYa
         42Gmc6k9yraPdH0fFN/yVTZFdbBJ+767Cb13iHqHgguTrrboWGjXM2Ji/UaDvz0lejAN
         ofYg==
X-Gm-Message-State: AOJu0YzxcddVZG6Ou4o7kYFmEMBIDeLHa885IdDKwoHkov8ACdvKe3qB
        FXuYKvxJPPXZnEF524anWeo=
X-Google-Smtp-Source: AGHT+IEReTPdnzD7gRJqUON++JWGiLkPednkeuQJ9Q/LGmsS3qQTO7HlxxeZYUTBxkB0Kho8i/vjYg==
X-Received: by 2002:a17:903:41d1:b0:1bf:193a:70b6 with SMTP id u17-20020a17090341d100b001bf193a70b6mr12540696ple.5.1692667357727;
        Mon, 21 Aug 2023 18:22:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001bbb1eec92dsm7683523plo.224.2023.08.21.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:22:37 -0700 (PDT)
Date:   Tue, 22 Aug 2023 01:22:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Message-ID: <ZOQNyVtQ9Cilfk92@liuwe-devbox-debian-v2>
References: <20230816175939.21566-1-decui@microsoft.com>
 <BYAPR21MB16888FCA41CEB8569685FBB1D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16888FCA41CEB8569685FBB1D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 16, 2023 at 08:10:25PM +0000, Michael Kelley (LINUX) wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, August 16, 2023 11:00 AM
> > 
> > When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
> > device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
> > device yet), doing a VM hibernation triggers a panic in
> > hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
> > pdev->dev.msi.data is still NULL.
> > 
> > Avoid the panic by checking if MSI-X/MSI is enabled.
> > 
> > Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> > 
> > Changes in v2:
> >     Replaced the test "if (!pdev->dev.msi.data)" with
> > 		      "if (!pdev->msi_enabled && !pdev->msix_enabled)".
> >       Thanks Michael!
> >     Updated the changelog accordingly.
> > 
> >  drivers/pci/controller/pci-hyperv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 2d93d0c4f10d..bed3cefdaf19 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
> >  	struct msi_desc *entry;
> >  	int ret = 0;
> > 
> > +	if (!pdev->msi_enabled && !pdev->msix_enabled)
> > +		return 0;
> > +
> >  	msi_lock_descs(&pdev->dev);
> >  	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
> >  		irq_data = irq_get_irq_data(entry->irq);
> > --
> > 2.25.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> 

I expect this to go through the PCI tree. Just let me know if I should
pick this up.

Thanks,
Wei.
