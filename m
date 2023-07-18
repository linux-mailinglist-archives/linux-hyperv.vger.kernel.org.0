Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384ED757929
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jul 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGRKSs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRKSr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 06:18:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C72BD;
        Tue, 18 Jul 2023 03:18:46 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id C2418232AD57; Tue, 18 Jul 2023 03:18:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2418232AD57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689675525;
        bh=6XGcDhIWrhS23tD6OwMQQJa/j5MXYUXS0CKJz9pthPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQIFUHHMEi1O3hQvxP8eYYA4ZWRBtBVbDAATEZhC1DdLBFlVrT7GkNbdRe09o/sbs
         vlPjlNtLUv9vhFrMQ+oIXuiWpRNq6MXagDjUMDBiRMuRKOIHd+7Co90Hh9e0QgBqkc
         uKrO/P9hrSDr9YT5FXWASiCeUezrmkRel6316iE0=
Date:   Tue, 18 Jul 2023 03:18:45 -0700
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
Message-ID: <20230718101845.GA24931@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
 <PH7PR21MB3116F77C196628B6BBADA3C7CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20230703043742.GA9533@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703043742.GA9533@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Sun, Jul 02, 2023 at 09:37:42PM -0700, Shradha Gupta wrote:
> On Thu, Jun 29, 2023 at 12:44:26PM +0000, Haiyang Zhang wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Sent: Thursday, June 29, 2023 5:59 AM
> > > To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > > netdev@vger.kernel.org
> > > Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > > <pabeni@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > > <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> > > (LINUX) <mikelley@microsoft.com>; David S. Miller <davem@davemloft.net>
> > > Subject: [PATCH] hv_netvsc: support a new host capability
> > > AllowRscDisabledStatus
> > > 
> > > A future Azure host update has the potential to change RSC behavior
> > > in the VMs. To avoid this invisble change, Vswitch will check the
> > > netvsc version of a VM before sending its RSC capabilities, and will
> > > always indicate that the host performs RSC if the VM doesn't have an
> > > updated netvsc driver regardless of the actual host RSC capabilities.
> > > Netvsc now advertises a new capability: AllowRscDisabledStatus
> > > The host will check for this capability before sending RSC status,
> > > and if a VM does not have this capability it will send RSC enabled
> > > status regardless of host RSC settings
> > > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > ---
> > >  drivers/net/hyperv/hyperv_net.h | 3 +++
> > >  drivers/net/hyperv/netvsc.c     | 8 ++++++++
> > >  2 files changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> > > index dd5919ec408b..218e0f31dd66 100644
> > > --- a/drivers/net/hyperv/hyperv_net.h
> > > +++ b/drivers/net/hyperv/hyperv_net.h
> > > @@ -572,6 +572,9 @@ struct nvsp_2_vsc_capability {
> > >  			u64 teaming:1;
> > >  			u64 vsubnetid:1;
> > >  			u64 rsc:1;
> > > +			u64 timestamp:1;
> > > +			u64 reliablecorrelationid:1;
> > > +			u64 allowrscdisabledstatus:1;
> > >  		};
> > >  	};
> > >  } __packed;
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index da737d959e81..2eb1e85ba940 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -619,6 +619,14 @@ static int negotiate_nvsp_ver(struct hv_device
> > > *device,
> > >  	init_packet->msg.v2_msg.send_ndis_config.mtu = ndev->mtu +
> > > ETH_HLEN;
> > >  	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q = 1;
> > > 
> > > +	/* Don't need a version check while setting this bit because if we
> > > +	 * have a New VM on an old host, the VM will set the bit but the host
> > > +	 * won't check it. If we have an old VM on a new host, the host will
> > > +	 * check the bit, see its zero, and it'll know the VM has an
> > > +	 * older NetVsc
> > > +	 */
> > > +	init_packet-
> > > >msg.v2_msg.send_ndis_config.capability.allowrscdisabledstatus = 1;
> > 
> > Have you tested on the new host to verify: Before this patch, the host shows
> > RSC status on, and after this patch the host shows it's off?
> I have completed the patch sanilty tests. We are working on an upgraded host setup
> to test the rsc specific changes, will update with results soon.
> > 
> > Thanks,
> > - Haiyang

Completed this testing, rsc status reflects properly with the patch.
