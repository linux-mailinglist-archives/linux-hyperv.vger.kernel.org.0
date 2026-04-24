Return-Path: <linux-hyperv+bounces-10358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMgYDX3j6mkbFQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10358-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 05:29:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FD459723
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 05:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 020A43006F1C
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DC337BBD;
	Fri, 24 Apr 2026 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s62oztTN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005333710F;
	Fri, 24 Apr 2026 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001337; cv=none; b=nEJC+rummXbh4//IUWihWaYNlTRqI4Wn7aUiHXMEOZS/X5D3nqslGKKbOwq4XiLQH3HAK6XkCX7hOJaH89TAJRru17s+mi/28aMlr1kmfngijtm/jmQf/LK25yg7sLKHXywSfGyPOZX+oFV186LAuiNi5TJ5eGpA9iPbguTGVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001337; c=relaxed/simple;
	bh=8KbY4d9Sc1hur3MrKTEc3ePr/WWJlpdT80t8kvm2Slo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTF7i3SXlKSqzYZaX/fCZEZCDG/l6Eqp2hw28X7t3W2TEgVb9Rg6ZfmOZCwEfcchMH8x2E2BB5/mfgJqk5TNA1ctEnZuysvy/Oocb+1x/QUy2nOIt6yNBaOb29mRFM1xaOG0t5TTBXvcQgXz/9c1T77MnCj1Mg1kiQj8/pjWwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s62oztTN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 5EFDF20B7165; Thu, 23 Apr 2026 20:28:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EFDF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777001335;
	bh=hozJVYNbCa3wzecJn7QvQ9EMZSOZzc1JqZvHkZlE9Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s62oztTNxMqGVuyaG2gEvGu12rVs6B0C5CMdSYnyxlsFB9uJ03pN+q5zWKBEuMwx5
	 L6UvbtEEU07uN8K57dKz84WtwOg7rV1dbI1AVqLbiwG1FU5chgJDIbxLQMbNXw72HA
	 TpEcyo9QNs20D6sNbK8Gaa/FamMqDPv9Yz/F83EU=
Date: Thu, 23 Apr 2026 20:28:55 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
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
	ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Message-ID: <aerjdzgetiIeiBto@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <edccaafd-73f3-421d-a48e-a6cb704d39e6@lunn.ch>
 <aepviNMszMBtiB/H@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <7c4dbe89-9b51-45d6-ae89-39d4183e66b1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4dbe89-9b51-45d6-ae89-39d4183e66b1@lunn.ch>
X-Rspamd-Queue-Id: 8F6FD459723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10358-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]

On Thu, Apr 23, 2026 at 09:44:04PM +0200, Andrew Lunn wrote:
> On Thu, Apr 23, 2026 at 12:14:16PM -0700, Dipayaan Roy wrote:
> > On Thu, Apr 23, 2026 at 06:37:04PM +0200, Andrew Lunn wrote:
> > > > The root cause is in mana_gd_init_vf_regs(), which computes:
> > > > 
> > > >   gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> > > > 
> > > > without validating the offset read from hardware. If the register
> > > > returns a garbage value that is neither within bar 0 bounds nor aligned
> > > > to the 4-byte granularity, thus causing the alignment fault.
> > > 
> > > Is GDMA_REG_SHM_OFFSET special?
> > Hi Andrew,
> > GDMA_REG_SHM_OFFSET is not special. It was simply the only register
> > read that had no validation at all. The other two registers
> > (GDMA_REG_DB_PAGE_SIZE, GDMA_REG_DB_PAGE_OFFSET) already have checks
> > in place.
> 
> I must be missing something:
> 
> grep page_size *
> 
> gdma_main.c:	gc->db_page_size = mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;
> gdma_main.c:	gc->db_page_size = mana_gd_r32(gc, GDMA_REG_DB_PAGE_SIZE) & 0xFFFF;
> gdma_main.c:	void __iomem *addr = gc->db_page_base + gc->db_page_size * db_index;
> 

Hi Andrew,
There are 2 upstream commits regarding these, I think you missed
them please check once:

commit fb4b4a05aeeb8b0f253c5ddce21f4635dadc9550
Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Date:   Wed Mar 25 11:04:17 2026 -0700
 
    net: mana: Use at least SZ_4K in doorbell ID range check

commit 89fe91c65992a37863241e35aec151210efc53ce
Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Date:   Fri Mar 6 13:12:06 2026 -0800
 
    net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response

> So if GDMA_REG_DB_PAGE_SIZE returns garbage, it is at least masked,
> but it is still a random number.
> 
> mana_gd_ring_doorbell() takes this random number, multiples by
> db_index, adds, gc->db_page_base and then does:
> 
> writeq(e.as_uint64, addr);
> 
> So you write to a random address. 
> 
> I don't see any sanity checks here. Cannot you check that db_page_size
> is at least one of the expected page sizes?
As mentioned above checks are already present in this commit: 89fe91c65992a37863241e35aec151210efc53ce
> 
>    Andrew

Regards
Dipayaan Roy

