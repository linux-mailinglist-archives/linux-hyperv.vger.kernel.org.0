Return-Path: <linux-hyperv+bounces-11832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7mvnEmCTSmo0EwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11832-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Jul 2026 19:24:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C454770AACB
	for <lists+linux-hyperv@lfdr.de>; Sun, 05 Jul 2026 19:24:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=k6EADjin;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11832-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11832-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 413F0300D1EC
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Jul 2026 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89D2F7EED;
	Sun,  5 Jul 2026 17:24:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A129346F;
	Sun,  5 Jul 2026 17:24:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272285; cv=none; b=W7spDhtKv9pPrA8GgFi0Hz1C8iKZfYFk5dhCKeBue8nHvuidkYLkWWlpv4DZpZjPt9Jc15GG/+luHieS8E4ZMfMYeRrHEnWAcyTjz+3BbNZ45uy4s9aWm2OMP49XLm5uKEqJSNW9RukEuHvtOr/L4ejXEYedg+cpERK8LU7uaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272285; c=relaxed/simple;
	bh=ivc2Qyu03bsUwPfyfSqWTtgsSWP9nEpWKZSwBdnTgPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kURxGnNKhYP9A4M/8UnMY+y+vYNItEOnAqOAyg387AXEZBOTmrNxU65UUBDGt4UskZnfXCLWz8fa7m5O1w/sbjBrLVQQIXI4fGxxukPrdUmS5xU/VJloIWWCObx1t+ojkuCUX7KvzFq/PqtaMehMdaETIwnetw9jKpAO1NUXeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k6EADjin; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 3980820B7169; Sun,  5 Jul 2026 10:17:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3980820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783271858;
	bh=3dPjdWDTR7+OAoy9Jk8DWgNI00d9M34YmpuKKbFFwwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6EADjiny73p0uLx3h67fvzSPSoPHuvczsAtsve5HPQ8VQvD0vXYAr7SqI2hpe6ek
	 1y4A1QT5bYx2G1q3un0T+h6eryDlWNNF0Rk7KYqb8PFUpcTLJijrlznbPZYdQnZmtg
	 ucYKWefT4woErJlf5PLK2Je6CfmtJ/RJrFpQpOoE=
Date: Sun, 5 Jul 2026 10:17:38 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, dipayanroy@microsoft.com,
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v11 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <akqRspl/M5mBvdsH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260701141808.461554-1-dipayanroy@linux.microsoft.com>
 <akUn+nMBrjbUts2N@boxer>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akUn+nMBrjbUts2N@boxer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11832-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C454770AACB

On Wed, Jul 01, 2026 at 04:45:14PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 01, 2026 at 07:15:44AM -0700, Dipayaan Roy wrote:
> > On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool
> > fragments for allocation in the RX refill path (~2kB buffer per fragment)
> > causes 15-20% throughput regression under high connection counts
> > (>16 TCP streams at 180+ Gbps). Using full-page buffers on these
> > platforms shows no regression and restores line-rate performance.
> > 
> > This behavior is observed on a single platform; other platforms
> > perform better with page_pool fragments, indicating this is not a
> > page_pool issue but platform-specific.
> > 
> > This series adds an ethtool private flag "full-page-rx" to let the
> > user opt in to one RX buffer per page:
> > 
> >   ethtool --set-priv-flags eth0 full-page-rx on
> > 
> > There is no behavioral change by default. The flag can be persisted
> > via udev rule for affected platforms.
> 
> Were you able to track down what is the actual bottleneck on the 'broken'
> platform? What is the performance of full-page approach on healthy
> platforms? On changelog below you mention the frag approach 'outperforms'
> the full-page one.
> 
Hi Maciej,

The HW team identified a PCIE root port stall occurring due to a PCIe
errata in a HW IP used for this platform. Using full pages increases the
time in packet refill path and indirectly helping to reduce the back pressure
in NIC pipeline caused due to the stall in root port. As per them it
will be fixed in next version of this hw which is not anytime soon.

On various other healthy platforms with 4k base page size we tested, we see
improvements using page fragments than full pages around anywhere between 5 to 15%.

Regards
Dipayaan Roy

> > 
> > This series depends on the following fixes now merged in net-next:
> >   commit 17bfe0a8c014 ("net: mana: Add NULL guards in teardown path to prevent panic on attach failure")
> >   commit 5b05aa36ee24 ("net: mana: Skip redundant detach on already-detached port")
> > 
> > Changes in v11:
> >   - Rebased on net-next
> > Changes in v10:
> >   - Rebased on net-next which now includes the prerequisite fixes.
> >   - Recovery logic in mana_set_priv_flags() leverages the idempotent
> >     mana_detach() from the merged fixes.
> > Changes in v9:
> >   - Added correct tree.
> > Changes in v8:
> >   - Fixed queue_reset_work recovery by restoring port_is_up before
> >     scheduling reset so the handler can properly re-attach.
> >   - Simplified "err && schedule_port_reset" to "schedule_port_reset".
> > Changes in v7:
> >   - Rebased onto net-next.
> >   - Retained private flag approach after David Wei's testing on
> >     Grace (ARM64) confirmed that fragment mode outperforms
> >     full-page mode on other platforms, validating this is a
> >     single-platform workaround rather than a generic issue.
> > Changes in v6:
> >   - Added missed maintainers.
> > Changes in v5:
> >   - Split prep refactor into separate patch (patch 1/2)
> > Changes in v4:
> >   - Dropping the smbios string parsing and add ethtool priv flag
> >     to reconfigure the queues with full page rx buffers.
> > Changes in v3:
> >   - changed u8* to char*
> > Changes in v2:
> >   - separate reading string index and the string, remove inline.
> > 
> > Dipayaan Roy (2):
> >   net: mana: refactor mana_get_strings() and mana_get_sset_count() to
> >     use switch
> >   net: mana: force full-page RX buffers via ethtool private flag
> > 
> >  drivers/net/ethernet/microsoft/mana/mana_en.c |  22 ++-
> >  .../ethernet/microsoft/mana/mana_ethtool.c    | 178 +++++++++++++++---
> >  include/net/mana/mana.h                       |   8 +
> >  3 files changed, 177 insertions(+), 31 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> > 

