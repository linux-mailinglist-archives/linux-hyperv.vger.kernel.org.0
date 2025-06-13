Return-Path: <linux-hyperv+bounces-5891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDCAD8885
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709D51671FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9301291C3F;
	Fri, 13 Jun 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dd2DiEJX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4429C328
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Jun 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808437; cv=none; b=l2oQH2U/XzqL6Z4rThrxNEvn32UmBBef6Zj6aAVhf3hy8HFzWEqgTzoeNpg7PSjjXjO6seKVVhjoGkBjED4YqTnHF+xPqo3pmsg2ZcPMzyMQ6lgXM/MYBzufltIDuFnsxoihuc9nGa6itY3kBjLIC2A50Qp75grgrYoqY67vkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808437; c=relaxed/simple;
	bh=w8Hv/akzGNNs70K9zGB3fm4id4HA/YYMZZn8hObv0Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T80Q7Owr1ODh1SC79T1rUsIXbl93AfcKurHBFtdmcsC8POi0p5MjffE+DuqJXsuKenAQRqM+rZDBWa1+1LuZp4x2U441OMjLNeJ8KEEX2a8dNfsfdJUfPX/V9mWwAwOa1EmxJs5pJRJFZU0WSJdixJK02HhcASIueG79Ee7mqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dd2DiEJX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 17FC9201C76D; Fri, 13 Jun 2025 02:53:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17FC9201C76D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749808436;
	bh=5tDp2eD8XXRHqTdL72h/PLYvSWczfVzr9rdnDk74EK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dd2DiEJXuypRihKNMVGlf+J8n540vdmjtJw3lSZE1cW+JofNkYMI9YI9vsuglb1ko
	 gZJwGKCB93m7x8QlSrMDTcia9F7vnIBoQ3Wlr8M2k1qEcw8hpWHAJz9vAGnFFMw++V
	 iqBmKl87aiLUq/H6WK789hTknWxEwTTxDhliC3s8=
Date: Fri, 13 Jun 2025 02:53:56 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250613095356.GA20126@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250612175318.3a794cf2.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612175318.3a794cf2.olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jun 12, 2025 at 05:54:01PM +0200, Olaf Hering wrote:
> Tue, 15 Apr 2025 04:19:38 -0700 Shradha Gupta <shradhagupta@linux.microsoft.com>:
> 
> >  static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> > +	if (debug)
> > +		syslog(LOG_DEBUG, "%s: got a KVP: pool=%d key=%s val=%s",
> > +		       __func__, pool, key, value);
> >  
> >  	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
> > -		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
> > +		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
> > +		syslog(LOG_ERR, "%s: Too long key or value: key=%s, val=%s",
> > +		       __func__, key, value);
> > +
> > +		if (debug)
> > +			syslog(LOG_DEBUG, "%s: Too long key or value: pool=%d, key=%s, val=%s",
> > +			       __func__, pool, key, value);
> >  		return 1;
> > +	}
> 
> I think this is logging three times in case of an error.
> Maybe move the debug case after the size check, and change the LOG_ERR case to show all details just once?
> 
> 
> Olaf

Thanks Olaf. That makes sense. Let me send out another patch to address
this.


