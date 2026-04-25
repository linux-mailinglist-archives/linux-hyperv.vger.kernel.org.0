Return-Path: <linux-hyperv+bounces-10372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uZBXO9x17GmxYwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10372-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Apr 2026 10:05:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B046577E
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Apr 2026 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB665300CE78
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Apr 2026 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7C3016F7;
	Sat, 25 Apr 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jIIc3NO6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCB1D61BC;
	Sat, 25 Apr 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777104344; cv=none; b=KJ+PWPJKTd8L7MoogHeooQ+9A7lRbkv8nA7d6woEZIrV1US7R9oLYu2TGuSsrwmCGUULYafQM7Gat/QPcSjhnVHIPdq07C6T618svQzbh4S8KTNOvYpQrE16xHgRVCTZ6iFgGm6Kf1SwSJ5IfM+IaEaAh+9Lo7f1I1KP3rXzJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777104344; c=relaxed/simple;
	bh=S0X0pN8srarPwBPkfnx0eU3gnbLxXj9lMASqd+jq/0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxlfrXwq8wuPQm2oq4PpeIH9eN12TsHZ2NUEywIGZXDmooywpjuH28o406J+6nhC3VCnU5JGpj363qXz8loIhag85YWs+lKLptp86TDgAUFvjuVquZQmwIfZkfyKX/85jybDlGP+WENZgUuMYuZ7FuGSTKVjICIds25w8jE7pNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jIIc3NO6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 5E3E220B7165; Sat, 25 Apr 2026 01:05:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E3E220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777104343;
	bh=IkB9waU1QRQIGvPZnWRyZzWRYRvNT5pe3n4MZbVXQhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIIc3NO6qYngtvOses01TkQFruO+Ii5pevg0TCcHPvJBRUFzaF5qs+ZJqneqEElZ0
	 i0FcK/csMFPU/duYoCuPLHLjjHCpfAIMfQxc1eYOcwTZJy+pU+9lXwyU7WWNXh2LQH
	 FBkTQVb5twwtc4+KfgD3Kb6VGmogh2WIWmI9yuNA=
Date: Sat, 25 Apr 2026 01:05:43 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: David Wei <dw@davidwei.uk>, kuba@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org>
 <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
X-Rspamd-Queue-Id: 2B1B046577E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10372-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]

On Fri, Apr 24, 2026 at 01:05:24PM -0700, David Wei wrote:
> On 2026-04-23 05:48, Dipayaan Roy wrote:
> > On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
> > > On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
> > > > I still see roughly a 5% overhead from the atomic refcount operation
> > > > itself, but on that platform there is no throughput drop when using
> > > > page fragments versus full-page mode.
> > > 
> > > That seems to contradict your claim that it's a problem with a specific
> > > platform.. Since we're in the merge window I asked David Wei to try to
> > > experiment with disabling page fragmentation on the ARM64 platforms we
> > > have at Meta. If it repros we should use the generic rx-buf-len
> > > ringparam because more NICs may want to implement this strategy.
> > 
> > Hi Jakub,
> > 
> > Thanks. I think I was not precise enough in my previous reply.
> > 
> > What I meant is that the atomic refcount cost itself does not appear to
> > be unique to the affected platform. I see a similar ~5% overhead on
> > another ARM64 platformi (different vendor) as well. However, on that platform
> > there is no throughput delta between fragment mode and full-page mode; both reach
> > line rate.
> > 
> > On the affected platform, fragment mode shows an additional ~15%
> > throughput drop versus full-page mode. So the current data suggests that
> > the atomic overhead is common, but the throughput regression is not
> > explained by that overhead alone and likely depends on an additional
> > platform-specific factor.
> > 
> > Separately, the hardware team collected PCIe traces on the affected
> > platform and reported stalls in the fragment-mode case that are not seen
> > in full-page mode. They are still investigating the root cause, but
> > their current hypothesis is that this is related to that platform’s
> > PCIe/root-port microarchitecture rather than to page_pool refcounting
> > alone.
> > 
> > That said, I agree the right direction depends on whether this
> > reproduces on other ARM64 platforms. If David is able to reproduce the
> > same behavior, then using the generic rx-buf-len ringparam sounds like
> > the better direction.
> > 
> > Please let me know what David finds, and I can rework the patch
> > accordingly.
> 
> I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.
> 
> Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
> give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.
> 
> Use 1 combined queue only for the server. Affinitized its net rx softirq
> to run on core 4.
> 
> Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
> running on a host w/ same hw in the same region. Using 32 queues, no
> softirq affinities. The idea is to hammer page->pp_ref_count from
> different cores.
> 
> * 1 frag/page  -> 32.3 Gbps
> * 2 frags/page -> 36.0 Gbps
> 
> Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
> pp_ref_count goes up, as expected. Is this what you see? When you say
> there's a +5% overhead, what function?
> 
> Overall tput is higher with multiple frags. That's to be expected w/
> page pool.

Hi David,

Thanks for running this. Your results are consistent with mine.

I have tested this on 2 ARM64 platforms from different vendors,
running ntttcp and iperf3 using 4k as base page size.
In my observation I see both platforms show a 5% overhead in
napi_pp_put_page (~3.9%) and page_pool_alloc_frag_netmem (~1.9%)
when running in fragment mode, both stalling on the LSE ldaddal
atomic that maintains pp_ref_count.
This seems to be same as your observation as well. However in my
observation one of the platform shows 15% drop in throughput when
in fragment mode vs page mode. The other platform I ran the test on
infact performs slighty better in fragment mode than in full page
mode (simillar observation as yours).

So the atomic refcount overhead appears to be common across ARM64
platforms, but it does not cause a throughput regression.
The throughput regression seems specific to one platform only for which
we want to have the full page work around, also the HW team has
identified PCIe stalls in fragment mode that are absent in full-page mode.
Their investigation points to a suspected microarchitectural
issue in the PCIe root port. IMO, there seems to be no issue with
page_pool itself.

Given that:
 - Grace shows fragments are faster (your data)
 - A second ARM64 platform shows no regression (my data)
 - Only the affected platform shows a throughput drop
 - The HW team suspects this to a platform-specific PCIe issue,
   also form our experiment data the drop in throughput seems to
   be platform specific only.

I believe this remains a platform-specific workaround rather than
a generic issue. Would a private flag still be acceptable for this
case?


> 
> There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
> driver hack. Are you going to re-implement this change with rx-buf-len
> instead of a private flag? If so, I won't spend more time running this
> test.
> 
I can go either way depending on what Jakub prefers.
Hi Jakub,
with this new data from David, is it convincing enough for a mana driver
specific private flag, which can be set from user space by a udev rule
by detecting the underlying platform? If not then I will send the next
version with the other rxbuflen approach. 
> > 
> > 
> > Regards
> > Dipayaan Roy


Thanks and Regards
Dipayaan Roy

