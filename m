Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1003B8FD9
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhGAJjZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 05:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235352AbhGAJjZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 05:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1944661449;
        Thu,  1 Jul 2021 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625132215;
        bh=S1Efz8mAq8RON+Vr5JjVbvbMIB2aRjnUmMwpk1S1/98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zB6xWZER850I8uyuY+vjlBV9qPI5NMazggLQhpEb6O2p+iMK8eZkN9PQkYMfw5zX7
         MubT/KNGN3kR9rjdIAwo0PZuHmkrLt5bUycX1DAKikdf0pxllPFRXLzQ6RJdwdZMww
         O59+gxWbEUE+aW2M7nYK96PCyqMV/SEL15xN/zrI=
Date:   Thu, 1 Jul 2021 11:36:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YN2MtVFOC+yd/rRZ@kroah.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <YNq8p1320VkH2T/c@kroah.com>
 <BY5PR21MB1506FC199A753667E72C9B09CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506FC199A753667E72C9B09CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 01, 2021 at 06:58:35AM +0000, Long Li wrote:
> > Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
> > > +
> > > +static struct az_blob_device az_blob_dev;
> > > +
> > > +static int az_blob_ringbuffer_size = (128 * 1024);
> > > +module_param(az_blob_ringbuffer_size, int, 0444);
> > > +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size
> > > +(bytes)");
> > 
> > This is NOT the 1990's, please do not create new module parameters.
> > Just make this work properly for everyone.
> 
> The default value is chosen so that it works best for most workloads while not taking too much system resources. It should work out of box for nearly all customers.

Please wrap your email lines :(

Anyway, great, it will work for everyone, no need for this to be
changed.  Then just drop it.

> But what we see is that from time to time, some customers still want to change those values to work best for their workloads. It's hard to predict their workload. They have to recompile the kernel if there is no module parameter to do it. So the intent of this module parameter is that if the default value works for you, don't mess up with it.

Can you not just determine at runtime that these workloads are
overflowing the buffer and increase the size of it?  That would be best
otherwise you are forced to try to deal with a module parameter that is
for code, not for devices (which is why we do not like module parameters
for drivers.)

Please remove this for now and if you _REALLY_ need it in the future,
make it auto-tunable.  Or if that is somehow impossible, then make it a
per-device option, through something like sysfs so that it will work
correctly per-device.

thanks,

greg k-h
