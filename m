Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED4767425
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjG1SCl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jul 2023 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1SCk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jul 2023 14:02:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593993C1F
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 11:02:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bb231f1817so1673632a34.3
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jul 2023 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690567358; x=1691172158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEzxvMzQhe+aFw/a+Xbe6lGzH8JrChN+Z8lQ7mk28aE=;
        b=ScA6cwcWmNwMdsimpAwO6rLZQSvnT/clp4CKPqnsz4wOFo6JlJEkobkY2/u1nvPoIv
         kSkgTSZJiMcPKrk7dOV/fbEWZ3et5y/L0qklgUAf9vfa5Y50UqjZ3yVdOqNDWliQCV4R
         kIqmafyIqJUeXjixtnK8RQLUgRS0U81rJMQFqBTUSuLOchrMz0Q6zWxePBC9cwSwqCUc
         ZeyGRAJTKpHeDafbPHXjwLR4HQSLOYM5bHmrDuuT1ON4j87XRUwKoaRFbyPwZBA7+rp2
         DbwM3rTTrkr3QpAT1ABIXtv4zEzmmEYNltU5bMLEa8EWCRaykXaErQRELlwZ/gDUxel7
         izXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567358; x=1691172158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEzxvMzQhe+aFw/a+Xbe6lGzH8JrChN+Z8lQ7mk28aE=;
        b=kJKo8VO5Lo48KliyjrvElFtLgRDe0XukCrZlqeGrzm0cV+aSuavJAuZ+6GrG/nFzGp
         ri4lB9KOSMLrNcRkXi3pQDjIjj0dxVshi9XpBjLw8R9j46djqbwBlY6mOmpIUnG6eS+w
         j7yPtus2kwwuUze2A8am5IFwAKWUavzhEW3GnfGM8XMF2XBvD+W6LVxTIQgo0MVYs+Lv
         f/rpPIEc2l1xiqjAe7K/Z5tqcKo/JiiOwMRcTLePGqP2/njoluJoIAh5mwpX1dvxYSlx
         VZxMK4l7LepXrtJzaqW5eXheaMIgFnD9mFoWDaygBXriJ7nggrdm1fGhtXK8Xr8bcIRo
         gHTA==
X-Gm-Message-State: ABy/qLakLLQCkhz8vyqVSOTmDSwgzoajjQE9+rBwxi0itZkYS69Z3VB9
        6gqLGmqW6yUxY2JPlPPgoiOvqA==
X-Google-Smtp-Source: APBJJlEv2VmPAlHU14LlDhvqiR7Wi89nHv8L3mYJR0P8VC9gRtAxmL9tlIyiZRyAhUXMVsry+vWCKQ==
X-Received: by 2002:a9d:67ca:0:b0:6b9:4b45:42ca with SMTP id c10-20020a9d67ca000000b006b94b4542camr3076466otn.25.1690567358536;
        Fri, 28 Jul 2023 11:02:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cf212000000b0063007ccaf42sm1414844qvk.57.2023.07.28.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:02:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qPRnN-001fpu-71;
        Fri, 28 Jul 2023 15:02:33 -0300
Date:   Fri, 28 Jul 2023 15:02:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMQCuQU+b/Ai9HcU@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 28, 2023 at 05:51:46PM +0000, Long Li wrote:
> > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
> > driver.
> > 
> > On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > > Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> > > to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> > > handler when completion interrupt happens. EQs are destroyed when
> > > ucontext is deallocated.
> > 
> > It seems strange that interrupts would be somehow linked to a ucontext?
> > interrupts are highly limited, you can DOS the entire system if someone abuses
> > this.
> > 
> > Generally I expect a properly functioning driver to use one interrupt per CPU core.
> 
> Yes, MANA uses one interrupt per CPU. One interrupt is shared among multiple
> EQs.

So you have another multiplexing layer between the interrupt and the
EQ? That is alot of multiplexing layers..

> > You should tie the CQ to a shared EQ belong to the core that the CQ wants to have
> > affinity to.
> 
> The reason for using a separate EQ for a ucontext, is for preventing DOS. If we use
> a shared EQ, a single ucontext can storm this shared EQ affecting
> other users.

With a proper design it should not be possible. The CQ adds an entry
to the EQ and that should be rate limited by the ability of userspace
to schedule to re-arm the CQ.

Jason
