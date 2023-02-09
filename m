Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197C690F3F
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBIR3q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBIR3o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 12:29:44 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5825EA17;
        Thu,  9 Feb 2023 09:29:34 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 3634620C8AF1; Thu,  9 Feb 2023 09:29:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3634620C8AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675963774;
        bh=emY42uIRumszqRhel26tyEAGXIFmQmbZSW8GjvPknrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6OIuT4iJOL2QQ9oIro7GVTIuckp0NeGkW1II0NYN0Bv1hKKLOoieA66qIRAA83Nq
         4jOVBhOcZpVsImXwM/5b4SLkoli4jKP7RbJ8lFSJFbbSc835PFdkDjxPqRbeSo8zRp
         HmQ4+VYw/cSNfAFKIvag0voeAdR0mTdx4/Cm1gJw=
Date:   Thu, 9 Feb 2023 09:29:34 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com
Subject: Re: [PATCH v5 2/5] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Message-ID: <20230209172934.GA1346@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
 <1675944939-22631-3-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqJisFuagtm_VyzTiMzRiB18z+ZX8j63+efTDLWNaccoOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJisFuagtm_VyzTiMzRiB18z+ZX8j63+efTDLWNaccoOQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 09, 2023 at 09:17:45AM -0600, Rob Herring wrote:
> On Thu, Feb 9, 2023 at 6:15 AM Saurabh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > acpi_sleep_state_supported() currently is defined only when
> > CONFIG_ACPI=y.  For future work to enable device tree builds, put this
> > function under #ifdef CONFIG_ACPI.  Otherwise, return 'false' from
> > hv_is_hibernation_supported() as Hyper-V guest configs using device
> > tree don't support hibernation.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/hv/hv_common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 52a6f89ccdbd..370ec20d1993 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
> >
> >  bool hv_is_hibernation_supported(void)
> >  {
> > +#ifdef CONFIG_ACPI
> >         return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> 
> Rework the acpi_bus.h header so that this is defined for !CONFIG_ACPI:
> 
> static inline bool acpi_sleep_state_supported(u8 sleep_state) { return false; }

Sure,
acpi_bus.h doesn't get included in case of !ACPI, I will put this in include/linux/acpi.h

Regards,
Saurabh

> 
> Then you don't need this change here. That or using IS_ENABLED() is
> strongly preferred over #ifdefs.
> 
> Rob
