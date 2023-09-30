Return-Path: <linux-hyperv+bounces-367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F2D7B4306
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 718341C20821
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0F8C0B;
	Sat, 30 Sep 2023 18:31:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3D138E;
	Sat, 30 Sep 2023 18:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2140C433C8;
	Sat, 30 Sep 2023 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696098676;
	bh=gPSt2DVfnZHEWNHwWx6rdcYJzFL/8huE+2zVEzu3HzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCxGV53/kBfbr1GUpC5e/i9KXl5o7XVW0tcnTT1KwiBw4mRDy6sqeUIiaKpWMyMmh
	 71dbmjeyf2gRyNh1E+xT2rH6H1genxj9yX4EL+SNAWKzMe3IDdMDxLVi+gjIMu5HIc
	 Yy8X3iOpXOGLMRlr495lhglerpgD+4y/rq5Sq5Jo=
Date: Sat, 30 Sep 2023 20:31:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023093002-bonfire-petty-c3ca@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
 <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>

On Sat, Sep 30, 2023 at 06:11:19PM +0000, Wei Liu wrote:
> On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> > On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/linux/mshv.h
> > > @@ -0,0 +1,306 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > Much better.
> > 
> > > +#ifndef _UAPI_LINUX_MSHV_H
> > > +#define _UAPI_LINUX_MSHV_H
> > > +
> > > +/*
> > > + * Userspace interface for /dev/mshv
> > > + * Microsoft Hypervisor root partition APIs
> > > + * NOTE: This API is not yet stable!
> > 
> > Sorry, that will not work for obvious reasons.
> 
> This can be removed. For practical purposes, the API has been stable for
> the past three years.

Then who wrote this text?

confused,

greg k-h

