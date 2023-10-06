Return-Path: <linux-hyperv+bounces-478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBC7BB0D2
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Oct 2023 06:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E21C20847
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Oct 2023 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB041C39;
	Fri,  6 Oct 2023 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iBmOLzLe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B51C20
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Oct 2023 04:28:09 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF053DB;
	Thu,  5 Oct 2023 21:28:07 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 16F1220B74C0; Thu,  5 Oct 2023 21:28:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F1220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696566487;
	bh=VBmYwvXPtMjKxp0JBBoGPP6lwV3PKu/EqwN3kEREnbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBmOLzLeSVS1UZvXtX6J/+6jaPe9RtlnV/ovwK3HQsua+ZuhN8XUo5YON91oE2J8+
	 1s2NdXVPGbzVByTuC1Q/rSCWoZRZlhuTH2U3P6c0LlzxdlwwglsZpNl1NwgFczYKBI
	 /8J+5EkkDNtZ+UhCpqt1aXY2H0gR2QLLfJkD5JiQ=
Date: Thu, 5 Oct 2023 21:28:07 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
 devices
Message-ID: <20231006042807.GA22906@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
 <2023081215-canine-fragile-0a69@gregkh>
 <PUZP153MB06350DAEA2384B996519E07EBE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <2023082246-lumping-rebate-4142@gregkh>
 <20230906122307.GA5737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230926124126.GA12048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926124126.GA12048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 05:41:26AM -0700, Saurabh Singh Sengar wrote:
> On Wed, Sep 06, 2023 at 05:23:07AM -0700, Saurabh Singh Sengar wrote:
> > On Tue, Aug 22, 2023 at 01:48:03PM +0200, Greg KH wrote:
> > > On Mon, Aug 21, 2023 at 07:36:18AM +0000, Saurabh Singh Sengar wrote:
> > > > 
> > > > 
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Saturday, August 12, 2023 4:45 PM
> > > > > To: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > > > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > > > > <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> > > > > corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > > > > linux-doc@vger.kernel.org
> > > > > Subject: [EXTERNAL] Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V
> > > > > devices
> > > > > 
> > > > > On Fri, Aug 04, 2023 at 12:09:53AM -0700, Saurabh Sengar wrote:
> > > > > > Hyper-V is adding multiple low speed "speciality" synthetic devices.
> > > > > > Instead of writing a new kernel-level VMBus driver for each device,
> > > > > > make the devices accessible to user space through a UIO-based
> > > > > > hv_vmbus_client driver. Each device can then be supported by a user
> > > > > > space driver. This approach optimizes the development process and
> > > > > > provides flexibility to user space applications to control the key
> > > > > > interactions with the VMBus ring buffer.
> > > > > 
> > > > > Why is it faster to write userspace drivers here?  Where are those new drivers,
> > > > > and why can't they be proper kernel drivers?  Are all hyper-v drivers going to
> > > > > move to userspace now?
> > > > 
> > > > Hi Greg,
> > > > 
> > > > You are correct; it isn't faster. However, the developers working on these userspace
> > > > drivers can concentrate entirely on the business logic of these devices. The more
> > > > intricate aspects of the kernel, such as interrupt management and host communication,
> > > > can be encapsulated within the uio driver.
> > > 
> > > Yes, kernel drivers are hard, we all know that.
> > > 
> > > But if you do it right, it doesn't have to be, saying "it's too hard for
> > > our programmers to write good code for our platform" isn't exactly a
> > > good endorcement of either your programmers, or your platform :)
> > > 
> > > > The quantity of Hyper-V devices is substantial, and their numbers are consistently
> > > > increasing. Presently, all of these drivers are in a development/planning phase and
> > > > rely significantly on the acceptance of this UIO driver as a prerequisite.
> > > 
> > > Don't make my acceptance of something that you haven't submitted before
> > > a business decision that I need to make, that's disenginous.
> > > 
> > > > Not all hyper-v drivers will move to userspace, but many a new slow Hyperv-V
> > > > devices will use this framework and will avoid introducing a new kernel driver. We
> > > > will also plan to remove some of the existing drivers like kvp/vss.
> > > 
> > > Define "slow" please.
> > 
> > In the Hyper-V environment, most devices, with the exception of network and storage,
> > typically do not require extensive data read/write exchanges with the host. Such
> > devices are considered to be 'slow' devices.
> > 
> > > 
> > > > > > The new synthetic devices are low speed devices that don't support
> > > > > > VMBus monitor bits, and so they must use vmbus_setevent() to notify
> > > > > > the host of ring buffer updates. The new driver provides this
> > > > > > functionality along with a configurable ring buffer size.
> > > > > >
> > > > > > Moreover, this series of patches incorporates an update to the fcopy
> > > > > > application, enabling it to seamlessly utilize the new interface. The
> > > > > > older fcopy driver and application will be phased out gradually.
> > > > > > Development of other similar userspace drivers is still underway.
> > > > > >
> > > > > > Moreover, this patch series adds a new implementation of the fcopy
> > > > > > application that uses the new UIO driver. The older fcopy driver and
> > > > > > application will be phased out gradually. Development of other similar
> > > > > > userspace drivers is still underway.
> > > > > 
> > > > > You are adding a new user api with the "ring buffer" size api, which is odd for
> > > > > normal UIO drivers as that's not something that UIO was designed for.
> > > > > 
> > > > > Why not just make you own generic type uiofs type kernel api if you really
> > > > > want to do all of this type of thing in userspace instead of in the kernel?
> > > > 
> > > > Could you please elaborate more on this suggestion. I couldn't understand it
> > > > completely.
> > > 
> > > Why is uio the requirement here?  Why not make your own framework to
> > > write hv drivers in userspace that fits in better with the overall goal?
> > > Call it "hvfs" or something like that, much like we have usbfs for
> > > writing usb drivers in userspace.
> > > 
> > > Bolting on HV drivers to UIO seems very odd as that is not what this
> > > framework is supposed to be providing at all.  UIO was to enable "pass
> > > through" memory-mapped drivers that only wanted an interrupt and access
> > > to raw memory locations in the hardware.
> > > 
> > > Now you are adding ring buffer managment and all other sorts of things
> > > just for your platform.  So make it a real subsystem tuned exactly for
> > > what you need and NOT try to force it into the UIO interface (which
> > > should know nothing about ring buffers...)
> > 
> > Thank you for elaborating the details. I will drop the plan to introduce a
> > new UIO driver for this effort. However, I would like to know your thoughts
> > on enhancing existing 'uio_hv_generic' driver to achieve the same.  We
> > already have 'uio_hv_generic' driver in linux kernel, which is used for
> > developing userspace drivers for 'fast Hyper-V devices'.
> > 
> > Since these newly introduced synthetic devices operate at a lower speed,
> > they do not have the capability to support monitor bits. Instead, we must
> > utilize the 'vmbus_setevent()' method to enable interrupts from the host.
> > Earlier we made an attempt to support slow devices by uio_hv_generic :
> > https://lore.kernel.org/lkml/1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com/.
> > At that time, the absence of userspace code (fcopy) hindered progress
> > in this direction.
> > 
> > Acknowledging your valid concerns about introducing a new UIO driver for
> > Hyper-V, I propose exploring the potential to enhance the existing
> > 'uio_hv_generic' driver to accommodate slower devices effectively. My
> > commitment to this endeavour includes ensuring the seamless operation of
> > the existing 'fcopy' functionality with the modified 'uio_hv_generic'
> > driver. Additionally, I will undertake the task of removing the current
> > 'fcopy' kernel driver and userspace daemon as part of this effort.
> > 
> > Please let me know your thoughts. I look forward to your feedback and
> > the opportunity to discuss this proposal further. 
> 
> Greg,
> 
> May I know if enhancing uio_hv_generic.c to support 'slow devices' is
> an accptable approach ? I'm willing to undertake this task and propose
> the necessary modifications.
> 
> - Saurabh

ping

> 
> > 
> > - Saurabh

