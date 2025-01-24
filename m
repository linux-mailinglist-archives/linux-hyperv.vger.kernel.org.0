Return-Path: <linux-hyperv+bounces-3768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F38A1BB03
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jan 2025 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984F9162D27
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jan 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462E019B5AC;
	Fri, 24 Jan 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CdBJ2vjd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B9FBF6;
	Fri, 24 Jan 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737694; cv=none; b=BQJekBS6jHzTsZ8HDG5Q2rWInVrCpIHIzpZu5Ku1/HiklC8SDObiMTiMenPRnf15E/f865K7qhxD5Ujn4MV4XkukPqn9GMMYPadS04Ub9yW5LgFJVr1u1EYV1dcX4KmNqfuhuLXROvlUrBLEuZNolEcy06ZOJYJTqyjTA+iePFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737694; c=relaxed/simple;
	bh=TBbVYW6WszWSAbOJhmb3FyG6vlQ3bBhEEO3HgMw7QSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHQJgUe1dz1xXrddm9C2eVP2BFOkW2tsWyyxO8Y1INBNoqUaQhMujnQGBkpt+3QHioA/QpqDuRUQffhVtjZlqRzTtto6vOGSAMF3GPdWxJXIXSmywuRYoLNIohfExRdqTw24BvUmjpy6SW0N0rihXDaMhcgOCFZhrcGVXk1GPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CdBJ2vjd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3774E20BEBD5; Fri, 24 Jan 2025 08:54:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3774E20BEBD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737737692;
	bh=p/Ev/ixvfjDnN+f1HX/ZEmD3SPo56vV9nqjW8JhSjMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdBJ2vjdLBjVw/4VOt8h+eDnrkM2USNZk04ZWObCQcCyI7hTY1VFhqGy3y3KyNQfs
	 rz4F1FYZGIpXtEyMh/OOhfK9jKxexK7QBPlUfU2ew9NLBG59TVq3+Y298M+traRcnU
	 afU5RhcAId6lD1VmrHS0VK0S8GJk2yTjM0OwI8+o=
Date: Fri, 24 Jan 2025 08:54:52 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for
 VMBus
Message-ID: <20250124165452.GA861@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
 <1734409029-10419-2-git-send-email-ernis@linux.microsoft.com>
 <SN6PR02MB4157123D8C5C35C2B169A1E0D4052@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157123D8C5C35C2B169A1E0D4052@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Dec 18, 2024 at 06:27:18AM +0000, Michael Kelley wrote:
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Monday, December 16, 2024 8:17 PM
> > 
> > This change is specific to Hyper-V VM user.
> > If the Virtual Machine Connection window is focused,
> > a Hyper-V VM user can unintentionally touch the keyboard/mouse
> > when the VM is hibernating or resuming, and consequently the
> > hibernation or resume operation can be aborted unexpectedly.
> > Fix the issue by no longer registering the keyboard/mouse as
> > wakeup devices (see the other two patches for the
> > changes to drivers/input/serio/hyperv-keyboard.c and
> > drivers/hid/hid-hyperv.c).
> 
> One question: For the keyboard and mouse patches, it looks like the
> code change has the effect of changing the default value of
> "power/wakeup" for the keyboard and mouse device under /sys to
> be "disabled". But if a customer *wants* to enable keyboard and
> mouse wakeups, he still has the option of just writing "enabled"
> to "power/wakeup", and the wakeup behavior will be back like it
> was before these patches. So in other words, the patches only
> change the default enablement setting, and don't mess with the
> ability to generate wakeups. Or does disabling the "freeze" option
> for /sys/power/state mean that there's no scenario where wakeups
> are useful, so the enabling vs. disabling of wakeups is moot?
There is no scenario where wakeups are useful for keyboard and mouse. 
We wanted to remove them completely initially to support for 
hibernation. But based on Dimitry's suggestion we choose to opt for
default behaviour.
> 
> As you may have noticed, I've posted a patch with documentation
> about how hibernation works for Hyper-V VMs [1], and I probably
> should add a paragraph about wakeups. So I want to make sure
> I'm understanding correctly.
> 
> [1] https://lore.kernel.org/linux-hyperv/20241212231700.6977-1-mhklinux@outlook.com/
> 
> > 
> > The keyboard/mouse were registered as wakeup devices because the
> > VM needs to be woken up from the Suspend-to-Idle state after
> > a user runs "echo freeze > /sys/power/state". It seems like
> > the Suspend-to-Idle feature has no real users in practice, so
> > let's no longer support that by returning -EOPNOTSUPP if a
> > user tries to use that.
> > 
> > Fixes: 1a06d017fb3f ("Drivers: hv: vmbus: Fix Suspend-to-Idle for Generation-2 VM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>>
> > ---
> > Changes in v4:
> > * No change
> > 
> > Changes in v3:
> > * Add "Cc: stable@vger.kernel.org" in sign-off area.
> > 
> > Changes in v2:
> > * Add "#define vmbus_freeze NULL" when CONFIG_PM_SLEEP is not
> >   enabled.
> > ---
> >  drivers/hv/vmbus_drv.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 6d89d37b069a..4df6b12bf6a1 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
> >  }
> > 
> >  #ifdef CONFIG_PM_SLEEP
> > +/*
> > + * vmbus_freeze - Suspend-to-Idle
> > + */
> > +static int vmbus_freeze(struct device *child_device)
> > +{
> > +/*
> > + * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
> > + * that would require registering the Hyper-V synthetic mouse/keyboard
> > + * devices as wakeup devices, which can abort hibernation/resume unexpectedly.
> > + */
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  /*
> >   * vmbus_suspend - Suspend a vmbus device
> >   */
> > @@ -938,6 +951,7 @@ static int vmbus_resume(struct device *child_device)
> >  	return drv->resume(dev);
> >  }
> >  #else
> > +#define vmbus_freeze NULL
> >  #define vmbus_suspend NULL
> >  #define vmbus_resume NULL
> >  #endif /* CONFIG_PM_SLEEP */
> > @@ -969,7 +983,7 @@ static void vmbus_device_release(struct device *device)
> >   */
> > 
> >  static const struct dev_pm_ops vmbus_pm = {
> > -	.suspend_noirq	= NULL,
> > +	.suspend_noirq  = vmbus_freeze,
> >  	.resume_noirq	= NULL,
> >  	.freeze_noirq	= vmbus_suspend,
> >  	.thaw_noirq	= vmbus_resume,
> 
> Immediately preceding this definition and initialization of
> the vmbus_pm structure, there's a comment that talks
> about supporting Suspend-To-Idle. Since the intent here is
> to *not* support Suspend-To-Idle, that comment really
> needs to be updated so it accurately reflects this change.
> 
> I can't help but also notice the bizarre situation with the
> function names. The "freeze_noirq" function is named
> "vmbus_suspend", and the "suspend_noirq" function is
> named "vmbus_freeze". It certainly looks exactly backwards!
> 
> The "suspend_noirq" function should probably be named
> "vmbus_suspend", but that name is already taken for use
> in the hibernation path. I don't have a great suggestion on
> how to fix this, other than to rename vmbus_suspend() to
> vmbus_freeze(). That change wouldn't be that hard to do,
> though then vmbus_freeze() ends up calling the "suspend"
> function in struct hv_driver. Fixing the name in struct
> hv_driver is harder because most VMBus drivers would need
> to be updated. Sigh.
> 
> But it might be worth fixing the top-level function names
> of both vmbus_suspend() and vmbus_resume() so they
> don't look misused as the freeze/thaw and poweroff/restore
> functions. And then the suspend_noirq function could be
> named vmbus_suspend() so it makes sense.
> 
Thanks for the suggestion Micheal. I will work on it as a separate
patch.
> Michael

