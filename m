Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46C73F774
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjF0Ifm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jun 2023 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjF0IfH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jun 2023 04:35:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0E1B1B0;
        Tue, 27 Jun 2023 01:35:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id 168E7207D83C; Tue, 27 Jun 2023 01:35:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 168E7207D83C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687854905;
        bh=K4HFgVlcvPfQm78lAEPmPTT4urn6YNDo91cXDN2zB8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VD+yYVsDc4rAPZEi4myXvriUOzXzK9uTtXmHTHsVmjiMiJwb8oKH9g2QqtsmOwRYl
         Ttp9nnTmxfN87L/xnbn8KHVfdpJeMngVrwHOQntDlCtNxWiRT0cl2qMuO+ZHm7BZUb
         vNVKcAYhcWoz2BjacqhovPZIxfkor1ZUOgR+oM1g=
Date:   Tue, 27 Jun 2023 01:35:05 -0700
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Simon Horman <simon.horman@corigine.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
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
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230627083505.GA31802@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZJmNBKA3ygDryP7i@corigine.com>
 <SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230626134721.256c6c16@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626134721.256c6c16@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 26, 2023 at 01:47:21PM -0700, Stephen Hemminger wrote:
> On Mon, 26 Jun 2023 20:06:48 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
> 
> > > From: Simon Horman
> > > Sent: Monday, June 26, 2023 6:05 AM  
> > > > ...
> > > > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a
> > > > driver for
> > > > Microsoft Azure Network Adapter)  
> > > 
> > > nit: A correct format of this fixes tag is:
> > > 
> > > In particular:
> > > * All on lone line
> > > * Description in double quotes.
> > > 
> > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> > > Adapter (MANA)")  
> > 
> > Hi Souradeep, FYI I often refer to:
> > https://marc.info/?l=linux-pci&m=150905742808166&w=2
> > 
> > The link mentions:
> > alias gsr='git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
> > 
Thank you for the advice. Will use it from now onwards.
> > "gsr ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f" produces:
> > ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> You can do same thing without shell alias by using git-config
> 
> [alias]
> 	fixes = log -1 --format=fixes
> 	gsr = log -1 --format=gsr
> 
> [pretty]
> 	fixes = Fixes: %h (\"%s\")
> 	gsr = %h (\"%s\")
> 
> Then:
> $ git gsr 1919b39fc6eabb9a6f9a51706ff6d03865f5df29
> 1919b39fc6ea ("net: mana: Fix perf regression: remove rx_cqes, tx_cqes counters")
Thank you for the suggestion.
