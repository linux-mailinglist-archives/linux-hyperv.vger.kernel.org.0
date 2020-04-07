Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1A1A16E6
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGUmP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 16:42:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35034 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUmP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 16:42:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id r26so3280416wmh.0;
        Tue, 07 Apr 2020 13:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+kyW4mDgVYbrX53+0yy/aJtZBiiNTJiMN1q3teN/Bg=;
        b=anNbNsEYurSzE6xrCEwNPSbQlO6BYjDLFtgLhqayNOahXLxt1d6078ev0yJ4D2AVwG
         IXASDIpYVm3wME6K5+8RHUiSbvBr0T8c82VFlBxg09efC3wVeFQcxEgIjJ/xrzL58a7H
         nP8D8ZzXKcKPBRPD/Oqpwidzt3Qf3sAfxuTiJ0GT6weFU96z1ccmFqq3Mr0c2/hvXpF7
         H3ji4y3VsCuSEtEn+2d/fPlr575QkrJ0so+lApqqKhuO5mlq7cdxAomJomz/kRs8hUG0
         R3nRrwg3oPtDS/NblBu2SIB+l4QcjhSmHJT+kHX0C3YAwSAsmUuxVI3gje4/sF0SGSWq
         XrqA==
X-Gm-Message-State: AGi0PubRtP68G/DouNfI8DOpiKa/k5MQDoeuoO13OR7MwWZQoDAFe5tq
        L2r1htLl1GknOVuGpCzWz6A=
X-Google-Smtp-Source: APiQypKRJ8P0Fsa153hShEIVJFf7A48GlpRok+1kr6C+mLHm9baJlhBfyOJ3pt5jmKv0OIN+ezqq4A==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1022612wmc.129.1586292132710;
        Tue, 07 Apr 2020 13:42:12 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id d13sm32503523wrv.34.2020.04.07.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 13:42:11 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:42:09 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200407204209.ji655odu7b4tt7oh@debian>
References: <20200407065500.GA28490@lst.de>
 <87v9mblpq6.fsf@vitty.brq.redhat.com>
 <HK0P153MB0273278D61381693E022B3ADBFC30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0273278D61381693E022B3ADBFC30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 07, 2020 at 06:10:42PM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Vitaly Kuznetsov
> > Sent: Tuesday, April 7, 2020 12:28 AM
> > Christoph Hellwig <hch@lst.de> writes:
> > 
> > > Hi all,
> > >
> > > The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
> > > in the kernel using __vmalloc with exectutable persmissions, and the
> > > only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
> > > be readable?  Otherwise we could use vmalloc_exec and kill off
> > > PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn
> > off
> > > write permission on the hypercall page") it was even mapped writable..
> > 
> > [There is nothing secret in the hypercall page, by reading it you can
> > figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
> > likely not the only possible way :-)]
> > 
> > I see no reason for hv_hypercall_pg to remain readable. I just
> > smoke-tested
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 7581cab74acb..17845db67fe2 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -382,7 +382,7 @@ void __init hyperv_init(void)
> >         guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> >         wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
> > 
> > -       hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL,
> > PAGE_KERNEL_RX);
> > +       hv_hypercall_pg  = vmalloc_exec(PAGE_SIZE);
> 
> If we try to write into the page, Hyper-V will kill the guest immediately
> by a virtual double-fault (or triple fault?), IIRC.
> 

The guest would get injected a #GP fault in that case FWIW.  Perhaps
that leads to further double-fault or triple-fault.

Wei.
