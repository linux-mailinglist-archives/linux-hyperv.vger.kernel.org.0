Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B358ADD8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Aug 2022 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbiHEQFq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Aug 2022 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbiHEQFn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Aug 2022 12:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F69915A1C
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Aug 2022 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659715540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KO2+Lhn1y2XnVi7bI4Cc5ciAkJZHya2Xso0bWfCh5JA=;
        b=asfYgS+LNK+c7OobwJ43vYVFp1dTTK4pR7dzyZvc5SkdUhABvQscgEH5YtMCiEMp/3DW/O
        z8zEYNgwtr/W9HFj1mtwbh7JdJOpDCBl+PY8UA0+PDuWYXXUjTJXRauU6jt9eM+ZF2ohhs
        gm00aj/bRF/E24eduiU3/MWU/L2bjp4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-zv4v7QvWOhSCKLYm3IpN3g-1; Fri, 05 Aug 2022 12:05:39 -0400
X-MC-Unique: zv4v7QvWOhSCKLYm3IpN3g-1
Received: by mail-qt1-f197.google.com with SMTP id u12-20020a05622a010c00b0031ef5b46dc0so2192944qtw.16
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Aug 2022 09:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KO2+Lhn1y2XnVi7bI4Cc5ciAkJZHya2Xso0bWfCh5JA=;
        b=uGWKyKJdqFaUNt5eYoeFqsMYvIeUsNHXNtzYmLCUZ63BEi2NdsXyez0YWbIus/41Ms
         Ksredn9kUGJ6sche0Uhz+8+mBbUYwPLOE9e3gNMDYGRj47jIkw6zCFnwr80Mio4Qgyw5
         uQoSett5jCTiFKakHYS0MlfEyXUkemDjaTuXFWQ/ZE2zMGplzW0F8Uv/ORB+3vIE38ca
         OaYl6wRgWhEHyD30DFdiOhxGoSh7JJRm9AR+/jBrpqOYRr0s7OCgCdGYlW/L78tS7v+V
         YxEZm+N560H3gEnwU9WSWYgN+sxRMoHJ2gNJh9hTQ87saSlCDuar3IV8XA6LJwUZo207
         mPxw==
X-Gm-Message-State: ACgBeo3QAowd3Ah87IJSHORanfqJft3jvn6qYR8wFsCzLjIWoqtYK+5L
        PQMtME0FvPqtm3fFToID1khl7iAKWXvUslhJkaapFt3XpVdls7HXFdjDm+kocEC7FZAAbzhzbmS
        aChqjp6FjNJjOmRfl2ld74qjE
X-Received: by 2002:ad4:5ce3:0:b0:474:71c0:adf3 with SMTP id iv3-20020ad45ce3000000b0047471c0adf3mr6391529qvb.47.1659715538464;
        Fri, 05 Aug 2022 09:05:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6V/dJ4FYdWc2pXQmkRsGFLohJ8WPMbtbN/X/1uVIpxzDhT0pzdU07XUiuvIlyTbScoDMAaoA==
X-Received: by 2002:ad4:5ce3:0:b0:474:71c0:adf3 with SMTP id iv3-20020ad45ce3000000b0047471c0adf3mr6391470qvb.47.1659715538111;
        Fri, 05 Aug 2022 09:05:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id z9-20020a05622a028900b003422c7ccbc5sm2577102qtw.59.2022.08.05.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:05:37 -0700 (PDT)
Date:   Fri, 5 Aug 2022 18:05:28 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v3 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220805160528.4jzyrjppdftrvdr5@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Arseniy,
sorry but I didn't have time to review this series. I will definitely do 
it next Monday!

Have a nice weekend,
Stefano

On Wed, Aug 03, 2022 at 01:48:06PM +0000, Arseniy Krasnov wrote:
>Hello,
>
>This patchset includes some updates for SO_RCVLOWAT:
>
>1) af_vsock:
>   During my experiments with zerocopy receive, i found, that in some
>   cases, poll() implementation violates POSIX: when socket has non-
>   default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>   POLLRDNORM bits in 'revents' even number of bytes available to read
>   on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>   POLLIN flag and then tries to read data(for example using  'read()'
>   call), but read call will be blocked, because  SO_RCVLOWAT logic is
>   supported in dequeue loop in af_vsock.c. But the same time,  POSIX
>   requires that:
>
>   "POLLIN     Data other than high-priority data may be read without
>               blocking.
>    POLLRDNORM Normal data may be read without blocking."
>
>   See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>
>   So, we have, that poll() syscall returns POLLIN, but read call will
>   be blocked.
>
>   Also in man page socket(7) i found that:
>
>   "Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>   socket as readable only if at least SO_RCVLOWAT bytes are available."
>
>   I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>   uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>   this case for TCP socket, it works as POSIX required.
>
>   I've added some fixes to af_vsock.c and virtio_transport_common.c,
>   test is also implemented.
>
>2) virtio/vsock:
>   It adds some optimization to wake ups, when new data arrived. Now,
>   SO_RCVLOWAT is considered before wake up sleepers who wait new data.
>   There is no sense, to kick waiter, when number of available bytes
>   in socket's queue < SO_RCVLOWAT, because if we wake up reader in
>   this case, it will wait for SO_RCVLOWAT data anyway during dequeue,
>   or in poll() case, POLLIN/POLLRDNORM bits won't be set, so such
>   exit from poll() will be "spurious". This logic is also used in TCP
>   sockets.
>
>3) vmci/vsock:
>   Same as 2), but i'm not sure about this changes. Will be very good,
>   to get comments from someone who knows this code.
>
>4) Hyper-V:
>   As Dexuan Cui mentioned, for Hyper-V transport it is difficult to
>   support SO_RCVLOWAT, so he suggested to disable this feature for
>   Hyper-V.
>
>Thank You
>
>Arseniy Krasnov(9):
> vsock: SO_RCVLOWAT transport set callback
> hv_sock: disable SO_RCVLOWAT support
> virtio/vsock: use 'target' in notify_poll_in callback
> vmci/vsock: use 'target' in notify_poll_in callback
> vsock: pass sock_rcvlowat to notify_poll_in as target
> vsock: add API call for data ready
> virtio/vsock: check SO_RCVLOWAT before wake up reader
> vmci/vsock: check SO_RCVLOWAT before wake up reader
> vsock_test: POLLIN + SO_RCVLOWAT test
>
> include/net/af_vsock.h                       |   2 +
> net/vmw_vsock/af_vsock.c                     |  38 +++++++++-
> net/vmw_vsock/hyperv_transport.c             |   7 ++
> net/vmw_vsock/virtio_transport_common.c      |   7 +-
> net/vmw_vsock/vmci_transport_notify.c        |  10 +--
> net/vmw_vsock/vmci_transport_notify_qstate.c |  12 +--
> tools/testing/vsock/vsock_test.c             | 107 +++++++++++++++++++++++++++
> 7 files changed, 166 insertions(+), 17 deletions(-)
>
> Changelog:
>
> v1 -> v2:
> 1) Patches for VMCI transport(same as for virtio-vsock).
> 2) Patches for Hyper-V transport(disabling SO_RCVLOWAT setting).
> 3) Waiting logic in test was updated(sleep() -> poll()).
>
> v2 -> v3:
> 1) Patches were reordered.
> 2) Commit message updated in 0005.
> 3) Check 'transport' pointer in 0001 for NULL.
> 4) Check 'value' in 0001 for > buffer_size.
>
>-- 
>2.25.1

