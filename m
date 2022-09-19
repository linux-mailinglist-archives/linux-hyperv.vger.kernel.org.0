Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9D5BD119
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Sep 2022 17:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiISPd1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Sep 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiISPdY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 11:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147028704
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Sep 2022 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663601602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWg8VC3Y2I+R8H0oWyV4jcW6qd/ETEFixpJMwEeGBEQ=;
        b=fpywNlCRTeuQ95XpDjEaPjiEDVnE1+gxOCoTT15sYJz5R3KEtIASbRv8xJSjXN7nrCw58y
        Zbf4xSpLzGCaKa12ce5RzY7vjUbdTAZoOrhO7jAccBAY9q7vVfaELVhg01POU266aCXAPa
        Q67E1mbtoO6dbRVuebPdgbzXyrBJ0xg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-OT6ew6feNZyFNNgrsSOBvA-1; Mon, 19 Sep 2022 11:33:18 -0400
X-MC-Unique: OT6ew6feNZyFNNgrsSOBvA-1
Received: by mail-ej1-f72.google.com with SMTP id sa22-20020a1709076d1600b0077bab1f70a3so8800849ejc.12
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Sep 2022 08:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=CWg8VC3Y2I+R8H0oWyV4jcW6qd/ETEFixpJMwEeGBEQ=;
        b=Wi/HxvgscsOg+47x5AwYlDBusDx7+YW1RpKefGyVr/U+oPw+fZmWf9zIiKD6JBs81D
         8fSxTNlQzrVf2m+8YC5krll2lC1sNZrRteT+id4B/OM7/MhZ6mFgqGoeVYht+AXNY8DK
         GE60oyPQmoi8ojx5FZ50VSfIvbG24mp63/b/ytYmiiD5cftBjQf+nqP81eqAMBHzvVaF
         WjyiyHZSjtxPYEGb1rzhwUA5pS2HUK9I79H4H7c/FcRcIs2PMS9byqJCad5mFjYyr3+H
         wV6W3RI0/akIb8vf9mEdYJ7utQ31xBEG5BaU4kjQ2BLdj9JjrAxvCcukhhTNaaoNKJI3
         ni0Q==
X-Gm-Message-State: ACrzQf0dK46eMASf/GLAeFRAH0DFCaoiO34ASVesxwycFehSDKnHDX1P
        SB60+h7579jIaRaV5q1LYdlmUe0EZooanho5IOwP4Y78R8KJLOEopYuP0y1MpId9tFo4LciTaOi
        HZrJ97GHlOwBxokessNAzNdCq
X-Received: by 2002:a17:906:8a52:b0:781:7aa7:9dde with SMTP id gx18-20020a1709068a5200b007817aa79ddemr2059399ejc.70.1663601597740;
        Mon, 19 Sep 2022 08:33:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jpBl4EP1V68hm/6NhmgPAuWQStwEK91hLMOo30kSRGmXQzpiq1jOr3grUtqbEYYMJJjDx3Q==
X-Received: by 2002:a17:906:8a52:b0:781:7aa7:9dde with SMTP id gx18-20020a1709068a5200b007817aa79ddemr2059386ejc.70.1663601597530;
        Mon, 19 Sep 2022 08:33:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906314700b007708130c287sm15627839eje.40.2022.09.19.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:33:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] asm-generic: Remove unnecessary =?utf-8?B?4oCYMA==?=
 =?utf-8?B?4oCZ?= values from guest_id
In-Reply-To: <20220919015136.3409-1-zeming@nfschina.com>
References: <20220919015136.3409-1-zeming@nfschina.com>
Date:   Mon, 19 Sep 2022 17:33:15 +0200
Message-ID: <878rmfpef8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Li zeming <zeming@nfschina.com> writes:

> The file variable is assigned guest_id, it does not need to be initialized.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  include/asm-generic/mshyperv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c05d2ce9b6cd..cd5ce86c218a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -108,7 +108,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>  static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
>  				       __u64 d_info2)
>  {
> -	__u64 guest_id = 0;
> +	__u64 guest_id;
>  
>  	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
>  	guest_id |= (d_info1 << 48);

The initializer is certainly not needed, however, if we are to do some
changes, let's be bold. Suggestions:

1) Stop using "__u64" type, "u64" is good enough.

2) Drop all the parameters from the function, both call sites look like

 generate_guest_id(0, LINUX_VERSION_CODE, 0);

3) Rename the function to make it clear it's Hyper-V related,
e.g. "hv_generate_guest_id()".

...

-- 
Vitaly

