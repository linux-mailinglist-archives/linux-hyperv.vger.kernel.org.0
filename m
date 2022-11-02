Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B52616030
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 10:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBJqV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBJqU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 05:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0223176
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Nov 2022 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667382317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DW2a/80J8hDerpO8ayxyonD3c6E1iUdSbhWZlEaOu5c=;
        b=OP9ZBS21JauMiqj2jqv6a43yEvWdJ0McCa0JXokqbN5UX3iAAXyFAqtS09jmXco2Hi3qTw
        i0wwS7s6wl5itmVZRwiaeKNygX+nVp7gCLZjy31xf1ZxBLCLAiLgFWYGcUT8UxHBE9gId8
        L5a5cwgRe483yx43XIZQTw0nvjW+m/w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-sCsOR8AZMWO06rARmBa13g-1; Wed, 02 Nov 2022 05:45:16 -0400
X-MC-Unique: sCsOR8AZMWO06rARmBa13g-1
Received: by mail-qk1-f199.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so14833203qko.17
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Nov 2022 02:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW2a/80J8hDerpO8ayxyonD3c6E1iUdSbhWZlEaOu5c=;
        b=CcxZoJpRanrH6dxniyQcUT/DPz8+DLuS8NNZ2y9ABxjbpbnQ/lJVdWUPOnl8aodZ7k
         ZBgA/XFcmMnf3MbE5CEsIGyj6dTzXhZNGfd7Sut7DAm0NP9VRs/E10NCDsEd6oLu7wHc
         Yh3P0DjUgfxJYmVC66RAwEeneI/FcAFrwASjjPTCdWr7+H1LBlxN7WXiN8OkR++LdlbW
         yXnDM93T+VfOsDUeCVi4YtpYjsQlZBk3M4+vEPtt/pCwO8w0tf1W0IrrX00UkxRsFVy6
         U7S46/Adb+k2mWI4R7MsGbCVT9muK5u+1+1efrKs0IioOAv0djDeVA/twCwVQ3AVFkq7
         Oy6g==
X-Gm-Message-State: ACrzQf3Lo++E9ZRP2NJ62aRtFyYuOAn9i3QbKfviAjSv55FrDkYt6LNN
        edwjymnzhXZALOrqIJ6pnsF8ZBoNWNeOulJM6OgPZ6ZZSyAZW7Vn7wruk7OpI6ISXhmmygyzOwn
        sDPN+XhSXVX3Q05oZ76uBsRQy
X-Received: by 2002:a0c:906e:0:b0:4bb:e024:53b5 with SMTP id o101-20020a0c906e000000b004bbe02453b5mr16117816qvo.39.1667382315414;
        Wed, 02 Nov 2022 02:45:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DBLvfnyHa64NTohsQ2JJkSO3mLcgL9P+qhtcouJauIw3nBBLEsYTgOuVHQoDiDy+GcHZILg==
X-Received: by 2002:a0c:906e:0:b0:4bb:e024:53b5 with SMTP id o101-20020a0c906e000000b004bbe02453b5mr16117805qvo.39.1667382315054;
        Wed, 02 Nov 2022 02:45:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a400400b006cdd0939ffbsm8126852qko.86.2022.11.02.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:45:14 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:45:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Frederic Dalleau <frederic.dalleau@docker.com>
Cc:     wei.liu@kernel.org, netdev@vger.kernel.org, haiyangz@microsoft.com,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        stephen@networkplumber.org, edumazet@google.com, kuba@kernel.org,
        arseny.krasnov@kaspersky.com, decui@microsoft.com
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
 <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
 <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 01, 2022 at 09:21:06PM +0100, Frederic Dalleau via Virtualization wrote:
>Hi Dexan, Stephano,
>
>This solution has been proposed here,
>https://lists.linuxfoundation.org/pipermail/virtualization/2022-August/062656.html

Ops, I missed it!

Did you use scripts/get_maintainer.pl?
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#select-the-recipients-for-your-patch

Since your patch should be reposted (hasn't been sent to 
netdev@vger.kernel.org, missing Fixes tag, etc.) and Dexuan's patch on 
the other hand is ready (I just reviewed it), can you test it and 
respond with your Tested-by?

I would like to give credit to both, so I asked to add your Reported-by 
to the Dexuan's patch.

Thanks,
Stefano

