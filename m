Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1030C974
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Feb 2021 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhBBSS6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Feb 2021 13:18:58 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38015 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbhBBSQp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Feb 2021 13:16:45 -0500
Received: by mail-wr1-f54.google.com with SMTP id b3so3365596wrj.5;
        Tue, 02 Feb 2021 10:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCp+C+rgPYZTZ229hkCWEYMMpy6/7MzmueKWQdI985s=;
        b=AV298+j1AiOz73Ta9LuHBF/a4+s40toGw8rx4Ge35ATNTNQ1Bs8Jwv8HEHs5A6nNUW
         0enZabyNCwuiSvjW6XPVLZuGg8JOdpHOmx2bP3x3Lkzzu70gp7tziRM83sQohottoK3v
         AkY6uR1J5BzFKMLMcev9oratFZoJp6egTS/gZADHzFeRr+7oF8eWIs3PaIQIBp1yY3HU
         nwsoBXnvyCImhNV5P9EJTBEMES+kVFKgcYuAAIEoVUR0NgcgNYpJDPGNANy1SMfbOU4U
         2LUO+M/r0GCG7tvucm1KYbb1nb0WqSM85iWpqhFc0D4fQrgUhRaRUgvakp7WTkqKW9oc
         jVoA==
X-Gm-Message-State: AOAM53377A6xRl0XZnRSlxNRAOc5h1IcZj51G9cWNJlgI7V3eQQQA/j7
        FXH92/o7NEDl3s9FwrVFjv4=
X-Google-Smtp-Source: ABdhPJzm1+hIiMOhMVNoFIodRo9Vswj4u0lg6rRTh7uPnqz7H7LD3Ip2YXrB+ZXKnVMQ9OPhiXifIA==
X-Received: by 2002:adf:902a:: with SMTP id h39mr24929214wrh.147.1612289761909;
        Tue, 02 Feb 2021 10:16:01 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r11sm4433342wmh.9.2021.02.02.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:16:01 -0800 (PST)
Date:   Tue, 2 Feb 2021 18:16:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20210202181600.4lk4zber7dogsd6e@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-16-wei.liu@kernel.org>
 <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202173153.jkbvwck2vsjlbjbz@liuwe-devbox-debian-v2>
 <MWHPR21MB1593248BE6E343117897FE82D7B59@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593248BE6E343117897FE82D7B59@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 02, 2021 at 06:15:23PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, February 2, 2021 9:32 AM
> > 
> > On Wed, Jan 27, 2021 at 05:47:04AM +0000, Michael Kelley wrote:
> > > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > > >
> > > > When Linux runs as the root partition on Microsoft Hypervisor, its
> > > > interrupts are remapped.  Linux will need to explicitly map and unmap
> > > > interrupts for hardware.
> > > >
> > > > Implement an MSI domain to issue the correct hypercalls. And initialize
> > > > this irqdomain as the default MSI irq domain.
> > > >
> > > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > > ---
> > > > v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> > > > v3: build irqdomain.o for 32bit as well.
> > >
> > > I'm not clear on the intent for 32-bit builds.  Given that hv_proc.c is built
> > > only for 64-bit, I'm assuming running Linux in the root partition
> > > is only functional for 64-bit builds.  So is the goal simply that 32-bit
> > > builds will compile correctly?  Seems like maybe there should be
> > > a CONFIG option for running Linux in the root partition, and that
> > > option would force 64-bit.
> > 
> > To ensure 32 bit kernel builds and 32 bit guests still work.
> > 
> > The config option ROOT_API is to be introduced by Nuno's /dev/mshv
> > series. We can use that option to gate some objects when that's
> > available.
> > 
> 
> But just so I'm 100% clear, is there intent to run 32-bit Linux in the root
> partition?  I'm assuming not.

That's correct. There is no intent to run 32-bit Linux as the root
partition.

Wei.

> 
> Michael
