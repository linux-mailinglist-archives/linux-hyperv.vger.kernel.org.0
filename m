Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A2742285
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjF2Iot (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF2IoK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 04:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3C297B
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Jun 2023 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688028159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
        b=Alr/EKmhy79bwZ4O9Q7RJfYzqgYu7h5Af1xyuy8aVNI1RCX674wCfylb/e5nxm7S1sBPIf
        M/+pIMQ5unn9KQ2tSpBxLCbCwazE8QO9w4nk70IJ25SSfoHh7EpKl0cbshZRZkbF9NBEt7
        XFcJaXoUnBQBj9WFzQPWquMapAQXY5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-sjkt9kPNNiaHEZBUG0Welw-1; Thu, 29 Jun 2023 04:42:38 -0400
X-MC-Unique: sjkt9kPNNiaHEZBUG0Welw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313e542e2f5so38680f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028157; x=1690620157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
        b=g1Nk96hGyLxDijlqloTCD7JcdW5rgWEArSOm//uNJ5twdgsN945ecaK+lpW+D+FJof
         gcWk5chThe1n+XgyU8hdWschRHk04NQq6lRgHxGfAlQb6bkGiZFSRAsfs3utmDKoijQt
         n7bcPVPlMzcvRM+wTK9zDjMej1zvfbMUoSTVRo/GCnuz5SaESDILc2h/LOVnCiEFWtbQ
         OOPyG/bPdLkfNRkFnXfaixyRPubSCxGj4pK4QP1esZjn5yDOLK8RYAg1oKV95exj8oLM
         2AoYafep5PEOEHZUm8SI/v01nD6TYO4SywqqSE5ZvwIMNUKKuHsvIzqAnKDBV3sZI0f8
         T1mA==
X-Gm-Message-State: AC+VfDzdaXl3pX1CFydiYlVF1pQt9nplmDkl6uOmy3pZTTVM/xquy4S7
        t6Mac0vslefgFAN8xCPLl2o4wJvM1q5ZnB50i9cXYQy5vzyn0VGqhqrzf652vdP2R8IFGXbN9Yj
        WSh7JzFF+U72OdMbRNhmLXUVF
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947297wmh.3.1688028157032;
        Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+iH2URekcBBIFaPW3s8y3AcFdwpt0qhkGkVRHNjX6kI62bNLzHfSyF8zFoO0Ym2TuJLWyPg==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947276wmh.3.1688028156751;
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b003111025ec67sm15279253wrm.25.2023.06.29.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Message-ID: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     longli@linuxonhyperv.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>, stable@vger.kernel.org
Date:   Thu, 29 Jun 2023 10:42:34 +0200
In-Reply-To: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
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

On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
>=20
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue. Excessive MMIO writes result in CPU spending more
> time waiting on LOCK instructions (atomic operations), resulting in
> poor scaling performance.
>=20
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
>=20
> With this change, tests showed an improvement from 120G/s to 160G/s on a
> 200G physical link, with 16 or 32 hardware queues.
>=20
> Tests showed no regression in network latency benchmarks on single
> connection.
>=20
> While we are making changes in this code path, change the code for
> ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> hardware specification specifies that it should set to 0. Although
> currently the hardware doesn't enforce the check, in the future releases
> it may do.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")

Uhmmm... this looks like a performance improvement to me, more suitable
for the net-next tree ?!? (Note that net-next is closed now).

In any case you must avoid empty lines in the tag area.

If you really intend targeting the -net tree, please repost fixing the
above and explicitly specifying the target tree in the subj prefix.

thanks!

Paolo

