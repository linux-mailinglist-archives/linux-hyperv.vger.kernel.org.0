Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F773F7AA
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjF0Ip6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jun 2023 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0Ip5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jun 2023 04:45:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D10A4;
        Tue, 27 Jun 2023 01:45:56 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 63D7C207D83C; Tue, 27 Jun 2023 01:45:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63D7C207D83C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687855556;
        bh=i7MGykSxqd5wwaW7dH5l/H8ZR+ffdXIPeQyp76AdqDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtO3asfv0UIIlFb5+/StVJLrjEx3x7rXjXK38QwCRISnJw7ILGSCDFwzV0BgbUaTW
         1n/ujUtTvgvo7bfdCygQXoCQohpsg4BtPEvLrJ7FlN3K/y8RWCkeMZwuiyq5V2x1iA
         ZffNwrm0pGeqnCbqNQzGAYDPi4LgmjSJlb8uvw5Y=
Date:   Tue, 27 Jun 2023 01:45:56 -0700
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: Re: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230627084556.GD31802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
 <PH7PR21MB3116B7C4826A19F3103D6304CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3116B7C4826A19F3103D6304CA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 26, 2023 at 03:53:50PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> > Sent: Monday, June 26, 2023 5:20 AM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> > Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> > cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> > tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> > Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> > <schakrabarti@microsoft.com>; Souradeep Chakrabarti
> > <schakrabarti@linux.microsoft.com>
> > Subject: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
> > unresponsive
> 
> In general, two patches shouldn't have the same Subject.
> 
> For this patch set, the two patches are two steps to fix the unloading issue, and
> they are not very long. IMHO, they should be in one patch.
> 
> Thanks,
> - Haiyang
I will create a single patch in next version. As this fixes the unloading issue.
