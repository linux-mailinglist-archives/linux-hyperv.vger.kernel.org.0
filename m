Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED03C75EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGMRvz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMRvz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 13:51:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F118CC0613DD
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jul 2021 10:49:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso2601977pjp.2
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jul 2021 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mkfpRgpeLPxUYp+ddTZkPNka6bB8ZGq5QWO32nx4iz0=;
        b=edC+uUrC1ibal60WPRY84ZBLQ48kYRawi7D+gIF4wCdJuwZP0m5q/uuWjmHOWtUpdE
         06YSilXhpiGlcb6XyD2iMRYLL87z+wfOxHXMUHX08Py7mdZdj5dM8CxAF2Sj5HgqhWkD
         itfGjjLC8XA3IDYkRuOAPUwYooUT3aXXSojtV6y7Vctx5w2b9kFUd5i7FaRg6j1HSwAQ
         IkV5tUP3PDpNdB8NOcja6zELBwjYaq+ORUHqTtTvhGee+R1z1Ds9LpUSEAea8Gwh3fdM
         SX/y/ShBo+ZdIxOYsOg7pIdz3XNP2rAahf1jtFmIMFgNm62pkvjN1+AQHucvUPlHZXAq
         zwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mkfpRgpeLPxUYp+ddTZkPNka6bB8ZGq5QWO32nx4iz0=;
        b=WV4Ljep4ZEyaTHbLGP8CHztDZ1w7JU77z87O4cKQbSSDseH1N86pGEcBsPUEA/D5VD
         LZiLsyNrweiQid2yYsEYX5xm8ytYEo/xIn/dUNrOIgzaEqplh4nnxgquDLvRyV37MBMM
         +2D9W4iRQvY/QiLxmh20NxRidOzBTen6wgD2wkD+px4aIQoiVlXUI+YrcMKPztwizQ4a
         LFwQbTsPEmNB0nX55BQ/CWYFZ8CmQUBfIeWbNyjAJ3AwERmz9z7l80YOz41agJd5FA7J
         cWy5tP062Xji+u5dgNXk/1pGoDVoN7TKyIcF9BZKYlmCGpQFHjM3PjtFI+YsnXzzCI0c
         1/xQ==
X-Gm-Message-State: AOAM533WJsLAXKfjoKUt+02nF0Nm8QS30oW1ceWdVRQAIbKDBq+vA+82
        Dv6QW6EANmKw3LbO7FbV3oB+GA==
X-Google-Smtp-Source: ABdhPJz22XsuCy0FIbFP7wrjQC2jH1V7CQEz98z5mMv8mIvEOA+oZ9Pr8XzdgfkjtzlTELrxachHJA==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr5364656pjg.101.1626198544250;
        Tue, 13 Jul 2021 10:49:04 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.158.88])
        by smtp.googlemail.com with ESMTPSA id f3sm12953271pfk.206.2021.07.13.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:49:03 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Tue, 13 Jul 2021 23:18:46 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Michael Kelley <mikelley@microsoft.com>
cc:     Ani Sinha <ani@anisinha.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anirban.sinha@nokia.com" <anirban.sinha@nokia.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
In-Reply-To: <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2107132306310.2140183@anisinha-lenovo>
References: <20210713030522.1714803-1-ani@anisinha.ca> <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On Tue, 13 Jul 2021, Michael Kelley wrote:

> From: Ani Sinha <ani@anisinha.ca> Sent: Monday, July 12, 2021 8:05 PM
> >
> > Marking TSC as unstable has a side effect of marking sched_clock as
> > unstable when TSC is still being used as the sched_clock. This is not
> > desirable. Hyper-V ultimately uses a paravirtualized clock source that
> > provides a stable scheduler clock even on systems without TscInvariant
> > CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> > scheduler clock has been changed to the paravirtualized clocksource. This
> > will prevent any unwanted manipulation of the sched_clock. Only TSC will
> > be correctly marked as unstable.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 22f13343b5da..715458b7729a 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
> >  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> >  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
> >  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > -	} else {
> > -		mark_tsc_unstable("running on Hyper-V");
> >  	}
> >
> >  	/*
> > @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> >  #endif
> > +	/* TSC should be marked as unstable only after Hyper-V
> > +	 * clocksource has been initialized. This ensures that the
> > +	 * stability of the sched_clock is not altered.
> > +	 */
>
> For multi-line comments like the above, the first comment line
> should just be "/*".  So:

Hmm, checkpatch.pl in kernel tree did not complain :

total: 0 errors, 0 warnings, 20 lines checked

0001-Hyper-V-fix-for-unwanted-manipulation-of-sched_clock.patch has no
obvious style problems and is ready for submission.

However, I do know from my experience of submitting Qemu patches last
year that this is a requirement imposed by the Qemu community as
checkpatch.pl in qemu tree would complain otherwise. I also took a peek at
the Qemu git history. It seems they imported this check from the kernel's
checkpatch.pl with this commit in Qemu tree:

commit 8c06fbdf36bf4d4d486116200248730887a4d7d6
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Dec 14 13:30:48 2018 +0000

    scripts/checkpatch.pl: Enforce multiline comment syntax

Which adds this rule:

+               # Block comments use /* on a line of its own
+               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /*...*/
+                   $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
+                       WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
+               }


But in kernel there is no such rule. Hmm. strange!


>
> 	/*
> 	 * TSC should be marked as unstable only after Hyper-V
> 	 * clocksource has been initialized. This ensures that the
> 	 * stability of the sched_clock is not altered.
> 	 */
>
>
> > +	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> > +		mark_tsc_unstable("running on Hyper-V");
> >  }
> >
> >  static bool __init ms_hyperv_x2apic_available(void)
> > --
> > 2.25.1
>
> Modulo the comment format,
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
>
