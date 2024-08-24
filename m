Return-Path: <linux-hyperv+bounces-2855-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC795DED9
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 18:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82231B21041
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636222F11;
	Sat, 24 Aug 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T8BApDmc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4651E868;
	Sat, 24 Aug 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724515329; cv=none; b=IhKqKCGXC8iMx5l0ehRsK/dffGMauLnkR9DknM8i2UoIctJ85QjIAC8SgYTPNXwKOmQvin6cEkSq8ZpJP2pRH6AlZsOokyBc9QqNH6hBJ9wA8/2VgouG6JrOerTDpWe6H6y7ofN4IdgHLqO3O4Q41+kmxqXkjjMQKfHqdb6s2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724515329; c=relaxed/simple;
	bh=3mctRDLxq0na0JqzzHJt0c3k4fyBURQGSn+/D6VWgUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0zAsnyhICcvEafofi4LzCLT+7aNfaGVlFU45iOCtTtweLPiQ4pwCNn7GbLiVAnW0lTNhdI5Qj5rkUJ1YPD0hr8tf45yK5VA5pYgAR4hzJKFai2VthhT3qFYVQ2NE3P2JU1kfC6HprnFpIk3wgaAx3acFrxij3NTEB4a7k2fBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T8BApDmc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 661B420B7165; Sat, 24 Aug 2024 09:02:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 661B420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724515322;
	bh=vJrWn+gX+NDFRJBlwaRRDx9R5sUhkz39cTnd3tS4uSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8BApDmcx0yPYxTpNSdNI81x5tONRbXxgmobCIPbNJLsiQ4RPZoc6vqfG19H1uQVI
	 /1oYYYF/rR5305D+GLKmS6YNUWTsQ6Q4EaS5jFG6JaTpXvGXdQnYuTyW9YV+QowJiJ
	 4TTFf+8MFnkhzAT+4FwRUNtLEQzSkK2GZLsDhYLA=
Date: Sat, 24 Aug 2024 09:02:02 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question to hv_vtl_real_mode_header in hv_vtl.c
Message-ID: <20240824160202.GA18333@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240813172819.GA6572@yjiang5-mobl.amr.corp.intel.com>
 <20240813213628.GA7852@yjiang5-mobl.amr.corp.intel.com>
 <ZskQEpyoch3T2VXQ@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZskQEpyoch3T2VXQ@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 23, 2024 at 10:41:22PM +0000, Wei Liu wrote:
> On Tue, Aug 13, 2024 at 02:36:28PM -0700, Yunhong Jiang wrote:
> > On Tue, Aug 13, 2024 at 10:28:19AM -0700, Yunhong Jiang wrote:
> > > Hi, Srinivasan and Dexuan,
> > > 	I have a question to the hv_vtl_real_mode_header in
> > > arch/x86//hyperv/hv_vtl.c when addressing one patch review comment.
> > > 	In hv_vtl_early_init(), the real_mode_header is set to
> > > hv_vtl_real_mode_header, but there is no setup to the real_mode_header, since
> > > the realmode_init() is marked x86_init_noop in hv_vtl_init_platform.
> > > 	How is the real_mode_header(in another word, hv_vtl_real_mode_header)
> > > used? Is it to meet the access requirement from do_boot_cpu(), so that
> > > real_mode_header->trampoline_start64 will work, although the start_ip is not
> > > used?
> > > 	If it's really to support the do_boot_cpu() requirement, how does the
> > > non-VTL guest meet the access requirement? The hv_vtl_init_platform() is
> > > unconditionally called from ms_hyperv_init_platform(), so I assume all hyperv
> > > guest will have the realmode_init() set as x86_init_noop.
> > 
> > The patch review mentioned above is
> > https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/ . Can we set real_mode_header
> > to hv_vtl_real_mode_header in hv_vtl_init_platform(), instead of
> > hv_vtl_early_init()?

Yes, fine to move.

- Saurabh

