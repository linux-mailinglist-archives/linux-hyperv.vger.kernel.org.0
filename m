Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B1FC389
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2019 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKNKEV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Nov 2019 05:04:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbfKNKEV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Nov 2019 05:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573725861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLl4ACsFJPD0eyiByuCfJkYMTcF52xdC015U8Ny7BfU=;
        b=GcYwfx/I+OzQzQJZUwTG8OV5hNeOHG52pvBtpsjKOoR6zBuj8ov0Ajpfcx9ERMlMXBpQKa
        soWZPp3wjbafCFFRi7napMIy7aEd+KNKvHHFYobUSggpjAbkMvBkdyVCQVJx/i2AC1yNnA
        fysMLeuXxv4NEx4287haCOiysR36GI8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-79-MCUFXMs6L77tFr_-MoQ-1; Thu, 14 Nov 2019 05:04:20 -0500
Received: by mail-wr1-f72.google.com with SMTP id p4so4072290wrw.15
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Nov 2019 02:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MIYY6vTJ40iNpcIA6nOMAvyesiyY+lIANTNB53LU3fw=;
        b=ard6tcYxeNcZFviIwXa+flovQUTq3IqRinY162Y0E/Y/idcKjigcT5Kyf4AgLho4ah
         e0MuLLIzB7g8XCo1G96X5yy7HKxjx7zn5VD1e3N3epx++BRWH7oJdg2hphsSkErvICu2
         M6wnSGrnQu6Kv1gTOisB9BM9Bg3UA/o+olNzT2LiJLywiFrRsqARLhHapK41eeQcMUEc
         jyuCa3f2QDQhMPYVtvEl47/fZKfjQQWwopQQAxKGwxH4tFkNjpHcMPqScVeBmjph47qI
         h55MDU0eicXmKpSlo2j3bwC3V3pgIs38BM8y/2AvzAe2C+kMLuvQQ0jsw/ivX09jxFzp
         lGXA==
X-Gm-Message-State: APjAAAUrCT1HB0Q4TgmH8GTwJ00n7Ov6jfuzhS7hQDC5lojFeUGEQkXw
        fKXbFD51qDftpToGtHnm3FxuemJesDyBc02eLDzA9HdXsgaKPLhMqvRQ+whpy4orF7VMiErz9Q3
        n34NU9jree6W30utSvsKKuvqT
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr7088527wrr.88.1573725858593;
        Thu, 14 Nov 2019 02:04:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOtVn0G+YuKxp+AJfhyXSauq4aTtil7UF2WPkekaphH4ARhSylyzFJu+uHYsv/QY5pO9f4yg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr7088501wrr.88.1573725858332;
        Thu, 14 Nov 2019 02:04:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y6sm6459803wrr.19.2019.11.14.02.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 02:04:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of Hyper-V synic
In-Reply-To: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
References: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
Date:   Thu, 14 Nov 2019 11:04:16 +0100
Message-ID: <87mucykc4f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 79-MCUFXMs6L77tFr_-MoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> The crash handler calls hv_synic_cleanup() to shutdown the
> Hyper-V synthetic interrupt controller.  But if the CPU
> that calls hv_synic_cleanup() has a VMbus channel interrupt
> assigned to it (which is likely the case in smaller VM sizes),
> hv_synic_cleanup() returns an error and the synthetic
> interrupt controller isn't shutdown.  While the lack of
> being shutdown hasn't caused a known problem, it still
> should be fixed for highest reliability.
>
> So directly call hv_synic_disable_regs() instead of
> hv_synic_cleanup(), which ensures that the synic is always
> shutdown.

Generally, when performing kdump doing as little work as possible is
always preferred and hv_synic_cleanup() does too much: taking mutex,
walking through channel list,...=20

Also, hv_synic_cleanup() was calling hv_stimer_cleanup() and we have a
second redundant invocation in hv_crash_handler().

>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 664a415..665920d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2305,7 +2305,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  =09vmbus_connection.conn_state =3D DISCONNECTED;
>  =09cpu =3D smp_processor_id();
>  =09hv_stimer_cleanup(cpu);
> -=09hv_synic_cleanup(cpu);
> +=09hv_synic_disable_regs(cpu);
>  =09hyperv_cleanup();
>  };

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

--=20
Vitaly

