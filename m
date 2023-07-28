Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152227673A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG1RnS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjG1RnQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 13:43:16 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3010CB
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 10:43:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ae0784e0bso110078685a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690566194; x=1691170994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow1dOB44syTAe0NpfhihQwAompkV9GWSbhBvMRdYVTQ=;
        b=Ouhhw6u7fqADJY+H1/kFxhxmp2WKsqPyd03Mlv5dUG0DmvPy9caWPbD1AvCkvGYbWe
         1kLa0VVzdrCbfWm+rqWk9WsLPe+jFF1Zi7i2Ut2T9rY+MpLK7fh0NEblFrvF2djUssq7
         F+fxk1WcuUjH9a9p7T9UXCMqzVOHGcIC/A4wQL3T0r/pJ8cyWQbVwr1cqf5m3WjvYkbL
         AejUb+m5m7NR5Y3nppmUsxomi56ZmV904voI9terGcp9GZaBXll39GTC6ztqPGWmC2fz
         b/9J/bwNHZIbQRfvPCKH3fLM1b/mm5+lA1YfVxCKL6EThXIF0Y0GRBFXTxXo2aVYVyqy
         wapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566194; x=1691170994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow1dOB44syTAe0NpfhihQwAompkV9GWSbhBvMRdYVTQ=;
        b=j7bsx2VD7AGHeGtGMVgdohkEcZJtf/W8Jtc93GRmSfz+zmBvb2XypXjEmaTOaVaCtd
         bxq+ElrwDIKEaVQybOd16XUbVSDeSempX7gpP53cWfKdOmiM/nYVXSurne/9UVTsKeAg
         ycorEQ0EW8bjT1acBOViCUUD+hu3vyu8KdC6ssoefyPtsrRa+HnSqXeINQQbKcWyb9rv
         w4ZSjSpzy64kQ/UaxbBtVtw6CEIPqIIWGJPaJRU1K+/u63P2/ZY3FZfJdH0WyjmNLUOd
         FE1IdEbDv74PDYZqLznsUhVoyNxbNQfXSU3s1ZxyheByB8Dm1Qk2QflqQOv9vcSNdxgX
         nOEA==
X-Gm-Message-State: ABy/qLbowvl/hKqg5O+7zfxjgpyK+2Zj/cNgFZSSeiSywOXQnO74NttN
        yDpUdNHc1daeOgJY6h75sJYcMQ==
X-Google-Smtp-Source: APBJJlEf/l5iXtW9hUonbvLBpNRFVYCeb6kxyBQ2YKwEADRmvKg5uR+6zMAiiWhpmjOswALp7BGS5w==
X-Received: by 2002:a05:620a:4082:b0:767:1d7e:ec3d with SMTP id f2-20020a05620a408200b007671d7eec3dmr5043744qko.2.1690566194647;
        Fri, 28 Jul 2023 10:43:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a15a700b007682634ac20sm1274983qkk.115.2023.07.28.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:43:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qPRUe-001fhT-S8;
        Fri, 28 Jul 2023 14:43:12 -0300
Date:   Fri, 28 Jul 2023 14:43:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wei Hu <weh@microsoft.com>
Cc:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vkuznets@redhat.com,
        ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMP+MH7f/Vk9/J0b@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728170749.1888588-1-weh@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> handler when completion interrupt happens. EQs are destroyed when
> ucontext is deallocated.

It seems strange that interrupts would be somehow linked to a
ucontext? interrupts are highly limited, you can DOS the entire system
if someone abuses this.

Generally I expect a properly functioning driver to use one interrupt
per CPU core.

You should tie the CQ to a shared EQ belong to the core that the CQ
wants to have affinity to.

Jason
