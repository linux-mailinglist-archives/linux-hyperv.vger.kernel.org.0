Return-Path: <linux-hyperv+bounces-3198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43A9B3667
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E7A281C19
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7291DE896;
	Mon, 28 Oct 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PGl/BdZq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47355E73;
	Mon, 28 Oct 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132731; cv=none; b=qPQE3L6rTqRsAPClmitnEcbaShDrXVS8b2b5sv1MLBCOE/7OCmXvTogGxsxxRiu/dN+BH2v3WLmqu1wCdRUtiOWVXk7/HIhWxE0jLUsf0RYFdRCyRx1eCCqR236o8Elyh+HhOv4D6ULkJuwCaX3K36UEyHASQcUQ7oAcPdkkQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132731; c=relaxed/simple;
	bh=hTcVmdXCzHftuYNXfbC4o6x6uayNH2uk16AbT3F0N5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBaDJIgadFKqyk8QDz0nFwJCTmsOSn+OeGudr1Jt1G1Ha1eam6/nWBSjrUoXH3OQnKO4co33svRP8Ms79WpREUBSQVoOH6vl1qGXa6KO9TM8pqnA3FoW9KirVQY7vrKgSByTbD7zs9hC579wmEt4zGGFFnPvPj/I3PR2kcgdBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PGl/BdZq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BE059211F5EA; Mon, 28 Oct 2024 09:25:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE059211F5EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730132729;
	bh=tgM9pY2hja0eFXSb8GcM1GOs9qeJBhvOeYM7pJwnNzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGl/BdZqoxIpFVvWQJTQzrafEfA1bddztpd8+z/NuuoJQStn8Y4UFOIU3dZMCLHT1
	 kG/WWzmon7cHBQQBd6hRXoOmac8cMgrNKWwGNv83zLaFE1pMWp3R73zsY/nF4ESdKn
	 fFvDtz/Hy/bdDEK/Fm6wY7OIFDYxs1uu0QAeSnog=
Date: Mon, 28 Oct 2024 09:25:29 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: terminate fcopy daemon if read from uio
 fails
Message-ID: <20241028162529.GA22222@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241025143009.4571-1-olaf@aepfle.de>
 <20241028090620.GA32655@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20241028160156.71661aa3.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028160156.71661aa3.olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Oct 28, 2024 at 04:01:56PM +0100, Olaf Hering wrote:
> Mon, 28 Oct 2024 02:06:20 -0700 Saurabh Singh Sengar <ssengar@linux.microsoft.com>:
> 
> > Thanks for the patch. Changes look good to me, I will suggest to improve this
> > log message incase the error type is EIO by suggesting that users verify if
> > 'Guest Services' is enabled.
> 
> No error happens if the state of "Guest services" remains unchanged during
> the life time of the VM (either "enabled" or "disabled"). Also no error happens
> if "Guest services" changes from "disabled" to "enabled". But the error happens
> if "Guest services" changes from "enabled" to "disabled".

All this is correct.

> I think the actual
> error "EIO" is not relevant for the commit message. Maybe you mean the second
> paragraph should read like this?
> 
> This happens if the state of "Guest services" integration service is changed
> from "enabled" to "disabled" at runtime in the VM settings.

Right, we can inform user by putting this info in syslog error.

- Saurabh


