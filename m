Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC754BEA23
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiBUSFM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 13:05:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiBUSEY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 13:04:24 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D071AD90;
        Mon, 21 Feb 2022 09:56:03 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id d27so28483240wrb.5;
        Mon, 21 Feb 2022 09:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQ/Oyj3CQfmniV07x3o++/fZN+iiONMTqxiWxhJRUlY=;
        b=IaeQ3I2f6ayb3wpZCA4cKOoVf/SepEdNbhwAXPV23UjaibSB9oUR47V4Lekl+g3G0S
         LaOiWiQLmD/hMKwb19+0IENZXqkkeBMUFmfN66PE7vkpwak5ryQEXgzuyym/b5u/47O0
         AkXEx3HY4KgDv0inu88D68NNoj2ag9vRwKG+PsIjSgLjPSexGxAmmYNdxoWqU4J/Zgv1
         Q16XWGyeI42WIxFOt2fRBjQSYti3ZqZenvhIW/fDE+arwIBQePPAAv/1nrMST7L+f+Yx
         h1eRjhjXocerZqjz05hOE5ZNnRHAt96BT+Omv9no/rrfl/Q/MWV26+mLMTx3cSgNV2YG
         1J+Q==
X-Gm-Message-State: AOAM530ufGRl7J9qPKqmj7EUBPJu0wfgfd8DQhizr03IVaf7kivWPaWI
        BqmDKOwPPpsOz2vK/yCZNoE=
X-Google-Smtp-Source: ABdhPJxP5lu5chi+n8ksMNCmt7siV/ZlHwzfFSI60qorTjR4H+rzP++PgZMJY8qoNLyww1EqY9tqwQ==
X-Received: by 2002:a5d:4d0d:0:b0:1e7:a9e7:ad31 with SMTP id z13-20020a5d4d0d000000b001e7a9e7ad31mr16266827wrt.281.1645466161856;
        Mon, 21 Feb 2022 09:56:01 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d2sm22558483wro.49.2022.02.21.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:56:01 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:56:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall
 in irq_unmask() on ARM64
Message-ID: <20220221175600.gxbphsnbytgytcpz@liuwe-devbox-debian-v2>
References: <20220217034525.1687678-1-boqun.feng@gmail.com>
 <MWHPR21MB1593A265118977A57FF3B329D7369@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593A265118977A57FF3B329D7369@MWHPR21MB1593.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 17, 2022 at 04:31:06PM +0000, Michael Kelley (LINUX) wrote:
> From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 16, 2022 7:45 PM
> > 
> > On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> > devices, and SPIs can be managed directly via GICD registers. Therefore
> > the retarget interrupt hypercall is not needed on ARM64.
> > 
> > An arch-specific interface hv_arch_irq_unmask() is introduced to handle
> > the architecture level differences on this. For x86, the behavior
> > remains unchanged, while for ARM64 no hypercall is invoked when
> > unmasking an irq for virtual PCI devices.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > v1 -> v2:
> > 
> > *	Introduce arch-specific interface hv_arch_irq_unmask() as
> > 	suggested by Bjorn
> > 
> >  drivers/pci/controller/pci-hyperv.c | 233 +++++++++++++++-------------
> >  1 file changed, 122 insertions(+), 111 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I expect this to go through the PCI tree. Let me know if I should pick
this up.

Thanks,
Wei.
