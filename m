Return-Path: <linux-hyperv+bounces-9993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKd/JanT0Wn9OQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9993-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Apr 2026 05:14:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A339D32C
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Apr 2026 05:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E75D83002F5E
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 03:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2B23FC5A;
	Sun,  5 Apr 2026 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X2t2U6ur"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA21F1304;
	Sun,  5 Apr 2026 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775358882; cv=none; b=EpLynJTrg5oTf9gcmcIo4qUiGsDgLbLh9Ief5SM2hoDaWWv8LO6xt54+kRuz796ite8bXVHnb3VvIhZHPS+4hh4Y4tXZkmp/jbX96oO6K5+hZmmKWnbUCJg2eHYzPMZ36uh6JLSHtzuJTyYtUf1+oQ7bozCNLmwFWAq1khhZeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775358882; c=relaxed/simple;
	bh=P7Zi725YLqzVdA8rZ6y665+moo1oSEn103nvnKydJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnQpcgKmZfPBxAOL+BTMqCOwro2Dryxo6jAxJrHZeln0+3/vw45vL3qpXP3YQxrofs5BAavgxNd9Zg7O5/ttHkWdzKvV7dXTEPZhKxxUsSpjmNzTnIfSnyklk9g/QGNW6zahxbR1/Mz13wpctdNe5t1mk+vGOjhIGbjuyfHMyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X2t2U6ur; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 1203C20B6F01; Sat,  4 Apr 2026 20:14:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1203C20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775358875;
	bh=0bIrpRaHD+mAUYoibbvyttAD2W1I8KUuNlGO0fbluV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2t2U6ur0kfYXDqeiiCh8PISRbLCDk9zLmiYCXxvqrA8WWupJNh/EeDUlNkySlhB8
	 4bmnyI0RN6Z4sc/2Snw9acNABIe59y/p9j6ef/iTghQQXyI0TFg7qtuIJh1uRLkm2k
	 pEnRSxQFeuLehYlIi3KzBz6oJCudJKil0lsRaJoI=
Date: Sat, 4 Apr 2026 20:14:35 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	leitao@debian.org, kees@kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next,v4] net: mana: Force full-page RX buffers via
 ethtool private flag
Message-ID: <adHTm2SvjDrezEdv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <acrkwuIFyBXhwICF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260330154755.6a8c73a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330154755.6a8c73a6@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9993-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8E9A339D32C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:47:55PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Mar 2026 14:01:54 -0700 Dipayaan Roy wrote:
> > On some ARM64 platforms with 4K PAGE_SIZE, page_pool fragment
> > allocation in the RX refill path can cause 15-20% throughput
> > regression under high connection counts (>16 TCP streams).
> 
> Did you investigate what makes such a difference exactly?
> As I said I suspect there are some improvements we could
> make in the page pool fragmentation logic that could yield
> similar wins without bothering the user.
>
I collected the perf numbers, shared the analysis below.
> > Add an ethtool private flag "full-page-rx" that allows the user to
> > force one RX buffer per page, bypassing the page_pool fragment path.
> > This restores line-rate(180+ Gbps) performance on affected platforms.
> > 
> > Usage:
> >   ethtool --set-priv-flags eth0 full-page-rx on
> > 
> > There is no behavioral change by default. The flag must be explicitly
> > enabled by the user or udev rule.
> > 
> > The existing single-buffer-per-page logic for XDP and jumbo frames is
> > consolidated into a new helper mana_use_single_rxbuf_per_page().
> 
> ethtool -g rx-buf-len could also fit the bill but I guess this is more
> of a hack / workaround than legit config so no strong preference.
> 
ok, want to stay with private flag.
> > -static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
> > +static void mana_get_strings_stats(struct mana_port_context *apc, u8 **data)
> >  {
> > -	struct mana_port_context *apc = netdev_priv(ndev);
> >  	unsigned int num_queues = apc->num_queues;
> >  	int i, j;
> >  
> > -	if (stringset != ETH_SS_STATS)
> > -		return;
> >  	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
> > -		ethtool_puts(&data, mana_eth_stats[i].name);
> > +		ethtool_puts(data, mana_eth_stats[i].name);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mana_hc_stats); i++)
> > -		ethtool_puts(&data, mana_hc_stats[i].name);
> > +		ethtool_puts(data, mana_hc_stats[i].name);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
> > -		ethtool_puts(&data, mana_phy_stats[i].name);
> > +		ethtool_puts(data, mana_phy_stats[i].name);
> >  
> >  	for (i = 0; i < num_queues; i++) {
> > -		ethtool_sprintf(&data, "rx_%d_packets", i);
> > -		ethtool_sprintf(&data, "rx_%d_bytes", i);
> > -		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
> > -		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
> > -		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
> > -		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
> > +		ethtool_sprintf(data, "rx_%d_packets", i);
> 
> Please factor out the noisy, no-op prep work into a separate patch for
> ease of review
Ack, will split it out in 2 separate patches in v5.
> -- 
> pw-bot: cr

Hi Jakub,

I did some perf analysis on the ARM64 platform for which we want to
have this work around of full page rx buffers:

test: ntttcp with 48 tcp connections
perf: perf record -ag --call-graph dwarf -C 0-33 -- sleep 32

Page pool overhead summary: 
(framgment based rx buff vs full page rx buff on the same ARM64
platform)

  Function                        Fragment   Full-page   Delta
  ─----------------------------   ─-------   ---------   -----
  napi_pp_put_page                  3.93%      0.85%    +3.08%
  page_pool_alloc_frag_netmem       1.93%         —     +1.93%
  Total page_pool overhead          5.86%      0.85%    +5.01%

In fragment mode, napi_pp_put_page performs an atomic decrement of
the shared page refcount on every packet free. This single operation
accounts for ~3% more CPU than in full-page mode, where the page is
sole-owned and the atomic is skipped entirely. Additionally,
page_pool_alloc_frag_netmem adds ~2% overhead on the allocation
path for fragments.

Further annotation of the hot page pool functions in fragment mode
shows:

napi_pp_put_page:

    0.09 :   ffff80008117c240:       b       ffff80008117c268
<napi_pp_put_page+0x68>
         : 64               ATOMIC64_FETCH_OP(        , al, op, asm_op,
"memory")
         :
         : 66               ATOMIC64_FETCH_OPS(andnot, ldclr)
         : 67               ATOMIC64_FETCH_OPS(or, ldset)
         : 68               ATOMIC64_FETCH_OPS(xor, ldeor)
         : 69               ATOMIC64_FETCH_OPS(add, ldadd)
    0.00 :   ffff80008117c244:       mov     x3, #0xffffffffffffffff
// #-1
    0.08 :   ffff80008117c248:       add     x0, x2, #0x28
    0.06 :   ffff80008117c24c:       ldaddal x3, x3, [x0]
         : 73               }
         :
         : 75               ATOMIC64_OP_ADD_SUB_RETURN(_relaxed)
         : 76               ATOMIC64_OP_ADD_SUB_RETURN(_acquire)
         : 77               ATOMIC64_OP_ADD_SUB_RETURN(_release)
         : 78               ATOMIC64_OP_ADD_SUB_RETURN(        )
   88.09 :   ffff80008117c250:       sub     x3, x3, #0x1
         :
         : 81               return 0;
         : 82               }

88% of this function's cycles stall on the sub that depends on
ldaddal.


page_pool_alloc_frag_netmem:

         : 151              ATOMIC64_FETCH_OPS(add, ldadd)
    0.00 :   ffff8000811fd40c:       add     x1, x21, #0x28
    0.14 :   ffff8000811fd410:       ldaddal x0, x1, [x1]
         : 154              }
         :
         : 156              ATOMIC64_OP_ADD_SUB_RETURN(_relaxed)
         : 157              ATOMIC64_OP_ADD_SUB_RETURN(_acquire)
         : 158              ATOMIC64_OP_ADD_SUB_RETURN(_release)
         : 159              ATOMIC64_OP_ADD_SUB_RETURN(        )
   75.09 :   ffff8000811fd414:       add     x0, x0, x1
         : 161              WARN_ON(ret < 0);
    0.16 :   ffff8000811fd418:       cmp     x0, #0x0
    0.00 :   ffff8000811fd41c:       b.lt    ffff8000811fd394
<page_pool_alloc_frag_netmem+0xb4>  // b.tstop


75% of this function's cycles stall on the same pattern.


Full comparison (top functions, >0.5%):

Fragment mode:                          Full-page mode:
-------------                           --------------
 15.88%  __wake_up_sync_key             13.66%  __wake_up_sync_key
  9.66%  default_idle_call              10.41%  default_idle_call
  8.38%  handle_softirqs                 8.89%  handle_softirqs
  3.93%  napi_pp_put_page       ←        0.85%  napi_pp_put_page
  3.18%  tcp_gro_receive                 3.43%  tcp_gro_receive
  1.93%  page_pool_alloc_frag   ←           —
     —                                   1.14%
page_pool_recycle_in_cache
     —                                   1.06%
page_pool_put_unrefed_netmem
  0.93%  napi_build_skb                  1.24%  napi_build_skb
  0.56%  __build_skb_around              1.46%  __build_skb_around

In full page rx buffers mode  'napi_pp_put_page' took just 0.85% on
the same ARM64 platform.

Comparing with another platform(x86):

To confirm this behaviour is specific to this ARM64 platform, I
collected the same data on a x86 Vm (Intel, 192 vCPUs, same MANA NIC 200Gbps)
Here both full page rx buff mode and fragment modes rx buffs achieves identical
~182 Gbps on x86.

x86 fragment mode:                      x86 full-page mode:
─-----------------                      ─------------------
 61.69%  pv_native_safe_halt            50.91%  pv_native_safe_halt
  4.17%  _raw_spin_unlock_irqrestore     6.19%
_raw_spin_unlock_irqrestore
  3.95%  handle_softirqs                 4.02%  handle_softirqs
  2.51%  _copy_to_iter                   2.53%  _copy_to_iter
  0.60%  napi_pp_put_page                  —    napi_pp_put_page (<0.5%)

On x86, napi_pp_put_page is only 0.60% in fragment mode (vs 3.93%
on the ARM64 platform data shared earlier).

Note: I did not had a different arm64 platform available to run and compare
it with.

From the above data, seems to be an issue specific to this ARM64
platform.


Regards

