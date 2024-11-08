Return-Path: <linux-hyperv+bounces-3299-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F99C1B03
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Nov 2024 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A86328260E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Nov 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E51E009A;
	Fri,  8 Nov 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WKaBprb3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA647F69;
	Fri,  8 Nov 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062864; cv=none; b=AYpPKs12vwP5DfyiREemzWgNrhieKgPm//JfCNrzIXUGbFQz54p1T+qVPASPODBRPnzGu+bXhoOMpf/KHgXkrcYMljqaz5x8rZEcUA7vniWJuyuaAeQhuk7v9MrwXeDV9g9M7qP+1jRldFwLbwiOwb3btRXZVDhAOL5sE5+rkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062864; c=relaxed/simple;
	bh=vh1KEgwm8HS0FCaXG6dtHY0XbtYs85ctulsV8TBcLJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PECecm4yFpKGZiDYieFXrZYCxyKcHnh9o5LNkcDWpH9GMIIJnQG7RourmXhKlNbmX1i63UXThRY8H5AZQLu9VXzh2lZ9D3fzMN7e43tjEKplkmjD5aN084JR9V3JCszvd49BoDqP/UjQwfJfa1wVy7fxCu9fCSjip3FkBmCbcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WKaBprb3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 800FF2130822; Fri,  8 Nov 2024 02:47:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 800FF2130822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731062861;
	bh=rfmN39pQc5CWywNmtu+c00IPmRXCRUoGSDJrpxGFf88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKaBprb30Giu3MFacVCVRoL3qBrewwIVdoRvPR6GXH/Dagz8ngoYYRvAkfZeU7gh+
	 sNf/bt/pLrX/E//vTqICMDdeVPIE/eOiCtOKrHqPT/kHtswQ/6w/nK9appmCCW88D0
	 IaZiXBfsYb8l7fRrjwI7NS2VM9/sVAi1ie/hMTPo=
Date: Fri, 8 Nov 2024 02:47:41 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jikos@kernel.org, bentiss@kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] Revert "Input: hyperv-keyboard - register as a
 wakeup source"
Message-ID: <20241108104741.GA14651@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>
 <ZvIx85NmYB/HzKtI@csail.mit.edu>
 <Zv-j0qtWXsDz4Hah@google.com>
 <20241017134438.GA14386@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017134438.GA14386@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 17, 2024 at 06:44:38AM -0700, Erni Sri Satya Vennela wrote:
> On Fri, Oct 04, 2024 at 01:14:10AM -0700, Dmitry Torokhov wrote:
> > On Tue, Sep 24, 2024 at 03:28:51AM +0000, Srivatsa S. Bhat wrote:
> > > [+linux-pm, Rafael, Len, Pavel]
> > > 
> > > On Thu, Sep 12, 2024 at 02:27:49PM -0700, Erni Sri Satya Vennela wrote:
> > > > This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.
> > > > 
> > > > Remove keyboard as wakeup source since Suspend-to-Idle feature
> > > > is disabled.
> > > > 
> > > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > ---
> > > >  drivers/input/serio/hyperv-keyboard.c | 12 ------------
> > > >  1 file changed, 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> > > > index 31d9dacd2fd1..b42c546636bf 100644
> > > > --- a/drivers/input/serio/hyperv-keyboard.c
> > > > +++ b/drivers/input/serio/hyperv-keyboard.c
> > > > @@ -162,15 +162,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
> > > >  			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
> > > >  		}
> > > >  		spin_unlock_irqrestore(&kbd_dev->lock, flags);
> > > > -
> > > > -		/*
> > > > -		 * Only trigger a wakeup on key down, otherwise
> > > > -		 * "echo freeze > /sys/power/state" can't really enter the
> > > > -		 * state because the Enter-UP can trigger a wakeup at once.
> > > > -		 */
> > > > -		if (!(info & IS_BREAK))
> > > > -			pm_wakeup_hard_event(&hv_dev->device);
> > > > -
> > > >  		break;
> > > >  
> > > >  	default:
> > > > @@ -356,9 +347,6 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> > > >  		goto err_close_vmbus;
> > > >  
> > > >  	serio_register_port(kbd_dev->hv_serio);
> > > > -
> > > > -	device_init_wakeup(&hv_dev->device, true);
> > 
> > If you do not want the keyboard to be a wakeup source by default maybe
> > change this to:
> > 
> > 	device_set_wakeup_capable(&hv_dev->device, true);
> > 
> > and leave the rest of the driver alone?
> > 
> > Same for the HID change.
> > 
> > Thanks.
> >
> device_set_wakeup_capable() sets the @dev's power.can_wakeup flag and
> adds wakeup-related attributes in sysfs.
> 
> Could you please help me understand why explicitly calling this function 
> can be helpful in our use case?
> 
> > -- 
> > Dmitry
Just following up on this patch. Could you please help me understand the
reason for the change?

