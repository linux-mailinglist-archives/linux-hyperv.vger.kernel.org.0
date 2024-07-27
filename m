Return-Path: <linux-hyperv+bounces-2605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B4D93DF70
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jul 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A2D1F216AB
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jul 2024 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2851016;
	Sat, 27 Jul 2024 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="haWmD0Cn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0F4204B;
	Sat, 27 Jul 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722084813; cv=none; b=gvadUY6pJBDltgMh0I3oN+pI+cVnjrJOflfFoSeACiBuz67zEA48bLBWb1Xxt99XbYvBibV49kPT3lIZ9+9PWjYk7wAVRbtFwWn/+eqM1xu+0kHUi4DoryPpvleKGleVYxE7ZTEVgqaYWlzc15TJWFou54eveXvuDmASl1O9VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722084813; c=relaxed/simple;
	bh=43nsIiMLcI0BhYal9OGjHJm5ys+DnQ1ANMeM2pJt9Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7SjgTBSGMX+hcX8l2I5vfPuIwbQCWcoIaq/JosfqYgr8u5IE0SsNpkzEidH5qbnfA5Pw2MnHfJzRaYTphKSB5EJy1PNmBlrkmUIGY2epk1GXkhxKqDcUH+fjtbQkvFaYHTUPL1xcP9GH8S6onDCmrVYC1ICR9ZfO5EefWJYq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=haWmD0Cn; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JC33cJseZjIq4zuXKHq4PMMlt37bhXvQFX2NLrHqo4U=; t=1722084811; x=1722948811; 
	b=haWmD0CnJQUK6FnTYPCpXEGzQrCJpvbo/+WEwtdTa6+Cfo65a7X4vEuscq5mu6cm3S85QKCO0la
	I/x8bH6+pjPa7CbpqT7yKGzcUkDGo6Qu9wWLO+EgYrCIhQD9tvSOUcmzICu7kcWMZPScs/nOovSmO
	8k2P0jHcnoDT1B4q6mSZFXoUhnXbAZpFL3iW0JYw6K8K6OVb84Ac9gcbQd31cfaXEiwsyWqRbSZpO
	yuiAJziiaOuL8m8luhaGqnH5K4jGAkaXiu9Pc39x5ikpN2ZLx7r1yJaaEGXZsy08MOQ3HZkW1Yb1t
	JX1CQsy/NqSmG71O/TygRetAFFGwCENa+E0A==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sXgvJ-00Ae4C-A1;
	Sat, 27 Jul 2024 08:53:21 -0400
Date: Sat, 27 Jul 2024 12:53:15 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <ZqTtu1Qdz9e9/Fnm@csail.mit.edu>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>
 <ZqNDjUALdN2Qtop6@csail.mit.edu>
 <20240726112619.GA10862@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726112619.GA10862@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Jul 26, 2024 at 04:26:19AM -0700, Saurabh Singh Sengar wrote:
> On Fri, Jul 26, 2024 at 06:34:53AM +0000, Srivatsa S. Bhat wrote:
> > On Fri, Jul 26, 2024 at 12:01:33AM +0000, Dexuan Cui wrote:
> > > > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > > > Sent: Thursday, July 25, 2024 8:35 AM
> > > > Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
> > > 
> > > Without the patch, I think the current CPU uses IPIs to let the other
> > > CPUs, one by one,  run the function calls, and synchronously waits
> > > for the function calls to finish.
> > > 
> > > IMO the patch is not "Deferring per cpu tasks". "Defer" means "let it
> > > happen later". Here it schedules work items to different CPUs, and
> > > the work items immediately start to run on these CPUs.
> > > 
> > > I would suggest a more accurate subject:
> > > Drivers: hv: vmbus: Run hv_synic_init() concurrently
> > > 
> > 
> > It would be great to call out the "why" as well in the title,
> > something like:
> > 
> > Drivers: hv: vmbus: Speed-up booting by running hv_synic_init() concurrently
> 
> Thanks, I can also rephrase it like below if sounds fine to you:
> 
> Drivers: hv: vmbus: Optimize boot time by concurrent execution of hv_synic_init()
> 

Sure, that sounds good too.

Regards,
Srivatsa
Microsoft Linux Systems Group

