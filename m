Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478D76496B
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jul 2023 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjG0Hyx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjG0Hyh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 03:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2130DD
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Jul 2023 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690444113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
        b=XW0D6vstNvW3Vr8tVQKw6QeuKHe7OriQWfxYnsCcSv4RmEKTLFU3k7RjfN+fjGS69NWcwr
        iOJRnR790VLzB6EYf39ee8kFrCAL13bt+mq70xxa9k/w318t7x1otDhpHBAUqsZRtlWN1+
        xjB1q66QpPMa23GbCV+S6ykuFYPS5eE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-uil--iopMdGO47X_bvxu8g-1; Thu, 27 Jul 2023 03:48:29 -0400
X-MC-Unique: uil--iopMdGO47X_bvxu8g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so36751366b.0
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Jul 2023 00:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444109; x=1691048909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
        b=NGHmr0KjMf5eRjx90O/fafWNe5h1mdvXGZP/SM1fnshUB29tvDgOcRAsg9e82Tg2z3
         Jq+6/obDHvWH0Czt4Dmjh4uE+ob5BO21hQkTym33aikBHiil7FF0FmHLK8mWbkAMOFIA
         UVqFtzdZ3uWXDiZFIa7QAQo0dkJvavLvP2mmH0Qwb8/D/kif5lN965RJXD9ov7H/Mu7W
         SrKApLDNl6KaMheGrXHdDVx0ddoAkQ7PiVNF3sd5HPYNBN6qOPDVf4fZxpeVla9xQ9D2
         X2qU/6cOXCLRAWtD+JMHbjsKVWGIHP1fgRb30hpQmZvfrVamyDKuJRN4NkXMI3m+JlNo
         SMaQ==
X-Gm-Message-State: ABy/qLZLUVn4MlYJbBSnPqLKT04QDrxhXuxuPezWgw+DsEQjMvF63Ult
        yh0oVSAhwOERus2A9u3Z/J+PEjK0lLDukadiMJmElCpWJQEV+/ZfJWxzx/Hw8+a9g8UHhYLC31X
        Y24CUQSZD+aVzi2m/qTx18nUW
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id ia8-20020a170907a06800b0098931480e9amr1273082ejc.41.1690444108916;
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE55JyhKwJyB8qUe+lq1MkQNb4GdgSPTG/st46k7wZpyOLVvAygT9RNqVELeE+FBejRoktCsg==
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id ia8-20020a170907a06800b0098931480e9amr1273068ejc.41.1690444108579;
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.102])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906075000b00993a9a951fasm467215ejb.11.2023.07.27.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:48:21 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
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
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726143736-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
>> This commit adds a feature bit for virtio vsock to support datagrams.
>>
>> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> ---
>>  include/uapi/linux/virtio_vsock.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 331be28b1d30..27b4b2b8bf13 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -40,6 +40,7 @@
>>
>>  /* The feature bitmap for virtio vsock */
>>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>>
>>  struct virtio_vsock_config {
>>  	__le64 guest_cid;
>
>pls do not add interface without first getting it accepted in the
>virtio spec.

Yep, fortunatelly this series is still RFC.
I think by now we've seen that the implementation is doable, so we
should discuss the changes to the specification ASAP. Then we can
merge the series.

@Bobby can you start the discussion about spec changes?

Thanks,
Stefano

