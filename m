Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC270F94E
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 May 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjEXOyq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 May 2023 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjEXOyl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 May 2023 10:54:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0B1707
        for <linux-hyperv@vger.kernel.org>; Wed, 24 May 2023 07:54:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so3046415ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 24 May 2023 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1684940045; x=1687532045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuxm9M1T3VcSvc5bTzwUGDZCKtGjaiDhJDWNan/MCa8=;
        b=Ivj1gErGOAs0CsMEmRVCQZq3pnia3PQNEWq1PjGjMt4PKgdmLMHr38KozFdZOqen1v
         DCSNXgshzAAG4PTXvZm6rsJSKth8Zg78NLZ99htWzKr0z2k6CFDmAaxmoIP1N35tczkM
         wxT6kdTUb9HlIT/cLOdadD/ILbDe/OxT0/tVOEpjNFrXM7eeNfzvlQtUVF9kd1nxmFYH
         eJacO5abhAMaKenGcxZ6cNrPV+w2JwrfUZuCiBat0TEEY9Q2C8Na7aVlAlY8GB+1mxci
         wry3jkNre1koSM0WkDatTlYH58J0VjmgiZG/dOh2buajWDqg3ppPf+UBvi31sW9iJzGx
         MHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940045; x=1687532045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuxm9M1T3VcSvc5bTzwUGDZCKtGjaiDhJDWNan/MCa8=;
        b=d4MJOm7c1KhMHGJG1i/vjU7JnzfAaPQAmFawedN88RGmiIPYlxMWC+/4aeRitb2XDy
         khL2u3pzKakLY9roZI8AcUPzs6IhdHIVbEX47yTmVRozhZuixatGkLy9Idk5BGRt2Hwi
         MhkZnzALzz8WqF0WyCUOY28EjVISWGSK9DIGaWFhktcVbTWbfzoom9dtvnGBBZk3F23c
         PrOW0KPn8S3sQkh/vL9QBrIWaLTErt7aXLEKyuJ+xO6T09bvz/SJdsfanZmY3EynfWJw
         HQj4Xwq10l3+eDPOaXme+n81iSdF1U9YLRn8kksO8adpfrR2wZ3LQgmsS8VvsNmj+Fpw
         6tjw==
X-Gm-Message-State: AC+VfDzuDPvAUne0pvM35cCRjtgsmOf84QVv2Aw8csrVp9iM90Z7yPo6
        US8KN2nJn19FQ5sVjbVHVTFMGQ==
X-Google-Smtp-Source: ACHHUZ51qbwXblR3G0pv9Jz0roNc8j1oL351D2D/C8WQgTfKRJyqNp2N2Tg6lfArSVtLtCqSTOb3uw==
X-Received: by 2002:a17:902:d345:b0:1a2:6257:36b9 with SMTP id l5-20020a170902d34500b001a2625736b9mr18031174plk.31.1684940045181;
        Wed, 24 May 2023 07:54:05 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm8812715plr.197.2023.05.24.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:54:05 -0700 (PDT)
Date:   Wed, 24 May 2023 07:54:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2] hv_netvsc: Allocate rx indirection table size
 dynamically
Message-ID: <20230524075402.3a0e36bc@hermes.local>
In-Reply-To: <1684922230-24073-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1684922230-24073-1-git-send-email-shradhagupta@linux.microsoft.com>
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

On Wed, 24 May 2023 02:57:10 -0700
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> @@ -1034,7 +1035,9 @@ struct net_device_context {
>  
>  	u32 tx_table[VRSS_SEND_TAB_SIZE];
>  
> -	u16 rx_table[ITAB_NUM];
> +	u16 *rx_table;
> +
> +	int rx_table_sz;
Size should never be negative, use u32 or u16 here?
