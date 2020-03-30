Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D9197BBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgC3MYX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 08:24:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60303 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729927AbgC3MYW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 08:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585571061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ygALAJVOjqUJKfasvnnjImKIeALHsYUPdnk+AuUynM=;
        b=IkzJhIHRIyM6gElBVfZ8Tj5lSWRZsj1W6NdsiOxVKl1GQq6esEarejIORyEFGdWd7XDrQZ
        REeH52zPRJMpaTiw2FMiKHJVWCC+l4u4lV/VBFfIiQnxbVUBAXbEOVaX6jSGODk3zXUKiD
        yfoG+pDPHbLzSPQ/H6/87hpz+K6gfO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-uhNa_4oKMje1egkUU6VvCQ-1; Mon, 30 Mar 2020 08:24:19 -0400
X-MC-Unique: uhNa_4oKMje1egkUU6VvCQ-1
Received: by mail-wr1-f69.google.com with SMTP id j12so11130899wrr.18
        for <linux-hyperv@vger.kernel.org>; Mon, 30 Mar 2020 05:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/ygALAJVOjqUJKfasvnnjImKIeALHsYUPdnk+AuUynM=;
        b=XZ2xRiNVHZD1Y/lZs9JqIzYNUsO+KA2Swb557LNwD2u5xBnP6T21nL33k2Gql7y93O
         e5Kg7Dk7yBm7BZGZovsLxzSjF5du2RJzRCnwO9ctrF/jMOHtyY6wyFBVsgkA06T3UNEP
         ni4HLraWzRaAgIuvl44TMSU8zhc36HLHHwHT6gVGoim9BPNx7lpoHxuFXqmt5ecX8NlB
         LmxPpvGzzkAkqHCXkWta0S92hrdaPg7+mVpQqTT8rsEfiddCJTA+eqqU6exjs8TCloZ7
         A7tfbl8YKUxadxsy/E1j5m0SSoUetB7/rF7COqf1IjTBHYkROqy9uvHXnoPUOr7VVM9f
         Kc3w==
X-Gm-Message-State: ANhLgQ1DXiiD0mprsiGgF08+nLfo8JDVBfyd6pb8PWfXtjBTLfWP5+bP
        eWQWWn6nXhYpm+lVauE7YHm//uD9OY/K37TfW19erx+6iFykWJo6bUqM08CDzYq/E83SYbi8fLp
        AA7gk2gAA9lMFtYC55f8wA5GD
X-Received: by 2002:adf:ec02:: with SMTP id x2mr14564033wrn.365.1585571058691;
        Mon, 30 Mar 2020 05:24:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4+0mKL6LvY3oLktG34cbkfsvaDlgrbw2AYD/ENCNEbfbZ1AiL6eM0zhcnkf9XQGgVEbaibw==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr14564012wrn.365.1585571058374;
        Mon, 30 Mar 2020 05:24:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 9sm20168122wmm.6.2020.03.30.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:24:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
In-Reply-To: <MW2PR2101MB1052A2E44557B29C191F557DD7CA0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-3-parri.andrea@gmail.com> <871rpf5hhm.fsf@vitty.brq.redhat.com> <20200326154710.GA13711@andrea> <87sghv3u4a.fsf@vitty.brq.redhat.com> <20200328170833.GA10153@andrea> <MW2PR2101MB1052A2E44557B29C191F557DD7CA0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Date:   Mon, 30 Mar 2020 14:24:16 +0200
Message-ID: <87o8se2fpr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Andrea Parri <parri.andrea@gmail.com> Sent: Saturday, March 28, 2020 10:09 AM
>> 
>> > In case we believe that OFFER -> RESCINF sequence is always ordered
>> > by the host AND we don't care about other offers in the queue the
>> > suggested locking is OK: we're guaranteed to process RESCIND after we
>> > finished processing OFFER for the same channel. However, waiting for
>> > 'offer_in_progress == 0' looks fishy so I'd suggest we at least add a
>> > comment explaining that the wait is only needed to serialize us with
>> > possible OFFER for the same channel - and nothing else. I'd personally
>> > still slightly prefer the algorythm I suggested as it guarantees we take
>> > channel_mutex with offer_in_progress == 0 -- even if there are no issues
>> > we can think of today (not strongly though).
>> 
>> Does it?  offer_in_progress is incremented without channel_mutex...
>> 

No, it does not, you're right, by itself the change is insufficient.

>> IAC, I have no objections to apply the changes you suggested.  To avoid
>> misunderstandings: vmbus_bus_suspend() presents a similar usage...  Are
>> you suggesting that I apply similar changes there?
>> 
>> Alternatively:  FWIW, the comment in vmbus_onoffer_rescind() does refer
>> to "The offer msg and the corresponding rescind msg...".  I am all ears
>> if you have any concrete suggestions to improve these comments.
>> 
>
> Given that waiting for 'offer_in_progress == 0' is the current code, I think
> there's an argument to made for not changing it if the change isn't strictly
> necessary.  This patch set introduces enough change that *is* necessary. :-)
>

Sure. I was thinking a bit more about this and it seems that over years
we've made the synchronization of channels code too complex (every time
for a good reason but still). Now (before this series) we have at least:

vmbus_connection.channel_mutex
vmbus_connection.offer_in_progress
channel.probe_done
channel.rescind
Workqueues (vmbus_connection.work_queue,
 queue_work_on(vmbus_connection.connect_cpu),...)
channel.lock spinlock (the least of the problems)

Maybe there's room for improvement? Out of top of my head I'd suggest a
state machine for each channel (e.g something like
OFFERED->OPENING->OPEN->RESCIND_REQ->RESCINDED->CLOSED) + refcounting
(subchannels, open/rescind/... requests in progress, ...) + non-blocking
request handling like "Can we handle this rescind offer now? No,
refcount is too big. OK, rescheduling the work". Maybe not the best
design ever and I'd gladly support any other which improves the
readability of the code and makes all state changes and synchronization
between them more obvious.

Note, VMBus channel handling driven my messages (unlike events for ring
buffer) is not performance critical, we just need to ensure completeness
(all requests are handled correctly) with forward progress guarantees
(no deadlocks).

I understand the absence of 'hot' issues in the current code is what can
make the virtue of redesign questionable and sorry for hijacking the
series which doesn't seem to make things worse :-)

-- 
Vitaly

