Return-Path: <linux-hyperv+bounces-2587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18F93CD95
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 07:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4B71F21FF8
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238836B11;
	Fri, 26 Jul 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YDumTRsP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F220DF4;
	Fri, 26 Jul 2024 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971618; cv=none; b=WGQBA9Zwm+/cVHYCgxAk7sOOFCecN/f4eiSQKA8yOtuE2p/25CA+k4DZeSVyVFdMa9lguSJU0N32dTTmkFYfAEuZmW/8J2+MFrgMKrg7oPZQW+kADsz3vrUPxZJoD2AiUEzlTxTIwePB21fpN9R4CHHGXCmhDDmkwoFTq14JPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971618; c=relaxed/simple;
	bh=jooWUNRdQZfL5ePDn0m2vxWadTW4bc28IaYLTpEyrzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGZ7SBoWI/4O3wFYcG9oSZjyHbha+QWJK0CxazQEdOewaNs7bsPKoZy3V49lxhaJhg2LG2AYFinMXNg9JUneEt8z15cpW/nMP43WKFbwYP59FbPqeZGu2mRpgbaQq81Y9G021tRuEg/VefiJOT70acAYZpMWwbn9orBWPxle0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YDumTRsP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 9C30520B7165; Thu, 25 Jul 2024 22:26:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C30520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721971611;
	bh=IF4A3LRGJBunXi2guWTT84NHji0wn3SGxa5s9vfXsRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDumTRsPBoHr2rE4Ty5y/XrDUS5b7/wO1WbHgF5YxtV/zJO3hmFCQdU/9kW26ywDi
	 rr4nlM6MQlopHiJlfjVg0iVrFxFnaY+men1rsJizXZAkztAmVU9FZlb3XMhiis4kok
	 q+r2J3vrRRnAuakZcwH+r1f/0zmHoD4CnxRa4i0A=
Date: Thu, 25 Jul 2024 22:26:51 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <20240726052651.GA28809@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
User-Agent: Mutt/1.5.21 (2010-09-15)

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

Agree, this explains the change better.

> 
> > -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > "hyperv/vmbus:online",
> > -			hv_synic_init, hv_synic_cleanup);
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		struct work_struct *work = per_cpu_ptr(works, cpu);
> > +
> > +		INIT_WORK(work, vmbus_percpu_work);
> > +		schedule_work_on(cpu, work);
> > +	}
> > +
> > +	for_each_online_cpu(cpu)
> > +		flush_work(per_cpu_ptr(works, cpu));
> > +
> 
> Can you please add a comment to explain we need this for CPU online/offline'ing:

ok

> > +	ret = __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
> > "hyperv/vmbus:online", false,
> > +					     hv_synic_init, hv_synic_cleanup,
> > false);
> > +	cpus_read_unlock();
> 
> Add an empty line here to make it slightly more readable? :-)

My personal preference was to have empty line as well here, but then I looked the
other places in this file where we used cpus_read_unlock, hence I maintained that
style consistent.

Please let me know if you have strong opinion about this empty line, I can add in V2.

- Saurabh

> > +	free_percpu(works);
> >  	if (ret < 0)
> >  		goto err_alloc;
> 
> Thanks,
> Dexuan
> 
> 

