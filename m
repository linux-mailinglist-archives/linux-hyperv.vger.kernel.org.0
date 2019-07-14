Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0568196
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2019 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfGNX26 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 14 Jul 2019 19:28:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39008 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfGNX26 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 14 Jul 2019 19:28:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so2565763pfn.6;
        Sun, 14 Jul 2019 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6KAVR1F7/0ozIyc//7JULJry/rfgfUfBuLa6gXIeNo=;
        b=jYOz8mdI16SkYEivjvTXT1h2jm17+C4ILDda+i7O+9hQNFPYBZ5bGuKuvPqnfxo4+5
         FIvDIxoZ9jX2cWxsVjzGFZ48z6/z1E03Fqadv2+8OIxEMQmKpFsMByv7iHOdata3kSwq
         Yan5LV1G6E/NlS9Wc6Um9IENeyNMQw42fWOPIsjjifQCvn2ttBQF1lOJL1VNvf124Fug
         YnCmXoq3EXDn+st/6xapH0M9Zb962mfSQOQV7onKb7MEp/BLs9M9+rQCLzH9NizuuBqp
         3inP06YXzAYR5OCaUzUqqPKR6HC3fh+cMdki6PERShnZ8GdylOJo4T8HUrl2XLSSxyl7
         beHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6KAVR1F7/0ozIyc//7JULJry/rfgfUfBuLa6gXIeNo=;
        b=ABsjpZeuypJ0Lbw65a+8BIzQ5mC4VTM+U1AvHGzi/7ntuMQtCIsefqXQ7/txBfYMz2
         sQKf47sZ9R11NUqM1+WACccTAVv5KJsgwUnayvKMzYlMtkBnPMiA3DkOWtM0/+hPeRMu
         H0stPMjR0CoJPAFdsnBMlh9lFPzza2mPma0R9GfuncsP/zb4Qid/e1q0BzXqEeh7RoWw
         tp0cvQwaQyp+/ldiE/CGhqNkiKm7w7I7nwgzu6mHogW5gpL8XIrt87SdXXC/2purTQGZ
         A6A2oazlSN1xnWOUe7kPe6enAQ/q4JQ2tR29moRCaTMJRp3AO+0dGUDQm1w6IApq2NwS
         tA0w==
X-Gm-Message-State: APjAAAWMBH19WsCG4xoVC4lwi/W97Kyc0uzo3faDuYNgAFDymUiPZm6D
        7AUghtWM+KR2QNbxxU49TUjqgzzUxXQ=
X-Google-Smtp-Source: APXvYqzLX4e3PLlnd1x9G6Rbsj7ZjEgR4c3ntliAFe++AmMMcc/LOic+IYSaBEvXxnIcvdMMguTwsg==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr25118731pjt.108.1563146937584;
        Sun, 14 Jul 2019 16:28:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h26sm15781173pfq.64.2019.07.14.16.28.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 16:28:56 -0700 (PDT)
Date:   Sun, 14 Jul 2019 16:28:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] Input: hv: Remove dependencies on PAGE_SIZE for
 ring buffer
Message-ID: <20190714232854.GA41479@dtor-ws>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
 <5af419d636506d9d87ab7d2650fa800ead91a29a.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5af419d636506d9d87ab7d2650fa800ead91a29a.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 12, 2019 at 08:30:27AM +0000, Maya Nakamura wrote:
> Define the ring buffer size as a constant expression because it should
> not depend on the guest page size.
> 
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied, thank you.

> ---
>  drivers/input/serio/hyperv-keyboard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 8e457e50f837..88ae7c2ac3c8 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -75,8 +75,8 @@ struct synth_kbd_keystroke {
>  
>  #define HK_MAXIMUM_MESSAGE_SIZE 256
>  
> -#define KBD_VSC_SEND_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
> -#define KBD_VSC_RECV_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
> +#define KBD_VSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
> +#define KBD_VSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
>  
>  #define XTKBD_EMUL0     0xe0
>  #define XTKBD_EMUL1     0xe1
> -- 
> 2.17.1
> 

-- 
Dmitry
