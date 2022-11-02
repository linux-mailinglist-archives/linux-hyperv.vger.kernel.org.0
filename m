Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA5616A06
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 18:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKBRIT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBRIR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 13:08:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280C15FFD
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Nov 2022 10:08:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h206so12076803iof.10
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Nov 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=docker.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYpb4d0goOw4Qakn303/fmOhgAIywNtc7WDJeQRPfyI=;
        b=Kq7IwIHGR1V6/baYeT2eDh5Y4bSEGpfBS7B08g6NLbQhphskuNcyelhtTtbycYkAMM
         86aepi4OkIf4jLOV2Vr/QNeA8CDd8pAzbdPIIKMcjQdpl65LfTtLh94c146ypWyL/MqT
         epxM4ECPHB6upmujHKvyW2hMZSkQUMv98tSn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYpb4d0goOw4Qakn303/fmOhgAIywNtc7WDJeQRPfyI=;
        b=6qu8ShLtmDLsUwRfxvrpWYejYItic2XdGpTlObagYZX7d9xrjX60dDlggT+KvWACkH
         VUQW5+3b2psyMOE753THIgc9+h1gNrBjQXSC16dtZHoMk6rco0DPac2iJvKo3kU8DMAG
         np9nEIrpJrAtJCG9BZcl+2Jw+gntz+o88oTKFl5/MFWpLFj3ABrvWBJ3aJ9k+f+L3L+c
         w7x/0pVnGYsb/7W999n+HfmBLnwnpHgzM7FJIebPTcprCwI25d0+lZGk4tX+qcTavpwl
         uMZuL5FyZks39GP6WKxZ9MAlZ9k4fTosw+vOYiNe/IX2387CdtT4DGSTrr3RQBRt6O0k
         dV3A==
X-Gm-Message-State: ACrzQf3G8qblN++eqqxIn/dluIAGr2Qht468/dRT9nGGU3f0AkIHFDfD
        La/puVM78lhTY8Uz3uDG8b22TlKqzINW3l0RrBVGng==
X-Google-Smtp-Source: AMsMyM5qV5kZNIawOYXAXvYYQOMoQBp1yfN5MVvXg41kmZNpBZM1irQma9pnpokWz9vReEDPyEs6PxMzR/syikwq/KI=
X-Received: by 2002:a5d:8913:0:b0:6a4:71b5:8036 with SMTP id
 b19-20020a5d8913000000b006a471b58036mr16071369ion.171.1667408894004; Wed, 02
 Nov 2022 10:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028205646.28084-1-decui@microsoft.com> <20221028205646.28084-3-decui@microsoft.com>
 <20221031084327.63vikvodhs7aowhe@sgarzare-redhat> <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
 <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
In-Reply-To: <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
From:   Frederic Dalleau <frederic.dalleau@docker.com>
Date:   Wed, 2 Nov 2022 18:08:03 +0100
Message-ID: <CANWeT6hWU0tH6sBCUkxnfA21_qxcFuk56sqy=ZHgEJHogxqY5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in vsock_connectible_wait_data()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     wei.liu@kernel.org, netdev@vger.kernel.org, haiyangz@microsoft.com,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        stephen@networkplumber.org, edumazet@google.com, kuba@kernel.org,
        arseny.krasnov@kaspersky.com, decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Did you use scripts/get_maintainer.pl?
Not really, I just picked the list that seemed narrow enough for the topic

> respond with your Tested-by?
Done

> I would like to give credit to both, so I asked to add your Reported-by
> to the Dexuan's patch.
Thank you!

Regards,
Fr=C3=A9d=C3=A9ric
