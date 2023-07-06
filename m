Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E97498E9
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjGFKCp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGFKCg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 06:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D4E3
        for <linux-hyperv@vger.kernel.org>; Thu,  6 Jul 2023 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688637711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
        b=hKw1k4X7OtdOsb8IlPWp/krUxNJCPDcMl2THTnD/JQDIDIqEe4jSI/J7Yz18cmLYiPKypi
        EDb7CnWlLlPCgDjAAtJ5IMW1e6q3sKSGMMt8J+WE4t0IN2A4Y3XQ98j3zEsUCezK0tN6Kr
        G01gBm5htE8Ppf44EOCIk38faQUsR30=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-RFNwxjPEMZKRo_n6yZOXug-1; Thu, 06 Jul 2023 06:01:50 -0400
X-MC-Unique: RFNwxjPEMZKRo_n6yZOXug-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5704995f964so6055167b3.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Jul 2023 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637709; x=1691229709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFB/bHaV+5S4HNAEYX/AEdRm3PBRbuuOs/N7fpLg5iE=;
        b=I1+WCx5scWnn943pRirA6kkee8y3HPQDxEPnD6BLamS1oRKzoIm+VTuRSwoScS+iVP
         quEu23jynNoQGPpWg75kbhawsG3u0saHdn9T1FDagK0G9CWN+qUsL3a8vut8XcbFejIa
         0NciHirfmhCsT8Ij1ys03VbnIJ1QL/V0fW5ZyNu83k33bIkA6dYlzY7VxpbgYpd3mTRA
         SwzopxV2v6b/1IX7m4aFNl7P0oLmzC3yGQLoKwCott+Os+IE8rkUPGUwmwnVmqhLyqxI
         OwM1ZC8mRXhFM9/qkQvgGWMcalWvYwU32boHbYMs3tBHIfkvI2sn79YwDWVOxz7iJ/MF
         e8MQ==
X-Gm-Message-State: ABy/qLY8UQ2bqlPTN8v8Zge1D5WWJSPLpJxXzdQxLNStixP8LHCBE3BH
        NwOgIlbdhD9jaxQhIrgacl2pDeVU0pQprtr4FD4MEO5wUEKMlb6i/NIU/34kc65m/LGT8a6lxro
        DAOWRrg+Y/zZOJ9yfipMXRbLj19Ls81C0PGfugrC5
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id t126-20020a818384000000b0056d0c9739f4mr1424688ywf.8.1688637709731;
        Thu, 06 Jul 2023 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnS8DTGuBigSC1cOUEhrHGP3AjZEn+XIDZR976mIx9TGjJA3wYtGsoU6qHdLxp+gcwyMWCUHKwipRzaY/ylEo=
X-Received: by 2002:a81:8384:0:b0:56d:c97:39f4 with SMTP id
 t126-20020a818384000000b0056d0c9739f4mr1424668ywf.8.1688637709450; Thu, 06
 Jul 2023 03:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704234532.532c8ee7.gary@garyguo.net>
In-Reply-To: <20230704234532.532c8ee7.gary@garyguo.net>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Thu, 6 Jul 2023 12:01:38 +0200
Message-ID: <CAGxU2F4_br6e3hEELXP_wpQSZTs5FYhQ-iahiZKzMMRYWpFXdA@mail.gmail.com>
Subject: Re: Hyper-V vsock streams do not fill the supplied buffer in full
To:     Gary Guo <gary@garyguo.net>, Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Gary,

On Wed, Jul 5, 2023 at 12:45=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> When a vsock stream is called with recvmsg with a buffer, it only fills
> the buffer with data from the first single VM packet. Even if there are
> more VM packets at the time and the buffer is still not completely
> filled, it will just leave the buffer partially filled.
>
> This causes some issues when in WSLD which uses the vsock in
> non-blocking mode and uses epoll.
>
> For stream-oriented sockets, the epoll man page [1] says that
>
> > For stream-oriented files (e.g., pipe, FIFO, stream socket),
> > the condition that the read/write I/O space is exhausted can
> > also be detected by checking the amount of data read from /
> > written to the target file descriptor.  For example, if you
> > call read(2) by asking to read a certain amount of data and
> > read(2) returns a lower number of bytes, you can be sure of
> > having exhausted the read I/O space for the file descriptor.
>
> This has been used as an optimisation in the wild for reducing number
> of syscalls required for stream sockets (by asserting that the socket
> will not have to polled to EAGAIN in edge-trigger mode, if the buffer
> given to recvmsg is not filled completely). An example is Tokio, which
> starting in v1.21.0 [2].
>
> When this optimisation combines with the behaviour of Hyper-V vsock, it
> causes issue in this scenario:
> * the VM host send data to the guest, and it's splitted into multiple
>   VM packets
> * sk_data_ready is called and epoll returns, notifying the userspace
>   that the socket is ready
> * userspace call recvmsg with a buffer, and it's partially filled
> * userspace assumes that the stream socket is depleted, and if new data
>   arrives epoll will notify it again.
> * kernel always considers the socket to be ready, and since it's in
>   edge-trigger mode, the epoll instance will never be notified again.
>
> This different realisation of the readiness causes the userspace to
> block forever.

Thanks for the detailed description of the problem.

I think we should fix the hvs_stream_dequeue() in
net/vmw_vsock/hyperv_transport.c.
We can do something similar to what we do in
virtio_transport_stream_do_dequeue() in
net/vmw_vsock/virtio_transport_common.c

@Dexuan WDYT?

Thanks,
Stefano

