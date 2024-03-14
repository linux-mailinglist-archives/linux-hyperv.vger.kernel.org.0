Return-Path: <linux-hyperv+bounces-1750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509DA87B69B
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E7DB22431
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B931362;
	Thu, 14 Mar 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h881D/6v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AC8BE5;
	Thu, 14 Mar 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385042; cv=none; b=B0OmVNzwMpfVXoRhXIXr5Vt4tyGUo41fhsuNZ/QBovB8sekoInCvG3l9Dt4GJ4PnnGfGnIM5QBWMrlR/ekwKGRQ89cXDGSFUc0/HLvuYkiBp5xkXkiu6ZzegkFDFzxcL4ErSxSkkD5l8CnRxnDQ5A6i21fNtCrbWQdc98PZG0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385042; c=relaxed/simple;
	bh=6UGr1FCB/DQlxlKdXDcKgaFfLxkGBqfSY1r+CIlhATw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0rNcBROjvzFEHKgaktoanDlXXLjXPgF018BnCUo16/jATfYXKOMxTchqO3cXlmNbjSd3w8wcVkRswBloNZJOKsIZii5+QDYntVAJxJc7pg7/wZEqvevWdPsxSnY60VvcXTYczHE4nndrJwi3xsMRZ+1pjH/KeLUrxUbmKBj4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h881D/6v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1C3AF20B74C0; Wed, 13 Mar 2024 19:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C3AF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710385040;
	bh=66P25FXNgIs5HQWvc3vNtZYJsw5/Od+QnPZTiotxhoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h881D/6vJeZSZkW42zfwWokQkqJ4RGf7RqqzkGXVWMLY5LIYJoEa5o0niT2gscsut
	 Xz9YIG7S8W6WsYg1EGLOKn14lnppimejl/1grxQYynfq0YfccUTUDxFo+73/oVm/qe
	 WoyVzGuEKY1O0enfLM5SgcFagZqYTYhbwgbI/uGw=
Date: Wed, 13 Mar 2024 19:57:20 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
 <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Mar 10, 2024 at 09:19:50PM -0700, Shradha Gupta wrote:
> On Fri, Mar 08, 2024 at 11:22:44AM -0800, Jakub Kicinski wrote:
> > On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:
> > > > Dynamic is a bit of an exaggeration, right? On a well-configured system
> > > > each CPU should use a single queue assigned thru XPS. And for manual
> > > > debug bpftrace should serve the purpose quite well.  
> > > 
> > > Some programs, like irqbalancer can dynamically change the CPU affinity, 
> > > so we want to add the per-CPU counters for better understanding of the CPU 
> > > usage.
> > 
> > Do you have experimental data showing this making a difference
> > in production?
> Sure, will try to get that data for this discussion
> > 
> > Seems unlikely, but if it does work we should enable it for all
> > devices, no driver by driver.
> You mean, if the usecase seems valid we should try to extend the framework
> mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
> to include these stats as well?
> Will explore this a bit more and update. Thanks.

Following is the data we can share:

Default interrupts affinity for each queue:

 25:          1        103          0    2989138  Hyper-V PCIe MSI 4138200989697-edge      mana_q0@pci:7870:00:00.0
 26:          0          1    4005360          0  Hyper-V PCIe MSI 4138200989698-edge      mana_q1@pci:7870:00:00.0
 27:          0          0          1    2997584  Hyper-V PCIe MSI 4138200989699-edge      mana_q2@pci:7870:00:00.0
 28:    3565461          0          0          1  Hyper-V PCIe MSI 4138200989700-edge      mana_q3
@pci:7870:00:00.0

As seen the CPU-queue mapping is not 1:1, Queue 0 and Queue 2 are both mapped 
to cpu3. From this knowledge we can figure out the total RX stats processed by
each CPU by adding the values of mana_q0 and mana_q2 stats for cpu3. But if
this data changes dynamically using irqbalance or smp_affinity file edits, the
above assumption fails. 

Interrupt affinity for mana_q2 changes and the affinity table looks as follows
 25:          1        103          0    3038084  Hyper-V PCIe MSI 4138200989697-edge      mana_q0@pci:7870:00:00.0
 26:          0          1    4012447          0  Hyper-V PCIe MSI 4138200989698-edge      mana_q1@pci:7870:00:00.0
 27:     157181         10          1    3007990  Hyper-V PCIe MSI 4138200989699-edge      mana_q2@pci:7870:00:00.0
 28:    3593858          0          0          1  Hyper-V PCIe MSI 4138200989700-edge      mana_q3@pci:7870:00:00.0 

And during this time we might end up calculating the per-CPU stats incorrectly,
messing up the understanding of CPU usage by MANA driver that is consumed by 
monitoring services. 
 

Also sharing the existing per-queue stats during this experiment, in case needed

Per-queue stats before changing CPU-affinities:
     tx_cq_err: 0
     tx_cqe_unknown_type: 0
     rx_coalesced_err: 0
     rx_cqe_unknown_type: 0
     rx_0_packets: 4230152
     rx_0_bytes: 289545167
     rx_0_xdp_drop: 0
     rx_0_xdp_tx: 0
     rx_0_xdp_redirect: 0
     rx_1_packets: 4113017
     rx_1_bytes: 314552601
     rx_1_xdp_drop: 0
     rx_1_xdp_tx: 0
     rx_1_xdp_redirect: 0
     rx_2_packets: 4458906
     rx_2_bytes: 305117506
     rx_2_xdp_drop: 0
     rx_2_xdp_tx: 0
     rx_2_xdp_redirect: 0
     rx_3_packets: 4619589
     rx_3_bytes: 315445084
     rx_3_xdp_drop: 0
     rx_3_xdp_tx: 0
     rx_3_xdp_redirect: 0
     hc_tx_err_vport_disabled: 0
     hc_tx_err_inval_vportoffset_pkt: 0
     hc_tx_err_vlan_enforcement: 0
     hc_tx_err_eth_type_enforcement: 0
     hc_tx_err_sa_enforcement: 0
     hc_tx_err_sqpdid_enforcement: 0
     hc_tx_err_cqpdid_enforcement: 0
     hc_tx_err_mtu_violation: 0
     hc_tx_err_inval_oob: 0
     hc_tx_err_gdma: 0
     hc_tx_bytes: 126336708121
     hc_tx_ucast_pkts: 86748013
     hc_tx_ucast_bytes: 126336703775
     hc_tx_bcast_pkts: 37
     hc_tx_bcast_bytes: 2842
     hc_tx_mcast_pkts: 7
     hc_tx_mcast_bytes: 1504
     tx_cq_err: 0
     tx_cqe_unknown_type: 0
     rx_coalesced_err: 0
     rx_cqe_unknown_type: 0
     rx_0_packets: 4230152
     rx_0_bytes: 289545167
     rx_0_xdp_drop: 0
     rx_0_xdp_tx: 0
     rx_0_xdp_redirect: 0
     rx_1_packets: 4113017
     rx_1_bytes: 314552601
     rx_1_xdp_drop: 0
     rx_1_xdp_tx: 0
     rx_1_xdp_redirect: 0
     rx_2_packets: 4458906
     rx_2_bytes: 305117506
     rx_2_xdp_drop: 0
     rx_2_xdp_tx: 0
     rx_2_xdp_redirect: 0
     rx_3_packets: 4619589
     rx_3_bytes: 315445084
     rx_3_xdp_drop: 0
     rx_3_xdp_tx: 0
     rx_3_xdp_redirect: 0
     tx_0_packets: 5995507
     tx_0_bytes: 28749696408
     tx_0_xdp_xmit: 0
     tx_0_tso_packets: 4719840
     tx_0_tso_bytes: 26873844525
     tx_0_tso_inner_packets: 0
     tx_0_tso_inner_bytes: 0
     tx_0_long_pkt_fmt: 0
     tx_0_short_pkt_fmt: 5995507
     tx_0_csum_partial: 1275621
     tx_0_mana_map_err: 0
     tx_1_packets: 6653598
     tx_1_bytes: 38318341475
     tx_1_xdp_xmit: 0
     tx_1_tso_packets: 5330921
     tx_1_tso_bytes: 36210150488
     tx_1_tso_inner_packets: 0
     tx_1_tso_inner_bytes: 0
     tx_1_long_pkt_fmt: 0
     tx_1_short_pkt_fmt: 6653598
     tx_1_csum_partial: 1322643
     tx_1_mana_map_err: 0
     tx_2_packets: 5715246
     tx_2_bytes: 25662283686
     tx_2_xdp_xmit: 0
     tx_2_tso_packets: 4619118
     tx_2_tso_bytes: 23829680267
     tx_2_tso_inner_packets: 0
     tx_2_tso_inner_bytes: 0
     tx_2_long_pkt_fmt: 0
     tx_2_short_pkt_fmt: 5715246
     tx_2_csum_partial: 1096092
     tx_2_mana_map_err: 0
     tx_3_packets: 6175860
     tx_3_bytes: 29500667904
     tx_3_xdp_xmit: 0
     tx_3_tso_packets: 4951591
     tx_3_tso_bytes: 27446937448
     tx_3_tso_inner_packets: 0
     tx_3_tso_inner_bytes: 0
     tx_3_long_pkt_fmt: 0
     tx_3_short_pkt_fmt: 6175860
     tx_3_csum_partial: 1224213
     tx_3_mana_map_err: 0

Per-queue stats after changing CPU-affinities:
     rx_0_packets: 4781895
     rx_0_bytes: 326478061
     rx_0_xdp_drop: 0
     rx_0_xdp_tx: 0
     rx_0_xdp_redirect: 0
     rx_1_packets: 4116990
     rx_1_bytes: 315439234
     rx_1_xdp_drop: 0
     rx_1_xdp_tx: 0
     rx_1_xdp_redirect: 0
     rx_2_packets: 4528800
     rx_2_bytes: 310312337
     rx_2_xdp_drop: 0
     rx_2_xdp_tx: 0
     rx_2_xdp_redirect: 0
     rx_3_packets: 4622622
     rx_3_bytes: 316282431
     rx_3_xdp_drop: 0
     rx_3_xdp_tx: 0
     rx_3_xdp_redirect: 0
     tx_0_packets: 5999379
     tx_0_bytes: 28750864476
     tx_0_xdp_xmit: 0
     tx_0_tso_packets: 4720027
     tx_0_tso_bytes: 26874344494
     tx_0_tso_inner_packets: 0
     tx_0_tso_inner_bytes: 0
     tx_0_long_pkt_fmt: 0
     tx_0_short_pkt_fmt: 5999379
     tx_0_csum_partial: 1279296
     tx_0_mana_map_err: 0
     tx_1_packets: 6656913
     tx_1_bytes: 38319355168
     tx_1_xdp_xmit: 0
     tx_1_tso_packets: 5331086
     tx_1_tso_bytes: 36210592040
     tx_1_tso_inner_packets: 0
     tx_1_tso_inner_bytes: 0
     tx_1_long_pkt_fmt: 0
     tx_1_short_pkt_fmt: 6656913
     tx_1_csum_partial: 1325785
     tx_1_mana_map_err: 0
     tx_2_packets: 5906172
     tx_2_bytes: 36758032245
     tx_2_xdp_xmit: 0
     tx_2_tso_packets: 4806348
     tx_2_tso_bytes: 34912213258
     tx_2_tso_inner_packets: 0
     tx_2_tso_inner_bytes: 0
     tx_2_long_pkt_fmt: 0
     tx_2_short_pkt_fmt: 5906172
     tx_2_csum_partial: 1099782
     tx_2_mana_map_err: 0
     tx_3_packets: 6202399
     tx_3_bytes: 30840325531
     tx_3_xdp_xmit: 0
     tx_3_tso_packets: 4973730
     tx_3_tso_bytes: 28784371532
     tx_3_tso_inner_packets: 0
     tx_3_tso_inner_bytes: 0
     tx_3_long_pkt_fmt: 0
     tx_3_short_pkt_fmt: 6202399
     tx_3_csum_partial: 1228603
     tx_3_mana_map_err: 0


