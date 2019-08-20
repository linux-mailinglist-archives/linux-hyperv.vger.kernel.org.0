Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF7954F6
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHTDSK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 23:18:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40512 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTDSK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 23:18:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so2345575pgj.7;
        Mon, 19 Aug 2019 20:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5e6eaDGk/6j5T5h1NKftcrs+tBj3G4/S+VohjD6nD6U=;
        b=WVls6EByLVpXNPmLfFFZy/d/Vw1FhdBighDj3pt2mLWCZqhhVzfbnZBGKil4hoXHeI
         W/5hA7gbP5Lyi5p7tTtPNYOmTvdxJOfKC9E+k3YA2bwI4G9ctxI3oJBbLgkiNLeykE9G
         I7PTjVUzm0iOu9i3yFBBInlEt9vtOS+3UN+R3bKT1FrHwzxxUvzh52Fb97to8j/K0ba6
         gugPzQURBScEZdhvpXbsMVQWYk6a9FQ1DQ//67gxp6e6gjk1q7CHdTndhKTXI46pcLD9
         lTtfhLQQxFtRzIsAHObwBzQyv5DOaLjqGS9ArSayYNcGm2/3YgSWdsJs9q6UVXJzlel6
         IrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5e6eaDGk/6j5T5h1NKftcrs+tBj3G4/S+VohjD6nD6U=;
        b=hdw1eVAV+NQ+h500UTNBVXww6uGCn7NRgdpBn5w2/KOWdbsddI7OJP2AaD/oRktb0K
         Gev7lOywCY41x3R0vvirKRgpTegvu1ZMSyHXdulIiy3hbKQVWRwuSVZq/BnA8Eas/GYZ
         8p7EWUs7z4vXY0YftZuMNoqGAjS/kBMt6pO0Q/Ds2v7rEBrtRlbJziStBrEgu+ogad24
         i030suyToEBFjuAGE4H9phzWSsl/NufOC9wpC6ectUcE2mBneFfKL3YUwHq06QkHENz4
         QTwwiZkyTS7f58umaDGcvrUK3+mouICshrxrvq/vLHzJtSmbmadQnMqWaKL2Y9gzPG9X
         6fUQ==
X-Gm-Message-State: APjAAAVpvwCjbLW0lDgN3TlKOKNHu+60xqxDs/ueagZXLMp3FxvnmDxO
        LFFybkaqR8c5yPiz4pQROJE=
X-Google-Smtp-Source: APXvYqzIxDeuruppnpbEE0Lz3eELVRgwuAlSlZ6eXS+PP+RSzTHa/+wnpV9TezWBvzTJXrb5dE4ZLg==
X-Received: by 2002:a17:90a:ac0a:: with SMTP id o10mr4476048pjq.143.1566271088648;
        Mon, 19 Aug 2019 20:18:08 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t7sm17671364pfh.101.2019.08.19.20.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:18:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 20:18:05 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Message-ID: <20190820031805.GO121898@dtor-ws>
References: <1566270066-27546-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566270066-27546-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 20, 2019 at 03:01:23AM +0000, Dexuan Cui wrote:
> Simplify the ring buffer handling with the in-place API.
> 
> Also avoid the dynamic allocation and the memory leak in the channel
> callback function.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Hi Dmitry, can this patch go through Sasha's hyperv tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> 
> This is a purely Hyper-V specific change.

Sure, no problem.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
>  drivers/input/serio/hyperv-keyboard.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 88ae7c2..e486a8a 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -237,40 +237,17 @@ static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
>  
>  static void hv_kbd_on_channel_callback(void *context)
>  {
> +	struct vmpacket_descriptor *desc;
>  	struct hv_device *hv_dev = context;
> -	void *buffer;
> -	int bufferlen = 0x100; /* Start with sensible size */
>  	u32 bytes_recvd;
>  	u64 req_id;
> -	int error;
>  
> -	buffer = kmalloc(bufferlen, GFP_ATOMIC);
> -	if (!buffer)
> -		return;
> -
> -	while (1) {
> -		error = vmbus_recvpacket_raw(hv_dev->channel, buffer, bufferlen,
> -					     &bytes_recvd, &req_id);
> -		switch (error) {
> -		case 0:
> -			if (bytes_recvd == 0) {
> -				kfree(buffer);
> -				return;
> -			}
> -
> -			hv_kbd_handle_received_packet(hv_dev, buffer,
> -						      bytes_recvd, req_id);
> -			break;
> +	foreach_vmbus_pkt(desc, hv_dev->channel) {
> +		bytes_recvd = desc->len8 * 8;
> +		req_id = desc->trans_id;
>  
> -		case -ENOBUFS:
> -			kfree(buffer);
> -			/* Handle large packet */
> -			bufferlen = bytes_recvd;
> -			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
> -			if (!buffer)
> -				return;
> -			break;
> -		}
> +		hv_kbd_handle_received_packet(hv_dev, desc, bytes_recvd,
> +					      req_id);
>  	}
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
Dmitry
