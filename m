Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39611A9B26
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2020 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896520AbgDOKnc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Apr 2020 06:43:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2896515AbgDOKnW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Apr 2020 06:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586947398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNKRF/g9GTKiJfx6XpsmKFnQkmViCDbB0eElZUOgBB0=;
        b=IsfWvWJwSpq5UAJpFfbAjQiFi+jNN192XqdghpE/Sh9An4eS9p9pYtBHzmmBRtLEsHrSvU
        6vZIV25qUsJZKCGaYsz/hohtKXdaVr26yyjVa10aSPEz6053HnII7C5rT6LouxoTrXhCOK
        6I0PHxbUwkESW8vS3xc9Re9T23l4R1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-6as0x4fZPmyVcerPo-GDhA-1; Wed, 15 Apr 2020 06:43:12 -0400
X-MC-Unique: 6as0x4fZPmyVcerPo-GDhA-1
Received: by mail-wr1-f69.google.com with SMTP id h14so10338971wrr.12
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2020 03:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pNKRF/g9GTKiJfx6XpsmKFnQkmViCDbB0eElZUOgBB0=;
        b=D6+Q8J24iXsQMbNMMMn8q0cu8PdLr2/8UXhHDVx6ligtt2AE44A9VNhOMM9eC8S8Vw
         lFJZFaFOlPJiZDRYNS45YeHAV5Y7UWGja0o3XV+f1BMz8O50e7FUKcdnVJ6x99BGVlEJ
         dXovXrvO78ZeJLkMXFhd1rVQUZqTWx8/L/Ds/C+yk4+aI9+KPaKZjNgWnDbBLVv20Ki5
         DO1sQV1mL+w7lovlg2na3yliazxYpMkbWwU76Zt1tlivmIn5mkxy7xKa3FKl2IJq86gd
         EsqVbrYnl3vlpCt7Qwu5yqlPlG4pJf4ngzcSq4ilviPeCbp8w3AZ7tnywsYYI0CJUAdR
         GQ8A==
X-Gm-Message-State: AGi0PuYZgOAIoV0NWJW73hb5h4dPrT+5bQbq/BTBBDEK48skJMX/Y1gL
        9DjcUEoMAo78RyZVXngOBp98RAUyBeXCFSuy2TKFW8vEjnZpOXguBintriLN2Y2JPHFLhAK8JMY
        2EmqlTXUtCePBaNCYZSWV4AI0
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4456051wme.75.1586947390579;
        Wed, 15 Apr 2020 03:43:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKhnKuWPRttaxxiCUXsxLxq1NvxVDqGPZoJ9Xtcgg2zFz4OAoyXX13siir7frpyClDWevEokw==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr4456039wme.75.1586947390362;
        Wed, 15 Apr 2020 03:43:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h2sm22873378wmf.34.2020.04.15.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:43:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to pointer primary_channel
In-Reply-To: <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
References: <20200414152343.243166-1-colin.king@canonical.com> <87d08axb7k.fsf@vitty.brq.redhat.com> <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
Date:   Wed, 15 Apr 2020 12:43:08 +0200
Message-ID: <87wo6hvxkz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Colin Ian King <colin.king@canonical.com> writes:

> On 14/04/2020 17:51, Vitaly Kuznetsov wrote:
>> Colin King <colin.king@canonical.com> writes:
>> 
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The pointer primary_channel is being assigned with a value that is never,
>>> The assignment is redundant and can be removed.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/hv/channel_mgmt.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>>> index ffd7fffa5f83..f7bbb8dc4b0f 100644
>>> --- a/drivers/hv/channel_mgmt.c
>>> +++ b/drivers/hv/channel_mgmt.c
>>> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>>>  
>>>  	if (channel->primary_channel == NULL) {
>>>  		list_del(&channel->listentry);
>>> -
>>> -		primary_channel = channel;
>>>  	} else {
>>>  		primary_channel = channel->primary_channel;
>>>  		spin_lock_irqsave(&primary_channel->lock, flags);
>> 
>> If I'm looking at the right source (5.7-rc1) it *is* beeing used:
>> 
>> 	if (channel->primary_channel == NULL) {
>> 		list_del(&channel->listentry);
>> 
>> 		primary_channel = channel;
>> 	} else {
>> 		primary_channel = channel->primary_channel;
>> 		spin_lock_irqsave(&primary_channel->lock, flags);
>> 		list_del(&channel->sc_list);
>> 		spin_unlock_irqrestore(&primary_channel->lock, flags);
>> 	}
>> 
>> 	/*
>> 	 * We need to free the bit for init_vp_index() to work in the case
>> 	 * of sub-channel, when we reload drivers like hv_netvsc.
>> 	 */
>> 	if (channel->affinity_policy == HV_LOCALIZED)
>> 		cpumask_clear_cpu(channel->target_cpu,
>> 				  &primary_channel->alloced_cpus_in_node);
>>                                    ^^^^^ HERE ^^^^^
>> 
>
> I was basing my change on linux-next that has removed a hunk of code:
>
> commit bcefa400900739310e8ef0cb34cbe029c404455c
> Author: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Date:   Mon Apr 6 02:15:11 2020 +0200
>
>     Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
> logic
>

Ah, please add the right 'Fixes:' tag then.

-- 
Vitaly

