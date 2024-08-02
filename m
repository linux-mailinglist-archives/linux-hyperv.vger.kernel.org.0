Return-Path: <linux-hyperv+bounces-2664-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD23945715
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3827CB20FD0
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 04:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FD18EA8;
	Fri,  2 Aug 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M9ucvcQa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474E8836;
	Fri,  2 Aug 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572943; cv=none; b=OsBsYAMHnxO3wBlYY/XfVl+zRJRDSUeDvcc/n7+W6i8pjWQiRXlvktVIQa8TIFX7uzSkz0pyQ6D47va3/RB0ZyfEgDHjFh5IWQtRMA64K7ta0Z1ed5m8F8AjzdvePjkai9WtTrg0FDYVCnyPc63pHePX/40EFsrfrHYGIRDnJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572943; c=relaxed/simple;
	bh=9KJuyyvml3PXGB4TrJStcPInPtU3175rh4Ee+tEUj+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH4Kq9eKlSUl1v0L/2CsfBAPS1xahrJ0Q9cT0ZNIaUBNmB93UhUKdXMx3WgUs8eQAQscImESE03XNpVRLq7r2RB2S2Dcv3+2CmHCHr90fzPkYpWF3hIE1uV4mLrGd+avDHGcmGhnSnG5m/uvniV3Eo/7NueDeQsLydjMzUKZdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M9ucvcQa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0E73120B7165; Thu,  1 Aug 2024 21:29:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E73120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722572942;
	bh=eQOMIFj09GioJStl6h8C/2lXrRTjz2r3e4nHzMbFveE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9ucvcQamjFs60QX4CvBf2Q8OMHy+ZoDjzeMgJjAywe9vinNa+HOsMMHIBgmc6Stn
	 dd5dgs5dy4ZtjRd6eSIJp7GEIgBJEyzqjgMRPKk6XXxM1VTZ+l38+WVNRdPL6DTLXO
	 iXcQXhkItC6GnXMnN3lMf5ydZXenuSj72V57EiY4=
Date: Thu, 1 Aug 2024 21:29:02 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20240802042902.GA9957@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
 <f9dfaf0e-2f72-4917-be75-78856fb27712@linux.microsoft.com>
 <20240801034905.GA28115@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240801071649.386b4717@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801071649.386b4717@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 01, 2024 at 07:16:49AM -0700, Jakub Kicinski wrote:
> On Wed, 31 Jul 2024 20:49:05 -0700 Shradha Gupta wrote:
> > It is a pretty standard support for network drivers to allow changing
> > TX/RX queue sizes. We are working on improving customizations in MANA
> > driver based on VM configurations. This patch is a part of that series.
> > Hope that makes things more clear.
> 
> Simple reconfiguration must not run the risk of taking the system off
> network.
Agreed. I'm making the changes and send a new version. Thanks

