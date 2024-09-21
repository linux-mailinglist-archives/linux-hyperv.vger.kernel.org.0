Return-Path: <linux-hyperv+bounces-3059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B097DE76
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767AEB20F38
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2024 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55862AF18;
	Sat, 21 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TuYQD6N+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A891F957;
	Sat, 21 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945770; cv=none; b=VyGUOoHhsgSC8iFIUPcPLpPBllrYshPT6bljYO4a49BHhcxqp4OxwxFwcPbKYd6rzW3BhWmGL/BzhRh+sJFaRnBRCiXaoT2DgyNc57kCI2EmPLoek1qN7IB74VCbf/HgexfRRDHksgBu/P7FT2GZ3aUWVEK5LVVk10ybENHGWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945770; c=relaxed/simple;
	bh=bM8CjX6wFQ8Be1toPLT9uT8VxmdOVIL5XsPCd/g3zyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJl/6KPhRBUSMCK3zE3zlP0YdKSjy0PWsY1WDR4PrV/ARqpPLRmFLvCggXqeumQN2tDzX5m30nlVhutISm6INmDD3jZlDy4ZUamvVVArwTjZUQguWhk50gifM+WFEojt9WcJ6KEqA46RJ7QzFkWBdVE7aTz+Q+1zc8Zx4SVgH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TuYQD6N+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 83A7820C0B23; Sat, 21 Sep 2024 12:09:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83A7820C0B23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726945763;
	bh=mGsaS4WWgoL9j1sfR45e27OZbsXf/DeYuDn6GLEWb9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuYQD6N+gKDZeOc2592AShr0s/4NKquhgvkQgavZqsCxi9gDKFIyImQRncTYFrq/9
	 uFhj6ypWkAJHISLQDOUKfGA4N3PUeO3Df6a4LrFov1YpRMiyWeoFO15nD9q3ZYevXi
	 8rNrIHisjNL6oPIvqvTtUjBWAhHfBQgeKyPl0eqM=
Date: Sat, 21 Sep 2024 12:09:23 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
Message-ID: <20240921190923.GA15748@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-2-git-send-email-ernis@linux.microsoft.com>
 <b480a355-dbfa-4422-ad3c-65ec931a3ba0@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b480a355-dbfa-4422-ad3c-65ec931a3ba0@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Sep 13, 2024 at 12:49:27PM +0530, Naman Jain wrote:
> 
> 
> On 9/13/2024 2:57 AM, Erni Sri Satya Vennela wrote:
> >If the Virtual Machine Connection window is focused,
> >a Hyper-V VM user can unintentionally touch the keyboard/mouse
> >when the VM is hibernating or resuming, and consequently the
> >hibernation or resume operation can be aborted unexpectedly.
> >Fix the issue by no longer registering the keyboard/mouse as
> >wakeup devices (see the other two patches for the
> >changes to drivers/input/serio/hyperv-keyboard.c and
> >drivers/hid/hid-hyperv.c).
> >
> >The keyboard/mouse were registered as wakeup devices because the
> >VM needs to be woken up from the Suspend-to-Idle state after
> >a user runs "echo freeze > /sys/power/state". It seems like
> >the Suspend-to-Idle feature has no real users in practice, so
> >let's no longer support that by returning -EOPNOTSUPP if a
> >user tries to use that.
> >
> 
> Maybe it would be good to capture here the kind of VMs that this is
> going to be not supported - HyperV based VMs. You mentioned it in cover
> letter, but it would be good to add it here as well, as cover letter
> does not go to git log.
> 
Sure, I'll specify this in the next version of the patch.
> Also, the subject suggests that we are disabling suspend-to-idle for
> vmbus specifically, but from commit description, it suggests that
> "suspend to idle" feature itself is no longer supported on these
> particular VMs. Please rephrase it based on what exactly we are trying
> to do here. IIUC, we are now returning an error (EOPNOTSUPP) in vmbus
> driver callback, which insures that we don't support Suspend-to-Idle in
> these VMs.
> 
Yes, that's correct.
> >Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> >---
> >  drivers/hv/vmbus_drv.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> >index 965d2a4efb7e..4efd8856392f 100644
> >--- a/drivers/hv/vmbus_drv.c
> >+++ b/drivers/hv/vmbus_drv.c
> >@@ -900,6 +900,19 @@ static void vmbus_shutdown(struct device *child_device)
> >  }
> >  #ifdef CONFIG_PM_SLEEP
> >+/*
> >+ * vmbus_freeze - Suspend-to-Idle
> >+ */
> >+static int vmbus_freeze(struct device *child_device)
> >+{
> >+/*
> >+ * Do not support Suspend-to-Idle ("echo freeze > /sys/power/state") as
> >+ * that would require registering the Hyper-V synthetic mouse/keyboard
> >+ * devices as wakeup devices, which can abort hibernation/resume unexpectedly.
> >+ */
> >+	return -EOPNOTSUPP;
> >+}
> >+
> >  /*
> >   * vmbus_suspend - Suspend a vmbus device
> >   */
> >@@ -969,7 +982,7 @@ static void vmbus_device_release(struct device *device)
> >   */
> >  static const struct dev_pm_ops vmbus_pm = {
> >-	.suspend_noirq	= NULL,
> >+	.suspend_noirq  = vmbus_freeze,
> >  	.resume_noirq	= NULL,
> >  	.freeze_noirq	= vmbus_suspend,
> 
> I am not sure if this is OK or how it works, but this naming scheme
> seems a bit confusing to me -
> *suspend* -> vmbus_*freeze*
> *freeze* -> vmbus_*suspend*
> and we are removing support for "freeze" by returning EOPNOTSUPP in
> suspend callback.
AFAIU, suspend_noirq is used for Suspend-to-Idle operation and we use
"freeze > /sys/power/state" for the same. Maybe the naming convention
comes that way. 
The key point to understand here is suspend_noirq prepares the machine 
to low power state and freeze_noirq prepares the machine for hibernation 
(saving state to disk).
> 
> I'll try to understand more on this, but just see if its OK.
> 
> >  	.thaw_noirq	= vmbus_resume,
> 
> Regards,
> Naman
Yes, thaw_noirq is to restore devices from hibernation state. 

