Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE85CFD41
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJHPM3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 11:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfJHPM2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 11:12:28 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362EC44BD7
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Oct 2019 15:12:28 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k2so9260027wrn.7
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Oct 2019 08:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TVxQtqSMZ2FHlKInFtkoosjtqyBQr57VDotUlK3rfd8=;
        b=RkWf8end3ARaG2foX9n8YC064Q56xfiDK0pZrpRE5Ii7kolxGFSVgRo1wbbrx1J7l7
         oz/LjhvMKDmeumsGCYENYxxhb4yQ/OkWF0XHyVMWCGCQZbxGH5a6DZcoJrhJBFSjQNbf
         sxy5CrHrdyHVCIzrhNWiHpIgW/MBdoXA045O3ken3UTi2kZ7VUcE8fAx16UqyDqMEs2y
         6uqttBOAbJ5E3j4yABeiw5kA5Tw2gQ6WfR9b4LG5eHkd/0eRBcP/6o5pHCPCrOcPGGuZ
         gU8IrWUgDggcglK21aJRQtcTi3tehgTaUtllOlcqB2ILyuP+z5wOlXG/i7HHm86wC4OQ
         4VaA==
X-Gm-Message-State: APjAAAXDj8b1kMTl0hV+DMa/Hxe6Drhy/IqIeYYeDxLqqqijMYtLN45m
        mqUcls0Lcd9dGhc9leCYfaB5+3gS+T8yZ56yNa8Qi15NXYtObBvXW5RQgM97m5vuG7i9w0gnZ0i
        Yy2oKnvOL9n9kjqzf4IP5mwSO
X-Received: by 2002:a5d:6885:: with SMTP id h5mr27879944wru.92.1570547546797;
        Tue, 08 Oct 2019 08:12:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWPsbrFzZkwZFlcJmltVPmPI8g9/KYtbdTHTU1bA2U1kTZdyLlLDzQYpTdTZpJfELXjnhHew==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr27879921wru.92.1570547546560;
        Tue, 08 Oct 2019 08:12:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h7sm19634893wrs.15.2019.10.08.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:12:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: RE: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
In-Reply-To: <DM5PR21MB01371F96CD845743D9777DC5D79E0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191003155200.22022-1-parri.andrea@gmail.com> <87k19k1mad.fsf@vitty.brq.redhat.com> <DM5PR21MB01371F96CD845743D9777DC5D79E0@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Tue, 08 Oct 2019 17:12:25 +0200
Message-ID: <87tv8jz2xy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, October 4, 2019 9:57 AM
>> 
>> Andrea Parri <parri.andrea@gmail.com> writes:
>> 
>> > If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
>> > HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
>> > configuration version.  Bit 15 corresponds to the
>> > AccessTscInvariantControls privilege.  If this privilege bit is set,
>> > guests can access the HvSyntheticInvariantTscControl MSR: guests can
>> > set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
>> > After setting the synthetic MSR, CPUID will enumerate support for
>> > InvariantTSC.
>> 
>> I tried getting more information from TLFS but as of 5.0C this feature
>> is not described there. I'm really interested in why this additional
>> interface is needed, e.g. why can't Hyper-V just set InvariantTSC
>> unconditionally when TSC scaling is supported?
>> 
>
> Yes, this is very new functionality that is not yet available in a released
> version of Hyper-V.  And as you know, the Hyper-V TLFS has gotten
> woefully out-of-date. :-(
>
> Your question is the same question I asked.   The reason given by
> Hyper-V is to take the more cautious approach of not "automatically"
> giving VMs an InvariantTSC due to updating the underlying Hyper-V
> version.  Instead, guest VMs must have been explicitly coded to take
> advantage of the new InvariantTSC feature.  It's not clear to me how
> much of this caution is driven by Windows guests vs. Linux or FreeBSD
> guests, but it is what it is.
>
> Having to explicitly enable the InvariantTSC does give the Linux code
> the opportunity to be a bit cleaner by doing things like not marking
> the TSC as unstable when the InvariantTSC feature is present, and to
> mark the TSC as reliable so we don't try to do TSC synchronization
> (which Hyper-V does not want guests to try to do).

Thank you for these additional details Michael,

we'll probably have to add support for this bit to KVM and I'd like to
know the background. From Linux perspective, no matter what's the
interface we'd like to get InvariantTSC.

Feel free to add

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
