Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46235548123
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiFMH7G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 03:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFMH7F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 03:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 759F92AC0
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655107143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdrTunTbI0wI5V8jm3nRdejq4SYdiXn891lY7DXeMUU=;
        b=MFrvimvz8gD6lxlALN8nBfjm9Ef4MW+hIjDiP2WiElcKqH3wmCTgFwgJu8b4c4fA2mMLzZ
        olT0M+AQt4k2SERwADCNNb7aFceFrllkmnT+OmIoT972WDfsAT/VuLy+fgzXw+kcAMCo52
        fWhEvWF5w5Pk0xfueCIQ0CsBPdMj9sU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-w7ZdsfzlNoSAanj8iqUDpQ-1; Mon, 13 Jun 2022 03:59:01 -0400
X-MC-Unique: w7ZdsfzlNoSAanj8iqUDpQ-1
Received: by mail-qv1-f71.google.com with SMTP id dg8-20020a056214084800b004645cecc145so3394544qvb.6
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mdrTunTbI0wI5V8jm3nRdejq4SYdiXn891lY7DXeMUU=;
        b=DFo4+6lZYiBy5sDUUiKTKdexaxACZZGkMSZstcqwaIOaRg76Cws9/QUl1ixqESuTqg
         0E6UJrayZppoBYEjh0Zr88PTyxlo4gIxJBs54z85rvgJEBWUXWv4M5y3578HhZy33Yl6
         ODkM57hOtCeVKMxV1mSnHO5hHU7V/sMPAIbjGzzvppx5XbW0MoRhTY7f8z6G/rfo7Pgm
         Me/ekLv5khzs2bOhfMn16OMaT7qh0fGUPaTFHpCKsJ30uI/l/8xgu427KXSW1Ed2gUDk
         jij9ImvNM7+7ahGjn9G6O5+D9X8VgYDt1ASJPpR5xxQLcDj8x/Q+zKaQfNS75fdRPooL
         a1/Q==
X-Gm-Message-State: AOAM533Q7rXKN6n6z+dd6mreJP+rPqCWB57j07fswlPC0JxOQGDEDnpt
        qQp9nS254b3fYRxCsFqqm0EaV9Ck27iP8iWj7IXbE/rg5o4rfk0u5pYP8+YcwQVyYbbnxLwWlet
        LKOn1zbpgTMLVrPh3e7A6wMBz
X-Received: by 2002:a05:620a:24d4:b0:6a7:1d74:d8e6 with SMTP id m20-20020a05620a24d400b006a71d74d8e6mr15782711qkn.379.1655107141106;
        Mon, 13 Jun 2022 00:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmaQgTaVWUVlrIB5d3pp6NGbg0c4+Kz+GQ5c4VCtM1khwksrbwxdsiDi6j2EKNn4va2UdV5w==
X-Received: by 2002:a05:620a:24d4:b0:6a7:1d74:d8e6 with SMTP id m20-20020a05620a24d400b006a71d74d8e6mr15782698qkn.379.1655107140761;
        Mon, 13 Jun 2022 00:59:00 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b006a6edbbca84sm5148007qkp.94.2022.06.13.00.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:59:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Florian =?utf-8?Q?M?= =?utf-8?Q?=C3=BCller?= 
        <max06.net@outlook.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: RE: hv_balloon: Only works in ubuntu
In-Reply-To: <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
Date:   Mon, 13 Jun 2022 09:58:57 +0200
Message-ID: <87r13tj8ou.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Florian M=C3=BCller <max06.net@outlook.com> Sent: Saturday, June 11=
, 2022 12:45 PM
>>=20
>> > > > >
>> > > > > Issues showed up when I set up a Kali Linux Guest. I missed the
>> > > > > memory configuration before booting up the instance, so it start=
ed
>> > > > > with 1GB of memory, and ballooning active between 512MB and
>> > > > > several TB of memory. Hyper-V started to allocate more and more
>> > > > > memory to this guest since the reported memory requirements also
>> > > > > increased. The guest kernel didn't see any of that allocated mem=
ory, as=20
>> > > > > far as I can tell.
>> > > >
>> > > > Hot-adding new memory is done partially by the hv_balloon driver,
>> > > > but it also requires user space action.  The user space action is =
provided
>> > > > by udev rules.
>> > > > In your Ubuntu Server 20.04 guest, there's a file
>> > > > /lib/udev/rules.d/40-vm- hotadd.rules.
>> > > > This file contains udev rules for hot-adding memory and CPUs.  You
>> > > > should be able to copy this file with the udev rules onto your Kali
>> > > > system, and then the memory hot-add should work correctly.
>> > > >
>> > > > I'm not sure why Kali doesn't already have such udev rules.  You
>> > > > might grep through all the files in /lib/udev/rules.d and if there
>> > > > are any rules for SUBSYSTEM=3D=3Dmemory.
>> > > > Sometimes there are rules present, but commented out.
>> > > >
>> > > Thanks, I'll check these ones out!
>> > >
>> > > In the meantime, I was able to get it working, by compiling a kernel
>> > > with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
>> > > Which was previously unset. It's enabled in ubuntu and it seems to
>> > > make hv_balloon work properly.
>> > > This seems to be the same case with Debian.
>> > >
>> >
>> > Yes, that looks like a good solution.  I didn't remember that there is=
 a kernel
>> > config option to automatically do the onlining.  With this kernel opti=
on
>> > enabled, using a udev rule obviously isn't needed.  The kernel option =
was
>> > added in Linux kernel version 4.7, which might be after the last time =
I looked
>> > at Hyper-V memory hot-add in detail.
>> >
>> > Michael
>> >
>>=20
>> Awesome!
>>=20
>> Last question: Since not having the kernel option by default and also no=
t having the
>> udev rule in some distributions causes the Hyper-V host to eat up all th=
e memory up to
>> the defined limit (and to die eventually), should this be considered as =
a bug? And if the
>> answer is no, how can I (or anyone) forward the requirement to the publi=
shers to be
>> solved at the source?
>>=20
>> Thank you!
>>=20
>
> It's unclear whether this should be treated as a bug.  We certainly want =
the
> "right" thing to happen as seamlessly as possible, but there are tradeoff=
s.  Back
> when Vitaly Kuznetsov added CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE,
> I can see there was some debate about whether this option should be enabl=
ed
> by default. There was reluctance to do so because of potential backwards
> compatibility problems with other environments.  When hot-adding real
> physical memory to a bare-metal server, apparently you don't want to=20
> automatically online the added memory.

On x86/ARM you most likely do (as why plugging in memory in the first
place?) but there are not many bare metal systems which allow that.

Note, there were some developments after I've added
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, namely

commit 5f47adf762b78cae97de58d9ff01d2d44db09467
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Apr 6 20:07:44 2020 -0700

    mm/memory_hotplug: allow to specify a default online_type

>
> The Ubuntu image you were testing is specifically an image configured for=
 use
> in an Azure VM, so it makes sense to have memory automatically onlined by
> the kernel.  So I looked at a generic Ubuntu 18.04 system, and it also has
> this kernel option set by default.  But as another data point, RHEL/CentO=
S 8.4
> does *not* have the kernel option set.  So each distro evidently makes th=
eir
> own decision about this.=20=20

Note: Fedora kernels come with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy as
well.

> But both generic Ubuntu 18.04 and RHEL/CentOS 8.4
> have the udev rules.  The RHEL/CentOS 8.4 udev rule is more sophisticated
> in that it does not online the added memory when running on System/390
> and PowerPC.

I remember that with s390 we certainly don't want all memory to go
online automatically because but I don't remember the reason :-)

>
> I could envision changing the Linux kernel config rules to automatically =
set
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE whenever=20
> CONFIG_HYPERV_BALLOON is selected.=20

That could work for custom kernels but not for those shipped with
distributions as these will always have CONFIG_HYPERV_BALLOON if
Hyper-V is one of the supported targets (and it likely is).

> Alternatively, the Kali Linux folks could consider adding the
> appropriate udev rule.

Or just enable CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE. We've enabled
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE in Fedora in 2016 and haven't heard
many (any?) complaints (besides ppc64 where it was disabled) since.

Cc: David who mostly picked up the auto onlining work since.

--=20
Vitaly

