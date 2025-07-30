Return-Path: <linux-hyperv+bounces-6446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18373B160A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E04D56657E
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A27E110;
	Wed, 30 Jul 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="reJci/HK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556C39FCE;
	Wed, 30 Jul 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879738; cv=none; b=TI0BbICJVyvSvlNJYHCYdazUaooXrbTUQryJufzeRxchXqkZoFk5E95IU5wvSNPAjRejO339B5+5+ZSbDt8ONqZwcABSakxTr3A+gswoNYmXnf5flrJUnbakuaW3JFR48hLGTDH+0hNNzfwX6mI2m+XdDdXl5K4lxmJGSkwHNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879738; c=relaxed/simple;
	bh=0AbDoS/cP1HSgHn7TFY7LR7IXahHnT/TBZMuTc133Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa5TmWD9H6dGzzkxNd94K9SyFo/rAPvMQE2vhWdIkz6BWk/f9E1tK/5Ge+XmX7ejCcQ/E6upufxYeJoy4gQnO7uSNqnNpd2EDhAlim09BVx9w4dnLTyDawQkUH9cyHwr3ksLNVTIAhRslOw8xFWR0KK/3vf+FJGkD+Pb6luGHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=reJci/HK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1218)
	id 256932120E98; Wed, 30 Jul 2025 05:48:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 256932120E98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753879737;
	bh=UvocS1LqPk6cibdaisIPFnrGO8auI3MG3CAruDjokIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reJci/HK8HR53ZBi5i3yVYHzIIhlrbVPD4q/QyCzOPl++Z7gIEFBG5K0JqiFW5wo2
	 d5YXQtHig/8H0UmTTZsoGJB3IIO8r0KHpa8mpfpldMR0QUFjS04sxNN9Q4SVplY0JN
	 KIbTi6nKTfEhQBDMG7Zo5a9j5Nm6oRU8BF42y8tw=
Date: Wed, 30 Jul 2025 05:48:57 -0700
From: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: abhitiwari@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes for hv_utils_transport.c
Message-ID: <20250730124857.GA8145@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1753871840-23636-1-git-send-email-abhitiwari@linux.microsoft.com>
 <83070bd2-209a-4143-9efa-0a67f489563f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83070bd2-209a-4143-9efa-0a67f489563f@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 30, 2025 at 04:38:33PM +0530, Naman Jain wrote:
> 
> 
> On 7/30/2025 4:07 PM, Abhishek Tiwari wrote:
> >Fix issues reported by checkpatch.pl script for hv_utils_transport.c file
> >- Update pr_warn() calls to use __func__ for consistent logging context.
> >- else should follow close brace '}'
> >
> >No functional changes intended.
> >
> >Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
> 
> Please use a different prefix for Subject.
> Replace "x86/hyperv:" with "Drivers: hv: util:"
> 
> We generally follow the naming practice used for a file, which can be
> seen in git log <file_path>.
> 
> Rest LGTM. Post above change:
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> 
> Regards,
> Naman

Sure, thanks.
I will do the suggested commit message changes in the v2 patch.

Regards,
Abhishek.

