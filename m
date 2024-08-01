Return-Path: <linux-hyperv+bounces-2639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900919441FD
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 05:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C871F21F2D
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E995FEED;
	Thu,  1 Aug 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="entvHzVG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B540E1EB492;
	Thu,  1 Aug 2024 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484153; cv=none; b=oE0G1z5B4zIZ1rBjaeVgJHVtErZSWe8VyNzNqicUEKqF6Ac9GrFalwbtXhjUlrZMzGLTL2M5TXqMSFNRc+DENEls9Us0h/9DXhohN9DRVgj8Giv0cwY6P5LJUskXD/sewPc8UnGfh9o1K4HluJqC4sWelQVxp3WUimpxiRM38DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484153; c=relaxed/simple;
	bh=9ej2VIyOHYjd3QEyrOyewzphaHVD5p/LyehItNSoxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SReRPBF4V3kaFMhpgnR2L5QnVsp9/48QfrHqMHVPhiSjJjHwiISSQwqEHoJgR+TK1ZgZNyiumJVgS6O9KtRIYOVKzP7OPAqgacDC0u/EHtrPJrd6YSQ0ZUWA/mrIDYJTltICzR1X9T+waD3pB571FVu6C1YKh77lOun56pjNgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=entvHzVG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1A35920B7165; Wed, 31 Jul 2024 20:49:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A35920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722484145;
	bh=3adnSLI18j54XBzRjMcz1DkYZ3QcEDWZpj4XNWwo1I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=entvHzVGLPRXGY5QPMtAqcqN906PBEYCYRxHRPN0QFGZJDK80mn6ffaMzayOq6SMu
	 +q+1EZwyyx5YDXkkpBzjVy2kTtKJiSDGL07KFuzfnYWoAiTSudeJ0JmiBTUin8qORe
	 l7CF8XCWBUrluhiAupcfHa/mTwIvs/uTFh078UVI=
Date: Wed, 31 Jul 2024 20:49:05 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240801034905.GA28115@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
 <f9dfaf0e-2f72-4917-be75-78856fb27712@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9dfaf0e-2f72-4917-be75-78856fb27712@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 31, 2024 at 02:19:34PM +0530, Naman Jain wrote:
> 
> 
> On 7/30/2024 10:31 PM, Shradha Gupta wrote:
> >Currently the values of WQs for RX and TX queues for MANA devices
> >are hardcoded to default sizes.
> >Allow configuring these values for MANA devices as ringparam
> >configuration(get/set) through ethtool_ops.
> >
> >Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> >Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> >Reviewed-by: Long Li <longli@microsoft.com>
> >---
> >  Changes in v2:
> >  * Removed unnecessary validations in mana_set_ringparam()
> >  * Fixed codespell error
> >  * Improved error message to indicate issue with the parameter
> >---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 20 +++---
> >  .../ethernet/microsoft/mana/mana_ethtool.c    | 66 +++++++++++++++++++
> >  include/net/mana/mana.h                       | 21 +++++-
> >  3 files changed, 96 insertions(+), 11 deletions(-)
> >
> 
> From what I understand, we are adding support for "ethtool -G --set-
> ring"  command.
> Please correct me if I am wrong.
> 
> Maybe it would be good to capture the benefit/purpose of this patch in
> the commit msg, as in which use-cases/scenarios we are now trying to
> support that previously were not supported. The "why?" part basically.

Hi Naman,
Thanks for your comment. 
It is a pretty standard support for network drivers to allow changing
TX/RX queue sizes. We are working on improving customizations in MANA
driver based on VM configurations. This patch is a part of that series.
Hope that makes things more clear.

regards,
Shradha
> 
> 
> 
> Regards,
> Naman Jain

