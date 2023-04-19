Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A76E76FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Apr 2023 12:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjDSKBR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Apr 2023 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjDSKBQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Apr 2023 06:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69ECE7
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Apr 2023 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681898429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQ6sCjmuWnVFb8UpDGaTI+MOdoOd+qfctALNM5m0k+g=;
        b=hohYWnIIdB/5TSE4R0BeO4M83jCZ1NglIRnrlQkCTlkrKflfY40CMv/0j7rwBIwoTikjtJ
        mRpo+eQwes7oTZ7a86mEq6MrJ1hGjWrp6BRDX2FAefimjkv1MeeP0sfT3mTAOpuldAWszr
        RVvyCKO4fFSjWb9g+xwqxLInfZ1p5Vc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-z4Nau3coPqKtABKLnBDu8Q-1; Wed, 19 Apr 2023 06:00:28 -0400
X-MC-Unique: z4Nau3coPqKtABKLnBDu8Q-1
Received: by mail-qv1-f70.google.com with SMTP id t29-20020a0cb39d000000b005ef732729f9so3914158qve.9
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Apr 2023 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681898425; x=1684490425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ6sCjmuWnVFb8UpDGaTI+MOdoOd+qfctALNM5m0k+g=;
        b=CkBUUHZ7IIdLEqMMJ1LoLvp5VE0pAlKTeABi+12F4mro5b27cSM0DXcQ+Aok5sqOvQ
         HOh7CNf9cWzbmcaUmnbCkzno8Fb7iRKDWpzA3Fq6gAMBLFlxfMFARVRMKzf819BGK2AK
         0W26n6ind5s+jSHHnP/V7n9fvyNJNBq1sRpvh2quwaHKrGdBmE2lyKNuS1eikecz1BHt
         ZwNlKP60NvAUYNs1wQaik4oDs/HbGU778znmQkwxrAi3LOfaShjyq02NQf8RhStDZ6Pb
         DdmJCoYbzyG2NRymFo+uPRNTTzY4h4P/pxAqriLW4jlXYcWCVBjZ4kZtjz8DMkeiJs00
         4kvg==
X-Gm-Message-State: AAQBX9cq3bWwyYv0jdW/Xl2j3ylwZ1uxqxDXh+P1mxBJFg2kYoQ61ujA
        WJXCRefA9jEpLXjO60P1tZROiFFhb31oWBNyh3/OZ5aTxb8Ei0aTfGJbO4UBdjK8fR9M/550GqT
        7NdWh1cbBKEmbYsf78mnGMLKH
X-Received: by 2002:a05:622a:44e:b0:3ef:437e:c828 with SMTP id o14-20020a05622a044e00b003ef437ec828mr1647538qtx.54.1681898424520;
        Wed, 19 Apr 2023 03:00:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bx/DlObVliHPvUfPOoqrhYKHpZuPyTlGGGIslCUKrTunefbYRtBDLkw2QCfpHp8ro/QNbCag==
X-Received: by 2002:a05:622a:44e:b0:3ef:437e:c828 with SMTP id o14-20020a05622a044e00b003ef437ec828mr1647485qtx.54.1681898424062;
        Wed, 19 Apr 2023 03:00:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-157.retail.telecomitalia.it. [82.53.134.157])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05620a469000b007484d284cdasm4564029qkb.93.2023.04.19.03.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:00:23 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:00:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Jiang Wang <jiang.wang@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 0/4] virtio/vsock: support datagrams
Message-ID: <r6oxanmhwlonb7lcrrowpitlgobivzp7pcwk7snqvfnzudi6pb@4rnio5wef3qu>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <ZDk2kOVnUvyLMLKE@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZDk2kOVnUvyLMLKE@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bobby,

On Fri, Apr 14, 2023 at 11:18:40AM +0000, Bobby Eshleman wrote:
>CC'ing Cong.
>
>On Fri, Apr 14, 2023 at 12:25:56AM +0000, Bobby Eshleman wrote:
>> Hey all!
>>
>> This series introduces support for datagrams to virtio/vsock.

Great! Thanks for restarting this work!

>>
>> It is a spin-off (and smaller version) of this series from the summer:
>>   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>>
>> Please note that this is an RFC and should not be merged until
>> associated changes are made to the virtio specification, which will
>> follow after discussion from this series.
>>
>> This series first supports datagrams in a basic form for virtio, and
>> then optimizes the sendpath for all transports.
>>
>> The result is a very fast datagram communication protocol that
>> outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>> of multi-threaded workload samples.
>>
>> For those that are curious, some summary data comparing UDP and VSOCK
>> DGRAM (N=5):
>>
>> 	vCPUS: 16
>> 	virtio-net queues: 16
>> 	payload size: 4KB
>> 	Setup: bare metal + vm (non-nested)
>>
>> 	UDP: 287.59 MB/s
>> 	VSOCK DGRAM: 509.2 MB/s
>>
>> Some notes about the implementation...
>>
>> This datagram implementation forces datagrams to self-throttle according
>> to the threshold set by sk_sndbuf. It behaves similar to the credits
>> used by streams in its effect on throughput and memory consumption, but
>> it is not influenced by the receiving socket as credits are.

So, sk_sndbuf influece the sender and sk_rcvbuf the receiver, right?

We should check if VMCI behaves the same.

>>
>> The device drops packets silently. There is room for improvement by
>> building into the device and driver some intelligence around how to
>> reduce frequency of kicking the virtqueue when packet loss is high. I
>> think there is a good discussion to be had on this.

Can you elaborate a bit here?

Do you mean some mechanism to report to the sender that a destination
(cid, port) is full so the packet will be dropped?

Can we adapt the credit mechanism?

>>
>> In this series I am also proposing that fairness be reexamined as an
>> issue separate from datagrams, which differs from my previous series
>> that coupled these issues. After further testing and reflection on the
>> design, I do not believe that these need to be coupled and I do not
>> believe this implementation introduces additional unfairness or
>> exacerbates pre-existing unfairness.

I see.

>>
>> I attempted to characterize vsock fairness by using a pool of processes
>> to stress test the shared resources while measuring the performance of a
>> lone stream socket. Given unfair preference for datagrams, we would
>> assume that a lone stream socket would degrade much more when a pool of
>> datagram sockets was stressing the system than when a pool of stream
>> sockets are stressing the system. The result, however, showed no
>> significant difference between the degradation of throughput of the lone
>> stream socket when using a pool of datagrams to stress the queue over
>> using a pool of streams. The absolute difference in throughput actually
>> favored datagrams as interfering least as the mean difference was +16%
>> compared to using streams to stress test (N=7), but it was not
>> statistically significant. Workloads were matched for payload size and
>> buffer size (to approximate memory consumption) and process count, and
>> stress workloads were configured to start before and last long after the
>> lifetime of the "lone" stream socket flow to ensure that competing flows
>> were continuously hot.
>>
>> Given the above data, I propose that vsock fairness be addressed
>> independent of datagrams and to defer its implementation to a future
>> series.

Makes sense to me.

I left some preliminary comments, anyway now it seems reasonable to use
the same virtqueues, so we can go head with the spec proposal.

Thanks,
Stefano

