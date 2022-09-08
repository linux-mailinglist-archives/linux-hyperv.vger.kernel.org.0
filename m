Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDE5B20A9
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Sep 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiIHOhE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Sep 2022 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiIHOhC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Sep 2022 10:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E7DAB89
        for <linux-hyperv@vger.kernel.org>; Thu,  8 Sep 2022 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662647820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
        b=QbIlCjgNx9J2Q77eday2QeT5PwYMI8cKX9Nz+5HimDyXUB5wSYzPcGkleNfZajy1d1AMu+
        AheUGYsTGT0MX79CtWPpaqiLqf4AfKHYTWbXXp/ddUOGTxAKRFcqumPHdAp8mbgjO/8IIi
        nWCTn6RBpob3WAxByef3KwceFSs7Fi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-d44OFneaPDi6nW9Sj62fww-1; Thu, 08 Sep 2022 10:36:59 -0400
X-MC-Unique: d44OFneaPDi6nW9Sj62fww-1
Received: by mail-wr1-f69.google.com with SMTP id e15-20020adf9bcf000000b002285faa9bd4so4183333wrc.8
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Sep 2022 07:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
        b=B+FFZeQSMXD8gUjFliYBgSchFZN+lHcgwOn7jp770uwzI/aD7IpnnqKYzzX6qO8Jl5
         810grSb9VLvcom8q1ye4fHPNKNp0TPpWhKAllrXCU5Vjx00+xKlfbTZ6J8A8jMhEjDJl
         879GTtYhJ9BzIEB1d7TKij84CSn3jSUOpLHVzyB1eTjj+S2TPESHuOOE4QTeB7omCbWC
         g27QLSeA3T1In6r3QurS8Z+VGfyCY7ag6sL+gRmASjiIFjLcGWRoSJG2THE+g/UYLN48
         9YbNyi6zONYSW57B7eQyiOOIJZPoviJRC7r7v1RV4DKppRDw9s5nMvqELk344tDaKmiq
         rc4g==
X-Gm-Message-State: ACgBeo21o00S3CNQ/teEaHiArO3t+qVsHNgZ2jH9ZzRNiaPhZ6STcce3
        6WsXeWrzyAdRtYJl3rjgi4a4Sza/ASdo2SBNAXzaeC7aHK8Ajknb63rEpH52BKJCoER/YG2FrmY
        rKAGTVtFwCMus5YrlMQsyVJFs
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id u2-20020a5d6da2000000b0022864ca3978mr5285525wrs.542.1662647818273;
        Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BEGVkHcFX/ZuPLpySO7WMaIWzsWXcmGzFBbS0MxMsqv14mvHPWdYH6rv4OjZ1+HxLnAXdhw==
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id u2-20020a5d6da2000000b0022864ca3978mr5285510wrs.542.1662647818042;
        Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a3442f1229sm3131212wmn.29.2022.09.08.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:36:56 -0700 (PDT)
Date:   Thu, 8 Sep 2022 16:36:52 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Call to discuss vsock netdev/sk_buff [was Re: [PATCH 0/6]
 virtio/vsock: introduce dgrams, sk_buff, and qdisc]
Message-ID: <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora>
 <Yv5PFz1YrSk8jxzY@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yv5PFz1YrSk8jxzY@bullseye>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 18, 2022 at 02:39:32PM +0000, Bobby Eshleman wrote:
>On Tue, Sep 06, 2022 at 09:26:33AM -0400, Stefan Hajnoczi wrote:
>> Hi Bobby,
>> If you are attending Linux Foundation conferences in Dublin, Ireland
>> next week (Linux Plumbers Conference, Open Source Summit Europe, KVM
>> Forum, ContainerCon Europe, CloudOpen Europe, etc) then you could meet
>> Stefano Garzarella and others to discuss this patch series.
>>
>> Using netdev and sk_buff is a big change to vsock. Discussing your
>> requirements and the future direction of vsock in person could help.
>>
>> If you won't be in Dublin, don't worry. You can schedule a video call if
>> you feel it would be helpful to discuss these topics.
>>
>> Stefan
>
>Hey Stefan,
>
>That sounds like a great idea! I was unable to make the Dublin trip work
>so I think a video call would be best, of course if okay with everyone.

Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 
16:30 UTC.

Could this work for you?

It would be nice to also have HyperV and VMCI people in the call and 
anyone else who is interested of course.

@Dexuan @Bryan @Vishnu can you attend?

@MST @Jason @Stefan if you can be there that would be great, we could 
connect together from Dublin.

Thanks,
Stefano

