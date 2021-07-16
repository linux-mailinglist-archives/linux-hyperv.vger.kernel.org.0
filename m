Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918113CB7E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhGPNgw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbhGPNgv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 09:36:51 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2BBC061760
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:33:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x16so5331585plg.3
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fGgLXOAW+XYOflDoI9DlmXYjo7kRzoGFVJ7ubU3NwUg=;
        b=TIaYvYMfXmpt6sdGaeC2ECGubiFR1yIRQAkBP05fGdqPLzBTnKZ7QyyclaS/vleLyA
         O9jQgOsXQJF82T4AQvc77k6cXSMeyiTkCz6F+MnuQEb0FZXAb9myL9EAXxw6Q4fz+Rci
         MN4Oi2hPy4BJ8EkbCoU9iTR3H3ihrRcJ/jm8csy5X6xdoiFLGufnFsUYpbGU1caNr8U/
         aYh+LFjgw/t4dxhmqF290smTsSzhVYAt0n6h/PTHKynuJKxiQCnpBzYZJh9MOQUI+h60
         Xwibii1BPudU5EYmX1vKI40/AHhuDjX+0van4WdA7pR3KYe3tu1MtazEDdp3cirurq33
         BRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fGgLXOAW+XYOflDoI9DlmXYjo7kRzoGFVJ7ubU3NwUg=;
        b=kcGqqsx+BwSi1u12roKz5ZkJFzUlSH+dMR1YunYAzwFqUznkiWjTD+tOYFlZZ35MCt
         44SwwwCQIrPIz/qyAcryPzBPO5GhcvIPuGwxWk1EvXEtZN+jNpNl0kyV73exEOGYej+M
         LqcVsDEU6aYUdoG8jch5n48jdKhSuBtVrtT/icTp3iplTFq7bDgKqMVpVKXSA+zcaKBQ
         ZRerfaf05fW9lzTaWT6CxYNHz26ZKIvccsBUjL9NEdif05uu+5Yk6t7mu4aVNDcMLoGd
         bXRaQZDWo+C4PbUzPRAo1sqigVG4l2HZMISduSVCsCLyNfBqPHImasPVowcQKOJKy5Pb
         zW5g==
X-Gm-Message-State: AOAM533MzoFEZPxvsjv6ye3eL3WtrfZV8f4AbZkmF4y6tn13ABUkcmfA
        DPQIlTbbYIrdYlj/yYOS6uSb1A==
X-Google-Smtp-Source: ABdhPJymxQhxYFuwTkarDwkdq6Mk7dMTn3IkQ/R1rFwSW0w9q5dpyMCbTJriVn5YK9OlhKsK6oBcUQ==
X-Received: by 2002:a17:902:da83:b029:129:9f09:bedb with SMTP id j3-20020a170902da83b02901299f09bedbmr8010088plx.56.1626442436610;
        Fri, 16 Jul 2021 06:33:56 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.126.211])
        by smtp.googlemail.com with ESMTPSA id 73sm8800400pjz.24.2021.07.16.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:33:56 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Fri, 16 Jul 2021 19:03:48 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: add comment describing TSC_INVARIANT_CONTROL
 MSR setting bit 0
In-Reply-To: <8735se1jbw.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.22.394.2107161903220.3272758@anisinha-lenovo>
References: <20210716063341.2865562-1-ani@anisinha.ca> <8735se1jbw.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On Fri, 16 Jul 2021, Vitaly Kuznetsov wrote:

> Ani Sinha <ani@anisinha.ca> writes:
>
> > Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
> > added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
> > of this synthetic MSR will allow hyper-v guests to report invariant TSC
> > CPU feature through CPUID. This comment adds this explanation to the code
> > and mentions where the Intel's generic platform init code reads this
> > feature bit from CPUID. The comment will help developers understand how
> > the two parts of the initialization (hyperV specific and non-hyperV
> > specific generic hw init) are related.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 715458b7729a..d2429748170d 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -368,6 +368,14 @@ static void __init ms_hyperv_init_platform(void)
> >  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
> >  #endif
> >  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > +		/*
> > +		 * Setting bit 0 of the synthetic MSR 0x40000118 enables
> > +		 * guests to report invariant TSC feature through CPUID
> > +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> > +		 * early_init_intel() where this bit is examined. The
> > +		 * setting of this MSR bit should happen before init_intel()
> > +		 * is called.
>
> It should probably be emphasized, that write to 0x40000118
> updates/changes guest visible CPUIDs. This may not be clear as CPUIDs
> are generally considered 'static'.

Patch v2 sent.

