Return-Path: <linux-hyperv+bounces-2907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB008963951
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 06:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904171F235E5
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3CA446A2;
	Thu, 29 Aug 2024 04:24:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84522EF2;
	Thu, 29 Aug 2024 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905458; cv=none; b=TqP82HUjzizaTU8/bP35B/m7UYSUve3E8wRFgs7bibURfQKZbCEO4U+SILit7B3xCs1ur/9MtMu8WG5R3xj2cnckW6zniNIei+UX0nWeTj5QkESrVyp8exgaBhVDpkjadpERdM7QQ4+5Uxq/meUE6oYKrjk2XtO1ezpFISMgOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905458; c=relaxed/simple;
	bh=KehGCdshXIiswVfMoHH7TH5FP9Sf44TF27Ug2EGyzZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAlG+arjYGF5+r919Yvc6o66jaxnbDv/i6i+39bGW+mYSUWUbXHs+KMt/iNQIHCw9llJEpSZ3vRhUPSM/F7dwJZBXsqegXr/tqmXvxJBgLWSP0g3CB29Oz3/Zh30rBtNhKMWFUtGa3unSzAzIzVjRat6FECrRWxSbGZu/yspyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84AC868AA6; Thu, 29 Aug 2024 06:24:12 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:24:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask}
 return value v2
Message-ID: <20240829042412.GA4537@lst.de>
References: <20240824034925.1163244-1-hch@lst.de> <yq1v7zkdu3s.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7zkdu3s.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

I've pulled the series into the dma-mapping for-next tree now.


