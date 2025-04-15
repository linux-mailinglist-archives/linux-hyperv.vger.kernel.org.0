Return-Path: <linux-hyperv+bounces-4921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE4A8A3D6
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C3817E604
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE829E041;
	Tue, 15 Apr 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zx8vlGfH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEF2980AE;
	Tue, 15 Apr 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733646; cv=none; b=hocZatx/62V72OHoDapjxNgiReUIXSfUmDqyeXQKx7cQ3EPHcxjybShFi0xVqBQdDQHPMhfgSavNd10O8p3nQXLQrWFKCiSV9c/NddJkDgp/pWD7y0Mukthtns23MsOiH4ncwSMNxFHX8MrIhVqn8wQg4AR6h/ZujGZ8fB+zXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733646; c=relaxed/simple;
	bh=NbLare3beq/jAIFXidoKTYfv9DNLJVjdI7gHvGUkNMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/vTaJ1XruiS+Y2R94u9PfqUahi4vjWUIrCUVDcDFDndKBTN/yx9AB/gDZMtL1p2NJ/Gxx35tgECHiYxdsh62eew0xHnZEMRKcCQLFGLkszYVHieenp1psBB2wO2VBnFfaR3gA0oAyQNdd7X18vwbTKY/tQN2mjYWhwh1ISWJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zx8vlGfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E101C4CEEB;
	Tue, 15 Apr 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744733645;
	bh=NbLare3beq/jAIFXidoKTYfv9DNLJVjdI7gHvGUkNMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zx8vlGfH2I/rlgiziU5fVTIr66F9GJh02lbq3Va1r3zFay17UCDwHkqJ4E1V6yNc0
	 Q2RY8CEhGVMV85Kl7T4+XUWWkPCtzGQ7obLejfg/VQB0NJALOHEfaD4VVwxk6bknmo
	 vmp2AAW6W9G3yEeTehzE+q9r/td4vf4C38457/AA=
Date: Tue, 15 Apr 2025 18:14:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025041549-unawake-frisbee-5813@gregkh>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
 <20250410060847.82407-2-namjain@linux.microsoft.com>
 <2025041527-cesarean-facial-cdca@gregkh>
 <ca303616-750d-485d-bf3c-8a4106121aec@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca303616-750d-485d-bf3c-8a4106121aec@linux.microsoft.com>

On Tue, Apr 15, 2025 at 09:24:16PM +0530, Naman Jain wrote:
> 
> 
> On 4/15/2025 8:40 PM, Greg Kroah-Hartman wrote:
> > On Thu, Apr 10, 2025 at 11:38:46AM +0530, Naman Jain wrote:
> > > On regular bootup, devices get registered to VMBus first, so when
> > > uio_hv_generic driver for a particular device type is probed,
> > > the device is already initialized and added, so sysfs creation in
> > > uio_hv_generic probe works fine. However, when device is removed
> > > and brought back, the channel rescinds and device again gets
> > > registered to VMBus. However this time, the uio_hv_generic driver is
> > > already registered to probe for that device and in this case sysfs
> > > creation is tried before the device's kobject gets initialized
> > > completely.
> > > 
> > > Fix this by moving the core logic of sysfs creation for ring buffer,
> > > from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
> > > attributes for the channels are defined. While doing that, make use
> > > of attribute groups and macros, instead of creating sysfs directly,
> > > to ensure better error handling and code flow.
> > > 
> > > Problem path:
> > > vmbus_process_offer (new offer comes for the VMBus device)
> > >    vmbus_add_channel_work
> > >      vmbus_device_register
> > >        |-> device_register
> > >        |     |...
> > >        |     |-> hv_uio_probe
> > >        |           |...
> > >        |           |-> sysfs_create_bin_file (leads to a warning as
> > >        |                 primary channel's kobject, which is used to
> > >        |                 create sysfs is not yet initialized)
> > >        |-> kset_create_and_add
> > >        |-> vmbus_add_channel_kobj (initialization of primary channel's
> > >                                    kobject happens later)
> > > 
> > > Above code flow is sequential and the warning is always reproducible in
> > > this path.
> > > 
> > > Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
> > > Cc: stable@kernel.org
> > > Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > ---
> > >   drivers/hv/hyperv_vmbus.h    |   6 ++
> > >   drivers/hv/vmbus_drv.c       | 110 ++++++++++++++++++++++++++++++++++-
> > >   drivers/uio/uio_hv_generic.c |  39 ++++++-------
> > >   include/linux/hyperv.h       |   6 ++
> > >   4 files changed, 138 insertions(+), 23 deletions(-)
> > 
> > Always run checkpatch on a patch before submitting it for review :(
> > 
> 
> Hi Greg,
> I verified again and I could not see checkpatch warnings with patch 1,2.
> There was a warning regarding length of characters for link to previous
> versions in the cover letter but I ignored it.
> 
> I tried on latest linux-next tip with this series fetched from lore using
> b4. I'm sorry, if I am missing something, but can you please try again.

I've pointed out the first thing that I noticed, thanks.


