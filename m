Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23E71297A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 May 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjEZP2e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 May 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjEZP2c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 May 2023 11:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A11BF;
        Fri, 26 May 2023 08:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F72C650E5;
        Fri, 26 May 2023 15:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0DAC433EF;
        Fri, 26 May 2023 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685114901;
        bh=LCSRCtx+txpAlMWcHwFZ0OLjSSHA39brvSCzsYhZqJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEdr5gtIfYVukLgXLz6UnzVWJUAoI0fVU2VjZsFbTyrxeXmkR2ZSNFdKpoPo9en1z
         Apq9eKZ9dTBJ8tA40YrW8fcJyIw3gGsfyVpjGPEL51uSnDnCE4wok0EmdVGLdoPX+r
         wGQ42fSYWV+Jparf8CDubBjXgHCIncC0m3RZAob61o2MY2xypt6k3eRxHU/m8q65Fd
         bG8PAwa7rmFmEr4WX7qNbJIIF3xYxU4qBWzWqbcpqaLS5+OJSER6zKILW/i2/yuyGV
         vTCQPG39gL77IX8r1toBhYxr8MvwMUWm+3H64ZzeHaoCy/ygZVXq8Gj8Vfr2HWmdgS
         n2Jf/L5vKmJ2A==
Date:   Fri, 26 May 2023 08:28:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH V2,net] net: mana: Fix perf regression: remove rx_cqes,
 tx_cqes counters
Message-ID: <20230526082819.26ab0a9a@kernel.org>
In-Reply-To: <PH7PR21MB311639268988CD72DA545774CA47A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1685025990-14598-1-git-send-email-haiyangz@microsoft.com>
        <20230525202557.5a5f020b@kernel.org>
        <PH7PR21MB311639268988CD72DA545774CA47A@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 26 May 2023 14:42:07 +0000 Haiyang Zhang wrote:
> > Horatiu's ask for more details was perfectly reasonable.
> > Provide more details to give the distros and users an
> > idea of the order of magnitude of the problem. Example
> > workload and relative perf hit, anything.  
> 
> For example, a workload is iperf with 128 threads, and with RPS enabled.
> We saw perf regression of 25% with the previous patch adding the counters.
> And this patch eliminates the regression. 

Exactly what I was looking for, thanks. Please put that in the commit
message and post v3 (feel free to add the review tags which came in for
v1 in the meantime).
