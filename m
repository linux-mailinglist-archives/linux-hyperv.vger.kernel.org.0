Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C92688FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgINKJw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 06:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgINKJp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600078184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkR2wFIeHykLu1I53wtenqdg5Hq76Lrpn7XVwBMj+gs=;
        b=NEwxf+B6/JWX4qfiG240/B+RG8zmZLe4lfoR4a7F0biHTkXvhy2AiEl8Wqci2uaH3g9IyV
        bvQeJaggaAZ+uZR0XzvzfRruOX2I9JKg5iBozxtJQ3sHUfwb/DR1AQ9o7Og7d7S+K0VoPE
        89AniFaCO0U23q9MVqDhmnTnGFJyaZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-EIlS8AYfPuqlOK9bMNOLiQ-1; Mon, 14 Sep 2020 06:09:39 -0400
X-MC-Unique: EIlS8AYfPuqlOK9bMNOLiQ-1
Received: by mail-wm1-f70.google.com with SMTP id u5so2295853wme.3
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Sep 2020 03:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BkR2wFIeHykLu1I53wtenqdg5Hq76Lrpn7XVwBMj+gs=;
        b=p7huzuysu9xYzKsPdXSCxrmDZ5EEplu6nfJ+0XUCQOHxhwp/UXPysTb3NYcEWSNlUl
         j6Q92zeJjqtr9wl827YpwWnKND1CbXV47nSG7vq5qsAyZrP3G8e2ZoYX0hOBZTO9z0B3
         FCuTJf37YO/Kr5zBMuiy28hFFQGjjv8R12kA9AEL+k9UcOstUh8IIzORq2c5sjBid4Vl
         HycDSBceqV2iyPN6bPWmsXHERu0gF1ZtOTWreVV68EDV5dkSYqwXNPVXBXE8hbQ5Fwb4
         xHox9gx2eo032FYKsrrrv4r5pDinMvSwrJd7miw0jOsX6Ae0AdoK+lzsQ7loCgXv+e5s
         rOqA==
X-Gm-Message-State: AOAM532MdzhM9HQlkF4pFk27aUbocbFdy+PHETG/AOVTYW8z9xh+k4Y3
        UnHYEt9VHoj1iRXQOPAQHfuR5xDkckVs8pFJbMZM64sMnHTzYxM2QtA98uwdn+YGCWPZee8BUO1
        k3+EUZIsP4XYJ9kNjVt5n1Nup
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr14987105wrs.274.1600078177977;
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/ToRxQvrK1r21O6lGoGYyx4hT44wtlqfX0pqKBwFRdmqFFC82RD0AME4+CcGVMmoWPlEghg==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr14987077wrs.274.1600078177779;
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 185sm19860640wma.18.2020.09.14.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:09:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH 1/1] Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload
In-Reply-To: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
References: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 14 Sep 2020 12:09:36 +0200
Message-ID: <87imcgllen.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> vmbus_wait_for_unload() looks for a CHANNELMSG_UNLOAD_RESPONSE message
> coming from Hyper-V.  But if the message isn't found for some reason,
> the panic path gets hung forever.  Add a timeout of 10 seconds to prevent
> this.

If I remember correctly, the problem I was observing back then was that
if CHANNELMSG_UNLOAD_RESPONSE is not delivered, Hyper-V won't respond to
the consequent CHANNELMSG_INITIATE_CONTACT/CHANNELMSG_REQUESTOFFERS
(don't remember exactly) so we either hang here or crash in the kdump
kernel because we can't find any devices. Maybe the problem was only
with some ancient Hyper-V versions or it was fixed.

>
> Fixes: 415719160de3 ("Drivers: hv: vmbus: avoid scheduling in interrupt context in vmbus_initiate_unload()")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 591106c..1d44bb6 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -731,7 +731,7 @@ static void vmbus_wait_for_unload(void)
>  	void *page_addr;
>  	struct hv_message *msg;
>  	struct vmbus_channel_message_header *hdr;
> -	u32 message_type;
> +	u32 message_type, i;
>  
>  	/*
>  	 * CHANNELMSG_UNLOAD_RESPONSE is always delivered to the CPU which was
> @@ -741,8 +741,11 @@ static void vmbus_wait_for_unload(void)
>  	 * functional and vmbus_unload_response() will complete
>  	 * vmbus_connection.unload_event. If not, the last thing we can do is
>  	 * read message pages for all CPUs directly.
> +	 *
> +	 * Wait no more than 10 seconds so that the panic path can't get
> +	 * hung forever in case the response message isn't seen.
>  	 */
> -	while (1) {
> +	for (i = 0; i < 1000; i++) {
>  		if (completion_done(&vmbus_connection.unload_event))
>  			break;

LGTM,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

