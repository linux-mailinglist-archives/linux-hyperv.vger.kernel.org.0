Return-Path: <linux-hyperv+bounces-10181-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCORBpaG32nSUgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10181-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 14:37:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F81404525
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6C2F302E880
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4E2E8B6B;
	Wed, 15 Apr 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh9Nfnje"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300C2E228D;
	Wed, 15 Apr 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256634; cv=none; b=bN9vVLDomU2T4eYfhDYHA4xtMsXNfFUufBbgnCSMMGYMf+lzaFLgknazbCVN7xuQQsYWCF8Uc1NTK2UPJIcHd4lUKJUpCvcUEuj4x7XJ2OOdRzD4Fc0Mj3DJTZvc7KbMg2jEEj3s7HAvIuTpLJ7qjHhzyJLUDYG2HXE5Fj5NnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256634; c=relaxed/simple;
	bh=9WcJtVX39DXNYbKrDFg8jQAyc6OXoknuYErY+ikE79Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtUvM1K0Ocf6vAvq+O/xBFTVwpAkOAtP0oDENwwaLpm40Sza2Hgk60ReBrNmk9/I6hkLCtc/Vw9E2BOLkSX6vw9n49o5xY8uFQENRYlki12rW8RVD55z0seP/9fp4ORt78UIuLd3GtqICg1tajnO+b2uelIDe5GndVG51g6cDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh9Nfnje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA685C19424;
	Wed, 15 Apr 2026 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776256634;
	bh=9WcJtVX39DXNYbKrDFg8jQAyc6OXoknuYErY+ikE79Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bh9NfnjelALGjAl9Kbme0Hb7fSMm0cVgjNzT/iiMm8l7tVd3T5MEodsLnLiZXyu9D
	 rQJHf+G12BEard6TKszW6soFhdjpE/NMcvDsGGIgmYXqzqWlaSld7veuP5eze5KKYV
	 XYTonAUW+x33c1i1CWJeNS7gkrE7OFcmhCPEDZ4Ln4QrRp67BblJzYMnD7rJVTanbV
	 nRMxlL60et1a7SPg57CCxDeHMta/7114nYcEe5iRSdkG4AK9uS+dLiBRRQ1uVrNPGM
	 1rJTJtwW7fKO5pdz9iFn7sNIBttoGg7o3mmYMujxK3rmcfQv9QaDHPKEu7z2sULKUV
	 V1KzhJpluVUfg==
Date: Wed, 15 Apr 2026 13:37:07 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: mana: Don't overwrite port probe error
 with add_adev result
Message-ID: <20260415123707.GG772670@horms.kernel.org>
References: <20260413050843.605789-4-ernis@linux.microsoft.com>
 <20260414153503.769476-1-horms@kernel.org>
 <ad84k4qaMd9wnYwd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad84k4qaMd9wnYwd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10181-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 13F81404525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:04:51AM -0700, Erni Sri Satya Vennela wrote:
> On Tue, Apr 14, 2026 at 04:35:03PM +0100, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > net: mana: Don't overwrite port probe error with add_adev result
> > 
> > This commit ensures that if mana_probe_port() or mana_attach() fails, the
> > error is not overwritten by the result of add_adev(). By preserving the
> > error, it triggers mana_remove() cleanup instead of leaving ports partially
> > initialized.
> > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index 9d095a6fb56c7..4d42cbfb3f15b 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > @@ -3634,10 +3634,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> > >  	if (!resuming) {
> > >  		for (i = 0; i < ac->num_ports; i++) {
> > >  			err = mana_probe_port(ac, i, &ac->ports[i]);
> > > -			/* we log the port for which the probe failed and stop
> > > -			 * probes for subsequent ports.
> > > -			 * Note that we keep running ports, for which the probes
> > > -			 * were successful, unless add_adev fails too
> > > +			/* Log the port for which the probe failed, stop probing
> > > +			 * subsequent ports, and skip add_adev.
> > > +			 * Already-probed ports remain functional.
> > >  			 */
> > 
> > Are these comments accurate regarding ports remaining functional?
> > 
> > Since this patch preserves the error code, execution falls through to the end
> > of mana_probe() where it checks if err is set and calls mana_remove().
> > mana_remove() will iterate over the successfully allocated ports, completely
> > detach them, unregister their net_devices, and destroy event queues.
> > 
> > It appears no ports remain functional because the device is completely torn
> > down.
> >
> I will update the patch with the updated comment message. 

Thanks.

> > [ ... ]
> > 
> > > @@ -3651,10 +3650,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> > >  			enable_work(&apc->queue_reset_work);
> > >  			err = mana_attach(ac->ports[i]);
> > >  			rtnl_unlock();
> > > -			/* we log the port for which the attach failed and stop
> > > -			 * attach for subsequent ports
> > > -			 * Note that we keep running ports, for which the attach
> > > -			 * were successful, unless add_adev fails too
> > > +			/* Log the port for which the attach failed, stop
> > > +			 * attaching subsequent ports, and skip add_adev.
> > > +			 * Already-attached ports remain functional.
> > >  			 */
> > >  			if (err) {
> > >  				dev_err(dev, "Attach Failed for port %d\n", i);
> > > @@ -3663,7 +3661,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> > 
> > Does propagating this error during PM resume introduce a NULL pointer
> > dereference?
> > 
> > If PM resume fails here (resuming == true), the preserved error code causes
> > mana_probe() to call mana_remove(), which tears down the device and sets
> > gd->gdma_context = NULL.
> > 
> > However, a failed resume callback does not automatically unbind the driver.
> > When the device is eventually unbound later, mana_remove() is invoked again:
> > 
> > drivers/net/ethernet/microsoft/mana/mana_en.c:mana_remove() {
> >     struct gdma_context *gc = gd->gdma_context;
> >     struct device *dev = gc->dev;
> >     ...
> > }
> > 
> > In the second invocation, gd->gdma_context is NULL, meaning gc is NULL,
> > which could lead to a kernel panic when dereferencing gc->dev.
> 
> Thankyou for pointing it out, Simon.
> Since this is a pre-existing bug, I will create a different patch for
> this change and make it as part of this patchset.

Likewise, thanks.

FTR, it it is a pre-existing bug then I don't think it needs
to block progress of your patchset. Even if fixing things
sooner than later is a good maxim.

