Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA1C2A3D
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfI3XG4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Sep 2019 19:06:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3XG4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Sep 2019 19:06:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so8213405pgp.9;
        Mon, 30 Sep 2019 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OLxymM47T0Z1xEhjhIp3XuVNW/xM7/kJdYnYvwoTXKg=;
        b=BFkxIMgMo8eIDnqEV/lGUUdNzbWlckVIZvjpa2wckogM1CB++2BZTv5rhENJbw9KXB
         xrwAPH/Ci638zbgs2tOo4XFoRWOIJATfSDEqHNTWnl13Km5BxERRMrrKC7D2G0V5+9bR
         sVRkHWvm8lw0EFn7koXox1/fSg/03r9RDUDmt7JnaINE8kzc6gOh5eFzmrMT5DJnp7Au
         BcuB0mKpXAfKjkCGDDACyFSNEOZ40GkKTsVqzKt7oVSKXKyQTuHrFRX1rB9OxB1Tct9I
         7dKRY2A5csxaGZhIV3nQ9+UfOiWYCjlRCKfTMcdXuPshFspxdMM5EVYE3QNIW3ytwp0K
         Yqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OLxymM47T0Z1xEhjhIp3XuVNW/xM7/kJdYnYvwoTXKg=;
        b=jaQ7LongkihvjjPb8MZ1nVTMuWKChMw7CFBD38fEWx8hw0w+i/5f/hnssbP3LKU1qw
         U2GAnf0KL5xTYHyxgaGifBBVOtGzq7VBGPCSuMpnKQfsb/p8mewgx8sMw5vTJ7QLfrVB
         tfAe3Rc/ccPZ/QN2RNj6c1O+oKx1TZntw4DKkr7K1sLpbxrqsyj3LxQKRcYUr8W5YXJ/
         LYqFwNEBxnVFnsjIlI+/GBs7F9gDCbZi8G1THVzOBYvKjPI3jQSnCSt+XhGO2P/ul5HV
         TVLONeEy7QCvo4waVP7Jp7Ou7BD7JpJsfzpK0XGYCrgzUO7BoohIyl8cftKnNJprbTS5
         gKBg==
X-Gm-Message-State: APjAAAUbtfiFEuLqfuY+kV1RcJmJqJJ+KbM5mXGw2td5ZXGGkiMcfK2a
        pjBJ8vjPrqr3jznW8SZBG3E=
X-Google-Smtp-Source: APXvYqzzLO5KuAdNsnaabmSaBPVzVBrpuRISI4r/AYhZW+pFUJ8mN6Kb4MdLgXpTGPJxPVdCVXiBeA==
X-Received: by 2002:a62:7d81:: with SMTP id y123mr24346543pfc.133.1569884815033;
        Mon, 30 Sep 2019 16:06:55 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f15sm12652398pfd.141.2019.09.30.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:06:54 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:06:52 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Message-ID: <20190930230652.GW237523@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 30, 2019 at 10:09:27PM +0000, Dexuan Cui wrote:
> > From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> > Sent: Friday, September 27, 2019 5:32 PM
> > > ...
> > > pm_wakeup_pending() is tested in a lot of places in the suspend
> > > process and eventually an unintentional keystroke (or mouse movement,
> > > when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> > > causes the whole hibernation process to be aborted. Usually this
> > > behavior is not expected by the user, I think.
> > 
> > Why not? If a device is configured as wakeup source, then it activity
> > should wake up the system, unless you disable it.
> 
> Generally speaking, I agree, but compared to a physical machine, IMO 
> the scenario is a little differnet when it comes to a VM running on Hyper-V:
> on the host there is a window that represents the VM, and the user can
> unintentionally switch the keyboard input focus to the window (or move
> the mouse/cursor over the window) and then the host automatically 
> sends some special keystrokes (and mouse events) , and this aborts the
> hibernation process.  
> 
> And, when it comes to the Hyper-V mouse device, IMO it's easy for the
> user to unintentionally move the mouse after the "hibernation" button
> is clicked. I suppose a physical machine would have the same issue, though.

If waking the machine up by mouse/keyboard activity is not desired in
Hyper-V environment, then simply disable them as wakeup sources.

> 
> > > So, I use the notifier to set the flag variable and with it the driver can
> > > know when it should not call pm_wakeup_hard_event().
> > 
> > No, please implement hibernation support properly, as notifier + flag is
> > a hack. 
> 
> The keyboard/mouse driver can avoid the flag by disabling the 
> keyboard/mouse event handling, but the problem is that they don't know
> when exactly they should disable the event handling. I think the PM
> notifier is the only way to tell the drivers a hibernation process is ongoing.

Whatever initiates hibernation (in userspace) can adjust wakeup sources
as needed if you want them disabled completely.

> 
> Do you think this idea (notifer + disabling event handling) is acceptable?

No, I believe this a hack, that is why I am pushing back on this.

> 
> If not, then I'll have to remove the notifer completely, and document this as
> a known issue to the user: when a hibernation process is started, be careful
> to not switch input focus and not touch the keyboard/mouse until the
> hibernation process is finished. :-)
> 
> > In this particular case you do not want to have your
> > hv_kbd_resume() to be called in place of pm_ops->thaw() as that is what
> > reenables the keyboard vmbus channel and causes the undesired wakeup
> > events. 
> 
> This is only part of the issues. Another example: before the
> pm_ops()->freeze()'s of all the devices are called, pm_wakeup_pending()
> is already tested in a lot of places (e.g. in try_to_freeze_tasks ()) in the 
> suspend process, and can abort the whole suspend process upon the user's
> unintentional input focus switch, keystroke and mouse movement.

How long is the prepare() phase on your systems? User may wiggle mouse
at any time really, even before the notifier fires up.

> 
> > Your vmbus implementation should allow individual drivers to
> > control the set of PM operations that they wish to use, instead of
> > forcing everything through suspend/resume.
> > 
> > Dmitry
> 
> Since the devices are pure software-emulated devices, no PM operation was
> supported in the past, and now suspend/resume are the only two PM operations
> we're going to support. If the idea (notifer + disabling event handling) is not
> good enough, we'll have to document the issue to the user, as I described above.

¯\_(ツ)_/¯ If you do not want to implement hibernation properly in vmbus
code that is totally up to you (have you read in pm.h how freeze() is
different from suspend()?).

Thanks.

-- 
Dmitry
