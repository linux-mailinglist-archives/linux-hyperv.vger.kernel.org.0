Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED53558C687
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbiHHKgd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiHHKg3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 06:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 157B35F54
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659954983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ1tVOq7gmtva8bvG4/tC19zWSGUYjLfZNUM1FdlBcA=;
        b=aq79ZUAN4Q/3jZSK73nD1tswjVjkp1gOUzTNxXoDmq1GDy6TNWv1Dj0XZocq3ZnovLw9Ai
        Pdk/2DFZd8i1IC7zeq4ylI7E/nqFBIaSvhEFZqRd7KvQviwAHwb9JcDaKq0hY8tuqULzHf
        bldLYrs1B8qK7Yba+GK7q1XqoxQll50=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-vsa534FKO0O5mb1bg9X9bg-1; Mon, 08 Aug 2022 06:36:22 -0400
X-MC-Unique: vsa534FKO0O5mb1bg9X9bg-1
Received: by mail-qt1-f198.google.com with SMTP id bb40-20020a05622a1b2800b00342eb08cc48so3780562qtb.17
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zJ1tVOq7gmtva8bvG4/tC19zWSGUYjLfZNUM1FdlBcA=;
        b=KO3P4wq+7y5WJyBOYqYqFlohkGnQsvDjQHMkMXQJAa5oRNRqby/h2qFJ4Aw/auVkSD
         UDbVH4XOB2MUM+9DrNui+4U7JNcveO8uu7WlA/X6yu4YLwJvaOJ9WGy5ZF3x3/JuLPIk
         lneaN41KcNY0CDusRi7pSRNFt3502wKiW6cEDgd6idCNYruH7Z9s6hR1S7ZH+HyV6Iwr
         FKqfmuMjH66P4V1VZDOmZc/5slIjUiEERM4575KPJ7CFp4h2elCgqUHJ9csStv9g+Sze
         FsoKAld4CyFJhAEPgwclHFJpFokBiD2dONHtsAhPoPEHipHkJnaeQ/U53IWcysVN/xP1
         ozzw==
X-Gm-Message-State: ACgBeo0nz2A2KshK9sP/ANnj+OOeEbr8GaYifbeNeYpU9N8tw8lwfL5s
        T/k9tx9qGtkeksrDItkVUTM6bXhaB5esomFBN6I2DISNhx5pG/dnsNYr9kGUDZwF/+lgpQOFu/o
        Xf/YpJBdiS1Mbujq4OdwZ2ZUv
X-Received: by 2002:a05:622a:180e:b0:31f:d9b:5d08 with SMTP id t14-20020a05622a180e00b0031f0d9b5d08mr14834000qtc.361.1659954982352;
        Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6F6gVFFx3Fov1l256Ik12Z9hgmB//giFTCFLHWESSv1E7Qcw4/dS8csL3oAtpxvwHPq8lSnw==
X-Received: by 2002:a05:622a:180e:b0:31f:d9b:5d08 with SMTP id t14-20020a05622a180e00b0031f0d9b5d08mr14833976qtc.361.1659954982116;
        Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id m22-20020ac866d6000000b0031f229d4427sm7582235qtp.96.2022.08.08.03.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:36:21 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:36:11 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
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
Subject: Re: [RFC PATCH v3 4/9] vmci/vsock: use 'target' in notify_poll_in
 callback
Message-ID: <20220808103611.4ma4c5fpszrmstvx@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <2e420c8e-9550-c8c5-588f-e13b79a057ff@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2e420c8e-9550-c8c5-588f-e13b79a057ff@sberdevices.ru>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 03, 2022 at 01:57:54PM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
>syscall,but in some cases,it is incorrectly to set it, when socket has
>at least 1 bytes of available data. Use 'target' which is already exists
>and equal to sk_rcvlowat in this case.

Ditto as the previous patch.
With that fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

@Bryan, @Vishnu, if you're happy with this change, can you ack/review?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport_notify.c        | 8 ++++----
> net/vmw_vsock/vmci_transport_notify_qstate.c | 8 ++++----
> 2 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
>index d69fc4b595ad..852097e2b9e6 100644
>--- a/net/vmw_vsock/vmci_transport_notify.c
>+++ b/net/vmw_vsock/vmci_transport_notify.c
>@@ -340,12 +340,12 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
>-		/* We can't read right now because there is nothing in the
>-		 * queue. Ask for notifications when there is something to
>-		 * read.
>+		/* We can't read right now because there is not enough data
>+		 * in the queue. Ask for notifications when there is something
>+		 * to read.
> 		 */
> 		if (sk->sk_state == TCP_ESTABLISHED) {
> 			if (!send_waiting_read(sk, 1))
>diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
>index 0f36d7c45db3..12f0cb8fe998 100644
>--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
>+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
>@@ -161,12 +161,12 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
>-		/* We can't read right now because there is nothing in the
>-		 * queue. Ask for notifications when there is something to
>-		 * read.
>+		/* We can't read right now because there is not enough data
>+		 * in the queue. Ask for notifications when there is something
>+		 * to read.
> 		 */
> 		if (sk->sk_state == TCP_ESTABLISHED)
> 			vsock_block_update_write_window(sk);
>-- 
>2.25.1

