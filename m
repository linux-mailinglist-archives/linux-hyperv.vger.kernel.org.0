Return-Path: <linux-hyperv+bounces-466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AA7B86F4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 37C7F28159E
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046D1CA81;
	Wed,  4 Oct 2023 17:50:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D21C2AB;
	Wed,  4 Oct 2023 17:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC4C433C7;
	Wed,  4 Oct 2023 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696441834;
	bh=zUosDvRHyf5850z577fl4LTHEhb7yQpe48mCNpSn/dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2WhJHhBMIySUnPBl69ikcW1YP9LVxDdKLskFO0ilfchUa0N62QAKE6YuIQedy7KXD
	 SxnHr2LcS0FDOOjXfHSyTFyx3IFbO6clRjTbzA+eUie0xc0EVaPHTOXuzUnE9W/an/
	 Noh3F/uSnPsR43lBo/FgNg2eHFDKe5hpkVGQ9WLI=
Date: Wed, 4 Oct 2023 19:50:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	MUKESH RATHOR <mukeshrathor@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	vkuznets <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100415-diving-clapper-a2a7@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
 <2023100443-wrinkly-romp-79d9@gregkh>
 <SA1PR21MB1335F5145ACB0ED4F378105ABFCBA@SA1PR21MB1335.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335F5145ACB0ED4F378105ABFCBA@SA1PR21MB1335.namprd21.prod.outlook.com>

On Wed, Oct 04, 2023 at 05:36:32PM +0000, Dexuan Cui wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, October 3, 2023 11:10 PM
> > [...]
> > On Tue, Oct 03, 2023 at 04:37:01PM -0700, Nuno Das Neves wrote:
> > > On 9/30/2023 11:19 PM, Greg KH wrote:
> > > > On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> > > > > On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > > > > > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > > > > > +/* Define connection identifier type. */
> > > > > > > +union hv_connection_id {
> > > > > > > +   __u32 asu32;
> > > > > > > +   struct {
> > > > > > > +           __u32 id:24;
> > > > > > > +           __u32 reserved:8;
> > > > > > > +   } __packed u;
> 
> IMO the "__packed" is unnecessary.
> 
> > > > > > bitfields will not work properly in uapi .h files, please never do that.
> > > > >
> > > > > Can you clarify a bit more why it wouldn't work? Endianess? Alignment?
> > > >
> > > > Yes to both.
> > > >
> > > > Did you all read the documentation for how to write a kernel api?  If
> > > > not, please do so.  I think it mentions bitfields, but it not, it really
> > > > should as of course, this will not work properly with different endian
> > > > systems or many compilers.
> > >
> > > Yes, in
> > https://docs.k/
> > ernel.org%2Fdriver-
> > api%2Fioctl.html&data=05%7C01%7Cdecui%40microsoft.com%7Ce404769e0f
> > 85493f0aa108dbc4a08a27%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C
> > 0%7C638319966071263290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> > 7C%7C&sdata=RiLNA5DRviWBQK6XXhxC4m77raSDBb%2F0BB6BDpFPUJY%3D
> > &reserved=0 it says that it is
> > > "better to avoid" bitfields.
> > >
> > > Unfortunately bitfields are used in the definition of the hypervisor
> > > ABI. We import these definitions directly from the hypervisor code.
> >
> > So why do you feel you have to use this specific format for your
> > user/kernel api?  That is not what is going to the hypervisor.
> 
> If it's hard to avoid bitfield here, maybe we can refer to the definition of
> struct iphdr in include/uapi/linux/ip.h

It is not hard to avoid using bitfields, just use the proper definitions
to make this portable for all compilers.  And ick, ip.h is not a good
thing to follow :)

thanks,

greg k-h

