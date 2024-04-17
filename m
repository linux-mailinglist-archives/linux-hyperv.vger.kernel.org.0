Return-Path: <linux-hyperv+bounces-1980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E168A7E14
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891651F2166A
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE127D088;
	Wed, 17 Apr 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eyhUP7D/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199A200D2;
	Wed, 17 Apr 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342110; cv=none; b=bOk0b3EHtEY7rZWNFI4AjxxqRY9dqdpyfZogItYkd8Let/lSSAYrFEPnjpgp50v0ru23RmPKiquBKQMCwe0Tu5oGwf5CK/sKq3WBBbPGmLB2nAOQgtHj62dbAaCZhtuzBm61T2skEeQ7zlkag90H2q51KjZ16fsm7TaGzQOfSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342110; c=relaxed/simple;
	bh=CPggfGXwfpYl2LtMCk0W03Y0VcfNgWkf80LldNabsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx+xaR1pq28yHFWTrY6d+60mnfwHflcTxC74cTbI0YRcnZUPkajS2stApOEsEq/mDY2rJJJvMf6K+y0OqzY4dX8d3MoNJCVDHlvbDSvYBPyLzfH+rc4VT8feSlO5a9L1T1CTnHqXSntteC4KahvvhrFzX59WypRGKsxErRT1ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eyhUP7D/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 10DF220FD4AC; Wed, 17 Apr 2024 01:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10DF220FD4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713342109;
	bh=ml3zwjbhdXgIfoUW8gx0aMxv4GKw5XoRcB9hMN/WDuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyhUP7D/9u3vQ1XfE4uno2+u01BUlHETLcI7zZN4hEVGHY+upG/Qi3ziUUDyNisWh
	 8eClWwyGeUQ1NYJllVH9O0f4lyYc1WMO6G9nkR2EPtwKmL09N9dcoGducXt0YCCg01
	 irKj2u5TczGbdA2Fi6zf5GDoihfglCi1OLvPyrcE=
Date: Wed, 17 Apr 2024 01:21:49 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] tools: hv: suppress the invalid warning for packed
 member alignment
Message-ID: <20240417082149.GA9867@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>
 <2024041708-juror-briskly-9c86@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041708-juror-briskly-9c86@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 17, 2024 at 10:17:21AM +0200, Greg KH wrote:
> On Wed, Apr 17, 2024 at 01:00:48AM -0700, Saurabh Sengar wrote:
> > Packed struct vmbus_bufring is 4096 byte aligned and the reporting
> > warning is for the first member of that struct which shouldn't add
> > any offset to create alignment issue.
> > 
> > Suppress the warning by adding -Wno-address-of-packed-member flag to
> > gcc.
> > 
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> What commit id does this fix?

Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")

- Saurabh

