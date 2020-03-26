Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9A19456D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgCZR0o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 13:26:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56509 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgCZR0o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 13:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585243602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yoWExIa8uKZDm3d9Yylk3hPrFSP0vS6PZQcN1wyA1j8=;
        b=cN5HZCzY7r9yg6TOb5zpyy6wnirDoFhnt6FkoLbEOYWp6dQvPIHyAzW+/8lot+aidL5mmj
        VozciU+ME5E+oRb/3/9kpcYQyOGFi0QsDg7PtoW7N4oICcmyyR+6vTcNfAdzVa4xyqLvtR
        gwQDqLmahbBlEmeclKLGreA31IjfkuI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-ZNTvX_1rMqG1zGhJiO6qbw-1; Thu, 26 Mar 2020 13:26:35 -0400
X-MC-Unique: ZNTvX_1rMqG1zGhJiO6qbw-1
Received: by mail-wm1-f69.google.com with SMTP id w12so2460416wmc.3
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 10:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yoWExIa8uKZDm3d9Yylk3hPrFSP0vS6PZQcN1wyA1j8=;
        b=ts+K+FiqeT1C5jZ6fV3ws6Ec4HGE1NP95fD+XOtnoCPPmwx8ZTqxGx5ohSCtINlI4e
         6M4kj/wEYwd8H+Juqsw2CrfzndifZZmWwKw80x4NIKGbsAkzx0LAcolSGfy77wxr2R/F
         Vjfi0eXcm0jO0U21WwUAGHq0K1zwz0eMHFWkaaayl3KwoS7zFPq453TGmLNdvpZPKcyb
         7evhkfGKRQH5rpVIghccWN87kgZ/PlR1is5laS8fWIC3yXkUrOfz7bxRVRMiZ+badFUm
         En2YrA1QtMgz1zIPjtxqB16QkOKq+Zt4tWCwt+VLwVaB8CHVfKpjX43s5J48fIFy+JKL
         bnsA==
X-Gm-Message-State: ANhLgQ2zL59H/0RSOXL8AcHMi8kwMTZv68ZPtFzKCz4DYPr6zW8VrXbG
        21gXP2ZxL0HZRY+ccppKZgFdTdNw0R4RlXqgRuF4PSUD5aJFZo7bav2KKn6P9mxvJvR8fVY3dun
        A2DQMfZ+swPf0nAt4nYR9dhy+
X-Received: by 2002:adf:9dca:: with SMTP id q10mr10242784wre.11.1585243591328;
        Thu, 26 Mar 2020 10:26:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv/DCb/SqkrhQKck4vIy6KEd0b1W0o4eUjIG0rFQkPpkdQVgglZJpxfRB7w6/TwkmLHr08/ZQ==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr10242762wre.11.1585243591020;
        Thu, 26 Mar 2020 10:26:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q185sm4545103wme.10.2020.03.26.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:26:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific CPU
In-Reply-To: <20200326154710.GA13711@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-3-parri.andrea@gmail.com> <871rpf5hhm.fsf@vitty.brq.redhat.com> <20200326154710.GA13711@andrea>
Date:   Thu, 26 Mar 2020 18:26:29 +0100
Message-ID: <87sghv3u4a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Thu, Mar 26, 2020 at 03:16:21PM +0100, Vitaly Kuznetsov wrote:
>> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
>> 
>> > The offer and rescind works are currently scheduled on the so called
>> > "connect CPU".  However, this is not really needed: we can synchronize
>> > the works by relying on the usage of the offer_in_progress counter and
>> > of the channel_mutex mutex.  This synchronization is already in place.
>> > So, remove this unnecessary "bind to the connect CPU" constraint and
>> > update the inline comments accordingly.
>> >
>> > Suggested-by: Dexuan Cui <decui@microsoft.com>
>> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>> > ---
>> >  drivers/hv/channel_mgmt.c | 21 ++++++++++++++++-----
>> >  drivers/hv/vmbus_drv.c    | 39 ++++++++++++++++++++++++++++-----------
>> >  2 files changed, 44 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index 0370364169c4e..1191f3d76d111 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -1025,11 +1025,22 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
>> >  	 * offer comes in first and then the rescind.
>> >  	 * Since we process these events in work elements,
>> >  	 * and with preemption, we may end up processing
>> > -	 * the events out of order. Given that we handle these
>> > -	 * work elements on the same CPU, this is possible only
>> > -	 * in the case of preemption. In any case wait here
>> > -	 * until the offer processing has moved beyond the
>> > -	 * point where the channel is discoverable.
>> > +	 * the events out of order.  We rely on the synchronization
>> > +	 * provided by offer_in_progress and by channel_mutex for
>> > +	 * ordering these events:
>> > +	 *
>> > +	 * { Initially: offer_in_progress = 1 }
>> > +	 *
>> > +	 * CPU1				CPU2
>> > +	 *
>> > +	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
>> > +	 *
>> > +	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
>> > +	 * DECREMENT offer_in_progress	LOCK channel_mutex
>> > +	 * INSERT chn_list		SEARCH chn_list
>> > +	 * UNLOCK channel_mutex		UNLOCK channel_mutex
>> > +	 *
>> > +	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT
>> 
>> WAIT_ON offer_in_progress == 0
>> LOCK channel_mutex
>> 
>> seems to be racy: what happens if offer_in_progress increments after we
>> read it but before we managed to aquire channel_mutex?
>
> Remark that the RESCIND work must see the increment which is performed
> "before" queueing the work in question (and the associated OFFER work),
> cf. the comment in vmbus_on_msg_dpc() below and
>
>   dbb92f88648d6 ("workqueue: Document (some) memory-ordering properties of {queue,schedule}_work()")
>
> AFAICT, this suffices to meet the intended behavior as sketched above.
> I might be missing something of course, can you elaborate on the issue
> here?
>

In case we believe that OFFER -> RESCINF sequence is always ordered
by the host AND we don't care about other offers in the queue the
suggested locking is OK: we're guaranteed to process RESCIND after we
finished processing OFFER for the same channel. However, waiting for
'offer_in_progress == 0' looks fishy so I'd suggest we at least add a
comment explaining that the wait is only needed to serialize us with
possible OFFER for the same channel - and nothing else. I'd personally
still slightly prefer the algorythm I suggested as it guarantees we take
channel_mutex with offer_in_progress == 0 -- even if there are no issues
we can think of today (not strongly though).

-- 
Vitaly

