Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325B366062
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhDTTrR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 15:47:17 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55098 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTrQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 15:47:16 -0400
Received: by mail-wm1-f47.google.com with SMTP id k128so20892861wmk.4;
        Tue, 20 Apr 2021 12:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clJvZo41cTw/2l8oyUrG2xS0oDar4vQe+yD5wxBkpHU=;
        b=DpoDnoPRUtGsTJcPvTLLtrQ0GqN5hFmd5Q4MLmfzK00vAl62HPBqiUGE0pUHD+9wMC
         q1kvW/VELV4Aqujx18utLCOIG0eNAb1KkWydEpvwqlb9QDkwXbo+AZeJ54dSwJ2s6FyO
         0xpC7CkOSFDAAN8GOxl2b8C9Fba+W3zGTioUSR4/ENQSy21vQXbcJV7eoZ0yqzk3IJDr
         qFo5vQJ0NoGBMM7Shc5BQCbvZRgSzomlu4RXRRynRQjKnkswQCF+Swb+nDFWefIE7QUU
         v4fgcPaJ2u9WTM06Zsu3qNBOFspHM8CpCeawNpy17SBLHQcF5EPfgD5sEZx/uGyxWwvl
         iFjg==
X-Gm-Message-State: AOAM531V/uZaeT1k5YESamOaBd++lHJup+r3rIVwiCWJAyYJa2F5DH/6
        tqa6+TqiPb0a+nUTdb/swu8=
X-Google-Smtp-Source: ABdhPJy4B5Hsm6o0fy2L/dq9yBRHNPq+snwDrllOHfFUlwpl3S4nd19bIg/SFhj2JSa7YipSjG3XYQ==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr6160499wmf.9.1618948003981;
        Tue, 20 Apr 2021 12:46:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t14sm11683027wrz.55.2021.04.20.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:46:43 -0700 (PDT)
Date:   Tue, 20 Apr 2021 19:46:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        decui@microsoft.com
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 1/1] Drivers:
 hv: vmbus: Increase wait time for VMbus unload
Message-ID: <20210420194642.hnonoj4fftmktciy@liuwe-devbox-debian-v2>
References: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
 <87tuo1i9o5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuo1i9o5.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 20, 2021 at 11:31:54AM +0200, Vitaly Kuznetsov wrote:
> Michael Kelley <mikelley@microsoft.com> writes:
> 
> > When running in Azure, disks may be connected to a Linux VM with
> > read/write caching enabled. If a VM panics and issues a VMbus
> > UNLOAD request to Hyper-V, the response is delayed until all dirty
> > data in the disk cache is flushed.  In extreme cases, this flushing
> > can take 10's of seconds, depending on the disk speed and the amount
> > of dirty data. If kdump is configured for the VM, the current 10 second
> > timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
> > complete message may arrive well after the kdump kernel is already
> > running, causing problems.  Note that no problem occurs if kdump is
> > not enabled because Hyper-V waits for the cache flush before doing
> > a reboot through the BIOS/UEFI code.
> >
> > Fix this problem by increasing the timeout in vmbus_wait_for_unload()
> > to 100 seconds. Also output periodic messages so that if anyone is
> > watching the serial console, they won't think the VM is completely
> > hung.
> >
> > Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

> > ---
[...]
> >  
> > +#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
> > +#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
> > +#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
> > +#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
> > +#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
> > +
> >  static void vmbus_wait_for_unload(void)
> >  {
> >  	int cpu;
> > @@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
> >  	 * vmbus_connection.unload_event. If not, the last thing we can do is
> >  	 * read message pages for all CPUs directly.
> >  	 *
> > -	 * Wait no more than 10 seconds so that the panic path can't get
> > -	 * hung forever in case the response message isn't seen.
> > +	 * Wait up to 100 seconds since an Azure host must writeback any dirty
> > +	 * data in its disk cache before the VMbus UNLOAD request will
> > +	 * complete. This flushing has been empirically observed to take up
> > +	 * to 50 seconds in cases with a lot of dirty data, so allow additional
> > +	 * leeway and for inaccuracies in mdelay(). But eventually time out so
> > +	 * that the panic path can't get hung forever in case the response
> > +	 * message isn't seen.
> 
> I vaguely remember debugging cases when CHANNELMSG_UNLOAD_RESPONSE never
> arrives, it was kind of pointless to proceed to kexec as attempts to
> reconnect Vmbus devices were failing (no devices were offered after
> CHANNELMSG_REQUESTOFFERS AFAIR). Would it maybe make sense to just do
> emergency reboot instead of proceeding to kexec when this happens? Just
> wondering.
> 

Please submit a follow-up patch if necessary.

Wei.
