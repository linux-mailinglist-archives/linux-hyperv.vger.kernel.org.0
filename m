Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A428580096
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbfHBTCV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 15:02:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43540 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfHBTCU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 15:02:20 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so1175153ios.10;
        Fri, 02 Aug 2019 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vX8vlz05PAbtwj04IRyDoHvPXHFs00D4ccSNjAMsI0A=;
        b=A+xuqPf0eIp+OcH/IL74pGtJWJapiXZ6yLVE6xBfzGNQY/swYlq14QnMTMz/Qf7US9
         Nfs8VxABbBqX2qJlp2hG6HDeCtJDtpcUUi/lXmuqdMZ9jjd2XuE2SzJIG2FXNNZ4mrGL
         Igoyb8QAO3kdzjeWA/Rz/LXVmDhYddQY8V6QKXKC688M4Bz1WZBgJYwYWiAnqo5iXQx/
         KXdneh7qhxQqIIx+RpwAznD2QQi71mF/l1f6vRn/QYfv5ssj8BJdd8z9XnMK9AtIIe+N
         g38W5Mo2Dczccf+yybwyYF8m7sxdnZV5t5dFtQFbNUc1kgCYfhqcTU0D2QHYijobCm3f
         MhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vX8vlz05PAbtwj04IRyDoHvPXHFs00D4ccSNjAMsI0A=;
        b=K7zBi9Wi/8YNfJCrPcic+MTvsuLhJr0fYNC28T8Cl1mUpuv2Es07y+C0ySS4TjpBc2
         4t2v4FLWf7jfQfWl2W6R9QVVNpLeU77791F2GFMFVQzef+65nNskbhUY0QVHqLcquCj+
         5h3fXzs6ic4YS69RooasOxlHKByv2D0ElvG2seyyEnB+ap0H4ZKwAtrhc8fdMfxWpJj3
         RC71ObGMNeGOmi9WodY950mDPbNvSww92AWvleimap2QE0fY8CmYC6+hCLi05CStOIoD
         nJpEHO9e93N3zI6Bp6wIwuGIBlRUb7PtVqSt0Llre7yEi7OJaXuK4bEIvcR6E8KM97dc
         2Ijg==
X-Gm-Message-State: APjAAAUpQW1kpkAiMPqP4DYzcqKKvKZQH/3zsz1/w/6mM6GitZXSBeeF
        dE4ACsxGOPqLgRghZ2UVTA==
X-Google-Smtp-Source: APXvYqw66ahshAJ4h21vc1jML60PKKwYTAcHJHZxuuqKnQxg3VnjFt0DjTEWicJibcA+qpZtkakFzA==
X-Received: by 2002:a02:a183:: with SMTP id n3mr145575969jah.74.1564772539896;
        Fri, 02 Aug 2019 12:02:19 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id i4sm98958268iog.31.2019.08.02.12.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 12:02:19 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:02:17 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190802190217.GA27145@Test-Virtual-Machine>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
 <18193677a879c402d00955c445ae7ce461b4198f.1564527684.git.brandonbonaby94@gmail.com>
 <87d0hoggyc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0hoggyc.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 09:32:59AM +0200, Vitaly Kuznetsov wrote:
> Branden Bonaby <brandonbonaby94@gmail.com> writes:
> 
> > Introduce user specified latency in the packet reception path.
> >
> > Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> > ---
> >  drivers/hv/connection.c  |  5 +++++
> >  drivers/hv/ring_buffer.c | 10 ++++++++++
> >  include/linux/hyperv.h   | 14 ++++++++++++++
> >  3 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > index 09829e15d4a0..2a2c22f5570e 100644
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -354,9 +354,14 @@ void vmbus_on_event(unsigned long data)
> >  {
> >  	struct vmbus_channel *channel = (void *) data;
> >  	unsigned long time_limit = jiffies + 2;
> > +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> > +						channel :
> > +						channel->primary_channel;
> >  
> >  	trace_vmbus_on_event(channel);
> >  
> > +	if (unlikely(test_channel->fuzz_testing_buffer_delay > 0))
> > +		udelay(test_channel->fuzz_testing_buffer_delay);
> >  	do {
> >  		void (*callback_fn)(void *);
> >  
> > diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> > index 9a03b163cbbd..d7627c9023d6 100644
> > --- a/drivers/hv/ring_buffer.c
> > +++ b/drivers/hv/ring_buffer.c
> > @@ -395,7 +395,12 @@ struct vmpacket_descriptor *hv_pkt_iter_first(struct vmbus_channel *channel)
> >  {
> >  	struct hv_ring_buffer_info *rbi = &channel->inbound;
> >  	struct vmpacket_descriptor *desc;
> > +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> > +						channel :
> > +						channel->primary_channel;
> >  
> > +	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
> > +		udelay(test_channel->fuzz_testing_message_delay);
> >  	if (hv_pkt_iter_avail(rbi) < sizeof(struct vmpacket_descriptor))
> >  		return NULL;
> >  
> > @@ -420,7 +425,12 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
> >  	struct hv_ring_buffer_info *rbi = &channel->inbound;
> >  	u32 packetlen = desc->len8 << 3;
> >  	u32 dsize = rbi->ring_datasize;
> > +	struct vmbus_channel *test_channel = !channel->primary_channel ?
> > +						channel :
> > +						channel->primary_channel;
> 
> This pattern is repeated 3 times so a define is justified. I would also
> reversed the logic:
> 
>    test_channel = channel->primary_channel ? channel->primary_channel : channel;
> 
> >  
> > +	if (unlikely(test_channel->fuzz_testing_message_delay > 0))
> > +		udelay(test_channel->fuzz_testing_message_delay);
> 
> unlikely() is good but if it was under #ifdef it would've been even better.
> 
> >  	/* bump offset to next potential packet */
> -- 
> Vitaly

Makes sense, I'll address the repeated code and will change the way I
handled that if statement. Using an ifdef CONFIG_HYPERV_TESTING
seems like a good thing to add in here like you suggested.
