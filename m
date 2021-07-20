Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43C83CFF7A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhGTPuw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 11:50:52 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39649 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhGTPst (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 11:48:49 -0400
Received: by mail-wr1-f41.google.com with SMTP id f17so26674929wrt.6;
        Tue, 20 Jul 2021 09:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WuSxKbZv1270tdEdT+79zSasF7N89mdYN3IHwx2ceu4=;
        b=WqruCoV+0yBjaMXk2jEM/j0TWM1h7z3hzoSDFsuB7GRue+Ru8lgZVP9ZrG36nEii15
         a1/ESjCtXabmZ+GFJ8gpA5Jz1a9rlVFBSoKCXmlLTasP0CSiAI/6HvS3JO9RUDqRuf4/
         c7hEoaiCMGHqubbB2wtE+LjPTrG/eVizrIuI7RdQe0ZJ4BIydnG64HRoJmMLvFKVwyU/
         Yx/NxBfrtZeFzcCwMp9+HKypfD0MEGWE5Kj5FWGGnQAcoIdiOprG0QNJ4mAPdK8M3qnX
         BJEdTHIMNb/9q4vgQcv7Edl5W8Rwd6x5SC+g2M2NeuVJAaefV9MOKKJPQWkyP9P5UfuY
         XAiA==
X-Gm-Message-State: AOAM531Dd30VFRvvP6Jwe+e2jgEFn8RDynT2qKxN8bF6VSvrw6zHBMSw
        0E43yQfg/BfMzz2bGOh+41I=
X-Google-Smtp-Source: ABdhPJwDX9VDSbIc/atf9Qvf2Bq4ZHzx7iLjbiOb6TNRFayLjqkgUbUD70BsO2CZ6+JB5NhkGVNfDw==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr36898120wri.374.1626798565582;
        Tue, 20 Jul 2021 09:29:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o7sm16630673wrs.52.2021.07.20.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:29:25 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:29:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
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
Message-ID: <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
 <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 04:20:44PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 6:35 AM
> > 
> > On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
> > [...]
> > > >
> > > >> +	if (hv_root_partition &&
> > > >> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> > > >
> > > > Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
> > > > kernel check this too?
> > >
> > > Yes, you are right. Will update this in v2. thanks.
> > 
> > Please split adding this check to its own patch.
> > 
> > Ideally one patch only does one thing.
> > 
> > Wei.
> > 
> 
> I was just looking around in the Hyper-V TLFS, and I didn't see
> anywhere that the ability to set up a VP Assist page is dependent
> on HV_MSR_APIC_ACCESS_AVAILABLE.  Or did I just miss it?

The feature bit Praveen used is wrong and should be fixed.

Per internal discussion this is gated by the AccessIntrCtrlRegs bit.

Wei.

> 
> Maybe the VP Assist page is not useful for the APIC EOI optimization
> Purposes if !HV_MSR_APIC_ACCESS_AVAILABLE, but the VP Assist
> page has other uses, such as for nested enlightenments.  So I
> wonder if the VP Assist page setup really should be gated on
> HV_MSR_APIC_ACCESS_AVAILABLE.
> 
> Michael
