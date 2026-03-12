Return-Path: <linux-hyperv+bounces-9357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KAZAr7RsmnrPwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9357-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 15:46:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB7273971
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B117300869C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED101363C6B;
	Thu, 12 Mar 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cbg0LaTl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA3376BF1;
	Thu, 12 Mar 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326773; cv=none; b=d2bMFIzUpihkHCYqghnCUdobsmuS31jU61PjIKVLGlod9dVfiADhTFGxBDzTIJiPGmIa/IXGh5qY0hFTdDnFwESo/NS8XRtO5jv2fEJVd7ZBwR9caN7oM03mNx+R3KzjWALIAzfchoIx1/u05dZg66iZ/Prr+Jv7nnHzMlij6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326773; c=relaxed/simple;
	bh=JMB7nMHRCJ2NukyE7t95J5CarTlsyVXjAAdrzzx9NPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEFTRYhobzN6MPMzu+q/Z2PAVsiJ4QHpe4BycWyIttF/kVs3qdYNNy+mPUeSuE//g6uKAlJ3PGoFt4SircvUPo1DrIerRUz30XnnCQrE1d51M4SYkH4p2I3u/xnfFHhFUE7ycTLHoiMbarWJOJPDz7Ees8kfBOkpqdUUONHsFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cbg0LaTl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 81CA220B710C; Thu, 12 Mar 2026 07:46:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81CA220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773326768;
	bh=dn4sna73T608sAW83ClLRLUdcBy81wfv9Q/fnDJeO+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbg0LaTlsaWNl1hdTzFFBt2El0BVeL+PtZkQhvoZcucagpcwrY6HZ60kUY06pU9jW
	 uA005qJ9LQFrafdNJKxXw31c3svHiVe7qBolxYRhIXYa32fzYWwyXv0Dev05Gdjb97
	 3r2J/Gbj4pe5SVR11Bjh9xKJxvlzUoL8Yb+XJmvk=
Date: Thu, 12 Mar 2026 07:46:08 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com, kees@kernel.org, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <abLRsHkzf4Gnf0KC@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260309143840.675606-1-ernis@linux.microsoft.com>
 <20260311164653.GS461701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311164653.GS461701@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9357-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CDB7273971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 04:46:53PM +0000, Simon Horman wrote:
> On Mon, Mar 09, 2026 at 07:38:28AM -0700, Erni Sri Satya Vennela wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> 
> ...
> 
> > @@ -2128,6 +2140,9 @@ int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
> >  
> >  	mana_gd_cleanup(pdev);
> >  
> > +	debugfs_remove_recursive(gc->mana_pci_debugfs);
> > +	gc->mana_pci_debugfs = NULL;
> 
> Hi Erni,
> 
> The same cleanup of mana_pci_debugfs already appears in a couple of other
> places. It seems that all such cleanup is now paired with a call to
> mana_gd_cleanup().
> 
> So could you consider performing the mana_pci_debugfs cleanup in
> mana_gd_cleanup()? Possibly also renaming that function?
> 
Yes, I think that makes sense to combine them in once function.
I will make that change in the next version.
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2140,6 +2155,12 @@ int mana_gd_resume(struct pci_dev *pdev)
> >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> >  	int err;
> >  
> > +	if (gc->is_pf)
> > +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> > +	else
> > +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> > +							  mana_debugfs_root);
> 
> Likewise the setup of mana_pci_debugfs seems to now always be paired
> with a call to mana_gd_setup().
> 
Thankyou for the review.
I will send the next version with updated changes.

Regards,
Vennela
> > +
> >  	err = mana_gd_setup(pdev);
> >  	if (err)
> >  		return err;
> 
> ...

