Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4356F2ED035
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbhAGMsR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 07:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbhAGMsP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 07:48:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4420C0612F5;
        Thu,  7 Jan 2021 04:47:34 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n4so5952136iow.12;
        Thu, 07 Jan 2021 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCLy8VrQodAop51Awg1A+jpjQ6reSMPG8uPhfo714Ls=;
        b=eSeqxSlCqV8tW+X5KbxR8LtrlhxTB5WI8UAFAz6G4Mz2pkBlaTX+1nkN6ad1zsnF99
         dSpH/gxiZzKeA2jf3kUny5aJsn2kYZ/sEWXV2eoKwJVeq+cFsQCYsVJcu3ivN+ubc5H4
         TT8f8vTISNEigGJ0o7p+GWKMAEUXixLw/rGL6DDdW0DgvAMvckyVXXtDZbr6WOwKkMrq
         WOg9XV27DShAmB9s8mmY7TPmd7TaJmY1nYXxuYrXmXDsEZvyF6evqae8BUx/IjQsKgjr
         w5Ns4/XLKsTNbrBls8XlC1qh3N+nq6hIA/8riV0NFvelX9RZFbdtOUEoJfDBkxb6eTHR
         RIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCLy8VrQodAop51Awg1A+jpjQ6reSMPG8uPhfo714Ls=;
        b=P0T1kVyE2ycB9bGY0GDjFG7SSW0pQU+MEXSQlrXj2mbbj2BvFkS9dGHUf5LmpsLfV/
         KlywTM3n/R5XKtCNRi7dpzY0MNtkhIm1azNmRhZtBtPNjYBMFXIBerE+KX0KJlm2UKPQ
         FkJd4tW4wFp20OJGAtdE2Bz6TVMBK7i1lg8732SLWQKCoewPmqrv7KeLmuaVBpFNq0bu
         a7E5zNRKJBTnPvdiejiOOGmlARcIKCc1V7bYOOfo6mzYF9YwvJSkh6w2kgy0k8a3w9WS
         yPMM5fAFX7GpMIdqNmEfJZdE6KNJX95k4/EdMxBkWZsS/DlBkR69NwsmKGLTma6ccKpJ
         daMQ==
X-Gm-Message-State: AOAM531C+o7hMTjPeDqQRMSeuxREOSYQrj87VsY/WZ24XBaeaAjMHC8+
        BuBwHfT26c4POv6jFo4qsWk=
X-Google-Smtp-Source: ABdhPJyHwJzAQMHA9Zr5CNOCL+Xz3VQfgjiDe2rMDpFjL28zvO+T1PY+r1C9q0eUrH0KOTb7Eq7stA==
X-Received: by 2002:a05:6602:581:: with SMTP id v1mr1088734iox.120.1610023654312;
        Thu, 07 Jan 2021 04:47:34 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m19sm4557905ila.81.2021.01.07.04.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 04:47:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7AE3A27C0054;
        Thu,  7 Jan 2021 07:47:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Jan 2021 07:47:32 -0500
X-ME-Sender: <xms:4wL3XzlvL9h87oT0SYAOhHo6sHZk3wY9OE5KVHUFsZRqU2DdnvfGpg>
    <xme:4wL3X8Gaqq9CSXpmAw0z05Wttsmmo35sg8NXIFUBl_dbJPlOZX8X1WwD_HJ7UPwQk
    m7qI98_bIPBcuXAmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfejledvtedvfefgkedvkeelueehkeehvefguedufedvhefguedvuddttdeg
    ieffnecuffhomhgrihhnpehrshhtrdhsohenucfkphepudeijedrvddvtddrvddruddvie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:4wL3X7XpLPPpimG7L5YKjpmdFS9V-i_jtYKRFGXoZDjBs5DOarejLA>
    <xmx:4wL3XzwWPYGg8S9_SlJFzLUFq99Hty6B4wB9NHRFMtEbzqGfnKPSpg>
    <xmx:4wL3X5OoJpi8atnR2Qs8fjopNXu9UUIDaGo-UmLCvLGEwBGg-X_P-Q>
    <xmx:5AL3X-yv-JrFMk3WWp9rPw1zf1ohOqsnkvVXE-HYEXzQFyKFNI9zskSlGrE>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 900FD240066;
        Thu,  7 Jan 2021 07:47:31 -0500 (EST)
Date:   Thu, 7 Jan 2021 20:46:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Message-ID: <X/cCmLGoJDnv0m06@boqun-archlinux>
References: <20201223001222.30242-1-decui@microsoft.com>
 <MWHPR21MB15934AF3CA6C91DB036F7970D7D09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <MW2PR2101MB18199B8BB434D67363658E72BFD09@MW2PR2101MB1819.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB18199B8BB434D67363658E72BFD09@MW2PR2101MB1819.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 08:49:32PM +0000, Dexuan Cui wrote:
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Wednesday, January 6, 2021 9:38 AM
> > From: Dexuan Cui <decui@microsoft.com>
> > Sent: Tuesday, December 22, 2020 4:12 PM
> > >
> > > When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> > > hibernation for the VM (this happens on old Hyper-V hosts like Windows
> > > Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> > > the hibernation intent for the VM), the VM is discouraged from trying
> > > hibernation (because the host doesn't guarantee that the VM's virtual
> > > hardware configuration will remain exactly the same across hibernation),
> > > i.e. the VM should not try to set up the swap partition/file for
> > > hibernation, etc.
> > >
> > > x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> > > indication of the host toolstack support for a VM. Currently there is
> > > no easy and reliable way for the userspace to detect the presence of
> > > the state (see ...).  Add
> > > /sys/bus/vmbus/supported_features for this purpose.
> >
> > I'm OK with surfacing the hibernation capability via an entry in
> > /sys/bus/vmbus.  Correct me if I'm wrong, but I think the concept
> > being surfaced is not "ACPI S4 state" precisely, but slightly more
> > generally whether hibernation is supported for the VM.  While
> > those two concepts may be 1:1 for the moment, there might be
> > future configurations where "hibernation is supported" depends
> > on other factors as well.
> 
> For x86, I believe the virtual ACPI S4 state exists only when the
> admin/user declares the intent of "enable hibernation for the VM" via
> some PowwerShell/WMI command. On Azure, if a VM size is not suitable
> for hibernation (e.g. an existing VM has an ephemeral local disk),
> the toolstack on the host should not enable the ACPI S4 state for the
> VM. That's why we implemented hv_is_hibernation_supported() for x86 by
> checking the ACPI S4 state, and we have used the function
> hv_is_hibernation_supported() in hv_utils and hv_balloon for quite a
> while.
> 
> For ARM, IIRC there is no concept of ACPI S4 state, so currently
> hv_is_hibernation_supported() is actually not implemented. Not sure

Because the core support for ARM64 Hyper-V is not merged yet. In
Michael's core patchset, hv_is_hibernation_supported() is implemented as
always returning false, and there is more work (other than Michael's
core pachset) to make hiberation work on ARM64 Hyper-V guest.

Regards,
Boqun

> why hv_utils and hv_balloon can build successfully... :-) Probably
> Boqun can help to take a look.
> 
> >
> > The guidance for things in /sys is that they generally should
> > be single valued (see Documentation/filesystems/sysfs.rst).  So my
> > recommendation is to create a "hibernation" entry that has a value
> > of 0 or 1.
> >
> > Michael
> 
> Got it. Then let's use /sys/bus/vmbus/hibernation.
> 
> Will post v3.
> 
> Thanks,
> -- Dexuan
> 
