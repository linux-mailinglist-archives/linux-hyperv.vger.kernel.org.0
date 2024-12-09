Return-Path: <linux-hyperv+bounces-3437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796099E9CC8
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E48282B79
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0F155303;
	Mon,  9 Dec 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BmteNgfG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60C14B077;
	Mon,  9 Dec 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764585; cv=none; b=imBAxXGZftt509KynojesO0PWM3hVI9/09IHoSGsF15XshUbjAB/7+hpgb7OgKfA5m8kBTdRfBSXwf4JViW6Y8117ZrinrGTB7WQJwLYKdXtXy1qoyuz+xP3ns5R6oMRDmvY4t5gY95MbB6FwtmQPq0fI4MyD2nDCtW7zHuTJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764585; c=relaxed/simple;
	bh=2YpxKy6Gwqsp4Tqzs7nDAYWThdPYRCmcyf4sN0mRBrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6lwrukhhz5KdqVyaKf81uwzsDQafA1Eot4NYYvrX1usgm//S4268wp/C4JwVvRRVgFPt2db4TpPrLeEazsXwHpj9in+0erpw0mGDNLzz5Y6x4DHZov7uYk7rP7DIQREHOJJ2/qqxSs+a/kXR/YyIF/tItupwvUkTHyhK9NTRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BmteNgfG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 3D4B120C8BA2; Mon,  9 Dec 2024 09:16:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D4B120C8BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733764583;
	bh=HP4urfWccJ7rG3wZQ3lsLo0/S56sl2aC1BXsm/bKIIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmteNgfG/vZtVb8aiWHmqBDwO1kurvQXU84Vv9SI6llKd1t7/wX8aqzP1hiBirWRB
	 hcKrqEHr7X/As9mPOKrTH3f6Nfd8SRGjQtBlflDdDAqTQMOgSQ3eVjIrURGv7jy8g+
	 fh2loWyImxtJBPkwo59XZfpNiiinK3URjSxQRZtU=
Date: Mon, 9 Dec 2024 09:16:23 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jikos@kernel.org, bentiss@kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] Revert "Input: hyperv-keyboard - register as a
 wakeup source"
Message-ID: <20241209171623.GA29631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>
 <ZvIx85NmYB/HzKtI@csail.mit.edu>
 <Zv-j0qtWXsDz4Hah@google.com>
 <20241017134438.GA14386@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20241108104741.GA14651@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108104741.GA14651@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Nov 08, 2024 at 02:47:41AM -0800, Erni Sri Satya Vennela wrote:
> On Thu, Oct 17, 2024 at 06:44:38AM -0700, Erni Sri Satya Vennela wrote:
> > On Fri, Oct 04, 2024 at 01:14:10AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Sep 24, 2024 at 03:28:51AM +0000, Srivatsa S. Bhat wrote:
> > > > [+linux-pm, Rafael, Len, Pavel]
> > > > 
> > > > On Thu, Sep 12, 2024 at 02:27:49PM -0700, Erni Sri Satya Vennela wrote:
> > > > > This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.
> > > > > 
> > > > > Remove keyboard as wakeup source since Suspend-to-Idle feature
> > > > > is disabled.
> > > > > 
> > > > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/input/serio/hyperv-keyboard.c | 12 ------------
> > > > >  1 file changed, 12 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> > > > > index 31d9dacd2fd1..b42c546636bf 100644
> > > > > --- a/drivers/input/serio/hyperv-keyboard.c
> > > > > +++ b/drivers/input/serio/hyperv-keyboard.c
> > > > > @@ -162,15 +162,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
> > > > >  			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
> > > > >  		}
> > > > >  		spin_unlock_irqrestore(&kbd_dev->lock, flags);
> > > > > -
> > > > > -		/*
> > > > > -		 * Only trigger a wakeup on key down, otherwise
> > > > > -		 * "echo freeze > /sys/power/state" can't really enter the
> > > > > -		 * state because the Enter-UP can trigger a wakeup at once.
> > > > > -		 */
> > > > > -		if (!(info & IS_BREAK))
> > > > > -			pm_wakeup_hard_event(&hv_dev->device);
> > > > > -
> > > > >  		break;
> > > > >  
> > > > >  	default:
> > > > > @@ -356,9 +347,6 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> > > > >  		goto err_close_vmbus;
> > > > >  
> > > > >  	serio_register_port(kbd_dev->hv_serio);
> > > > > -
> > > > > -	device_init_wakeup(&hv_dev->device, true);
> > > 
> > > If you do not want the keyboard to be a wakeup source by default maybe
> > > change this to:
> > > 
> > > 	device_set_wakeup_capable(&hv_dev->device, true);
> > > 
> > > and leave the rest of the driver alone?
> > > 
> > > Same for the HID change.
> > > 
> > > Thanks.
> > >
> > device_set_wakeup_capable() sets the @dev's power.can_wakeup flag and
> > adds wakeup-related attributes in sysfs.
> > 
> > Could you please help me understand why explicitly calling this function 
> > can be helpful in our use case?
> > 
> > > -- 
> > > Dmitry
> Just following up on this patch. Could you please help me understand the
> reason for the change?


Vennela,

There is a difference between "wakeup source registration" and "wakeup capable".
For this there are two flags defined in power management framework:
 1. power.wakeup
 2. power.can_wakeup
 
More details on these flags can be read here: 
https://www.kernel.org/doc/html/v6.12/driver-api/pm/devices.html

'device_init_wakeup(dev, true)' sets both; ie it registers the device as a wakeup
source and marks it as wakeup capable too.

In our case, the device is "wakeup capable" but we do not want to
"register it as a wakeup source". 'device_set_wakeup_capable(dev, true)' is more
appropriate because this marks the device as wakeup capable but doesn't register
it as a wakeup source knowingly.

I understand that Dimitry suggests not to revert the entire patch but to replace
'device_init_wakeup' with 'device_set_wakeup_capable', to mark the device as
capable of wakeup but knowingly skipping the registering part.

Requesting Dimitry to correct me if there is any misinterpretation.

While fixing this in next version, please fix the kernel bot warings as well
reported for 1/3 patch of this series.

- Saurabh

