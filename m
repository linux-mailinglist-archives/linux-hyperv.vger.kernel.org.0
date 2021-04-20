Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE75366095
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhDTUEv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 16:04:51 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:60072 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233541AbhDTUEt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 16:04:49 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:04:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id A2798180A4912
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Apr 2021 19:58:54 +0000 (UTC)
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6E69C181D3030;
        Tue, 20 Apr 2021 19:58:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id F010F1727C;
        Tue, 20 Apr 2021 19:58:49 +0000 (UTC)
Message-ID: <c5de33a3cd1dc18688fc2bb7cf6a84aedcc5a041.camel@perches.com>
Subject: Re: [PATCH 1/1] video: hyperv_fb: Add ratelimit on error message
From:   Joe Perches <joe@perches.com>
To:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Tue, 20 Apr 2021 12:58:48 -0700
In-Reply-To: <1618933459-10585-1-git-send-email-mikelley@microsoft.com>
References: <1618933459-10585-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: F010F1727C
X-Spam-Status: No, score=0.10
X-Stat-Signature: wp7o7gzq7pg8kxru5xh3thy9zy7qob7b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19dJn8qDTGT/B7MaqDP5Xqh09MwTqzF5cI=
X-HE-Tag: 1618948729-943129
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2021-04-20 at 08:44 -0700, Michael Kelley wrote:
> Due to a full ring buffer, the driver may be unable to send updates to
> the Hyper-V host.  But outputing the error message can make the problem
> worse because console output is also typically written to the frame
> buffer.  As a result, in some circumstances the error message is output
> continuously.
> 
> Break the cycle by rate limiting the error message.  Also output
> the error code for additional diagnosability.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

None of the callers of this function ever check the return status.
Why is important/useful to emit this message at all?

> ---
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 4dc9077..a7e6eea 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -308,7 +308,7 @@ static inline int synthvid_send(struct hv_device *hdev,
>  			       VM_PKT_DATA_INBAND, 0);
>  
> 
>  	if (ret)
> -		pr_err("Unable to send packet via vmbus\n");
> +		pr_err_ratelimited("Unable to send packet via vmbus; error %d\n", ret);
>  
> 
>  	return ret;
>  }


