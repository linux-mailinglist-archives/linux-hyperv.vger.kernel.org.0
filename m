Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372758264B
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jul 2022 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiG0MWx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Jul 2022 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiG0MWw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Jul 2022 08:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448AE45F60
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Jul 2022 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658924570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2Ka0CTSNUje69lzv8PJ/TPp2RlYweVKt52OqRvsIcU=;
        b=hCNsxit3sOgekOMXCX8vEkyote23KAqAiukuUs+eZ4Uur2AsQhGq5uzID4UwjiR9q84m1K
        R3rP6m8isCm2miaFcS9tMxt0aJUKhr2GQyZwGAGD43IuI0+wa03hAtVAG5hdW3PiYxNomM
        MQX330eS8hk2g1PP9RAUpbJ2AM9sCgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-trxhIGc7NEamOe6JwpqVjQ-1; Wed, 27 Jul 2022 08:22:48 -0400
X-MC-Unique: trxhIGc7NEamOe6JwpqVjQ-1
Received: by mail-wm1-f71.google.com with SMTP id p2-20020a05600c1d8200b003a3262d9c51so1086265wms.6
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Jul 2022 05:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2Ka0CTSNUje69lzv8PJ/TPp2RlYweVKt52OqRvsIcU=;
        b=WtUcBeSBOTr5bbvqoUuSXmUwqmDkZo1ZtENi28pM7I622Np6arkHqbN0qhWTTndXI9
         2xCQ/RsA6TqRCahcLN5mb7/RiVr6R+C2Ls3D0q2JO+ddiIXr1FZzM5E2mIgpI4JgxYSI
         jSTjOMwgsisNqBk9B6SZH3cClL1PKlBRhFgPVBA5TU7yW4OaEd9DLsXc8wc9uSizZo5b
         f8e3SwvKrbGTo/5f3fOC+6VURIoxNgazKS+itOG8TrM/8M5GlBNLK55fDAQhRC+TzhVk
         yvh6H0WoTt6F7lHmFV2pVx1bsLjJt6fuYfRy+mFn6dGp/fl2hu5QFJup1k/AYiXuIiGF
         dRDw==
X-Gm-Message-State: AJIora8mVwF+2RAaKkZOoUL+GGW0jOBkZYU03GErXtyVhRJGHE1P0Gps
        ArTlAiDrfb0P+6lhy/T3QIMInNi1mYq2i/Nh2ADpWy1/AiRgXW2Mk8Itx5AsrUDYOIiH2cgALIC
        +T7EoXTnm1m2L/ZFuw4//ZYGN
X-Received: by 2002:a7b:ca57:0:b0:3a3:205d:2533 with SMTP id m23-20020a7bca57000000b003a3205d2533mr2850194wml.67.1658924567789;
        Wed, 27 Jul 2022 05:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1teiq1UKtrMdPdEkg4fkBnI9UGCnKXnu+86rN3hnX5P6j17GO3+sGhJ6NqbsUNOXvFAHuGSxQ==
X-Received: by 2002:a7b:ca57:0:b0:3a3:205d:2533 with SMTP id m23-20020a7bca57000000b003a3205d2533mr2850159wml.67.1658924567308;
        Wed, 27 Jul 2022 05:22:47 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id f5-20020adff445000000b0021e5f32ade7sm13639242wrp.68.2022.07.27.05.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:22:46 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:22:41 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jorgen Hansen <jhansen@vmware.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>
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
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/9] vmci/vsock: use 'target' in notify_poll_in,
 callback
Message-ID: <20220727122241.mrafnepbelcboo5i@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <355f4bb6-82e7-2400-83e9-c704a7ef92f3@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <355f4bb6-82e7-2400-83e9-c704a7ef92f3@sberdevices.ru>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

@Jorgen can you take a look at this series, especially this patch?

Maybe we need to update the comments in the else branch, something like
s/there is nothing/there is not enough data

Thanks,
Stefano

On Mon, Jul 25, 2022 at 08:01:01AM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
>syscall,but in some cases,it is incorrectly to set it, when socket has
>at least 1 bytes of available data. Use 'target' which is already exists
>and equal to sk_rcvlowat in this case.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport_notify.c        | 2 +-
> net/vmw_vsock/vmci_transport_notify_qstate.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
>index d69fc4b595ad..1684b85b0660 100644
>--- a/net/vmw_vsock/vmci_transport_notify.c
>+++ b/net/vmw_vsock/vmci_transport_notify.c
>@@ -340,7 +340,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
> 		/* We can't read right now because there is nothing in the
>diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
>index 0f36d7c45db3..a40407872b53 100644
>--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
>+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
>@@ -161,7 +161,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
> 		/* We can't read right now because there is nothing in the
>-- 
>2.25.1

