Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A486C5BD6
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Mar 2023 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCWB1B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Mar 2023 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWB1A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Mar 2023 21:27:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186D2F073
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Mar 2023 18:26:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5446a91c40cso206421557b3.18
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Mar 2023 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679534818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9N2HnRYrae+sksVu/QRqXOm2kRG5pCUILA+G4RL3KP4=;
        b=oVuow6GNGDAbF85SsutVT0v2FAYa/hsAB+asR6DacVUBzcygDbpTgqT6vdXtHs/qQP
         nl+KLJJpQn4DJmAUKgt6QbKmBfZ5dHVMHJLpf7kXsCyl/rinQ1KDLrsvQNzyXTyf+utg
         9Znq0Up53ShivcXFIy68Mk4tKYs5U/LfYFR7BK3jxewQ1eCuL6CzGYysFIDa8ppeLG+Q
         vviGX1hQvwATjCxNRLwu4MJyLrUiQtA5yrfewp1bsKZ9cRUPR2VgkqRlbOroB7mfeWm9
         jijTDsNS1lQvYLznIR93Fwc7ajeXF7RCQk67NQTxAG0IWtCKfdDTgSp5xUm1XvGwEYLu
         2a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679534818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N2HnRYrae+sksVu/QRqXOm2kRG5pCUILA+G4RL3KP4=;
        b=d9djeV33/rgCTNYsPsjA9oWWUkVrsErXYMUYmgevmkGVSdg+Te+MvBYyU8TTUlVz8E
         lQeuTF5o0W5Wggh9VB8oFGsDw2VLFdLnFqjtwBIbOzWbob4drOsggyJ+yxPCZOb3sqos
         GrkHr7/f94hGJ8WmuOlMwJzSqDNzZtk5p9RxJNG/6TbK9hZivcJSmLSp/k8O6M+JYmvF
         n5G48JLu8FS3ZdKck1/hvXfmjeBClDylbJHJ7TrOIU8oxTqpVx/2o02LQYUgl4sJRGQF
         bdWERPD2A766KxT3z7ETGZ3qXgBO2X+UVa59Q6B24rO8/VwWjwvNwTIylfHsi2NHKzx3
         PHxg==
X-Gm-Message-State: AAQBX9fLgoZSFQ4dkqgCymA7N0UqRjphiK2gwvRgMDN/ZMv/gv8xX1tF
        KaXB4qq5tqn72rgxxHXg7gjw3Ksf+5g=
X-Google-Smtp-Source: AKy350ZAKPcOKD/Xpw0JOF1LdrDfRSndo4JbAlkozLFSiHMC/P3aitD5K0VXiaeLJw2hvq09vSAwvl6aHmQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ec03:0:b0:541:6975:2340 with SMTP id
 j3-20020a81ec03000000b0054169752340mr998299ywm.6.1679534818051; Wed, 22 Mar
 2023 18:26:58 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:26:56 -0700
In-Reply-To: <BYAPR21MB16884B3D0E15E501A7BB8E78D7869@BYAPR21MB1688.namprd21.prod.outlook.com>
Mime-Version: 1.0
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
 <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com> <BYAPR21MB16884B3D0E15E501A7BB8E78D7869@BYAPR21MB1688.namprd21.prod.outlook.com>
Message-ID: <ZBuq4KjU2ekKk+iS@google.com>
Subject: Re: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to /proc/stat
From:   Sean Christopherson <seanjc@google.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 22, 2023, Michael Kelley (LINUX) wrote:
> From: Dave Hansen <dave.hansen@intel.com> Sent: Wednesday, March 22, 2023 11:07 AM
> > 
> > On 2/27/23 10:46, Michael Kelley wrote:
> > > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > > index 766ffe3..9f668d2 100644
> > > --- a/arch/x86/kernel/irq.c
> > > +++ b/arch/x86/kernel/irq.c
> > > @@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
> > >  #ifdef CONFIG_X86_MCE_THRESHOLD
> > >  	sum += irq_stats(cpu)->irq_threshold_count;
> > >  #endif
> > > +#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
> > > +	sum += irq_stats(cpu)->irq_hv_callback_count;
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_HYPERV)
> > > +	sum += irq_stats(cpu)->irq_hv_reenlightenment_count;
> > > +	sum += irq_stats(cpu)->hyperv_stimer0_count;
> > > +#endif
> > >  #ifdef CONFIG_X86_MCE
> > >  	sum += per_cpu(mce_exception_count, cpu);
> > >  	sum += per_cpu(mce_poll_count, cpu);
> > 
> > This seems fine, especially since arch_show_interrupts() has them.  But,
> > what's with the "#if IS_ENABLED" versus the plain #ifdef?  Is there some
> > difference I'm missing?  Why not just be consistent with the other code
> > and use a plain #ifdef for both?
> 
> I'm following the coding pattern in arch_show_interrupts(), in irq_cpustat_t,
> and most other places that test CONFIG_HYPERV.   Maybe all those existing
> cases are a mis-application of Documentation/process/coding-style.rst
> Section 21, which prefers "if (IS_ENABLED(CONFIG_HYPERV))" over
> "#ifdef CONFIG_HYPERV".  "#if IS_ENABLED()" is not the same as
> "if (IS_ENABLED())".  :-)
> 
>  Net, I don't have a strong preference either way.

Using IS_ENABLED() is mandatory because CONFIG_HYPERV is a tri-state, i.e. can
be a module and thus #define CONFIG_HYPER_MODULE instead of CONFIG_HYPERV.
