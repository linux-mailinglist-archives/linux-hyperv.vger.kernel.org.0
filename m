Return-Path: <linux-hyperv+bounces-2590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F093D236
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD30B2192E
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6E17A581;
	Fri, 26 Jul 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mOXMiDyA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13F41B27D;
	Fri, 26 Jul 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993181; cv=none; b=aWF6tHVBgD9S4yglHeuOUnB7L+qFicNx6ri4OiROIxBilbmUwYMsfDupo6LhhZaHr7WwEj13AVlBDQYKnomQd8In6c8dp6Esq810kvz69MBkNa4zF7fppqn7kL78mQ61ghAAUPSsmbwhqL18C7/HLADAaKuRL6bJGst7XomsoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993181; c=relaxed/simple;
	bh=jcbmb1zuwCEe3KPSZShcV0RbRTlHWSPHx2V8ALGSBlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBivrEHRekQpUX4O8dHZGn6hZmRYkzW2ZVgnmccPKyWiwm4fMyZlnWqtVRigslEz7HsZKNn0OU6sphiMUwPa4xIsD3BcvNs8XVq8LQNzlv7cSod3MS//4EqU9TS/2W7EcxxZcDGOFU5TnkHOyr+dXF3H36StdwL4QRhdnsMZ7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mOXMiDyA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 50D7820B7165; Fri, 26 Jul 2024 04:26:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50D7820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721993179;
	bh=XVcsNaD9LvCpPZU7FIwlYMQGV4pGY+ychCzaADn+ugU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOXMiDyA4QS5aXWYgOMJPwXBSo3awt4sz4FnAkMHaI7564bkizNX+HlC2/XW8pZYs
	 HYWBmuSfV+rtX7qY111NAvtRRV7CcnhwJ64n6uoxRykUTJOSx7EyekQ3/OtGFNUh7f
	 LYhd95xnawSC2gsaFGiiCjjkb7MyqCAfskoHgFC4=
Date: Fri, 26 Jul 2024 04:26:19 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <20240726112619.GA10862@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>
 <ZqNDjUALdN2Qtop6@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqNDjUALdN2Qtop6@csail.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 26, 2024 at 06:34:53AM +0000, Srivatsa S. Bhat wrote:
> On Fri, Jul 26, 2024 at 12:01:33AM +0000, Dexuan Cui wrote:
> > > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > > Sent: Thursday, July 25, 2024 8:35 AM
> > > Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
> > 
> > Without the patch, I think the current CPU uses IPIs to let the other
> > CPUs, one by one,  run the function calls, and synchronously waits
> > for the function calls to finish.
> > 
> > IMO the patch is not "Deferring per cpu tasks". "Defer" means "let it
> > happen later". Here it schedules work items to different CPUs, and
> > the work items immediately start to run on these CPUs.
> > 
> > I would suggest a more accurate subject:
> > Drivers: hv: vmbus: Run hv_synic_init() concurrently
> > 
> 
> It would be great to call out the "why" as well in the title,
> something like:
> 
> Drivers: hv: vmbus: Speed-up booting by running hv_synic_init() concurrently

Thanks, I can also rephrase it like below if sounds fine to you:

Drivers: hv: vmbus: Optimize boot time by concurrent execution of hv_synic_init()

- Saurabh

> 
> Regards,
> Srivatsa
> Microsoft Linux Systems Group

