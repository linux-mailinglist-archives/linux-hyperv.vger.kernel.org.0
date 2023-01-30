Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63405680C78
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjA3Lxy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 06:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjA3Lxx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 06:53:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47EC1350C;
        Mon, 30 Jan 2023 03:53:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t7so2446694wrp.5;
        Mon, 30 Jan 2023 03:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGloNujiL0CsgogRLovAVVyc6KEZFVadDdcOWuMAQsQ=;
        b=DV8o93oCQ73nQnF6DKwI5AzadrxQNopoi9mYTUm8VXhAF/qN4J/4O5a5pBBbHw9+dy
         ZtqDU02mUJOTkEW3lXS3R4n610Pein98fCIAQDcPn38n+/aaJTet9MP1WMw6Ww+6CLjl
         5+F6klm8htSBwuIFCZuPNW8wrPHaMMr5XyxIO55Z5H/9Xdgn0JQLD7q/ME/fr/X2RCIK
         mPYzzMe8sPJBT6nzlF/rTs46FncTH6ZMAuUjEgDxMl/Zh2q7TeWkqSU5R2ip/hnPFhMB
         8SAFIo3GB6loDpJxArn2vu8S4eiM5GYSaLAh0+spfd730xZq+zplUPNsNfLeEnYM21aw
         t2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGloNujiL0CsgogRLovAVVyc6KEZFVadDdcOWuMAQsQ=;
        b=f4N3SEpF4Mcj+lF7xc9uwHbUUos5kW2fYJvXxdPMVkZFMHbxWaZrvnuw1gK3qgKHmM
         V2/vyAntBKyu3L5saSNee6mVH8CP7pqQWQsM9SWEnXrML9BVbNPaQFya5KTH5FDAyqwP
         n+Mwe/FXYbGVTZgkfHd7QMDkxE7H4ghtn0AcNWGPaJhWf/0KU/oN7rKs3GhnCkhV0mRG
         d7P70Tb9zlEOwb2XD0BI6b6nsdbIieIppafHDwC4SAciKux6njudZ1n6TTDxw8OJv/Ze
         QGWcrCLdDES1KYS2B+UN9kEUUIOj0hD+5LRSzP+L4uk8bxRlHUXRVdUliHsxp4B0eXW9
         QasA==
X-Gm-Message-State: AO0yUKX3QQb7GO+IT5McX7rRE4nuwhm2rlQZxxpfSQhquLv4v+d4xDSo
        zKQATo6G9X/pAzX2pFGMpvQ=
X-Google-Smtp-Source: AK7set99aypYxsMEBlz2WZVjweCmV/hwIdnZNU+KENU9bagNUuU2UXoj/aDRU6yeJuS1ze7BTzlhow==
X-Received: by 2002:adf:f8cb:0:b0:2bf:b047:d4af with SMTP id f11-20020adff8cb000000b002bfb047d4afmr19424812wrq.5.1675079630213;
        Mon, 30 Jan 2023 03:53:50 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3cac.dip0.t-ipconnect.de. [217.234.60.172])
        by smtp.gmail.com with ESMTPSA id t27-20020adfa2db000000b002366553eca7sm11594342wra.83.2023.01.30.03.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:53:49 -0800 (PST)
Message-ID: <4a196e8f-cbc9-7453-6e36-aad458549e25@gmail.com>
Date:   Mon, 30 Jan 2023 12:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 6/9] HID: surface-hid: Constify lowlevel HID driver
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
 <20230130-hid-const-ll-driver-v1-6-3fc282b3b1d0@weissschuh.net>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230130-hid-const-ll-driver-v1-6-3fc282b3b1d0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 1/30/23 04:59, Thomas Weißschuh wrote:
> Since commit 52d225346904 ("HID: Make lowlevel driver structs const")
> the lowlevel HID drivers are only exposed as const.
> 
> Take advantage of this to constify the underlying structure, too.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/hid/surface-hid/surface_hid_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
> index 87637f813de2..a3e9cceddfac 100644
> --- a/drivers/hid/surface-hid/surface_hid_core.c
> +++ b/drivers/hid/surface-hid/surface_hid_core.c
> @@ -174,7 +174,7 @@ static int surface_hid_raw_request(struct hid_device *hid, unsigned char reportn
>   	return -EIO;
>   }
>   
> -static struct hid_ll_driver surface_hid_ll_driver = {
> +static const struct hid_ll_driver surface_hid_ll_driver = {
>   	.start       = surface_hid_start,
>   	.stop        = surface_hid_stop,
>   	.open        = surface_hid_open,
> 
