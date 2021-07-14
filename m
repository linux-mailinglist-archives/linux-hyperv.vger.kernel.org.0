Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB03C7CBB
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 05:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhGNDTq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 23:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhGNDTq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 23:19:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA44C0613DD
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jul 2021 20:16:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l11so660929pji.5
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jul 2021 20:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eQln7Sxs1F1MvVvqEAYpR9G/TYLHEFaC/1K6W6mv5tY=;
        b=A+fJDlQWk4r/ME4C5NmsuE8jcnNfjSxEPC9wlFKZxNcxP/5mPvwKG/R+TOA9NN18wa
         1aHt3pBiTQVA1q6D+ESsBqIU8O6Kz0zsiWO1NShGnYN8bVtA1JyjJXwjGxZ/Zdxiwpv8
         b6fXsfwE00Zq0A/x6MPwVEV1hMj+rvcAFdruB+kRw5q77T/p1VJWFzSZIDdhgxANzt79
         X6VmOLN/hMM4adDo9vEOI+R9e/qCyDtmj9VAXtmgn2FG9+QZkjw5qq5e6q/NRwbuarMH
         3IXF+GNMTO00DtLBp45+6Z6JnTO2LKG7kuma5VP18SX/TJHkagUVuRMYAT7i0DgeHJ6p
         ueSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eQln7Sxs1F1MvVvqEAYpR9G/TYLHEFaC/1K6W6mv5tY=;
        b=MGqVjDnDvRW1eGnUzFvS1Vuj11PCyPJr44A2DnA5ZaTH7fY1lvDKPwZ+fF+iBwl/eH
         r8reaV7QTBuHFB6kq+BGiSal5HamwiLz9rijOgD4QAhexAn3UGvqEygMtvwlJfsxcVMU
         x0z5VbI7bPaGm6z8HYWLp6qXxwJ3y7xda9JZTDjghV2Cw62U25E6MzUg5f3VkaDsSRDY
         pt78OSEPOfEAzKWblcv2oBrISP63cHNaW4OhNcuWBkk9INzaP3rnh11zeyQwEJji3qZk
         z9p6F3fJE/MmBi/71LVknowkQb/tAIDrud5sUHE6ihB1dxHftrvRsDUeY4UdTDcuF5B6
         EV6w==
X-Gm-Message-State: AOAM530TrYfXQgXZb1w3YyH2EXQUAiqb0Wnl0QFo+6vE3yPr0ldwUwcZ
        Fbz/ni0WhZ4bs9K7gyPtfsaqOw==
X-Google-Smtp-Source: ABdhPJwAZeqBeDJY0b4RLdYETlN1sxn/oTHc3FO/saug4bP8k9gOU3x3gbO8eqciw/kdvxsb0nNT8g==
X-Received: by 2002:a17:902:a503:b029:12b:2429:385e with SMTP id s3-20020a170902a503b029012b2429385emr6089516plq.64.1626232614130;
        Tue, 13 Jul 2021 20:16:54 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.109.231])
        by smtp.googlemail.com with ESMTPSA id a23sm585346pfn.117.2021.07.13.20.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:16:53 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Wed, 14 Jul 2021 08:46:36 +0530 (IST)
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
In-Reply-To: <CY4PR21MB1586E7C0820C257A1D57B462D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2107140841240.2156790@anisinha-lenovo>
References: <20210713030522.1714803-1-ani@anisinha.ca> <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com> <alpine.DEB.2.22.394.2107132306310.2140183@anisinha-lenovo>
 <CY4PR21MB1586E7C0820C257A1D57B462D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On Tue, 13 Jul 2021, Michael Kelley wrote:

> From: Ani Sinha <ani@anisinha.ca> Sent: Tuesday, July 13, 2021 10:49 AM
> >
> > On Tue, 13 Jul 2021, Michael Kelley wrote:
> >
> > > From: Ani Sinha <ani@anisinha.ca> Sent: Monday, July 12, 2021 8:05 PM
> > > >
> > > > Marking TSC as unstable has a side effect of marking sched_clock as
> > > > unstable when TSC is still being used as the sched_clock. This is not
> > > > desirable. Hyper-V ultimately uses a paravirtualized clock source that
> > > > provides a stable scheduler clock even on systems without TscInvariant
> > > > CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> > > > scheduler clock has been changed to the paravirtualized clocksource. This
> > > > will prevent any unwanted manipulation of the sched_clock. Only TSC will
> > > > be correctly marked as unstable.
> > > >
> > > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > ---
> > > >  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > > index 22f13343b5da..715458b7729a 100644
> > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > @@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
> > > >  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > > >  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
> > > >  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > > > -	} else {
> > > > -		mark_tsc_unstable("running on Hyper-V");
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
> > > >  	/* Register Hyper-V specific clocksource */
> > > >  	hv_init_clocksource();
> > > >  #endif
> > > > +	/* TSC should be marked as unstable only after Hyper-V
> > > > +	 * clocksource has been initialized. This ensures that the
> > > > +	 * stability of the sched_clock is not altered.
> > > > +	 */
> > >
> > > For multi-line comments like the above, the first comment line
> > > should just be "/*".  So:
> >
> > Hmm, checkpatch.pl in kernel tree did not complain :
> >
> > total: 0 errors, 0 warnings, 20 lines checked
> >
> > 0001-Hyper-V-fix-for-unwanted-manipulation-of-sched_clock.patch has no
> > obvious style problems and is ready for submission.
> >
> > However, I do know from my experience of submitting Qemu patches last
> > year that this is a requirement imposed by the Qemu community as
> > checkpatch.pl in qemu tree would complain otherwise. I also took a peek at
> > the Qemu git history. It seems they imported this check from the kernel's
> > checkpatch.pl with this commit in Qemu tree:
> >
> > commit 8c06fbdf36bf4d4d486116200248730887a4d7d6
> > Author: Peter Maydell <peter.maydell@linaro.org>
> > Date:   Fri Dec 14 13:30:48 2018 +0000
> >
> >     scripts/checkpatch.pl: Enforce multiline comment syntax
> >
> > Which adds this rule:
> >
> > +               # Block comments use /* on a line of its own
> > +               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /*...*/
> > +                   $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
> > +                       WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
> > +               }
> >
> >
> > But in kernel there is no such rule. Hmm. strange!
> >
> >
>
> See section 8 of "Documentation/process/coding-style.rst" in a Linux kernel
> source code tree. :-)
>

Yes that is fine. What I was confused about is that the commenting rule
existed in Qemu and checkpatch.pl there enforced this. Upon digging, I
found that the Qemu community themselves "imported" this formating rule
from kernel. Yet, kernel's own checkpatch.pl did not enforce this although
as you point above, the rule exists in written form.

This diff will fix kernel's checkpatch.pl without breaking drivers/net or
net/ . Enforcing rules through proper tooling saves everyone's time and
also ensures consistency.

Will send out this patch soon.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..5f047b762aa1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3833,6 +3833,14 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}

+# Block comments use /* on a line of its own
+		if (!($realfile =~ m@^(drivers/net/|net/)@) &&
+		    $rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&	#inline /*...*/
+		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
+		    WARN("BLOCK_COMMENT_STYLE",
+			 "Block comments use a leading /* on a separate line\n" . $herecurr);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
