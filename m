Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B105AE3B3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Sep 2022 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiIFJBS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Sep 2022 05:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiIFJBQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Sep 2022 05:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986343341D
        for <linux-hyperv@vger.kernel.org>; Tue,  6 Sep 2022 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662454869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEYw8dkEXgcUOX7V93X65x+uXJi/wlkI4CEWgXjX+U8=;
        b=HCy7yX2g3zQ21ogmXk2HBdo3eDlohLM6I8mLQnIm+arDizqejXvUVGgvxyMxhC6/gTs3aT
        T37L2H9cLSCzb+CzPtQAXRg+bsk/GFsCgZwa43kTPML6uO1AGRCToyPFbHrNJnbFJyN4Pe
        4D53aQ93z+j9a0jG8O5TrlwfYaW/zrk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-1wi3PfLNPmiha9q-9y6F_g-1; Tue, 06 Sep 2022 05:01:06 -0400
X-MC-Unique: 1wi3PfLNPmiha9q-9y6F_g-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso8634581qkp.21
        for <linux-hyperv@vger.kernel.org>; Tue, 06 Sep 2022 02:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uEYw8dkEXgcUOX7V93X65x+uXJi/wlkI4CEWgXjX+U8=;
        b=TfSZU7IDt72mhirf38jXRDfurfZPHLC2RJRDSK+l8lyv2b5YiT419lN4yfDhUq40Si
         BpfDVSG9yEMkObNMZ25L3S2UOWoYOSL5FzNiAm8BGQTVGKGuy30ZpiIXZCQLGcq9Psi+
         gG8TeGTG20dLXLBvdfRYCn4/wzcoZH1vqzKMLsywKFLKQO/ObKi3udShCIGk15kGpPxD
         G2fYXP2AOjvormxk7AaKlvBK1HQxaAKGWeT9MMfL5lBfZ3xDZf9MY9kxSUB3zGU+aT/a
         3Vu5imhJzlyICXT/ldK7aCWxWtS00qD1pKbe5f4BldZ3oohK7YmTecY6uROmFfskuHxG
         0Q9w==
X-Gm-Message-State: ACgBeo07vLlmHIHSr+SScz/gejdXDfbKDyHMhNlm94HvDVSOPh3N//Xt
        prUMWuoSpqejfXgTEfkrBwC4ebZhru/ZqL1qHSHX1b5yMDWTWr4dsgvfBFSbLj+CsJXxcRppk7Y
        e31mfAOVGXZocnqLAtAcsXVyF
X-Received: by 2002:a05:620a:4711:b0:6bb:7e1b:5f0b with SMTP id bs17-20020a05620a471100b006bb7e1b5f0bmr33657202qkb.127.1662454866188;
        Tue, 06 Sep 2022 02:01:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54SeftazVhGuQR9Denza8esCRyPUSRNGJRsOYWXZ1aLyu1Zb25CEzZerEVP/BwXWQhYQ8KcQ==
X-Received: by 2002:a05:620a:4711:b0:6bb:7e1b:5f0b with SMTP id bs17-20020a05620a471100b006bb7e1b5f0bmr33657178qkb.127.1662454865958;
        Tue, 06 Sep 2022 02:01:05 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id z20-20020ac87cb4000000b0031f36cd1958sm8888786qtv.81.2022.09.06.02.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:01:04 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:00:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220906090048.xdwdnxy3dvuos36x@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220817025250-mutt-send-email-mst@kernel.org>
 <3abb1be9-b12c-e658-0391-8461e28f1b33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3abb1be9-b12c-e658-0391-8461e28f1b33@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 18, 2022 at 12:28:48PM +0800, Jason Wang wrote:
>
>在 2022/8/17 14:54, Michael S. Tsirkin 写道:
>>On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
>>>Hey everybody,
>>>
>>>This series introduces datagrams, packet scheduling, and sk_buff usage
>>>to virtio vsock.
>>>
>>>The usage of struct sk_buff benefits users by a) preparing vsock to use
>>>other related systems that require sk_buff, such as sockmap and qdisc,
>>>b) supporting basic congestion control via sock_alloc_send_skb, and c)
>>>reducing copying when delivering packets to TAP.
>>>
>>>The socket layer no longer forces errors to be -ENOMEM, as typically
>>>userspace expects -EAGAIN when the sk_sndbuf threshold is reached and
>>>messages are being sent with option MSG_DONTWAIT.
>>>
>>>The datagram work is based off previous patches by Jiang Wang[1].
>>>
>>>The introduction of datagrams creates a transport layer fairness issue
>>>where datagrams may freely starve streams of queue access. This happens
>>>because, unlike streams, datagrams lack the transactions necessary for
>>>calculating credits and throttling.
>>>
>>>Previous proposals introduce changes to the spec to add an additional
>>>virtqueue pair for datagrams[1]. Although this solution works, using
>>>Linux's qdisc for packet scheduling leverages already existing systems,
>>>avoids the need to change the virtio specification, and gives additional
>>>capabilities. The usage of SFQ or fq_codel, for example, may solve the
>>>transport layer starvation problem. It is easy to imagine other use
>>>cases as well. For example, services of varying importance may be
>>>assigned different priorities, and qdisc will apply appropriate
>>>priority-based scheduling. By default, the system default pfifo qdisc is
>>>used. The qdisc may be bypassed and legacy queuing is resumed by simply
>>>setting the virtio-vsock%d network device to state DOWN. This technique
>>>still allows vsock to work with zero-configuration.
>>The basic question to answer then is this: with a net device qdisc
>>etc in the picture, how is this different from virtio net then?
>>Why do you still want to use vsock?
>
>
>Or maybe it's time to revisit an old idea[1] to unify at least the 
>driver part (e.g using virtio-net driver for vsock then we can all 
>features that vsock is lacking now)?

Sorry for coming late to the discussion!

This would be great, though, last time I had looked at it, I had found 
it quite complicated. The main problem is trying to avoid all the 
net-specific stuff (MTU, ethernet header, HW offloading, etc.).

Maybe we could start thinking about this idea by adding a new transport 
to vsock (e.g. virtio-net-vsock) completely separate from what we have 
now.

Thanks,
Stefano

