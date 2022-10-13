Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717565FD67F
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Oct 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJMI4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Oct 2022 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJMI4e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Oct 2022 04:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F111D985
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Oct 2022 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665651393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWmJJ7tdKeTxLJ2ihy3nss5D3o4zsrHdrclXvSYrvos=;
        b=iHL/8G309rNJOfesqjxj5bNSDgMoeEDttAXULghtPPoY0x1fSKiz1ZukohdISwHUWPIZGH
        Gcer4No2CMcQPL+Jf6KQukeo4/UZiYPCkogYZrGYYWjmvQy4RCkxQ14CfPmjpJiYtFGDrS
        VnwOCxuefx+I4CN/WHRFJX9CUReo0oc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-KjhoN_8lMhiY01HiAJYzqQ-1; Thu, 13 Oct 2022 04:56:32 -0400
X-MC-Unique: KjhoN_8lMhiY01HiAJYzqQ-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003c56437e529so523853wmh.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Oct 2022 01:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OWmJJ7tdKeTxLJ2ihy3nss5D3o4zsrHdrclXvSYrvos=;
        b=fOoZ4OxP7i3bPKtzXdpovqfFLBzNduM/DsOBpu3+PPy65kyo/kOJamiljMGGkVa8ra
         5QpOlohJAJwgpLtNplREr5EsEgJEV0ZHrEip0K3n5RCUS32M9ryYAYPWIpelLDJHP5lO
         qz9uHbcwSai6I5SLI+kkH71SFb3NbT2iqLyV7TUiEKkWnTffaq9sv7BSo25NB87ihxub
         s1T8FNNQIeSFPVsNCRz10IQNJMPhVe576yRUszyv5lfhU1Afsfnl/V19g9IXW/jhaeOv
         3vCzAKAWIGnn3EYGqaiyq33CgsXJyaiBm4Pl78oM3VHCGirNJ8huRWe2WwQdQhyqUqhp
         Cl1g==
X-Gm-Message-State: ACrzQf3rEKWwwRgnntnFrBI1Jw9xKbtcIlpEFqMsrlO9qatz6TWvMA4S
        DzOeCgeqVweb7x0/3w/45oGQDUTN3YMP6oxvqy5nH3F0GhnGdSemwcuA4RRA0/yFHiq3FbRB7yX
        7TzB8x7+A5SoXQm2eT5l/Pm4k
X-Received: by 2002:a05:600c:1291:b0:3c6:9ed5:7bb1 with SMTP id t17-20020a05600c129100b003c69ed57bb1mr5651429wmd.205.1665651389864;
        Thu, 13 Oct 2022 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6zBtVFTk6p7NJAlsSz+xOnO7y4M5i5HyvAD8uKoPBrShiyyjtebhAyV0/y9BOXUCkWnD15WQ==
X-Received: by 2002:a05:600c:1291:b0:3c6:9ed5:7bb1 with SMTP id t17-20020a05600c129100b003c69ed57bb1mr5651415wmd.205.1665651389547;
        Thu, 13 Oct 2022 01:56:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c204a00b003c6bd12ac27sm3782546wmg.37.2022.10.13.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:56:28 -0700 (PDT)
Message-ID: <e71426117517a62f4e940318b1c048f15d8fe5b7.camel@redhat.com>
Subject: Re: [PATCH v2] hv_netvsc: Fix a warning triggered by memcpy in
 rndis_filter
From:   Paolo Abeni <pabeni@redhat.com>
To:     Cezar Bulinaru <cbulinaru@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 13 Oct 2022 10:56:27 +0200
In-Reply-To: <20221012013922.32374-1-cbulinaru@gmail.com>
References: <20221012013922.32374-1-cbulinaru@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

On Tue, 2022-10-11 at 21:39 -0400, Cezar Bulinaru wrote:
> A warning is triggered when the response message len exceeds
> the size of rndis_message. Inside the rndis_request structure
> these fields are however followed by a RNDIS_EXT_LEN padding
> so it is safe to use unsafe_memcpy.
> 
> memcpy: detected field-spanning write (size 168) of single field "(void *)&request->response_msg + (sizeof(struct rndis_message) - sizeof(union rndis_message_container)) + sizeof(*req_id)" at drivers/net/hyperv/rndis_filter.c:338 (size 40)
> RSP: 0018:ffffc90000144de0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8881766b4000 RCX: 0000000000000000
> RDX: 0000000000000102 RSI: 0000000000009ffb RDI: 00000000ffffffff
> RBP: ffffc90000144e38 R08: 0000000000000000 R09: 00000000ffffdfff
> R10: ffffc90000144c48 R11: ffffffff82f56ac8 R12: ffff8881766b403c
> R13: 00000000000000a8 R14: ffff888100b75000 R15: ffff888179301d00
> FS:  0000000000000000(0000) GS:ffff8884d6280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055f8b024c418 CR3: 0000000176548001 CR4: 00000000003706e0
> Call Trace:
>  <IRQ>
>  ? _raw_spin_unlock_irqrestore+0x27/0x50
>  netvsc_poll+0x556/0x940 [hv_netvsc]
>  __napi_poll+0x2e/0x170
>  net_rx_action+0x299/0x2f0
>  __do_softirq+0xed/0x2ef
>  __irq_exit_rcu+0x9f/0x110
>  irq_exit_rcu+0xe/0x20
>  sysvec_hyperv_callback+0xb0/0xd0
>  </IRQ>
>  <TASK>
>  asm_sysvec_hyperv_callback+0x1b/0x20
> RIP: 0010:native_safe_halt+0xb/0x10
> 
> Signed-off-by: Cezar Bulinaru <cbulinaru@gmail.com>

Could you please additionally provide a suitable 'Fixes' tag?

You need to repost a new version, including such tag just before your
SoB. While at that, please also include the target tree in the subj
prefix (net).

On this repost you can retain the ack/review tags collected so far.

Thanks,

Paolo

