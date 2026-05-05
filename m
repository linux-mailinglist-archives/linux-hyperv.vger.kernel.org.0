Return-Path: <linux-hyperv+bounces-10638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IETGAu4a+mkJJgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10638-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 18:29:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 084224D1496
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BFEF301B067
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F348C404;
	Tue,  5 May 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PUJNa2RE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DF48B367;
	Tue,  5 May 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998534; cv=none; b=C1aMZxqOv2kOkoUdS3QQ9FaOTHRK6cGFF7l6AT0rc9ro5J5KlIkFX9zIn7T2oXpUilu3t8kzwrl5GS6MoFffXNuTClNCl4adpGhii+i1wF0+Nh4C0q1m5DxtFMe/+JjX7YzBKu/4wbVl/8YgP7P5lL1F0b5TrZfsvCgsYpd58TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998534; c=relaxed/simple;
	bh=qpP5JJexx5FbkH/P8mJ5gw7/jHOXkN/yHbJmFS6aZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJNBNeFiRIB/EVcxeiA2voKFKBrowI+jAADxH2Rl0ELQKUcHqFVn7yulQlw/TffBKHeMTIpVgKhnLhtHaAiWM3ZDAd2NuCG7WvTvUZl+k6+3QGW4mG/Rr17ZUjJHdvoG8Z822vZRYyx8ShWpckCtpNAmI3NGFgF4qD2N7aCTfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PUJNa2RE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id E9B0F20B7168; Tue,  5 May 2026 09:28:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9B0F20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777998530;
	bh=yQ9B0+Murk+liHcUEGFo3TbZqnJLciO6uudJWzl4OMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUJNa2REUMiWBad5gobyGUkXEJmQrPQDFgxtkL4tffBQtp/cN0EBDpCTv3zE/LJWz
	 8+SdQNQ5E6OEs5/4komCyIQ7DrLGLDJ3OQcY3u2+YQBt89Rhg4c5sbYf2bGIJjJnO0
	 pYwQ9owHP7vaWFWdWrxfjMJsPkKM5etMsiO2R5V4=
Date: Tue, 5 May 2026 09:28:50 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH net, v3] net: mana: Fix crash from unvalidated SHM offset
 read from BAR0 during FLR
Message-ID: <afoawjLcpe++Cjsu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <30f588ad-cf80-432b-bde3-13b3c0d5a124@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f588ad-cf80-432b-bde3-13b3c0d5a124@redhat.com>
X-Rspamd-Queue-Id: 084224D1496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10638-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]

On Tue, May 05, 2026 at 03:42:46PM +0200, Paolo Abeni wrote:
> On 5/1/26 4:47 AM, Dipayaan Roy wrote:
> > @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
> >  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
> >  
> >  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> > +	if (sriov_base_off >= gc->bar0_size ||
> > +	    gc->bar0_size - sriov_base_off <
> > +		GDMA_PF_REG_SHM_OFF + sizeof(u64) ||
> > +	    !IS_ALIGNED(sriov_base_off, sizeof(u64))) {
> > +		dev_err(gc->dev,
> > +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> > +			sriov_base_off, (u64)gc->bar0_size);
> > +		return -EPROTO;
> > +	}
> 
> I think that the additional fix suggested by sashiko is really worthy,
> but should go in a separate patch. @Dipayaan: please follow-up on that
> one, thanks!
> 
> Paolo
>
Hi Paolo,

Thanks for reviewing, and I will cross check and send out a separate patch for
issue pointed out by Sashiko(un-related to the current issue).

Regards
Dipayaan Roy



