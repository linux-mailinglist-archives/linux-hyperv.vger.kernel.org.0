Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34DE52A5DB
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 May 2022 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349782AbiEQPTY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 May 2022 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiEQPTX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 May 2022 11:19:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5F37A0A
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 08:19:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso2523905pjb.3
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtCVu5kwlt/0GeeCJHb+/bnS0itYTikVVYx8LL9uX0w=;
        b=3RKQV6tsbyrmUfidQNrHgRSDxahUsw5KwHXeTnnuzXwmOO18WyoB6EVhZRXSLdFM4j
         zhKtx7nP76meXVYhp6sQx/QMcfYgtsiaFpTnDO86tdqLDdvxA0bCTrmjvlmZISP5TF74
         M6vIq8BT7levvC+TleV3x9XzZHcvBWx4E8V7E++SXUVQvSk+20pqNJeTU26CVDOe65Lm
         eKfT6swZRtxVqSSk5TDWZTCof+IXc0eiwsclaJWZ7VOyBUUwUZIvNxx6DzGSBUGog4O1
         E93CV0Ocu5nWcuXRgZrxWu8sGpGTGuj0ygKK7NO9RR02tXT8ctEw8u+Sr1h1ovusMGW4
         55Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtCVu5kwlt/0GeeCJHb+/bnS0itYTikVVYx8LL9uX0w=;
        b=mNNF1PFeH0X9ri3RWIv08bkGSDzgiH1OiEv1cC8FosYjU2jha5KRWvVYm1ylHekDMG
         w6HPjbTVQIE4ICDxg5CuibUEjDQTMDRjqjSBN8t1o9EnEgzU3F07WJdAvNw4QXRSewcJ
         9yAhm/s8/9hRgViC4BpN3Sph0+4hpWoVSF6OL+Z1CeCdG9RHDFm5y7qqAA7T6TL9+nS8
         q5RlqsyjcRKk4kXmIwyHXgadjkB7drGbi7O9ewNpPLjeNt0cTFs1GGcUkdZKhHXYHK5l
         AscGJES2fJQoNFcLG/X0PqIl9ZFuBc2sZvgnvbIPj1ADeARAKorQoNK7y1waBhnn9Xn3
         8dFg==
X-Gm-Message-State: AOAM530XvXQAv7o77ERUuRNiTeWHARugFOq8+433QES8/yrTzTe+idrN
        b3BSTAcA7TZ6dSE4bZ4+7ADW6Q==
X-Google-Smtp-Source: ABdhPJwfcOh/4LoIXBpkam4xGXt5zJ1nliaKG8JzVlw5Aie6/aZ/7LkEJQUh+M7FdG8XsHexJ6E/Zg==
X-Received: by 2002:a17:903:248:b0:155:e660:b774 with SMTP id j8-20020a170903024800b00155e660b774mr22794133plh.174.1652800762271;
        Tue, 17 May 2022 08:19:22 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b0016144a84c31sm7127822pla.119.2022.05.17.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:19:21 -0700 (PDT)
Date:   Tue, 17 May 2022 08:19:18 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     longli@linuxonhyperv.com
Cc:     longli@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 03/12] net: mana: Handle vport sharing between devices
Message-ID: <20220517081918.655fe626@hermes.local>
In-Reply-To: <1652778276-2986-4-git-send-email-longli@linuxonhyperv.com>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
        <1652778276-2986-4-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 17 May 2022 02:04:27 -0700
longli@linuxonhyperv.com wrote:

> diff --git a/drivers/net/ethernet/microsoft/mana/mana.h b/drivers/net/ethernet/microsoft/mana/mana.h
> index 51bff91b63ee..26f14fcb6a61 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana.h
> +++ b/drivers/net/ethernet/microsoft/mana/mana.h
> @@ -375,6 +375,7 @@ struct mana_port_context {
>  	unsigned int num_queues;
>  
>  	mana_handle_t port_handle;
> +	atomic_t port_use_count;

Could this be a refcount_t instead?
The refcount_t has protections against under/overflow.
