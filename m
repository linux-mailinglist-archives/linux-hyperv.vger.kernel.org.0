Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF02CBF38
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgLBOLw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 09:11:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgLBOLv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 09:11:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id k14so4142842wrn.1;
        Wed, 02 Dec 2020 06:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VFmvo9qAPDBPuqmhfbmjzQYI5Z9eFTcq3dsoBi3Wl9w=;
        b=QCOmxSWOTiFtxi3oURXsJazbEgKZ6uL+LCQOY3XTsCmJOONtUSVxa39+uWo5Oi82pz
         ZhfdNl3+XubxZGAXnzkmUkng34O1O3KkLOybvxr/BQo/5TcqlpWO59I2FI82RqveNoDZ
         geNUDn0tn5S2VrYqYGMrvc7qgtcbVHMzzHEO/mjkh06AHfgEEFu8RHV2pDtgDZRItqkG
         276qT5BmxhrrpmJ/H0XibbPWcZALV0WpUqLIxRD4tV6ei8bsRWy6ihWuLZ8sHwSgDHsJ
         hfDylvt1yesGJ5uGT53RE3rM2XUz9SQfLNg8liLdxvBaq9fhuphXYtbUws4V+pG7tpyB
         Re+Q==
X-Gm-Message-State: AOAM531Chkm/PyeXT9QMR9WgS0Bsl3W15EKJuuGk87GAkG7Q+Kr6ehBF
        fnCQiMKYk+LR4cQKcvCRWOU=
X-Google-Smtp-Source: ABdhPJyjPIEmj2CHj7Ial9lkzZOaHh/npZJoOOgmYWKnG5gPqCZZMyjNJ/pf2mX44pIPPdRc5CbI6Q==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr3689699wru.45.1606918269807;
        Wed, 02 Dec 2020 06:11:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q17sm2565999wro.36.2020.12.02.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:11:09 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:11:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
Message-ID: <20201202141107.covsx4ugipuyl6he@liuwe-devbox-debian-v2>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-17-wei.liu@kernel.org>
 <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 25, 2020 at 12:26:12PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 1:46 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > We are about to implement an irqchip for IO-APIC when Linux runs as root
> > on Microsoft Hypervisor. At the same time we would like to reuse
> > existing code as much as possible.
> >
> > Move mp_chip_data to io_apic.h and make a few helper functions
> > non-static.
> 
> > +struct mp_chip_data {
> > +       struct list_head irq_2_pin;
> > +       struct IO_APIC_route_entry entry;
> > +       int trigger;
> > +       int polarity;
> > +       u32 count;
> > +       bool isa_irq;
> > +};
> 
> Since I see only this patch I am puzzled why you need to have this in
> the header?
> Maybe a couple of words in the commit message to elaborate?

Andy, does the following answer your question?

"The chip_data stashed in IO-APIC's irq chip is mp_chip_data.  The
implementation of Microsoft Hypevisor's IO-APIC irqdomain would like to
manipulate that data structure, so move it to io_apic.h as well."

If that's good enough, I can add it to the commit message.

Wei.
