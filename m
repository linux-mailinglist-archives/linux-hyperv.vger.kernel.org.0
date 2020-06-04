Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9A1EE91B
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2020 19:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFDRFi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Jun 2020 13:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgFDRFi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Jun 2020 13:05:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999AC08C5C0;
        Thu,  4 Jun 2020 10:05:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c12so6752683qkk.13;
        Thu, 04 Jun 2020 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1s+Pb16pv1Gt2bDnL169e1AM8Xj4PBoeGtJfzzqmg0=;
        b=kWRmb1F/c0Ll+ov/vXxNYVQuHIEHFMZjBqwXE3AtjgjdSe/9c4liVH3hneDQRuPCKj
         MyKOiJB0+7VxmsIDxYXxwFQNi/Zxprfpc2pmNEKDNigvVbl78OBOC2kv3TvYZYICCeKO
         WQq82CuaR7rezVzt+xRTQhSG8FpR0PhxdO+dly5yKkpwJh0D0/+s1exDwjx/RxNUrouO
         VmUa7JmfS4vMHyJGwZwPWXJRRHk1faU3e3HEkX15wM2UeoxAFcpCgVscpv9PBWMzay3l
         X+QWajiLLFc3uaGGbmIN0Sbql/exdoZPmdb2GTTKrmGYVcHvluMYK5txVH095cw4HIaL
         wwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1s+Pb16pv1Gt2bDnL169e1AM8Xj4PBoeGtJfzzqmg0=;
        b=jOtn8dyDFMhmZiAmEoJatIclBPun//TBcfAcsm6A2VthANRhmnNuLBsglAYnuhYy1h
         OdUZFsahv3ZXhPiAVSEJK4apg4oUaFIowLjDa1FZQ9R6QPANt8ZdycEYb27XrHXroewF
         rKrIHI12/4BjffOwDD+6190qbcrX+DKfH6LyiF9J9DiSW38YpvDiR89U2JJnMWkj0fky
         CUBwz3B4CRDzDNnG/k4haDAZN7D+I0Vt5ruoFH4R84xPdNgJWEG0zEPID7peLFz2gZp7
         d7nw3x7hyWJI5EIH09YMgJpkxmdalgAkSynNOZ/Zc1e8eBHkdQKq9ytbzRRSVUTXZUXR
         7cjA==
X-Gm-Message-State: AOAM5313WvX0RxX/CwugAw/Pk3jTj+A3cTkM7JpLIKLgHRMgcn6MFxX7
        bJML0eBziyyIctWvmkTaPGfRyeldYpqV9axECke6J/Mm
X-Google-Smtp-Source: ABdhPJxDscWfcQXe6GEfNz6VFXlDTFKCZ9rWEriz6wH/9VW6nQGW73AH9oqy/IMdQ0qC40JhyOXEwUaKjsSF93dl2Kc=
X-Received: by 2002:a05:620a:1321:: with SMTP id p1mr5739527qkj.476.1591290337698;
 Thu, 04 Jun 2020 10:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200604130406.108940-1-efremov@linux.com>
In-Reply-To: <20200604130406.108940-1-efremov@linux.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Thu, 4 Jun 2020 10:05:26 -0700
Message-ID: <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
To:     Denis Efremov <efremov@linux.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 4, 2020 at 6:06 AM Denis Efremov <efremov@linux.com> wrote:
>
> Use kzfree() instead of memset() with 0 followed by kfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/scsi/storvsc_drv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 072ed8728657..e5a19cd8a450 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2035,10 +2035,7 @@ static int storvsc_suspend(struct hv_device *hv_dev)
>
>         vmbus_close(hv_dev->channel);
>
> -       memset(stor_device->stor_chns, 0,
> -              num_possible_cpus() * sizeof(void *));
> -
> -       kfree(stor_device->stor_chns);
> +       kzfree(stor_device->stor_chns);
>         stor_device->stor_chns = NULL;
>
>         cpumask_clear(&stor_device->alloced_cpus);
> --
> 2.26.2

Hi Denis,
When I added the function storvsc_suspend() several months ago, somehow I forgot
to remove the unnecessary memset(). Sorry!

The buffer is recreated in storvsc_resume() -> storvsc_connect_to_vsp() ->
storvsc_channel_init() -> stor_device->stor_chns = kcalloc(...), so I believe
the memset() can be safely removed.  Can you please make a v2 patch for it
and Cc my corporate email "decui" (in To)?

Thanks,
Dexuan
