Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE368DF1D
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBGRjM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 12:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjBGRjJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 12:39:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012C7421A;
        Tue,  7 Feb 2023 09:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A7160F92;
        Tue,  7 Feb 2023 17:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7488C4339E;
        Tue,  7 Feb 2023 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675791547;
        bh=KZlrxH/j0b90gVF45TsrOX41MvrLcj8pAItg6Xzoxdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GBOSdL5WJf/wN4rUEjZiQTaQ87SKc9knmDdocyN27DLgtcevcjewUvlju5pPYTDDF
         gCq8LBxzDYG063ZTo2GufKunfjMbvUZMsQ8GEEvTA5aYOo1Wf+Cp1hAGOp0gSjnVRA
         WjBDtIfBbWnW6ehmUX7ZjHqVWfaGQgvebPk/XdfFHM1wqqWl2gpkCUaG5Z5bufAYk5
         ix6av/JK0kWbmRBrF2Au+1HmRQRILDLzlNgEMMUazQ9UvqwRlNuQm13T3uqk868Y3u
         +0FRgWRoArOJP4UmEZKs6B0uPGSJOLn6MZ7G+llBisOq+AIzaVhprre2nlOppjD/Aw
         EHW4b6ffFruMA==
Received: by mail-vs1-f53.google.com with SMTP id k6so17092413vsk.1;
        Tue, 07 Feb 2023 09:39:07 -0800 (PST)
X-Gm-Message-State: AO0yUKUGE2Imit4S4fZFvK/FEZ2Rlc9A6xWsBEJj2NrpIifq40gd0qLv
        yYQADPLQlcowEswm2nSSHM+esKxc2rLp7Mte/w==
X-Google-Smtp-Source: AK7set8he/v5HFsA1kt1CzDG53fUn4W/mqRZFX4p6+6jCqlvPfny4Lqp0rVvcs5fJmGGKMoqWTO9zOzlppsHceLljxs=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr815523vsc.53.1675791546831; Tue, 07 Feb
 2023 09:39:06 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201174638.GA3872117-robh@kernel.org> <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Feb 2023 11:38:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
Message-ID: <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 3, 2023 at 11:36 AM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Wed, Feb 01, 2023 at 11:46:38AM -0600, Rob Herring wrote:
> > On Wed, Feb 01, 2023 at 08:51:33AM -0800, Saurabh Singh Sengar wrote:
> > > On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> > > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > > <ssengar@linux.microsoft.com> wrote:
> > > > >
> > > > > Update the driver to support device tree boot as well along with =
ACPI.
> > > > > At present the device tree parsing only provides the mmio region =
info
> > > > > and is not the exact copy of ACPI parsing. This is sufficient to =
cater
> > > > > all the current device tree usecases for VMBus.
> > > > >
> > > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++=
++++--
> > > > >  1 file changed, 73 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > > > index 49030e756b9f..1741f1348f9f 100644
> > > > > --- a/drivers/hv/vmbus_drv.c
> > > > > +++ b/drivers/hv/vmbus_drv.c
> > > > > @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_devi=
ce *device_obj)
> > > > >         device_unregister(&device_obj->device);
> > > > >  }
> (...)
> > > > >         struct pci_dev *pdev;
> > > > > @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start,=
 resource_size_t size)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> > > > >
> > > > > +#ifdef CONFIG_ACPI
> > > >
> > > > It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the
> > >
> > > I wanted to have separate function for ACPI and device tree flow, whi=
ch
> > > can be easily maintained with #ifdef. Please let me know if its fine.
> >
> > Yes, you can have separate functions:
> >
> > static int vmbus_acpi_add(struct platform_device *pdev)
> > {
> >       if (!IS_ENABLED(CONFIG_ACPI))
> >               return -ENODEV;
> >
> >       ...
> > }
> >
> > The compiler will throw away the function in the end if CONFIG_ACPI is
> > not enabled.
> >
> > That is easier for us to maintain because it reduces the combinations t=
o
> > build.
> >
>
> I tried removing #ifdef CONFIG_ACPI and use C's if(!IS_ENABLED(CONFIG_ACP=
I)) but looks
> compiler is not optimizing out the rest of function, it still throwing er=
rors
> for acpi functions. This doesn't look 1:1 replacement to me.
> Please let me know if I have missunderstood any of your suggestion.
>
> drivers/hv/vmbus_drv.c:2175:8: error: implicit declaration of function =
=E2=80=98acpi_dev_resource_interrupt=E2=80=99 [-Werror=3Dimplicit-function-

That's a failure of the ACPI headers not having empty function
declarations. The DT functions do...

Also, this is just a broken assumption:

#ifdef CONFIG_ACPI

#else
// Assume DT
#endif

Both ACPI and DT can be enabled at the same time. They may be mutually
exclusive for a platform, but not the kernel. For distro kernels, both
will be enabled typically if the arch supports both. On arm64, DT is
never disabled because the boot interface is always DT.

Furthermore, this makes compile testing your code difficult. The arm64
defconfig, allmodconfig and allyesconfig all will not build the DT
code. The same for x86. This means all the CI builds that happen can't
build test this.

Rob
