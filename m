Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74B73B281
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jun 2023 10:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFWIQ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Jun 2023 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjFWIQW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Jun 2023 04:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366A2713
        for <linux-hyperv@vger.kernel.org>; Fri, 23 Jun 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687508135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvP94iL0b14tTM53kZ2sYxqnmPo54a4UlF6JdzA9tVs=;
        b=dJk+Dl7bahH4SGBsAyO/sxhAXpNsRvhepXUBbFUVtycd4S3t/+Y0hjfx91ZHOAQI7Fhv8h
        WXlGJIUUV4IkDl8VdLqgopQiu4t5WxSl8dygXczDy+clM6XSUhrpkJKkvQ5VY/h8TJ+cfw
        OfZNMz6Wz6EBBu+kVAcXwQ1n1aBjsI0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-cWpTOKxqMCe7hEsSffwO7g-1; Fri, 23 Jun 2023 04:15:28 -0400
X-MC-Unique: cWpTOKxqMCe7hEsSffwO7g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so27712766b.2
        for <linux-hyperv@vger.kernel.org>; Fri, 23 Jun 2023 01:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508127; x=1690100127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvP94iL0b14tTM53kZ2sYxqnmPo54a4UlF6JdzA9tVs=;
        b=du0xz+upELeJVCfk1tGf1j8gX4Ux1xOSAJIyJTrts7PYlkD4O/CDd2dvMbiHXPBJ7S
         NG6/0R4leJKDM9hokoXce62m22DLNZqw56GrnzYQfBViw+jSjuu/rjXBf82SAe1QesPI
         7UlyvpHrZqpbEqY9jqDYqr4rNZD87MzYDNfRLQ+kEfB5mxuEzYVHB9g2daoLbRK6EiN7
         F8262eWw1W2G9//5we12ilKhbKX4+s9FNFyl3SMU0or2RmZ7055ySldOrKilT52xps8Q
         YAZ1jjUTjMqq8ZfJOJer1yiViC3yusPoQYJl94ISpyAr/ClcKOTnDiYhgzVAgdNCZ+Po
         bNIA==
X-Gm-Message-State: AC+VfDxXJPgq2LOemKDmQ3F2eAKX1tRTR/Yzqlv8RIP6TG/DGWbmMR48
        vgC9tpAbZFZ4Eb6uto+t36X7TKn1JNih32qjHqJxXCevqrQ/DQ4Oa8oE536oRqEvJ8Kwb1cSU6m
        3stWn2iCOITSq0vvJSP8VuskQ
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id hd31-20020a170907969f00b00947335f5a0dmr18564033ejc.62.1687508127034;
        Fri, 23 Jun 2023 01:15:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sG50KKcb8/4d0k9Sa5DNa+zxv2rKJ2E9yej3gVqMAjHzgkvZGHjdevsBGJ9oYHGKr3rl2Pw==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id hd31-20020a170907969f00b00947335f5a0dmr18563999ejc.62.1687508126768;
        Fri, 23 Jun 2023 01:15:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090608cb00b00985ed2f1584sm5635492eje.187.2023.06.23.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:15:26 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:15:23 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
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
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 4/8] vsock: make vsock bind reusable
Message-ID: <oq5c2c4snksklko6tmq44g73d6ihrbnqjyugsvfbhtdsnlrioi@hklfspvyjmad>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
 <p2tgn3wczd3t3dodyicczetr2nqnqpwcadz6ql5hpvg2cd2dxa@phheksxhxfna>
 <ZJTTx0XJ2LeITNh0@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZJTTx0XJ2LeITNh0@bullseye>
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

On Thu, Jun 22, 2023 at 11:05:43PM +0000, Bobby Eshleman wrote:
>On Thu, Jun 22, 2023 at 05:25:55PM +0200, Stefano Garzarella wrote:
>> On Sat, Jun 10, 2023 at 12:58:31AM +0000, Bobby Eshleman wrote:
>> > This commit makes the bind table management functions in vsock usable
>> > for different bind tables. For use by datagrams in a future patch.
>> >
>> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > ---
>> > net/vmw_vsock/af_vsock.c | 33 ++++++++++++++++++++++++++-------
>> > 1 file changed, 26 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index ef86765f3765..7a3ca4270446 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>> > 	sock_put(&vsk->sk);
>> > }
>> >
>> > -static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>> > +					    struct list_head *bind_table)
>> > {
>> > 	struct vsock_sock *vsk;
>> >
>> > -	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>> > +	list_for_each_entry(vsk, bind_table, bound_table) {
>> > 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>> > 			return sk_vsock(vsk);
>> >
>> > @@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > 	return NULL;
>> > }
>> >
>> > +static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +{
>> > +	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>> > +}
>> > +
>> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>> > 						  struct sockaddr_vm *dst)
>> > {
>> > @@ -646,12 +652,17 @@ static void vsock_pending_work(struct work_struct *work)
>> >
>> > /**** SOCKET OPERATIONS ****/
>> >
>> > -static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > -				    struct sockaddr_vm *addr)
>> > +static int vsock_bind_common(struct vsock_sock *vsk,
>> > +			     struct sockaddr_vm *addr,
>> > +			     struct list_head *bind_table,
>> > +			     size_t table_size)
>> > {
>> > 	static u32 port;
>> > 	struct sockaddr_vm new_addr;
>> >
>> > +	if (table_size < VSOCK_HASH_SIZE)
>> > +		return -1;
>>
>> Why we need this check now?
>>
>
>If the table_size is not at least VSOCK_HASH_SIZE then the
>VSOCK_HASH(addr) used later could overflow the table.
>
>Maybe this really deserves a WARN() and a comment?

Yes, please WARN_ONCE() should be enough.

Stefano

