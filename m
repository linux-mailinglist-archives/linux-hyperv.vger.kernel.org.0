Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA74C9BE1
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 04:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiCBDOy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 22:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiCBDOx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 22:14:53 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7BAEF16;
        Tue,  1 Mar 2022 19:14:11 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r7so430348iot.3;
        Tue, 01 Mar 2022 19:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYcFqXZ3f+3vaLrLlPHVjivEfeCZxjhL/C8gZ+zIprU=;
        b=kYULTdoHBl9943ttJvK8zc3511heUc9zNOHTLC8o/fXVmSh0hiXNvNQYREC75HRZGU
         fCKLhnnHbKXJ0+TFl8zRlQkCEzPf4mDwhsBJrNhV8JvkrKY1HtHAi92x24BOZbVDeZnA
         W+BoDdN2NB6y8AjJZSmywm7bBuxiuthfwb5bLiBkg4SOfZ/IVASG1nsqD+Vsn8IJQspo
         dQmrwJEg+QMGKDLduCpVT4hjNPYPhDJZZg+tefF813dY/YqKQguuNwgBlmmgGO0/bn4s
         aCaZwjVFJ4IDBW6rrEQcI1HfXMcr2BwyP+Af/FaFf/OMwKCGHFrkwsByPqEzZuihB7/o
         Z99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYcFqXZ3f+3vaLrLlPHVjivEfeCZxjhL/C8gZ+zIprU=;
        b=6/KL71UM1tWCZwkEapkUxbZBWHg3dVzwoEuI+vxggmVkWgG4uD4d23VOJnsY8vA+qh
         FoxhuFg0WhhkXyzunCH2AqJq4trS5tjWh6biR3cFVWRzpBi6JDJwQ0uQy2K8UpcdvIj7
         kLiEl5FlMc8qxgMn/cBdQPVTxA9L6/ZOdrK8QTXdxk4p25Q7z0cuG67AJ1LVCTumu2VM
         s2Ce1JrRMVxnod/G1GUdqam09Y6Tyuxs9BNv6Er3m8KPb4aO1K7NHZ97y/HdUgcItOW4
         h3aDgRwUhWn9YDLDBZhvAL/X+zkB69s5GgXesG8u4btvsRbo4PrEpiTuIrygS+0kGKCo
         1Z7w==
X-Gm-Message-State: AOAM532Zn6JEuI0eXPXpR9R0nKsddBZuc77B/Ethf5DkJ+WxlOA1o1q7
        wBORYxzi8a2mWIGopH4xZsM=
X-Google-Smtp-Source: ABdhPJw05AvAfdvmaxRyIyts0b9CxLZQXZOgSNW87dIDgLcUFsaKeKi9cU0QZp6THIK0IyZPkHZWjA==
X-Received: by 2002:a05:6638:502:b0:30e:4b0c:55cf with SMTP id i2-20020a056638050200b0030e4b0c55cfmr23313828jar.11.1646190851140;
        Tue, 01 Mar 2022 19:14:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cbcc000000b002bd04428740sm8832499ilq.80.2022.03.01.19.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 19:14:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CA1F627C0054;
        Tue,  1 Mar 2022 22:14:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Mar 2022 22:14:08 -0500
X-ME-Sender: <xms:AOEeYiTcplFmAgrzemTsPswU0VNuS5WoAOc5EajKGv98ZYv9gyLAgQ>
    <xme:AOEeYnwv-h4k7UW3aZR9rffEr1aYYNcpK-6opUbXYWPR7m_PJIaVhHMMPD6XPUYYT
    lRHBz3Q5-xoOTxaBw>
X-ME-Received: <xmr:AOEeYv333zzh_yCgMIa52pnCRZ4-XKo-_c4evfe0TA7bzaQIujNGqKmzJKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:AOEeYuBQSWz4IF9CMwAKI_6fY2IGsQhGLHLgbtLXPr3qHQ6FiY0vDA>
    <xmx:AOEeYrhzpARo5eMWdmlHJ1aY4xYIjMwyVFzyFlCKsBP2XK4a5HZ83w>
    <xmx:AOEeYqoxg3hOyW6JJ_77ufdWALGxbhwXyxVbo5f036I768rwCXfAFA>
    <xmx:AOEeYmQ2KLCkKVZvw5flr7Du9EhILbjuouSjJHZAgTuThNYmKvL9OPi4Rec>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 22:14:07 -0500 (EST)
Date:   Wed, 2 Mar 2022 11:13:05 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <Yh7gwaAcfVvQzoND@boqun-archlinux>
References: <20220217034525.1687678-1-boqun.feng@gmail.com>
 <MWHPR21MB1593A265118977A57FF3B329D7369@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220221175600.gxbphsnbytgytcpz@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221175600.gxbphsnbytgytcpz@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 05:56:00PM +0000, Wei Liu wrote:
> On Thu, Feb 17, 2022 at 04:31:06PM +0000, Michael Kelley (LINUX) wrote:
> > From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 16, 2022 7:45 PM
> > > 
> > > On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> > > devices, and SPIs can be managed directly via GICD registers. Therefore
> > > the retarget interrupt hypercall is not needed on ARM64.
> > > 
> > > An arch-specific interface hv_arch_irq_unmask() is introduced to handle
> > > the architecture level differences on this. For x86, the behavior
> > > remains unchanged, while for ARM64 no hypercall is invoked when
> > > unmasking an irq for virtual PCI devices.
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > > v1 -> v2:
> > > 
> > > *	Introduce arch-specific interface hv_arch_irq_unmask() as
> > > 	suggested by Bjorn
> > > 
> > >  drivers/pci/controller/pci-hyperv.c | 233 +++++++++++++++-------------
> > >  1 file changed, 122 insertions(+), 111 deletions(-)
> > 
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> I expect this to go through the PCI tree. Let me know if I should pick
> this up.
> 

I also expect the same.

Lorenzo, let me know if there is more work needed for this patch.
Thanks!

Regards,
Boqun

> Thanks,
> Wei.
