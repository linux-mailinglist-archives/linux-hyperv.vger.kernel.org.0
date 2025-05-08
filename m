Return-Path: <linux-hyperv+bounces-5434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C173AB019E
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 19:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864D77A2368
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C2221263;
	Thu,  8 May 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD9tyjFA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A035280;
	Thu,  8 May 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726262; cv=none; b=N3ga8ZXPGdkSWDMLuPq0FiqQ9pqK4HGyFU9h3jPEoeBdeY41H4v6MZ/Mo+zSGylPq8DPnNY6Uz63VVoK/tn9YNVMXldvWnYgeS7rJTX609wqlih8RwYb+NlxA30MFMtC+SLggLL2E4txf9KGRgNktR4QII0cMku2lM7OeYVEpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726262; c=relaxed/simple;
	bh=ggJqzLfDZF6JcVjU9+qn2WkG6jbiVBUxtOFInV1yt08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z66UT7ceAdWP3EQUvACdDTojRc7MdNxeD2hfgH7ngcR35dDk35aFcNKo8Hxi1TfhcGTrWRBKkqFkIZpGpJweJ/mIzrt+2HoUWHtYvmN1wthnvUaCj7VIXIjYkmEi6vsLKmjPS2x4LBgIpzvxEH3udwwNM6Bgre5Gk+Cqp3IlkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD9tyjFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADE2C4CEE7;
	Thu,  8 May 2025 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746726261;
	bh=ggJqzLfDZF6JcVjU9+qn2WkG6jbiVBUxtOFInV1yt08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cD9tyjFA+jyI1ZP42QTPLdyZXJSxb/Mq8y7GAuDsMdYIRhQRSP8Irc/0/sAmTWSqm
	 EqmvRks7CurmfHomSQ0kKu1WqEoiZIMuPwcZKUkWM30maCmib2CvfSkhLJ1+V6madO
	 n/fjpxbJ6lbeNDYSmPo0W4J4vUuYGANcZaXw48TinHELSJ87C+Lny2Q09mgrhcajsM
	 e3k06UInPlQ1sw62573TwUanJfL0kvEQZEMM6lz00L+vn3HRKDZLoLSImKqOK5vjmu
	 Xms2mvv9fELcVu0eC/8sXqJFJEVnQ4swMXr7lZognPFL12bHvxSvKfYxfPo2IIDVnF
	 w0lcx7ST71YSA==
Date: Thu, 8 May 2025 17:44:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <aBztdK82ZQQvnWsh@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
 <29edc00e-9797-4f4a-83b3-0b4158c94a16@linux.microsoft.com>
 <KUZP153MB14448028621F8148D5129D9FBE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <1edea7f4-5ad2-4103-8eb5-9d5d9f0c7b0d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1edea7f4-5ad2-4103-8eb5-9d5d9f0c7b0d@linux.microsoft.com>

On Thu, May 08, 2025 at 08:44:14AM -0700, Roman Kisel wrote:
> 
> 
> On 5/7/2025 8:00 PM, Saurabh Singh Sengar wrote:
> > > 
> > > On 5/7/2025 4:21 AM, Naman Jain wrote:
> > > > 
> > > > 
> > > 
> > > [...]
> > > 
> > > > <snip>
> > > > 
> > > > > > +        return -EINVAL;
> > > > > > +    if (copy_from_user(payload, (void __user *)message.payload_ptr,
> > > > > > +               message.payload_size))
> > > > > > +        return -EFAULT;
> > > > > > +
> > > > > > +    return hv_post_message((union
> > > > > 
> > > > > This function definition is in separate file which can be build as
> > > > > independent module, this will cause problem while linking . Try
> > > > > building with CONFIG_HYPERV=m and check.
> > > > > 
> > > > > - Saurabh
> > > > 
> > > > Thanks for reviewing Saurabh. As CONFIG_HYPERV can be set to 'm'
> > > > and CONFIG_MSHV_VTL depends on it, changing CONFIG_MSHV_VTL to
> > > > tristate and a few tweaks in Makefile will fix this issue. This will
> > > > ensure that mshv_vtl is also built as a module when hyperv is built as a
> > > module.
> > > > 
> > > > I'll take care of this in next version.
> > > 
> > > Let me ask for a clarification. How would the system boot if CONFIG_HYPERV
> > > is set to m? The arch parts are going to be still compiled-in, correct?
> > > Otherwise I don't see how that would initialize.
> > > 
> > > I am thinking who would load Hyper-V modules on the system that requires
> > > Hyper-V here. It is understandable that distro's build Hyper-V as a module.
> > > That way, they don't have to load anything when there is no Hyper-V. Here, it
> > > is Hyper-V in and out, what do we need to fix?
> > 
> > We need to fix compilation - for everyone.
> 
> You seem to know for whom it is broken, would be great to share this
> knowledge. When CONFIG_MSHV_VTL is set to "m", OpenHCL will break down
> without additional work. So why do we need to be able to build that
> as a module, to let someone build the firmware that doesn't work?
> 
> So far the request comes off as absurd to me.
> 

I don't think this is an absurd request.

While obviously Microsoft will only build the code as builtin, there are
bots that do randconfig build tests but never run the resulting binary.

Thanks,
Wei.

> > 
> > - Saurabh
> > 
> > > 
> > > > 
> > > > here is the diff for reference:
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> > > > 57dcfcb69b88..c7f21b483377 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -73,7 +73,7 @@ config MSHV_ROOT
> > > >             If unsure, say N.
> > > > 
> > > >    config MSHV_VTL
> > > > -       bool "Microsoft Hyper-V VTL driver"
> > > > +       tristate "Microsoft Hyper-V VTL driver"
> > > >           depends on HYPERV && X86_64
> > > >           depends on TRANSPARENT_HUGEPAGE
> > > >           depends on OF
> > > > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile index
> > > > 5e785dae08cc..c53a0df746b7 100644
> > > > --- a/drivers/hv/Makefile
> > > > +++ b/drivers/hv/Makefile
> > > > @@ -15,9 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)    +=
> > > > hv_debugfs.o
> > > >    hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> > > >    mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o
> > > > mshv_irq.o \
> > > >                  mshv_root_hv_call.o mshv_portid_table.o
> > > > +mshv_vtl-y := mshv_vtl_main.o
> > > > 
> > > >    # Code that must be built-in
> > > >    obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o -obj-$(subst
> > > > m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
> > > > -
> > > > -mshv_vtl-y := mshv_vtl_main.o mshv_common.o
> > > > +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o ifneq
> > > > +($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> > > > +    obj-y += mshv_common.o
> > > > +endif
> > > > 
> > > > Regards,
> > > > Naman
> > > 
> > > --
> > > Thank you,
> > > Roman
> > 
> 
> -- 
> Thank you,
> Roman
> 

