Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC42FCA4
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2019 15:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE3NvJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 May 2019 09:51:09 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54522 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE3NvI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 May 2019 09:51:08 -0400
Received: by mail-wm1-f53.google.com with SMTP id g135so842081wme.4
        for <linux-hyperv@vger.kernel.org>; Thu, 30 May 2019 06:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VJdacDVHBRo3cqkBw/isPcHDnC2ea++G9bD0r1ee6oo=;
        b=Qi9WdyXYPRzLlKw5kP6c7PnMj5Kc+xHDBiAURUmSrOMq3SEcGQDjVqXxrMm7jY/X2L
         uW3k3N1yltSn9Vf0Y5TuXWh5Z/R7cj7lEfui2St7sQB6LmSo/JxmVT6Nc20zVXSN1IyX
         ls95MzWS1/OwfwRaoV/y//Oq5EfecZpF6bTOo66ZW6U0pd3CjL3nOtp7F2EaB2dg96xZ
         u3TPUOFEvQzB2517xk6XDnjyn0rrbSCvvnYF2/sbn3dcRPy4Z7ned1evcUp0pUI0Coeg
         H39aKFX2cRyGvJWXnODjDtKHc4Vb3QDtmwZDQ5UzdR5jD4Uy+hIz1qArRmzKrHl8elzF
         VQug==
X-Gm-Message-State: APjAAAX2+NG3rV58enXBQl47bhEea8dc3RiPq6jRh5LI21zStybuaH5/
        ipECkDHAJt7GpVxezUTPzbVSuQ==
X-Google-Smtp-Source: APXvYqwclqccELRhv/Sc7m1LCuXJUri8+5XDjrijQ5Xip1CQhdaXGUvUnmQqjXffUiL+V6d2OnkrVg==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr2421566wmh.86.1559224267185;
        Thu, 30 May 2019 06:51:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f2sm3815143wrq.48.2019.05.30.06.51.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 06:51:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "catalin.marinas\@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "will.deacon\@arm.com" <will.deacon@arm.com>,
        "marc.zyngier\@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "apw\@canonical.com" <apw@canonical.com>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v3 2/2] Drivers: hv: Move Hyper-V clocksource code to new clocksource driver
In-Reply-To: <BYAPR21MB122115920E78B7897FDC7BE9D7180@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <1558969089-13204-1-git-send-email-mikelley@microsoft.com> <1558969089-13204-3-git-send-email-mikelley@microsoft.com> <87r28gl1d1.fsf@vitty.brq.redhat.com> <BYAPR21MB122115920E78B7897FDC7BE9D7180@BYAPR21MB1221.namprd21.prod.outlook.com>
Date:   Thu, 30 May 2019 15:51:05 +0200
Message-ID: <87imtskq46.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, May 30, 2019 2:48 AM
>> > +		/*
>> > +		 * sched_clock_register is needed on ARM64 but
>> > +		 * is a no-op on x86
>> > +		 */
>> > +		sched_clock_register(read_hv_sched_clock_msr,
>> > +						64, HV_CLOCK_HZ);
>> 
>> I'm not sure about ARM, but MSR-based clocksource would be a really bad
>> choice for sched clock on x86, this will slow things down
>> significantly. Luckily, as you're validly stating above,
>> sched_clock_register() is a no-op on x86 as we don't define
>> CONFIG_GENERIC_SCHED_CLOCK.
>> 
>> Can we actually *not* do sched_clock_register() in case
>> TSC page is unavailable (and revert to counting jiffies or whatever)?
>> 
>
> We can't skip the sched_clock_register() on ARM64 because it
> does define CONFIG_GENERIC_SCHED_CLOCK.  However, Hyper-V
> should always provide REFERENCE_TSC_AVAILALBE on ARM64,
> so we should never end up in the MSR-based code on ARM64.
> Arguably that means the call to sched_clock_register() could be
> removed since it's a no-op on x86.  But I'd like to keep it for symmetry
> and in case there's a testing/debugging situation on ARM64 where
> we want to clear REFERENCE_TSC_AVAILABLE and go down the
> MSR-based code path.

Ok, so it is just a fall-back and not going to be actively used. Thanks!

-- 
Vitaly
