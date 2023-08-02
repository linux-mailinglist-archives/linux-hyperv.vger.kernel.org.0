Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE576C4F0
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHBFhH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjHBFhG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 01:37:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FCAFE4;
        Tue,  1 Aug 2023 22:37:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id E6B10238AF65; Tue,  1 Aug 2023 22:37:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6B10238AF65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690954624;
        bh=llvx4mdfvSj5J9l9m59JQT19sx7YAHn2YDSG1Mqh4zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXeucYayypWB4Kio0+xxOSHEZRvpMym5mJtcgLvrT2yZlil5eZM/tWaHJtEkIUWiP
         FF8Vo+uFbn0zN1C/cQslGXIeVX0ojBDCdxMUZstsuVdhBv0IvOOX96FOhvqpxx51wT
         0XNmljKGS06jFaD5DcQ/XkZQ6NFNWwgR/P0q/eio=
Date:   Tue, 1 Aug 2023 22:37:04 -0700
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        Simon Horman <horms@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
 hardware is
Message-ID: <20230802053704.GA3488@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZMklUch+vfZBqfAr@kernel.org>
 <PUZP153MB0788A2C4FC7A76D2CDD021BCCC0AA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <CAH-L+nPsuoJfCQcJnpMWk5DPGev8f+YWi0K4V+fU=5-bxP5GVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nPsuoJfCQcJnpMWk5DPGev8f+YWi0K4V+fU=5-bxP5GVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 02, 2023 at 10:57:52AM +0530, Kalesh Anakkur Purayil wrote:
> Hi Souradeep,
> 
> It looks like the subject line is not complete. I could see "net: mana: Fix
> MANA VF unload when hardware is".
> 
> Is that correct?
> 
> Regards,
> Kalesh
>
Yes, it got truncated. Will fix it in next version. 
> On Wed, Aug 2, 2023 at 12:29 AM Souradeep Chakrabarti <
> schakrabarti@microsoft.com> wrote:
> 
> >
> >
> > >-----Original Message-----
> > >From: Simon Horman <horms@kernel.org>
> > >Sent: Tuesday, August 1, 2023 9:01 PM
> > >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > >kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> > >Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> > >cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets
> > ><vkuznets@redhat.com>; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> > >netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > >rdma@vger.kernel.org; Souradeep Chakrabarti
> > ><schakrabarti@microsoft.com>; stable@vger.kernel.org
> > >Subject: [EXTERNAL] Re: [PATCH V7 net] net: mana: Fix MANA VF unload when
> > >hardware is
> > >
> > >On Tue, Aug 01, 2023 at 05:29:13AM -0700, Souradeep Chakrabarti wrote:
> > >
> > >...
> > >
> > >Hi Souradeep,
> > >
> > >
> > >> +    for (i = 0; i < apc->num_queues; i++) {
> > >> +            txq = &apc->tx_qp[i].txq;
> > >> +            while (skb = skb_dequeue(&txq->pending_skbs)) {
> > >
> > >W=1 builds with both clang-16 and gcc-12 complain that they would like an
> > >extra set of parentheses around an assignment used as a truth value.
> > Thanks for letting me know. I will fix it in next version.
> > >
> > >> +                    mana_unmap_skb(skb, apc);
> > >> +                    dev_consume_skb_any(skb);
> > >> +            }
> > >> +            atomic_set(&txq->pending_sends, 0);
> > >> +    }
> > >>      /* We're 100% sure the queues can no longer be woken up, because
> > >>       * we're sure now mana_poll_tx_cq() can't be running.
> > >>       */
> > >> --
> > >> 2.34.1
> > >>
> > >>
> >
> >
> 
> -- 
> Regards,
> Kalesh A P


