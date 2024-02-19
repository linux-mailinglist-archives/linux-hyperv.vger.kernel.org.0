Return-Path: <linux-hyperv+bounces-1572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3CA85A034
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20E11F22A88
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD824A1C;
	Mon, 19 Feb 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OaYGNPNa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB28493;
	Mon, 19 Feb 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336336; cv=none; b=TnCfWJo0ZiM0/ysJJq0fpwdDZVl43q6r9qxZAmfzCAaE8uN0mdY5kNd+O5g1gq+3L8rcbB8YW26yemlnKvkhMFGaarJv5oGTnZWaYF7nRRfODxUy14vWPH38+RSHBTj1QZ8D4TlzLsLlf3UdGejpG9xKVhy8V1Dl4ItmfVeZSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336336; c=relaxed/simple;
	bh=17MGFy/IvW9y8Ov4GBUczLXEtaklBUOuyGCgWadV0j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlSpJAOrWmw6GNGUUhdIeXMsvy4xDMnP839wPEsRo3DXtXeimwSwO+iEAxx9iQjmsQLJOpV9c7kgOWttQM3wxMS2u5/+2LAGvndoyp6B1zFzey5zDlrQ+5zt0tvoMM20GOr2+n/4Co5uNDXPSWb/NRN2OxqC3SkNV14AtexL3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OaYGNPNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEA9C433F1;
	Mon, 19 Feb 2024 09:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708336336;
	bh=17MGFy/IvW9y8Ov4GBUczLXEtaklBUOuyGCgWadV0j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaYGNPNab7Y7Crcmyn8xjc2PildDNZ2dHV6lMSwUYtCf5SRUjFiR//FgoA1YIT7er
	 YtlmmKSfIRb0uxHdb5KVSyoMXKbQA8LrjKhFo0hVbSB/hk7tmkYWO6FGnt0GoS07+B
	 bSqLopQoyFwKP4vZuQd2IbMytPK9RT/umzEXdBwQ=
Date: Mon, 19 Feb 2024 10:52:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <2024021932-marbled-passable-e7ab@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
 <2024021908-royal-sequester-84be@gregkh>
 <20240219092421.GA32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219092421.GA32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Feb 19, 2024 at 01:24:21AM -0800, Saurabh Singh Sengar wrote:
> > > +#define HV_RING_SIZE		(4 * 4096)
> > 
> > Hey, that doesn't match the kernel driver!  Why these values?
> 
> This application talks to device which is recognize as HV_FCOPY
> is kernel. In the first patch of current patch series I have
> mentioned .pref_ring_size = 0x4000 for HV_FCOPY which matches this.
> 
> This code is well tested.

I'm commenting on the fact the 4096 is sometimes PAGE_SIZE and sometimes
not, and you have a default of using PAGE_SIZE values in the kernel
driver, and as such, this will not match up.  So be careful here.

> > > +
> > > +unsigned char desc[HV_RING_SIZE];
> > > +
> > > +static int target_fd;
> > > +static char target_fname[PATH_MAX];
> > > +static unsigned long long filesize;
> > > +
> > > +static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
> > > +{
> > > +	int error = HV_E_FAIL;
> > > +	char *q, *p;
> > > +
> > > +	filesize = 0;
> > > +	p = (char *)path_name;
> > 
> > Why the unneeded cast?
> 
> This code is existing today as form of hv_fcopy_daemon. As this new
> application is replacing hv_fcopy_daemon I reused the same code and
> casting.

That wasn't obvious that this was copied code, please be explicit about
that.

thanks,

greg k-h

