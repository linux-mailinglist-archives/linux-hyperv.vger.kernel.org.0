Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D0D0BE8
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Oct 2019 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfJIJyc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Oct 2019 05:54:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52339 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJIJyc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Oct 2019 05:54:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so1747161wmh.2;
        Wed, 09 Oct 2019 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjzPB8hZxTlvLEbGNCa+B9mKE/gfU2JFjpfrgoII7AM=;
        b=ghGng6jvRuyoU5VrK0M9LvMWPWhWdUWwRxombiYF7h7LD50JfxHYeWYouqmkjHJz09
         g9dlBr51y5GlMYcXM4xu50W/QQc79U4pFR4liuW4rMqWKAf/oaJppWvy0IwpZotfgGDe
         OozCn6XAOtih00mC5qmCslTQe6qatrfpHQfmb+4VAplOwofiEuFTMnDBVj6vvkPyiyGQ
         lsUMvgMkhUWDfp5fuaRvqFSu6rKqM0S6KlFWKPQ7nWUX81uOGAMcM8uy9kgBKfD4dClC
         Eo1tKxNNeGqFNKK/eEow2mEJHXeMyRlGpuYq6XI1hPLJuFiVVKBZD2/7uwz65znyPb1s
         cM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjzPB8hZxTlvLEbGNCa+B9mKE/gfU2JFjpfrgoII7AM=;
        b=aRxguDB7jCz+fFF7E94GbXRi1LAk9KCJmi1kmGpZkcNA9Ggby8AK0JVnt05D6D2pQQ
         GTfdY2Eh5WBHu574HukpUFk3Iic8wQrBaxc3uHiwWltzr8tkOvzaEMObehWevD+kWJF0
         XnVIoc0OVLyGg1oQpwkSW5H2HUgh+18xMVXgYnmDLWOQ8B8CM0f6XVbJAJ2gQ6BrcPkF
         JUsotzfFHzK/wQneyT5OJYdUkPOU1vwUvtFnKb2/nUMAHlArUSs+ui6kFqRskhJp4SFE
         0JRkLzv2P0FqznhWeGUoRpuEWB1VkNagm7ihARfdWs4NPAbj0D+pW7x3maoRqb4AHXFT
         3F/A==
X-Gm-Message-State: APjAAAWR9BLFNecSfvYzFy6BeOljtU8mA1b4l3hY75eispAVIb4aWdPV
        GRH/iB6B06BL/w6rGzbeiRk=
X-Google-Smtp-Source: APXvYqyzSzpbZLdrScmzqUjPE+OgHqQuRNExZtlUOLssA5O9RU+O+jSTmgzNcsK0Vq+2zD9vSNJZOg==
X-Received: by 2002:a1c:5587:: with SMTP id j129mr1915601wmb.15.1570614869657;
        Wed, 09 Oct 2019 02:54:29 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:e0c:643a:f61b:5721])
        by smtp.gmail.com with ESMTPSA id a3sm3065408wmc.3.2019.10.09.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:54:29 -0700 (PDT)
Date:   Wed, 9 Oct 2019 11:54:23 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Message-ID: <20191009095423.GA9510@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
 <87eezo1nrr.fsf@vitty.brq.redhat.com>
 <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
 <87zhibz91y.fsf@vitty.brq.redhat.com>
 <PU1P153MB0169B3B15DB8D220F8E1A728BF9A0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169B3B15DB8D220F8E1A728BF9A0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 08, 2019 at 10:41:42PM +0000, Dexuan Cui wrote:
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Sent: Tuesday, October 8, 2019 6:00 AM
> >  ...
> > > Looking at the uses of VERSION_INVAL, I find one remaining occurrence
> > > of this macro in vmbus_bus_resume(), which does:
> > >
> > > 	if (vmbus_proto_version == VERSION_INVAL ||
> > > 	    vmbus_proto_version == 0) {
> > > 		...
> > > 	}
> > >
> > > TBH I'm looking at vmbus_bus_resume() and vmbus_bus_suspend() for the
> > > first time and I'm not sure about how to change such check yet... any
> > > suggestions?
> > 
> > Hm, I don't think vmbus_proto_version can ever become == VERSION_INVAL
> > if we rewrite the code the way you suggest, right? So you'll reduce this
> > to 'if (!vmbus_proto_version)' meaning we haven't negotiated any version
> > (yet).
> 
> Yeah, Vitaly is correct. The check may be a little paranoid as I believe 
> "vmbus_proto_version" must be a negotiated value in vmbus_bus_resume()
> and vmbus_bus_suspend().  I added the check just in case.
> 
> > > Mmh, I see that vmbus_bus_resume() and vmbus_bus_suspend() can access
> > > vmbus_connection.conn_state: can such accesses race with a concurrent
> > > vmbus_connect()?
> > 
> > Let's summon Dexuan who's the author! :-)
> 
> There should not be an issue:
> 
> vmbus_connect() is called in the early subsys_initcall(hv_acpi_init).
> 
> vmbus_bus_suspend() is called late in the PM code after the kernel boots up, e.g.
> in the hibernation function hibernation_snapshot() -> dpm_suspend(). 
> 
> vmbus_bus_resume() is also called later in late_initcall_sync(software_resume).
> 
> In the hibernatin process, vmbus_bus_suspend()/resume() can also be called a
> few times, and vmbus_bus_resume() calls vmbus_negotiate_version(). As I
> checked, there is no issue, either.

Thank you both for these remarks.

So, I'll proceed with the removal of VERSION_INVAL in v2 of this series.

Thanks,
  Andrea
