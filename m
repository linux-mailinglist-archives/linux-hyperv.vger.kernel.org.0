Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C95969E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Aug 2022 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiHQGyq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Aug 2022 02:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiHQGyp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Aug 2022 02:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DFF5F9A5
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Aug 2022 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660719282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcPD4jBG73lQXOoH43Q6tPWaFdDfYRto/2dXXxDgwek=;
        b=Zj2pAXsd4q69s+qQo6qi6ije2FgY75UDnmqKiMWMoFDh599/FBQeWmT/UAMK04B9pZnFxy
        i1L0GSP25ua2Qtuua4vq6+hcurd146GFHJnq5NGsYuziLH5/uq32SEHy0kEYLG2hAclIBh
        OaAXxEUqosw7AGgRjVQgSRllOBzaygo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-S8xpjImmPdm4sNQGel8qVw-1; Wed, 17 Aug 2022 02:54:40 -0400
X-MC-Unique: S8xpjImmPdm4sNQGel8qVw-1
Received: by mail-wr1-f70.google.com with SMTP id o3-20020adfa103000000b0022514e8e99bso815684wro.19
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Aug 2022 23:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zcPD4jBG73lQXOoH43Q6tPWaFdDfYRto/2dXXxDgwek=;
        b=O5h6ngOlDe8Wl2XGKYota9NI4zb4Y5zSHRVuS09b0bgU59xWdnJNl7YIuR2pvwHCYS
         p4plDC7iPRoKxEX0y6hLRaNZXSmOGX075YZN4FkccrQXFHrkzQ6TKnxccF2sLyVyjMof
         J13iR5nkyZE/fh/q1wjxl6RpgtrwuS5OG8Z6bKBzyjVHEaVCmm/aTfGPEqO9T+7fVLQ4
         DcQL/ZZuWjMMBFMhcgRQz37hWWPfmtM6G91vS3gD7NEfUdt/v+zg9Yia/KK8yeinZSFH
         LQxn4lgbCCFZuktWbjpvKEs/phgSfDjmxGKk6wBaqeYhUUaaXq7XGX472SJuWmzykGL0
         rfOQ==
X-Gm-Message-State: ACgBeo2ITrJ865SRJrmr7ijlpsBGBpP/vTGPZ0J73ryvexXJvm/DC7FE
        nEPanTHB8/eydO0jj6LaAur9KUELHSBLLqpFUnEYMZmLPMzSVvnXU/Ryhd9k9YXQlSePPltPbKA
        GfDjx7suaD6qMLC6zvJp4HLWI
X-Received: by 2002:adf:d1c9:0:b0:225:f98:d602 with SMTP id b9-20020adfd1c9000000b002250f98d602mr5595055wrd.419.1660719279678;
        Tue, 16 Aug 2022 23:54:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71mbO/1JAgp957U1l5Y2ejH9W2IMsrKo6NRUtwq9BrlZgJpVzkNJv+ewui/k38InlrBVqC/w==
X-Received: by 2002:adf:d1c9:0:b0:225:f98:d602 with SMTP id b9-20020adfd1c9000000b002250f98d602mr5595029wrd.419.1660719279393;
        Tue, 16 Aug 2022 23:54:39 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm1288244wmg.5.2022.08.16.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:54:38 -0700 (PDT)
Date:   Wed, 17 Aug 2022 02:54:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20220817025250-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
> Hey everybody,
> 
> This series introduces datagrams, packet scheduling, and sk_buff usage
> to virtio vsock.
> 
> The usage of struct sk_buff benefits users by a) preparing vsock to use
> other related systems that require sk_buff, such as sockmap and qdisc,
> b) supporting basic congestion control via sock_alloc_send_skb, and c)
> reducing copying when delivering packets to TAP.
> 
> The socket layer no longer forces errors to be -ENOMEM, as typically
> userspace expects -EAGAIN when the sk_sndbuf threshold is reached and
> messages are being sent with option MSG_DONTWAIT.
> 
> The datagram work is based off previous patches by Jiang Wang[1].
> 
> The introduction of datagrams creates a transport layer fairness issue
> where datagrams may freely starve streams of queue access. This happens
> because, unlike streams, datagrams lack the transactions necessary for
> calculating credits and throttling.
> 
> Previous proposals introduce changes to the spec to add an additional
> virtqueue pair for datagrams[1]. Although this solution works, using
> Linux's qdisc for packet scheduling leverages already existing systems,
> avoids the need to change the virtio specification, and gives additional
> capabilities. The usage of SFQ or fq_codel, for example, may solve the
> transport layer starvation problem. It is easy to imagine other use
> cases as well. For example, services of varying importance may be
> assigned different priorities, and qdisc will apply appropriate
> priority-based scheduling. By default, the system default pfifo qdisc is
> used. The qdisc may be bypassed and legacy queuing is resumed by simply
> setting the virtio-vsock%d network device to state DOWN. This technique
> still allows vsock to work with zero-configuration.

The basic question to answer then is this: with a net device qdisc
etc in the picture, how is this different from virtio net then?
Why do you still want to use vsock?

> In summary, this series introduces these major changes to vsock:
> 
> - virtio vsock supports datagrams
> - virtio vsock uses struct sk_buff instead of virtio_vsock_pkt
>   - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_skb,
>     which applies the throttling threshold sk_sndbuf.
> - The vsock socket layer supports returning errors other than -ENOMEM.
>   - This is used to return -EAGAIN when the sk_sndbuf threshold is
>     reached.
> - virtio vsock uses a net_device, through which qdisc may be used.
>  - qdisc allows scheduling policies to be applied to vsock flows.
>   - Some qdiscs, like SFQ, may allow vsock to avoid transport layer congestion. That is,
>     it may avoid datagrams from flooding out stream flows. The benefit
>     to this is that additional virtqueues are not needed for datagrams.
>   - The net_device and qdisc is bypassed by simply setting the
>     net_device state to DOWN.
> 
> [1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.wang@bytedance.com/
> 
> Bobby Eshleman (5):
>   vsock: replace virtio_vsock_pkt with sk_buff
>   vsock: return errors other than -ENOMEM to socket
>   vsock: add netdev to vhost/virtio vsock
>   virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>   virtio/vsock: add support for dgram
> 
> Jiang Wang (1):
>   vsock_test: add tests for vsock dgram
> 
>  drivers/vhost/vsock.c                   | 238 ++++----
>  include/linux/virtio_vsock.h            |  73 ++-
>  include/net/af_vsock.h                  |   2 +
>  include/uapi/linux/virtio_vsock.h       |   2 +
>  net/vmw_vsock/af_vsock.c                |  30 +-
>  net/vmw_vsock/hyperv_transport.c        |   2 +-
>  net/vmw_vsock/virtio_transport.c        | 237 +++++---
>  net/vmw_vsock/virtio_transport_common.c | 771 ++++++++++++++++--------
>  net/vmw_vsock/vmci_transport.c          |   9 +-
>  net/vmw_vsock/vsock_loopback.c          |  51 +-
>  tools/testing/vsock/util.c              | 105 ++++
>  tools/testing/vsock/util.h              |   4 +
>  tools/testing/vsock/vsock_test.c        | 195 ++++++
>  13 files changed, 1176 insertions(+), 543 deletions(-)
> 
> -- 
> 2.35.1

