Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862EF73A5CC
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFVQNK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVQNJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 12:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57551BD9
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jun 2023 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687450338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
        b=NgQ7Dbu3qmM0+3ctrDymBwaWdVhXqqMEP3G8Y3sOWrlX2kjQXo5IzGhHhH45S/sfh6eBCa
        HAlGfqyrCSLLjOLQTMLbA9YiWDMTi1JNDdYibWjfqb1h2Cw/DVXt0cxjsqzQeCPXi0qVOT
        eDzoW3CSPQSQj99CdG8DNgeloo1qAo0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-wprQhOUSMDyXPaEU8uL2mw-1; Thu, 22 Jun 2023 12:09:28 -0400
X-MC-Unique: wprQhOUSMDyXPaEU8uL2mw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1d8fa4629so58734521fa.0
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jun 2023 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450156; x=1690042156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
        b=jgh5lpcoFBfdwxVI5y+I8WeuvP8mZqbrE0kVXOc+HHtMh+7+HHLWHMjQRdJmaHVm8F
         14GF4foBOSVM/cA2W4VD0xdWa4ly41ZftyuDL81/U5RCzDkEjuEv//QVtnjf1OX+MiYh
         5EEb37LUGJKCiQ97jzgpgr/OdIpb0HS86Qleux6Y58nB1eUK8O9RstBJ4YMADv8TyTcf
         iWlsX+Atgdt8iXOUJV2vi4mrPESkhRrIOFO2+JHvspVwNSWa5EpByGlBs7r84nWbltT9
         5qeM+VgT5YO9k+6tWkVJ+HYMemMgu9zudl+c6iWon/V6+Zjw+jXTgrN4oPeTjoRKI3lY
         83dQ==
X-Gm-Message-State: AC+VfDwMl0gA22N0KpdHiTWh44MVa8ny0OxEsBaz71NeBbNLGXFv9d3S
        aJnktA4PfcrO03sy8ByUswnUhNvvul0aCH5Ld4t/VLUoyfUvaCREwjp+1Dxho80Tms5F1CzQoty
        ew35+k5lj8Ox5hTm1j9p4Cake
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id p14-20020a2e9a8e000000b002b58cfd5236mr2267179lji.17.1687450155866;
        Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PUI9RE8kTcJcsGtpi7DjRk/Abacp0W+tVcBZjDh9XPq5tuQJut8wknojrAHXz03XIsMl3gQ==
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id p14-20020a2e9a8e000000b002b58cfd5236mr2267154lji.17.1687450155518;
        Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b0098d2f91c850sm1026234ejr.89.2023.06.22.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:09:14 -0700 (PDT)
Date:   Thu, 22 Jun 2023 18:09:12 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <oxffffaa@gmail.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>Hello Bobby!
>
>On 10.06.2023 03:58, Bobby Eshleman wrote:
>> This commit adds support for datagrams over virtio/vsock.
>>
>> Message boundaries are preserved on a per-skb and per-vq entry basis.
>
>I'm a little bit confused about the following case: let vhost sends 4097 bytes
>datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>has two skb in it rx queue, and user in guest wants to read data - does it read
>4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>special marker in header which shows where message ends, and how it works here?

I think the main difference is that DGRAM is not connection-oriented, so
we don't have a stream and we can't split the packet into 2 (maybe we
could, but we have no guarantee that the second one for example will be
not discarded because there is no space).

So I think it is acceptable as a restriction to keep it simple.

My only doubt is, should we make the RX buffer size configurable,
instead of always using 4k?

Thanks,
Stefano

