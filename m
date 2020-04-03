Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5F19D64D
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDCMFH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 08:05:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32870 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgDCMFH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 08:05:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id z14so1955797wmf.0;
        Fri, 03 Apr 2020 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQUCZCTE/wfncIspo6/ZNTbBsoILMFYafkiG6+ey3Cs=;
        b=pSnNFTtM5YI501cqh/ryyVPeJmwEBSBsuN2y8qewOXNz9FUCav3FxR7hgueViunHlP
         eSgYKCq62fNIZkpXZH6Ynq6mOouR3Lzfqx1EL2OHN3NNCHiBzgnLHZAwqHNOXODzI+FI
         N2d8eNIZHC5DOCQ0+JsnrNMs+Mkq7m2FOiyvxcvwdeKAgg0/FL8ySPYBDajQeI19YXlU
         xLbTshBiZaanbVwjw74GHiyh97iZNY1ZB2lkur1RBAX2SixuJBJt7ZGIKW/3aSUON1YU
         BSPLDAj5XfOrQahMquJdw5w4vG3EEcoBq3o9CcJdguLrQ6c2M6i2Y6lQJZWEvp3t67AZ
         ohBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQUCZCTE/wfncIspo6/ZNTbBsoILMFYafkiG6+ey3Cs=;
        b=K3BESkzgDMc5qLnuEYEQCphWd8LLDYKZTHjv2lF1W2PEdq5aIL9erPWFH7fpvoe6sK
         b76lkZk6UiDOcBuaTnSM/wkHt3LWtl5FkWkWoiSrADZIO5BlGx7jI8JioFq9l0rgUXD/
         5hianovxYxhpEhRadu+bwgU2MZQFme9Oce+FyLLwGIEf2Su7ysw+CEXZ3IUadAgwdlJM
         psW+IHYIYPS9BUZimwM3vygR6YFQhhM6fmJwjlbp6tS+UgGMonxOGuSdnveUdZJSTaVL
         2q1h8EY/A5X1NGBH9twhkspYTRr+4YSf/mmBetvO7ytXE3Z4fZILMdS4kOGCWWual7uL
         nHUA==
X-Gm-Message-State: AGi0PuaLJ3lm9fVjY3kinSeIJG3HxrHmuD5x6MUGsU5VVWJXCalWD4n7
        6M39KPa5mVXLldzs9OX4ABc=
X-Google-Smtp-Source: APiQypLYe9nuAdZ+EQw0NRG5/kOXlwhnrfOqBhgn/M0rfit03aaXiVbHcGJqCCFDr6nd0PhGZuldvg==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr8104627wml.44.1585915504593;
        Fri, 03 Apr 2020 05:05:04 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id f25sm11024914wml.11.2020.04.03.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 05:05:04 -0700 (PDT)
Date:   Fri, 3 Apr 2020 14:04:56 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the
 offer&rescind works to a specific CPU
Message-ID: <20200403120456.GA24298@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-3-parri.andrea@gmail.com>
 <871rpf5hhm.fsf@vitty.brq.redhat.com>
 <20200326154710.GA13711@andrea>
 <87sghv3u4a.fsf@vitty.brq.redhat.com>
 <20200328170833.GA10153@andrea>
 <MW2PR2101MB1052A2E44557B29C191F557DD7CA0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <87o8se2fpr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8se2fpr.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 30, 2020 at 02:24:16PM +0200, Vitaly Kuznetsov wrote:
> Michael Kelley <mikelley@microsoft.com> writes:
> 
> > From: Andrea Parri <parri.andrea@gmail.com> Sent: Saturday, March 28, 2020 10:09 AM
> >> 
> >> > In case we believe that OFFER -> RESCINF sequence is always ordered
> >> > by the host AND we don't care about other offers in the queue the
> >> > suggested locking is OK: we're guaranteed to process RESCIND after we
> >> > finished processing OFFER for the same channel. However, waiting for
> >> > 'offer_in_progress == 0' looks fishy so I'd suggest we at least add a
> >> > comment explaining that the wait is only needed to serialize us with
> >> > possible OFFER for the same channel - and nothing else. I'd personally
> >> > still slightly prefer the algorythm I suggested as it guarantees we take
> >> > channel_mutex with offer_in_progress == 0 -- even if there are no issues
> >> > we can think of today (not strongly though).
> >> 
> >> Does it?  offer_in_progress is incremented without channel_mutex...
> >> 
> 
> No, it does not, you're right, by itself the change is insufficient.
> 
> >> IAC, I have no objections to apply the changes you suggested.  To avoid
> >> misunderstandings: vmbus_bus_suspend() presents a similar usage...  Are
> >> you suggesting that I apply similar changes there?
> >> 
> >> Alternatively:  FWIW, the comment in vmbus_onoffer_rescind() does refer
> >> to "The offer msg and the corresponding rescind msg...".  I am all ears
> >> if you have any concrete suggestions to improve these comments.
> >> 
> >
> > Given that waiting for 'offer_in_progress == 0' is the current code, I think
> > there's an argument to made for not changing it if the change isn't strictly
> > necessary.  This patch set introduces enough change that *is* necessary. :-)
> >
> 
> Sure. I was thinking a bit more about this and it seems that over years
> we've made the synchronization of channels code too complex (every time
> for a good reason but still). Now (before this series) we have at least:
> 
> vmbus_connection.channel_mutex
> vmbus_connection.offer_in_progress
> channel.probe_done
> channel.rescind
> Workqueues (vmbus_connection.work_queue,
>  queue_work_on(vmbus_connection.connect_cpu),...)
> channel.lock spinlock (the least of the problems)
> 
> Maybe there's room for improvement? Out of top of my head I'd suggest a
> state machine for each channel (e.g something like
> OFFERED->OPENING->OPEN->RESCIND_REQ->RESCINDED->CLOSED) + refcounting
> (subchannels, open/rescind/... requests in progress, ...) + non-blocking
> request handling like "Can we handle this rescind offer now? No,
> refcount is too big. OK, rescheduling the work". Maybe not the best
> design ever and I'd gladly support any other which improves the
> readability of the code and makes all state changes and synchronization
> between them more obvious.
> 
> Note, VMBus channel handling driven my messages (unlike events for ring
> buffer) is not performance critical, we just need to ensure completeness
> (all requests are handled correctly) with forward progress guarantees
> (no deadlocks).
> 
> I understand the absence of 'hot' issues in the current code is what can
> make the virtue of redesign questionable and sorry for hijacking the
> series which doesn't seem to make things worse :-)

(Back here...  Sorry for the delay.)

FWIW, what you wrote above makes sense to me; and *yes*, the series in
question was not intended as "let us undertake such a redesign" (quite
the opposite in fact...)

With regard to this specific patch, it seems to me that we've reached
a certain consensus or, at least, I don't see complaints  ;-).  Please
let me know if I misunderstood.

Thanks,
  Andrea
