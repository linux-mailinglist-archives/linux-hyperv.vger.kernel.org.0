Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC421AAA33
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2020 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636649AbgDOOiA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Apr 2020 10:38:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42785 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634473AbgDOOh6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Apr 2020 10:37:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id j2so76318wrs.9;
        Wed, 15 Apr 2020 07:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFQ6OPmr3bYT6YpSGJ9844rrkbuCT3rhKovZKEMdYh0=;
        b=qiyQlCkYPCtZHfLm/XKHhyDVdnPhtNbb9u63GDkyLnVXVN+nM4VKCjMwJUz/HEOTvB
         y3TGzt93sSujI093P5rQPzgCD50TClpTTLqeZQbODnMPas+p5PyMgNfbB5A2131KZ4X1
         bImA9UUvW5tIf0JoeVq63aAyT8t4vj2Z56t0+zY3p4G4L2IBykwG+WWcoBzkNPpcHsiH
         Kv4wWsMv6TMoEVpHGvCPpSncMQYEcGbbh6V6HaAM8DcUJxnBmHXAEfon2AD8bfZmQtLi
         otGje7/IAzHXp0i04LuhZNNLA1WJZGuIBvSuceMprYTAFxwqFORCUgQ8eKlNRjaU6Rfg
         Eg+Q==
X-Gm-Message-State: AGi0PuZH7DHRAm5/KX8nu1z+mUTZ8wURAqgotg/b4fBOUVYL2Vb65PWs
        fdTIO/6q1bWvz9ihhYdW0xk=
X-Google-Smtp-Source: APiQypJMJJT5Xdg+uQJVYoi7gV4Bgvt7rTcXwzNbFzINw6ITI4fwZ4N2Aq2ucU2Xm7enL/b+GekA1A==
X-Received: by 2002:a5d:4106:: with SMTP id l6mr1527916wrp.111.1586961474756;
        Wed, 15 Apr 2020 07:37:54 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id u16sm23302758wro.23.2020.04.15.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:37:54 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:37:52 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to
 pointer primary_channel
Message-ID: <20200415143752.cm3xbesiuksfdbzm@debian>
References: <20200414152343.243166-1-colin.king@canonical.com>
 <87d08axb7k.fsf@vitty.brq.redhat.com>
 <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
 <87wo6hvxkz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo6hvxkz.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 15, 2020 at 12:43:08PM +0200, Vitaly Kuznetsov wrote:
> Colin Ian King <colin.king@canonical.com> writes:
> 
> > On 14/04/2020 17:51, Vitaly Kuznetsov wrote:
> >> Colin King <colin.king@canonical.com> writes:
> >> 
> >>> From: Colin Ian King <colin.king@canonical.com>
> >>>
> >>> The pointer primary_channel is being assigned with a value that is never,
> >>> The assignment is redundant and can be removed.
> >>>
> >>> Addresses-Coverity: ("Unused value")
> >>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>> ---
> >>>  drivers/hv/channel_mgmt.c | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> >>> index ffd7fffa5f83..f7bbb8dc4b0f 100644
> >>> --- a/drivers/hv/channel_mgmt.c
> >>> +++ b/drivers/hv/channel_mgmt.c
> >>> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
> >>>  
> >>>  	if (channel->primary_channel == NULL) {
> >>>  		list_del(&channel->listentry);
> >>> -
> >>> -		primary_channel = channel;
> >>>  	} else {
> >>>  		primary_channel = channel->primary_channel;
> >>>  		spin_lock_irqsave(&primary_channel->lock, flags);
> >> 
> >> If I'm looking at the right source (5.7-rc1) it *is* beeing used:
> >> 
> >> 	if (channel->primary_channel == NULL) {
> >> 		list_del(&channel->listentry);
> >> 
> >> 		primary_channel = channel;
> >> 	} else {
> >> 		primary_channel = channel->primary_channel;
> >> 		spin_lock_irqsave(&primary_channel->lock, flags);
> >> 		list_del(&channel->sc_list);
> >> 		spin_unlock_irqrestore(&primary_channel->lock, flags);
> >> 	}
> >> 
> >> 	/*
> >> 	 * We need to free the bit for init_vp_index() to work in the case
> >> 	 * of sub-channel, when we reload drivers like hv_netvsc.
> >> 	 */
> >> 	if (channel->affinity_policy == HV_LOCALIZED)
> >> 		cpumask_clear_cpu(channel->target_cpu,
> >> 				  &primary_channel->alloced_cpus_in_node);
> >>                                    ^^^^^ HERE ^^^^^
> >> 
> >
> > I was basing my change on linux-next that has removed a hunk of code:
> >
> > commit bcefa400900739310e8ef0cb34cbe029c404455c
> > Author: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > Date:   Mon Apr 6 02:15:11 2020 +0200
> >
> >     Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
> > logic
> >
> 
> Ah, please add the right 'Fixes:' tag then.

I don't think the Fixes tag is particularly useful in this instance.
Andrea's commit is not yet in Linus' tree. If I rebase hyper-next over
the next 2.5 months the tag is going to have a stale commit hash in it.

Wei.

> 
> -- 
> Vitaly
> 
