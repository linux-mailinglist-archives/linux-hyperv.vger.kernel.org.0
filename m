Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9896E30FBDB
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhBDSqB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 13:46:01 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55381 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbhBDSnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 13:43:55 -0500
Received: by mail-wm1-f53.google.com with SMTP id f16so4006207wmq.5;
        Thu, 04 Feb 2021 10:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hAXu9lZgOGKgsgAF3qBaSgL6tziuKPxThr6otN2BFf0=;
        b=fr9AK1BAlkJ7xSeutHaTMQLpCQ9bqNZTh0zPlxLTr2lmsl8Z7NC0chv4dQkDP0gQVq
         Pu+pBOKYtDTu7HtqAJa4uYoThjYJDzglOcUYy9fOOq9aVoQHXWJLGzJ7z3pyyn5XXP6C
         L9nzUXoSReT0LUnjn2IVmtlOw6IYLJCWRzW8+JMvz0Q9IsXVrn9KCkGZWFDH5nWR6dEw
         hGOaau49MnGJdqQX7nTcJ2laKTH0rwwTDA1lrKDViUAXh8pFXq56MjrRRZoLkdn/zqiS
         qVjy9aVBqoHgU3g65cfV3x6lrTNhkgl7KH+Gpxnt8rfDPL/1JTyCE/wj01JVvoSAjpSB
         MG/g==
X-Gm-Message-State: AOAM533yEQCahiRVxEP7qdHTOx8yEfpTYnWioM5AlpGfMu1qxK89nOgd
        rMyySXBaB29Jrk1rZyRYAGY=
X-Google-Smtp-Source: ABdhPJwNq5pTrvkb8cEoO5L+yzFW8L7fJZR1eb3ywR9i2LZYnIP2TJJiRqIM7Jf8Stq9KkYDhHWMCw==
X-Received: by 2002:a1c:4106:: with SMTP id o6mr446359wma.165.1612464193112;
        Thu, 04 Feb 2021 10:43:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z4sm8993349wrw.38.2021.02.04.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:43:12 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:43:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20210204184311.xuqlrenlth2vi236@liuwe-devbox-debian-v2>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-16-wei.liu@kernel.org>
 <MWHPR21MB15932010E9CF5975EBAD1EDAD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210204175641.pzonxqrqlo7uvvze@liuwe-devbox-debian-v2>
 <MWHPR21MB15934AD184476EF14CF4C732D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15934AD184476EF14CF4C732D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 04, 2021 at 06:40:55PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, February 4, 2021 9:57 AM
[...]
> > I've got the following diff to fix both issues. If you're happy with the
> > changes, can you give your Reviewed-by? That saves a round of posting.
> > 
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > index 0cabc9aece38..fa71db798465 100644
> > --- a/arch/x86/hyperv/irqdomain.c
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > 
> >  /*
> > - * for Linux to run as the root partition on Microsoft Hypervisor.
> > + * Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
> >   *
> >   * Authors:
> >   *  Sunil Muthuswamy <sunilmut@microsoft.com>
> > @@ -20,7 +20,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
> >         struct hv_device_interrupt_descriptor *intr_desc;
> >         unsigned long flags;
> >         u64 status;
> > -       cpumask_t mask = CPU_MASK_NONE;
> > +       const cpumask_t *mask;
> >         int nr_bank, var_size;
> > 
> >         local_irq_save(flags);
> > @@ -41,10 +41,10 @@ static int hv_map_interrupt(union hv_device_id device_id, bool
> > level,
> >         else
> >                 intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > 
> > -       cpumask_set_cpu(cpu, &mask);
> > +       mask = cpumask_of(cpu);
> >         intr_desc->target.vp_set.valid_bank_mask = 0;
> >         intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> > -       nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);
> > +       nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), mask);
> 
> Can you just do the following and get rid of the 'mask' local entirely?
> 
> nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));

Sure. That can be done.

> 
> Either way,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thank you.

Wei.
