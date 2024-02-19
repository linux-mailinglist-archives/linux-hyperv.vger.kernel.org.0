Return-Path: <linux-hyperv+bounces-1575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9987585A0E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 11:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CB1F242E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3B2C691;
	Mon, 19 Feb 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="orwmxdGb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A22C68E;
	Mon, 19 Feb 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338236; cv=none; b=l8Dgkj6CxR/foKGPLC0ucTW7SG2Lf5X847mrg88Z+snW2aCjwBwbBJmXYjLqTl8swxHM9IRQx/RXG0BDbnIV6TsB+27wjeK8SW7arFpAQcjaN5YZLdo6n3BCQqO/5ENIVD5ebIfY8ByY+yK3YbsigiGDczUqsXUIp1vKmMAnkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338236; c=relaxed/simple;
	bh=9lFhpNcxNkWQKY4Mqd3QqZPa1srTB9MzJwoZyS6/FoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwCLbPCjcmjJYTaRmb2zJlNK9oeRmU3bIDiXYAYd3RS0oQFictETZNKWgoKc6BlQe/l8A64dkPeLDbQIXc1xj2qBp4WhSxiwmhPAHCF5NIJl2sKWHee6aDuE8JcLCQihk3KhvQ1Mm5upKXmv7FG3UMiV9nZuCoAi69DIBxSWnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=orwmxdGb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 6189A20B2000; Mon, 19 Feb 2024 02:23:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6189A20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708338234;
	bh=lqvmacQRB7KOJtXqzg9VNGDCrcZQrM2SF0mAB9k8gtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orwmxdGb6Ua8U1wwO9vYFSRq+cU8dvuvUOaA9NA5+gvfekPiqHqkoprrcoD1YN1Vr
	 tJKeFNl9CPpjQ5do/M8BSOURfax5Wsu43mNawZPRp1LevTtZRwqNvtBNo11o5M6CQ8
	 2nZ7LLcrGnOwIMST3W5eQH3b4jb60wWjn+zuarok=
Date: Mon, 19 Feb 2024 02:23:54 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <20240219102354.GA12268@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
 <2024021908-royal-sequester-84be@gregkh>
 <20240219092421.GA32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2024021932-marbled-passable-e7ab@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021932-marbled-passable-e7ab@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 19, 2024 at 10:52:12AM +0100, Greg KH wrote:
> On Mon, Feb 19, 2024 at 01:24:21AM -0800, Saurabh Singh Sengar wrote:
> > > > +#define HV_RING_SIZE		(4 * 4096)
> > > 
> > > Hey, that doesn't match the kernel driver!  Why these values?
> > 
> > This application talks to device which is recognize as HV_FCOPY
> > is kernel. In the first patch of current patch series I have
> > mentioned .pref_ring_size = 0x4000 for HV_FCOPY which matches this.
> > 
> > This code is well tested.
> 
> I'm commenting on the fact the 4096 is sometimes PAGE_SIZE and sometimes
> not, and you have a default of using PAGE_SIZE values in the kernel
> driver, and as such, this will not match up.  So be careful here.

Thanks for clarification, I will add some note for it in V2.

> 
> > > > +
> > > > +unsigned char desc[HV_RING_SIZE];
> > > > +
> > > > +static int target_fd;
> > > > +static char target_fname[PATH_MAX];
> > > > +static unsigned long long filesize;
> > > > +
> > > > +static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
> > > > +{
> > > > +	int error = HV_E_FAIL;
> > > > +	char *q, *p;
> > > > +
> > > > +	filesize = 0;
> > > > +	p = (char *)path_name;
> > > 
> > > Why the unneeded cast?
> > 
> > This code is existing today as form of hv_fcopy_daemon. As this new
> > application is replacing hv_fcopy_daemon I reused the same code and
> > casting.
> 
> That wasn't obvious that this was copied code, please be explicit about
> that.
> 
> thanks,
> 
> greg k-h

