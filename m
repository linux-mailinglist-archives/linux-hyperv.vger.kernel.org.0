Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E051C307
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380857AbiEEOzm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380855AbiEEOzl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 10:55:41 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DABFF56FBB
        for <linux-hyperv@vger.kernel.org>; Thu,  5 May 2022 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651762321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uM+ofZNcfgbacCYmlCH29DRYVtctL+nEHY0EJrvY55Y=;
        b=dP6hJhmd2QIHKkFr3nMaBruaUmhfmeTbGlM7mCVtkUY3Kr5vO6mG/SM0tXbBnDxtPNk27+
        yKn8Vd4Pj2uGWBl2FeYxVtpCEG2X4XjYx22g6AIhUvcYWpExUutfj1OiQIcjrvgA4Utq3J
        vFZ5xsjaiYEZUP34K9/b4Jw8T20wsKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-hMhhV9LYMjO7y3kbLHcm9Q-1; Thu, 05 May 2022 10:51:57 -0400
X-MC-Unique: hMhhV9LYMjO7y3kbLHcm9Q-1
Received: by mail-wm1-f72.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so1843781wmh.9
        for <linux-hyperv@vger.kernel.org>; Thu, 05 May 2022 07:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uM+ofZNcfgbacCYmlCH29DRYVtctL+nEHY0EJrvY55Y=;
        b=qxdA73jiAtm8BRUIQyb0tyeD5xWBhCgxaF8qGUnti7/IbP9WFIyOau8b81WbCaK8yU
         A2/yiKJnpQBMTiKXMeLf43/C12KvBcuAwiRJvLKunJyo2OJtS0sO52U3DlMJqGeKyIP8
         lHiR5vF6lSmXrkGZG8Sl8TMaUtWdvxkkv+ns6i12q92BK7iytpcxXag2xNctLJDlOxkr
         Kyd6OSdMxTQQ5M5UgP3T27W8IclAun6BBbFXWHuv3BAg2TawX+axgV7rVGSAXoh3/Szx
         qK3zGh/Wgk0DcPA1DXpWZHsfwy9ZTcf/6WJl9obBsc4vEZ+UoT0sRjTkwhPc2kbl3yAj
         Rwjw==
X-Gm-Message-State: AOAM531P64KkCSJIl7dCuZTMIVD0A8QKYlkO7fAqQJJ3FlZ3RN9ADN4H
        6HvQYJlqjU2TwfkwVGxZ3LP2wBdXCVpFPz5UFlsYDFF4qdOzEUuvaUn2NLKQF5q4D0sV0tADt99
        7tyjilaHAVao1hRYfeMewaOp/lx9Tu1KmUdXqX5O7iOQF76H2ll/sL44nWW67n0zT1J8leXtGHO
        fq
X-Received: by 2002:a1c:6a1a:0:b0:394:272e:5bdf with SMTP id f26-20020a1c6a1a000000b00394272e5bdfmr5347734wmc.55.1651762316214;
        Thu, 05 May 2022 07:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzZ199d4B0hb5YxHFT/G5vw6e8Q1vc2C0FJNM5txW7lPwaFe4IrmxdRb6YfGAM2P9o3lQ5lw==
X-Received: by 2002:a1c:6a1a:0:b0:394:272e:5bdf with SMTP id f26-20020a1c6a1a000000b00394272e5bdfmr5347690wmc.55.1651762315893;
        Thu, 05 May 2022 07:51:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003942a244ed1sm1524096wmk.22.2022.05.05.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:51:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
In-Reply-To: <YnPf3KPBXDNTpQoG@FVFF77S0Q05N.cambridge.arm.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
 <878rrg13zb.fsf@redhat.com>
 <YnPf3KPBXDNTpQoG@FVFF77S0Q05N.cambridge.arm.com>
Date:   Thu, 05 May 2022 16:51:54 +0200
Message-ID: <87y1zgyqut.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, May 05, 2022 at 03:52:24PM +0200, Vitaly Kuznetsov wrote:
>> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
>> 
>> > On 05/05/2022 09:53, Mark Rutland wrote:
>> >> [...]
>> >> Looking at those, the cleanup work is all arch-specific. What exactly would we
>> >> need to do on arm64, and why does it need to happen at that point specifically?
>> >> On arm64 we don't expect as much paravirtualization as on x86, so it's not
>> >> clear to me whether we need anything at all.
>> >> 
>> >>> Anyway, the idea here was to gather a feedback on how "receptive" arm64
>> >>> community would be to allow such customization, appreciated your feedback =)
>> >> 
>> >> ... and are you trying to do this for Hyper-V or just using that as an example?
>> >> 
>> >> I think we're not going to be very receptive without a more concrete example of
>> >> what you want.
>> >> 
>> >> What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?
>> >> 
>> >> Thanks
>> >> Mark.
>> >
>> > Hi Mark, my plan would be doing that for Hyper-V - kind of the same
>> > code, almost. For example, in hv_crash_handler() there is a stimer
>> > clean-up and the vmbus unload - my understanding is that this same code
>> > would need to run in arm64. Michael Kelley is CCed, he was discussing
>> > with me in the panic notifiers thread and may elaborate more on the needs.
>> >
>> > But also (not related with my specific plan), I've seen KVM quiesce code
>> > on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not sure if
>> > this is necessary for arm64 or if this already executing in some
>> > abstracted form, I didn't dig deep - probably Vitaly is aware of that,
>> > hence I've CCed him here.
>> 
>> Speaking about the difference between reboot notifiers call chain and
>> machine_ops.crash_shutdown for KVM/x86, the main difference is that
>> reboot notifier is called on some CPU while the VM is fully functional,
>> this way we may e.g. still use IPIs (see kvm_pv_reboot_notify() doing
>> on_each_cpu()). When we're in a crash situation,
>> machine_ops.crash_shutdown is called on the CPU which crashed. We can't
>> count on IPIs still being functional so we do the very basic minimum so
>> *this* CPU can boot kdump kernel. There's no guarantee other CPUs can
>> still boot but normally we do kdump with 'nprocs=1'.
>
> Sure; IIUC the IPI problem doesn't apply to arm64, though, since that doesn't
> use a PV mechanism (and practically speaking will either be GICv2 or GICv3).
>

This isn't really about PV: when the kernel is crashing, you have no
idea what's going on on other CPUs, they may be crashing too, locked in
a tight loop, ... so sending an IPI there to do some work and expecting
it to report back is dangerous.

>> For Hyper-V, the situation is similar: hv_crash_handler() intitiates
>> VMbus unload on the crashing CPU only, there's no mechanism to do
>> 'global' unload so other CPUs will likely not be able to connect Vmbus
>> devices in kdump kernel but this should not be necessary.
>
> Given kdump is best-effort (and we can't rely on secondary CPUs even making it
> into the kdump kernel), I also don't think that should be necessary.

Yes, exactly.

>
>> There's a crash_kexec_post_notifiers mechanism which can be used instead
>> but it's disabled by default so using machine_ops.crash_shutdown is
>> better.
>
> Another option is to defer this to the kdump kernel. On arm64 at least, we know
> if we're in a kdump kernel early on, and can reset some state based upon that.
>
> Looking at x86's hyperv_cleanup(), everything relevant to arm64 can be deferred
> to just before the kdump kernel detects and initializes anything relating to
> hyperv. So AFAICT we could have hyperv_init() check is_kdump_kernel() prior to
> the first hypercall, and do the cleanup/reset there.

In theory yes, it is possible to try sending CHANNELMSG_UNLOAD on kdump
kernel boot and not upon crash, I don't remember if this approach was
tried in the past. 

>
> Maybe we need more data for the vmbus bits? ... if so it seems that could blow
> up anyway when the first kernel was tearing down.

Not sure I understood what you mean... From what I remember, there were
issues with CHANNELMSG_UNLOAD handling on the Hyper-V host side in the
past (it was taking *minutes* for the host to reply) but this is
orthogonal to the fact that we need to do this cleanup so kdump kernel
is able to connect to Vmbus devices again.

-- 
Vitaly

