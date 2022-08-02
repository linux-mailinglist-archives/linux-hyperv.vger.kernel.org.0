Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380AD5878A4
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Aug 2022 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiHBIEi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Aug 2022 04:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiHBIEg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Aug 2022 04:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1088A3F32B
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Aug 2022 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659427474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnAgHb+qwkYr0eoeRI+miU3649J+IzbjO84fBGvUAWw=;
        b=ihqJzcGU3ZhASUCcOzoJasC+r9lQ+V6kqXCro63hqoRwTJ//sNo3AHntquIWc9Lk9NojGc
        ckaOC9o2Jprfk+Y/wo4ETTRnpNrLjbtdsSxQh2xgPj5c6Vuv9huVvi9qXMgoJobA+6XmTZ
        hMW8pqplBmYsn5LfWm8d6cEkTaLVEIU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-w2TG4_AZO9Cj4KyK8Vx7UA-1; Tue, 02 Aug 2022 04:04:29 -0400
X-MC-Unique: w2TG4_AZO9Cj4KyK8Vx7UA-1
Received: by mail-qv1-f69.google.com with SMTP id cv14-20020ad44d8e000000b004760bec67a8so3883888qvb.14
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Aug 2022 01:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PnAgHb+qwkYr0eoeRI+miU3649J+IzbjO84fBGvUAWw=;
        b=YmuEr7sivqyZTvzNzEqJJoPYZMdgyWLRV6ufFz+9iObPciKCDHxVC48/eSBWWcB1mK
         +pBUe5dXyu7uDZD2w1651Bl79HAqqgEH5obajYPOjnyC5R1HX1XUpBo0C6JE9O1mrLaL
         pPo6bV1mkcm4UFB8UUORleNHMDK9jfwQLbdNwHDH0eMJjB4jg0umMk1P4KW6DxM/Ljcy
         WOOL7fz5iIBM4PU0DnX61pQdfVGiXvxpYDS1DeVo5e4vfBdgTJYIrrIj/FJjc+dLPmQL
         q2ZcdEun99XwW28O+ktrgJpkinLMmXBL/SodaE9vFslJdUZONX+xvaoTRQP0NxBjfvQ3
         u8DQ==
X-Gm-Message-State: AJIora/+qT3Fj93a7qLB51hZkuFEvpNzKy3d5Xc9EU7xsNHS6MGRbPnR
        N672+ZEN+vbI4wnHjBeXtHFIJWcyHGFAahaX9CIjadETMEAs/0sgNsU1MZRdZgeR2rFk0KihAzY
        +EYJXiGdgui4uFFYeb7NSQyok
X-Received: by 2002:ac8:5b96:0:b0:31f:1931:b2b1 with SMTP id a22-20020ac85b96000000b0031f1931b2b1mr17183320qta.17.1659427468873;
        Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8d3getE7v6ehQxa40+uRjwcWSGfnrWrzaZU1/gX3jMXiALvanlrDyYV5QWSN3xAJSiT9vUw==
X-Received: by 2002:ac8:5b96:0:b0:31f:1931:b2b1 with SMTP id a22-20020ac85b96000000b0031f1931b2b1mr17183303qta.17.1659427468660;
        Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a40d200b006b8d1914504sm636431qko.22.2022.08.02.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:04:28 -0700 (PDT)
Date:   Tue, 2 Aug 2022 10:04:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v2 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220802080417.xyfwdidlirklr4oj@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <20220727123710.pwzy6ag3gavotxda@sgarzare-redhat>
 <D7315A7C-D288-4BDC-A8BF-B8631D8664BA@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D7315A7C-D288-4BDC-A8BF-B8631D8664BA@vmware.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Vishnu,

On Tue, Aug 02, 2022 at 05:35:22AM +0000, Vishnu Dasa wrote:
>> On Jul 27, 2022, at 5:37 AM, Stefano Garzarella <sgarzare@redhat.com> 
>> wrote:
>> Hi Arseniy,
>>
>> On Mon, Jul 25, 2022 at 07:54:05AM +0000, Arseniy Krasnov wrote:

[...]

>>>
>>> 3) vmci/vsock:
>>>  Same as 2), but i'm not sure about this changes. Will be very good,
>>>  to get comments from someone who knows this code.
>>
>> I CCed VMCI maintainers to the patch and also to this cover, maybe
>> better to keep them in the loop for next versions.
>>
>> (Jorgen's and Rajesh's emails bounced back, so I'm CCing here only
>> Bryan, Vishnu, and pv-drivers@vmware.com)
>
>Hi Stefano,
>Jorgen and Rajesh are no longer with VMware.  There's a patch in
>flight to remove Rajesh from the MAINTAINERS file (Jorgen is already
>removed).

Thanks for the update! I will contact you and Bryan for any questions 
with VMCI in the future :-)

Stefano

