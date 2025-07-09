Return-Path: <linux-hyperv+bounces-6167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DFAFF51C
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB99173486
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0219D065;
	Wed,  9 Jul 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgfhfhLi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D616DEB1
	for <linux-hyperv@vger.kernel.org>; Wed,  9 Jul 2025 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102167; cv=none; b=cLOuSpi0Cio5s6XwA3QTtx0yCEMoNTUUpf5pt0dpJcQyHNr7dwjhb2KvXtm61bwhOzwovwRxIyCyf/1JMta3/bxobMaxZeBwceyOeGOm/57AZsSqR8KyNms5Ou/kKXRJzQBIegMMSrBI5TrhdeODTi8LH3cVh3G9mE5atSqpeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102167; c=relaxed/simple;
	bh=HbTINc76TFz2DxjE24fE1+zFNZNnYW/92B5YQe2ethg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkUlbo4/aqZoaaL5WTtGewGuxkpPOX9+Vl4d01+SMVb7JiB7nw1V6koj5P9N8gz5mdXwP7O1WGxDWnc6mEN4pQby0NKZks8CRoMvP0wVfUs6u+TpHBrqC3LIoiZzqUadm336PXzCc8Tew5bLLVUFthsgUXIVW98nNnAQq4iMILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgfhfhLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2833C4CEEF;
	Wed,  9 Jul 2025 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752102166;
	bh=HbTINc76TFz2DxjE24fE1+zFNZNnYW/92B5YQe2ethg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgfhfhLiKCk7AtaiCzouNlZacxsw4xR8p040/G2IAYjfzSVeaGxbC30Jor61xaTvH
	 ceeIfz/Q0aCrjWmpyWyie/2XMQQPDxNv1bwCQyC88f+hYvUpbmOix0QGux/KKBuawI
	 sEg8dro4iheszrr7rxXvCyI45p0XRcmgVLWegKrMBp699bd4+532jJ2jBSMd82ozmp
	 2djKEOJAXTeGv16UJmxvN77Enjlk76psfilZH8d2jpAOm+H/AYRPoLGcOuCL2PSnKe
	 +GBKGoD8TmT6PZejAlf+7IRrdIQ0F3DoaKHo9t1a0VSrxAXSgYn1vq1IHLVh2K4+PK
	 07meVUqx0pwNA==
Date: Wed, 9 Jul 2025 23:02:45 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: yasuenag@gmail.com, eahariha@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, ssengar@linux.microsoft.com
Subject: Re: [PATCH v5 1/1] tools/hv: fcopy: Fix incorrect file path
 conversion
Message-ID: <aG71FVGjuBYSvuHD@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250628022217.1514-1-yasuenag@gmail.com>
 <20250628022217.1514-2-yasuenag@gmail.com>
 <f71d33bb-65e5-4a92-b08b-9d706e74e745@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71d33bb-65e5-4a92-b08b-9d706e74e745@linux.microsoft.com>

On Tue, Jul 01, 2025 at 03:06:08PM +0530, Naman Jain wrote:
> 
> 
> On 6/28/2025 7:52 AM, yasuenag@gmail.com wrote:
> > From: Yasumasa Suenaga <yasuenag@gmail.com>
> > 
> > The hv_fcopy_uio_daemon fails to correctly handle file copy requests
> > from Windows hosts (e.g. via Copy-VMFile) due to wchar_t size
> > differences between Windows and Linux. On Linux, wchar_t is 32 bit,
> > whereas Windows uses 16 bit wide characters.
> > 
> > Fix this by ensuring that file transfers from host to Linux guest
> > succeed with correctly decoded file names and paths.
> > 
> > - Treats file name and path as __u16 arrays, not wchar_t*.
> > - Allocates fixed-size buffers (W_MAX_PATH) for converted strings
> >    instead of using malloc.
> > - Adds a check for target path length to prevent snprintf() buffer
> >    overflow.
> > 
> > Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> > Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
[...]
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied to hyperv-fixes. Thank you both for the patch and the review!

