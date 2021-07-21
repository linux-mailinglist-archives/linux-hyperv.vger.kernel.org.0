Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D53D0D6A
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhGUKmT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 06:42:19 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36647 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbhGUJ3x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 05:29:53 -0400
Received: by mail-wm1-f52.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so3099488wms.1;
        Wed, 21 Jul 2021 03:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGOZ0CCJk1xISndjbgUHFvSngWpzz+50b0eJ0QnZMjI=;
        b=W/kOvwY065HGsCWg743fxeSOFWPbh/FR34ZAH9A1p2oHuufZYn3pcRPOtH3hzXLXrJ
         uhwIDGv4T1enLESjgpbe7zb2wmJVhe1XS0mq57Gh/F0ntXzSJ0+8ORJC7AgD93RYoO9V
         970OcuYBCf9a5N3DzOEaZ22uGvLYsbu/N0JbpVPfzYnQagixWl2sVODj6bEXG0JN1kGO
         lHoAhezbKa125T+Fm+JwO0QvrPXiN7/RqhOh9t9msZiOeBjOS+u7T7z0b8DFUZE/zz+s
         oe5GOSc6pCYTBzT9teZiNIcg/3fQpjvWpQCEUKdla0udizCX+8lamiuQ5/H8uRIlN5Qg
         sP5w==
X-Gm-Message-State: AOAM530G/ZG4qsJQMKeMg1diWtGC5tcqxrkE4iEMHigP7xuxLtZH8AjR
        UFqOKwkr+eH3aql4j2sDwkk=
X-Google-Smtp-Source: ABdhPJwAYYhAAIXec9Vo9y6rCL5ag9JTdcByujK/Xmr1EKfbOj2RYSId+IK87GxQM5owHTAf8dulDw==
X-Received: by 2002:a1c:3942:: with SMTP id g63mr37370396wma.64.1626862228400;
        Wed, 21 Jul 2021 03:10:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f17sm5247550wrr.81.2021.07.21.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:10:28 -0700 (PDT)
Date:   Wed, 21 Jul 2021 10:10:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Message-ID: <20210721101026.3tujagjag5umqejh@liuwe-devbox-debian-v2>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
 <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
 <MWHPR21MB159302588AD32CA605192398D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <d8bd9c00-4eb5-187f-e31b-cba2ecec565b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8bd9c00-4eb5-187f-e31b-cba2ecec565b@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 21, 2021 at 12:42:52PM +0530, Praveen Kumar wrote:
> On 21-07-2021 09:40, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 9:29 AM
> >>
> >> On Tue, Jul 20, 2021 at 04:20:44PM +0000, Michael Kelley wrote:
> >>> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 6:35 AM
> >>>>
> >>>> On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
> >>>> [...]
> >>>>>>
> >>>>>>> +	if (hv_root_partition &&
> >>>>>>> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> >>>>>>
> >>>>>> Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
> >>>>>> kernel check this too?
> >>>>>
> >>>>> Yes, you are right. Will update this in v2. thanks.
> >>>>
> >>>> Please split adding this check to its own patch.
> >>>>
> >>>> Ideally one patch only does one thing.
> >>>>
> >>>> Wei.
> >>>>
> >>>
> >>> I was just looking around in the Hyper-V TLFS, and I didn't see
> >>> anywhere that the ability to set up a VP Assist page is dependent
> >>> on HV_MSR_APIC_ACCESS_AVAILABLE.  Or did I just miss it?
> >>
> >> The feature bit Praveen used is wrong and should be fixed.
> >>
> >> Per internal discussion this is gated by the AccessIntrCtrlRegs bit.
> >>
> >> Wei.
> >>
> > 
> > The AccessIntrCtrlRegs bit *is* HV_MSR_APIC_ACCESS_AVAILABLE.
> > Both are defined as bit 4 of the Partition Privilege flags.  :-)   I don't
> > know why the names don't line up.   Even so, it's not clear to me that
> > AccessIntrCtrlRegs has any bearing on the VP Assist page.  I see this
> > description of AccessIntrCtrlRegs:
> > 
> 
> Yup, what I understood as well, this is the one required one for Partition Privilege Flags (4th bit), however, cannot comment on the naming convention.
> 
>      5 /* Virtual APIC assist and VP assist page registers available */
>      4 #define HV_MSR_APIC_ACCESS_AVAILABLE            BIT(4)
> 

Urgh, okay. It is my fault for not reading the code closely. Sorry for
the confusion.

> > The partition has access to the synthetic MSRs associated with the
> > APIC (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR).
> > If this flag is cleared, accesses to these MSRs results in a #GP fault if
> > the MSR intercept is not installed.
> > 
> 
> As per what I also understood from the TLFS doc,that we let partition
> access the MSR and do a fault.  However, the point is, does it make
> sense to allocate page for vp assist and perform action which is meant
> to fail when the flag is cleared ?

Like Michael said, there are some other things that are not tied to that
particular bit. We should get more clarity on what gates what.  Perhaps
that privilege bit only controls access to the EOI assist bit and the
other things in the VP assist page are gated by other privilege bits.
This basically means we should setup the page when there is at least one
thing in that page can be used.

This is mostly an orthogonal issue from the one we want to fix. In
the interest of making progress we can drop the new check for now and
just add a root specific path for setting up and tearing down the VP
assist pages.

How does that sound?

Wei.

> 
> > But maybe you have additional info that applies to the root
> > partition that is not in the TLFS.
> > 
> 
> As per what discussed internally and I understood, the root partition
> shares the vp assist page provided by hypervisor and its read only for
> Root kernel.
> 
> > Michael
> > 
> 
> Regards,
> 
> ~Praveen.
