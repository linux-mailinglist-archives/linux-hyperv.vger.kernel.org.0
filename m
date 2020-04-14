Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0306E1A85E9
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440698AbgDNQvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 12:51:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441028AbgDNQvS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 12:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586883077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEwW/84Bx+Wn4UVzdKy29mX/tgdsrLXZkRwHZ2M75ns=;
        b=AH+xoIgYnCAHv9ZmXyrRI2RLrNizErROBc4D/B1HKpjc7Y5kx/14yCp10LLIRWYM+pqYdK
        VBrZONbC1bnufWaQb1QR9uDQKdlF2n9PS/HkQy0BLIzdr5QerGx5MUljpne60GirQ5pLHD
        ls2lCzuWwHwMZ8vnkY4NbwcUjBERNls=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-O5gqPsLsMrKzUxuQPsaPew-1; Tue, 14 Apr 2020 12:51:15 -0400
X-MC-Unique: O5gqPsLsMrKzUxuQPsaPew-1
Received: by mail-wr1-f70.google.com with SMTP id r17so9019707wrg.19
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Apr 2020 09:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xEwW/84Bx+Wn4UVzdKy29mX/tgdsrLXZkRwHZ2M75ns=;
        b=jTwhqTuQZRvc6EsOh90aRLxf9rdLunurZ7O87anrEUaCP7A93/HuEkeYNPGqfBR/zC
         YviC378fumR5FVKSBoIRRJfdAGxo/hI9UguWdNHK/WV4NxIt59X5ES4vGpnrro3PN9jt
         EJeJGGjzI8lWbmBJTVzwwWzFslPKXKIeAGvLnqGDGiIVgbcObLj1mrQx0rc5X19DJKN3
         0buu3tB3STwDd4Hh0iSOBcI/4t7ZBkXIShco+t0WWwb2nQMlXLyc8dAIQlMTbQW+6vO/
         aQAGwLLAy5ctzBOsp6gsrsXWZYDH1gJ9SEl9/n03JRpxuacUX4jbCLLsrdFNEn5nyPhz
         rdgQ==
X-Gm-Message-State: AGi0PuYSfGlNGpeOPeiFoSy+2BGdUm544iy3leDIiLXhoddIujMOQ3+z
        y8mFIe7D4RCdI45Dv+pFV6+J7RrNiLCPYq8kcfytS2Kxyk8MDTvVXsMyIjRitu1YJDbcguNnpo4
        6S/qQDtzmE19guT1kAwbdVcz0
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr809881wmo.118.1586883073922;
        Tue, 14 Apr 2020 09:51:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJCdYCN7qTchgvOqHA8okoWjFJVzrdCxgqqIR560y3Z2b+3g4AVFAj455QlShPovTl9i6iVNA==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr809859wmo.118.1586883073583;
        Tue, 14 Apr 2020 09:51:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t20sm9185423wmi.2.2020.04.14.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:51:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to pointer primary_channel
In-Reply-To: <20200414152343.243166-1-colin.king@canonical.com>
References: <20200414152343.243166-1-colin.king@canonical.com>
Date:   Tue, 14 Apr 2020 18:51:11 +0200
Message-ID: <87d08axb7k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer primary_channel is being assigned with a value that is never,
> The assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hv/channel_mgmt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ffd7fffa5f83..f7bbb8dc4b0f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>  
>  	if (channel->primary_channel == NULL) {
>  		list_del(&channel->listentry);
> -
> -		primary_channel = channel;
>  	} else {
>  		primary_channel = channel->primary_channel;
>  		spin_lock_irqsave(&primary_channel->lock, flags);

If I'm looking at the right source (5.7-rc1) it *is* beeing used:

	if (channel->primary_channel == NULL) {
		list_del(&channel->listentry);

		primary_channel = channel;
	} else {
		primary_channel = channel->primary_channel;
		spin_lock_irqsave(&primary_channel->lock, flags);
		list_del(&channel->sc_list);
		spin_unlock_irqrestore(&primary_channel->lock, flags);
	}

	/*
	 * We need to free the bit for init_vp_index() to work in the case
	 * of sub-channel, when we reload drivers like hv_netvsc.
	 */
	if (channel->affinity_policy == HV_LOCALIZED)
		cpumask_clear_cpu(channel->target_cpu,
				  &primary_channel->alloced_cpus_in_node);
                                   ^^^^^ HERE ^^^^^

-- 
Vitaly

