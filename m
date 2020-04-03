Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BED19D7C3
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgDCNif (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 09:38:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42290 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390770AbgDCNif (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 09:38:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so8553510wrx.9;
        Fri, 03 Apr 2020 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngUgjvZBWhVhOxFEXIDkx6xzsKtQ5zuVaNcA064tn4Q=;
        b=ci8KXxcRJrNNYah2UU5gFhowpYCli5deBpIuCq29PgGWbVIrzvr9Jp9fLNC9N11zp/
         Sekfzn4vN4zcV54Id7tDFZT9462/7sdKQrn90ctsv3n+87yO65ywf5UYEPbs465wjrCk
         4mBIXFyPmFF5/48Rd8JynP6WF9zVNdQBKS8eFm5QEE4WbmO2nZDqspCs7kWI0RxZdGD9
         kNJokcnssdL+AMtROKC2m75bOhN8gq5BjzKgUJrh3AG3uZST1crrTGfSXBkpeZ3hSbKv
         6LuRe4Zgn4qBqHx7hKS9oNU788MTPyDcBUxJJ+ZbNf6gN5qSuZnrvLjhMt2iXd9AqHyR
         RUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngUgjvZBWhVhOxFEXIDkx6xzsKtQ5zuVaNcA064tn4Q=;
        b=ZUD3T5jgBPphT7Ni8adY+oJPj8tPFlkp5i0LBVq652M405eMX1vPdbxYVz0eW/VuvH
         sQvF1sogQiNZILw23upTQgtcdm/QiLxGQp9gm4Hwf2dMDLAdHI3hSZcRsx9rSms1WSIY
         rd2AxM5VHclfSmXrj6Kgrsq0CQJx+lMCA1BuR9RoWmqClu3l9ZnJx8TA4tnUwXZC5jvA
         fEzVvMt5Ac6aCZ/4N1NBpsvN2VdWGrQaGJ1lKVS2DkVBDUd22sWRmWqzv4/CKlVd21Mt
         LPIG+JpKh9AgkAmDX71W0v/urGVqHL0Tjr3WCnZv9SHHMSTxUscr1uJcz4JRPKjW/iEF
         u9HQ==
X-Gm-Message-State: AGi0PuYXSFJvEbqhlFQKY3aMQ2QDnQQxMJuRNe9b9GcTtcvBdjOuJJPI
        g70lR0qxSqn1ZJqzFn7RZuM=
X-Google-Smtp-Source: APiQypKlE8pDWi7VTwPr/NlgbiNOyuGhYIfDBVKNVEc0vFBtC9rRsjhB2dwwteMQ+izNzqMhj4vV8w==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr9036370wrh.7.1585921112598;
        Fri, 03 Apr 2020 06:38:32 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id s11sm11837516wrw.58.2020.04.03.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:38:32 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:38:26 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU
 channel lists with a global array of channels
Message-ID: <20200403133826.GA25401@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-4-parri.andrea@gmail.com>
 <87y2rn4287.fsf@vitty.brq.redhat.com>
 <20200326170518.GA14314@andrea>
 <87pncz3tcn.fsf@vitty.brq.redhat.com>
 <20200328182148.GA11210@andrea>
 <87imim2epp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imim2epp.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 30, 2020 at 02:45:54PM +0200, Vitaly Kuznetsov wrote:
> Andrea Parri <parri.andrea@gmail.com> writes:
> 
> >> Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
> >> per-cpu list of channels on the same CPU so we don't need a spinlock to
> >> guarantee that during an interrupt we'll be able to see the update if it
> >> happened before the interrupt (in chronological order). With a global
> >> list of relids, who guarantees that an interrupt handler on another CPU
> >> will actually see the modified list? 
> >
> > Thanks for pointing this out!
> >
> > The offer/resume path presents implicit full memory barriers, program
> > -order after the array store which should guarantee the visibility of
> > the store to *all* CPUs before the offer/resume can complete (c.f.,
> >
> >   tools/memory-model/Documentation/explanation.txt, Sect. #13
> >
> > and assuming that the offer/resume for a channel must complete before
> > the corresponding handler, which seems to be the case considered that
> > some essential channel fields are initialized only later...)
> >
> > IIUC, the spin lock approach you suggested will work and be "simpler";
> > an obvious side effect would be, well, a global synchronization point
> > in vmbus_chan_sched()...
> >
> > Thoughts?
> 
> This is, of course, very theoretical as if we're seeing an interrupt for
> a channel at the same time we're writing its relid we're already in
> trouble. I can, however, try to suggest one tiny improvement:

Indeed.  I think the idea (still quite informal) is that:

  1) the mapping of the channel relid is propagated to (visible from)
     all CPUs before add_channel_work is queued (full barrier in
     queue_work()),

  2) add_channel_work is queued before the channel is opened (aka,
     before the channel ring buffer is allocate/initalized and the
     OPENCHANNEL msg is sent and acked from Hyper-V, cf. OPEN_STATE),

  3) the channel is opened before Hyper-V can start sending interrupts
     for the channel, and hence before vmbus_chan_sched() can find the
     channel relid in recv_int_page set,

  4) vmbus_chan_sched() finds the channel's relid in recv_int_page
     set before it search/load from the channel array (full barrier
     in sync_test_and_clear_bit()).

This is for the "normal"/not resuming from hibernation case; for the
latter, notice that:

  a) vmbus_isr() (and vmbus_chan_sched()) can not run until when
     vmbus_bus_resume() has finished (@resume_noirq callback),

  b) vmbus_bus_resume() can not complete before nr_chan_fixup_on_resume
     equals 0 in check_ready_for_resume_event().
     
(and check_ready_for_resume_event() does also provides a full barrier).

If makes sense to you, I'll try to add some of the above in comments.

Thanks,
  Andrea


> 
> vmbus_chan_sched() now clean the bit in the event page and then searches
> for a channel with this relid; in case we allow the search to
> (temporary) fail we can reverse the logic: search for the channel and
> clean the bit only if we succeed. In case we fail, next time (next IRQ)
> we'll try again and likely succeed. The only purpose is to make sure no
> interrupts are ever lost.  This may be an overkill, we may want to try
> to count how many times (if ever) this happens. 
> 
> Just a thought though.
> 
> -- 
> Vitaly
> 
