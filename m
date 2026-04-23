Return-Path: <linux-hyperv+bounces-10355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL0SKehw6mlBzQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10355-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 21:20:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB596456A83
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 21:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6313013A47
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7952392825;
	Thu, 23 Apr 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NvqlUclk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBC386557;
	Thu, 23 Apr 2026 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971659; cv=none; b=BxHh2UplV/yGp/kGYcLyDjF1PRHz3Vfwda8ZlyiHCspRojjk6FKJ/3FHMwdRZK914+IvDNcdz00RzpHSH2Q6qn/Yl7jwEduZjdEWP74C4obb8aa7lJX6BduUZlYWFWPOZIoxjNmp7VKuL6g+TgXD+2yrmYPYHkG4o4TllmOLpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971659; c=relaxed/simple;
	bh=0/kYI9nntU+3cuXXL/zPv/qL56aQxM1oszkFiqCXqtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6bP6sjqzfVXfvE0yZ5T5ndksi8VBJw8rmLgt75oe5IoHkXgldrdMGTm2lZmrkMDM2hRfXCfmKUFTH5rEHM8XSN3Fgf2uTsKBgfMFXyzHPex6SPNG6sZ8jAWhV73KOdmllgb5Nu8fqhlhC/ED6kjpBDWF8CM1uH6LQsU02hSip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NvqlUclk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 9D63620B7165; Thu, 23 Apr 2026 12:14:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D63620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776971656;
	bh=RA4mvuAjlH+oxj2ch9HaoJ3O7maNpOWXkD3uf3/Ozvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvqlUclkx+2a5lGeuqdlDSCGbqHdyFca1IHF5N5ZPfAMfiV6Je45Y5VPK+RtAsntB
	 PA0zWyeexlLW45Sd/CURMZUZ1miw80Pa6mSCJ0kIeAik0AQnOjt/8UM8y6QInPyQeO
	 fRHvuivhzi/uuvj72a6G5X7RpgX733/Cg4HbQNug=
Date: Thu, 23 Apr 2026 12:14:16 -0700
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
Message-ID: <aepviNMszMBtiB/H@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <edccaafd-73f3-421d-a48e-a6cb704d39e6@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edccaafd-73f3-421d-a48e-a6cb704d39e6@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10355-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DB596456A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 06:37:04PM +0200, Andrew Lunn wrote:
> > The root cause is in mana_gd_init_vf_regs(), which computes:
> > 
> >   gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> > 
> > without validating the offset read from hardware. If the register
> > returns a garbage value that is neither within bar 0 bounds nor aligned
> > to the 4-byte granularity, thus causing the alignment fault.
> 
> Is GDMA_REG_SHM_OFFSET special?
Hi Andrew,
GDMA_REG_SHM_OFFSET is not special. It was simply the only register
read that had no validation at all. The other two registers
(GDMA_REG_DB_PAGE_SIZE, GDMA_REG_DB_PAGE_OFFSET) already have checks
in place. Also shm_off becomes gc->shm_base (bar0_va + shm_off) and
gc->shm_base is dereferenced via readl() (ldr w1, [x20]) in
mana_smc_poll_register(), which is why it requires 4-byte alignment on arm64
device memory. Or else a misaligned shm_off propagates directly into a
misaligned shm_base, causing an alignment fault (FSC=0x21).
>
> What if GDMA_REG_DB_PAGE_SIZE or GDMA_REG_DB_PAGE_OFFSET have returned
> garbage? Are you going to die a horrible death as well?
Those two already have validation in the current code:

- GDMA_REG_DB_PAGE_SIZE is checked for < SZ_4K (returns -EPROTO)
- GDMA_REG_DB_PAGE_OFFSET is checked for >= bar0_size (returns -EPROTO)

The same checks exist for the PF equivalents (GDMA_PF_REG_DB_PAGE_SIZE
and GDMA_PF_REG_DB_PAGE_OFF) as well.
> 
> Isn't there a way you can poll the firmware to ask it if it is ready?
Unfortunately no, as there is no separate readiness register to
poll.

The existing recovery flow already waits MANA_SERVICE_PERIOD (10
seconds) after suspend before attempting resume. If the registers are
still invalid after that, the -EPROTO triggers a PCI remove/rescan,
which re-probes the device.
> 
> And what about the PF case. Can GDMA_PF_REG_SHM_OFF also be garbage?
Yes. This patch also adds bounds and alignment validation for the PF path:
both GDMA_SRIOV_REG_CFG_BASE_OFF and the SHM offset read via
(sriov_base_off + GDMA_PF_REG_SHM_OFF) are validated before use.
> 
>       Andrew

Regards
Dipayaan Roy

