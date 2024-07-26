Return-Path: <linux-hyperv+bounces-2589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387A93CE33
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 08:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD281F20F4F
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853D17335B;
	Fri, 26 Jul 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="LmyYzhqd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0688364DC;
	Fri, 26 Jul 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975705; cv=none; b=Cmb9rR12GLA6VA7ZJNwEVo18NgU1dUzHS18ptQ0dCzv7kQutf1TgE/QsODOzP3TkkeYh5ovA8Y74q4dj6jnxcx1IhYla1gUjF8xYzHmoNkhFwc0XfDZrlLyNUIXYnxkamUGrPa1EELpAfioREJhzSBdk5UIMlgeuyYCCfuCl08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975705; c=relaxed/simple;
	bh=PZfSsz3ulJHFXIi/lJFlfTJ3zWld9zetH28g4ZxlSck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCXf6jkbJoGYut4wpH/GAplPb1oA146nxBHZFxBzOTuUstyjK/0mqFoKYTAQ4jHvbylYPzC2CsnQEFbA+uswUWtyRnPDRpn84bj8dlV+mYjF+N9xHMJjsDgJbcaJDSZcrsECSa3DXOuc8UdpousoDLfOYxZvJ9EjSzH9B+HMiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=LmyYzhqd; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/9kziFIezmJwmyR7yuupUk0XJgkW6rjlPdbESAqvOlE=; t=1721975703; x=1722839703; 
	b=LmyYzhqdZIVirmIVediROdSKUU8w2ffuegr0re9hIn/uBLIwOTSjNgPIyD8GZDv6d0bPRFr2qfL
	aeFqsH36I7hmqxlHVo/Zivuc5Vnt0sdye5GyOHHclCBkROOe0e6C1Ir4R59k3vEz5UYierRoFONas
	RCT3zQrW4QvrsZ1vbQ5ZEXjBTfuuI5qG+EfqN0b5Y7Vn/1hWL+GVDKgWGdZrRGtC+IiiTv0iV6xts
	Y9HYPd6BPdg/Nak7JrSlI6XsHKnaxyBWu9UO1NBvZTF9tFpQ25ebPhfyfgHsfnq7olXVHyN1+xrW0
	CiGFj0UfGqKUKxNrHmxjvO4EC+DSMKLXQD5g==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sXEXc-007RmA-56;
	Fri, 26 Jul 2024 02:35:00 -0400
Date: Fri, 26 Jul 2024 06:34:53 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Dexuan Cui <decui@microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <ZqNDjUALdN2Qtop6@csail.mit.edu>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>

On Fri, Jul 26, 2024 at 12:01:33AM +0000, Dexuan Cui wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > Sent: Thursday, July 25, 2024 8:35 AM
> > Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
> 
> Without the patch, I think the current CPU uses IPIs to let the other
> CPUs, one by one,  run the function calls, and synchronously waits
> for the function calls to finish.
> 
> IMO the patch is not "Deferring per cpu tasks". "Defer" means "let it
> happen later". Here it schedules work items to different CPUs, and
> the work items immediately start to run on these CPUs.
> 
> I would suggest a more accurate subject:
> Drivers: hv: vmbus: Run hv_synic_init() concurrently
> 

It would be great to call out the "why" as well in the title,
something like:

Drivers: hv: vmbus: Speed-up booting by running hv_synic_init() concurrently

Regards,
Srivatsa
Microsoft Linux Systems Group

