Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D933C2509
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhGINho (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 09:37:44 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44635 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhGINhn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 09:37:43 -0400
Received: by mail-wr1-f44.google.com with SMTP id f9so6518069wrq.11;
        Fri, 09 Jul 2021 06:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t65TrXzTgBuxjzSlReCJ6QpG572DUj+HfWyNKCca6RQ=;
        b=un7c7YIWhS3/UyqUfyHZ9WOZcDaoVeIXnEhccl/yeyVLYKsEiKYACpnD4lnncSQ836
         2mQ/SUFeDyYCHH++sRaz6CIobPH++CQDbza/X0vwr6oec4AafzVebGC0hq6fSJAh1Fcu
         hIav4OKRqx1+fcpNZz9O94FTJuIXg/ypgHTcjAt5Tn+THL9Jqb9ZME4txBFhYZovnR51
         IaKB5mpeh8lJ0nrinN4ghLlzRVbNsAQIi++ZdoFLXBPx8LfHTnd6CjTUxnMtNUaCHdW+
         28g7I+ApNpUrKxY5BsvoeV1G4M7YQ3bAxQhRMrHSFCDOzkEi103ESYjqT0zsBc+c6xIg
         Vj2w==
X-Gm-Message-State: AOAM533GJEAX8N+xdMr43LEdQ1QDq4w9IZlnC9M20syve0wCkyw3Jk7P
        jJlgpyQZ5wnFFUq4GrT+//2Ag3BcsjQ=
X-Google-Smtp-Source: ABdhPJzHHNK5AYPEu+qwIR4GYzqj1yEC+9+CdEccFDeVhjdj+9HVf35OD8XaFW5bR5NKmUQP2/tU3w==
X-Received: by 2002:a5d:5751:: with SMTP id q17mr13896201wrw.18.1625837698522;
        Fri, 09 Jul 2021 06:34:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b20sm5067213wmj.7.2021.07.09.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:34:58 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:34:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        pasha.tatashin@soleen.com, kumarpraveen@linux.microsoft.com,
        Will Deacon <will@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        Vineeth Pillai <viremana@linux.microsoft.com>
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in
 PV-IOMMU
Message-ID: <20210709133456.awctvxgtivjo6fuj@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 01:46:19PM +0100, Robin Murphy wrote:
> On 2021-07-09 12:43, Wei Liu wrote:
> > Some devices may have been claimed by the hypervisor already. One such
> > example is a user can assign a NIC for debugging purpose.
> > 
> > Ideally Linux should be able to tell retrieve that information, but
> > there is no way to do that yet. And designing that new mechanism is
> > going to take time.
> > 
> > Provide a command line option for skipping devices. This is a stopgap
> > solution, so it is intentionally undocumented. Hopefully we can retire
> > it in the future.
> 
> Huh? If the host is using a device, why the heck is it exposing any
> knowledge of that device to the guest at all, let alone allowing the guest
> to do anything that could affect its operation!?

The host in this setup consists of the hypervisor, the root kernel and a
bunch of user space programs.

Root is not an ordinary guest. It does need to know all the hardware to
manage the platform. Hypervisor does not claim more devices than it
needs to, nor does it try to hide hardware details from the root.

The hypervisor can protect itself just fine. Any attempt to use the
already claimed devices will be blocked or rejected, so are the attempts
to attach them to device domains.

That, however, leads to some interesting interactions between the
hypervisor and Linux kernel.  When kernel initializes IOMMU during boot,
it will try to attach all devices in one go. Any failure there will
cause kernel to detach the already attached devices. That's not fatal to
kernel, and is only a minor annoyance to our current use case, because
the default domain is a passthrough domain anyway. It will become
problematic once we switch the default domain to a DMA domain to further
tighten security during Linux boot.

Wei.

> 
> Robin.
> 
