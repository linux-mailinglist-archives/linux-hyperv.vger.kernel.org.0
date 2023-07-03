Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B341745491
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jul 2023 06:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjGCEho (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Jul 2023 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCEho (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Jul 2023 00:37:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0405D1AB;
        Sun,  2 Jul 2023 21:37:43 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 7263A208F5BA; Sun,  2 Jul 2023 21:37:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7263A208F5BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688359062;
        bh=98TCDgh+qhihYtqPbBtXT0BEKRZ3kHNSyHjDAf+oyZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feEaWfBd4YMfWq1EeLD8WY7WGXUmYm1E4NuI6suImR+DOgHjAIx6MJG/XjOUJekT0
         4K2MnSErLSCGUC3/8HoFs5WF12G9RBUxIaI3RdY/WczwBV3Sg8T6AQm5G4ZNpzbv+K
         SknYnQgRWBTjnup9LPfUOY5Zd4agd8zhVKTwlBxc=
Date:   Sun, 2 Jul 2023 21:37:42 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] hv_netvsc: support a new host capability
 AllowRscDisabledStatus
Message-ID: <20230703043742.GA9533@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
 <PH7PR21MB3116F77C196628B6BBADA3C7CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3116F77C196628B6BBADA3C7CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
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

On Thu, Jun 29, 2023 at 12:44:26PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Sent: Thursday, June 29, 2023 5:59 AM
> > To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org
> > Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> > (LINUX) <mikelley@microsoft.com>; David S. Miller <davem@davemloft.net>
> > Subject: [PATCH] hv_netvsc: support a new host capability
> > AllowRscDisabledStatus
> > 
> > A future Azure host update has the potential to change RSC behavior
> > in the VMs. To avoid this invisble change, Vswitch will check the
> > netvsc version of a VM before sending its RSC capabilities, and will
> > always indicate that the host performs RSC if the VM doesn't have an
> > updated netvsc driver regardless of the actual host RSC capabilities.
> > Netvsc now advertises a new capability: AllowRscDisabledStatus
> > The host will check for this capability before sending RSC status,
> > and if a VM does not have this capability it will send RSC enabled
> > status regardless of host RSC settings
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  drivers/net/hyperv/hyperv_net.h | 3 +++
> >  drivers/net/hyperv/netvsc.c     | 8 ++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> > index dd5919ec408b..218e0f31dd66 100644
> > --- a/drivers/net/hyperv/hyperv_net.h
> > +++ b/drivers/net/hyperv/hyperv_net.h
> > @@ -572,6 +572,9 @@ struct nvsp_2_vsc_capability {
> >  			u64 teaming:1;
> >  			u64 vsubnetid:1;
> >  			u64 rsc:1;
> > +			u64 timestamp:1;
> > +			u64 reliablecorrelationid:1;
> > +			u64 allowrscdisabledstatus:1;
> >  		};
> >  	};
> >  } __packed;
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index da737d959e81..2eb1e85ba940 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -619,6 +619,14 @@ static int negotiate_nvsp_ver(struct hv_device
> > *device,
> >  	init_packet->msg.v2_msg.send_ndis_config.mtu = ndev->mtu +
> > ETH_HLEN;
> >  	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q = 1;
> > 
> > +	/* Don't need a version check while setting this bit because if we
> > +	 * have a New VM on an old host, the VM will set the bit but the host
> > +	 * won't check it. If we have an old VM on a new host, the host will
> > +	 * check the bit, see its zero, and it'll know the VM has an
> > +	 * older NetVsc
> > +	 */
> > +	init_packet-
> > >msg.v2_msg.send_ndis_config.capability.allowrscdisabledstatus = 1;
> 
> Have you tested on the new host to verify: Before this patch, the host shows
> RSC status on, and after this patch the host shows it's off?
I have completed the patch sanilty tests. We are working on an upgraded host setup
to test the rsc specific changes, will update with results soon.
> 
> Thanks,
> - Haiyang
