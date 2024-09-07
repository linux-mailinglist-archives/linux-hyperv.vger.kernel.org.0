Return-Path: <linux-hyperv+bounces-2987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B396FFF7
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 06:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E071C22164
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 04:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6726AE6;
	Sat,  7 Sep 2024 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sv0xBNQT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9028E8;
	Sat,  7 Sep 2024 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725683599; cv=none; b=mwpFUS+LftzDPPTLYyaa26UlLvR+sK7cR+Q1xrtOUoORrjNs8FFyJTuryMdvPw7hu1NoeDf8crSKxUgxcKkaHYYZrDsBe3c0EWCL2Vpsj0MNoOqGEuMHv6k97+GSPNNc6lAnSQY1S1aixcDdUdeDUTMEp/DdG016vxuQ6qmERDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725683599; c=relaxed/simple;
	bh=LUVJkOSjoqPPaNcTEFLviopgiZG1Q/dI0FQsLJM6x0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XurV90PdL/GKCaV7wU5VndCU3jyNgo637u0FDqO+tKEkw9O4bMTrtoEXxDkRFms7ZJv4HedM2zKeQaiw6yRcAja44uEucuggzdq35aWk2iY69cQvf0kGx1fVgt4fFfWQd3lUfgEQcCqRICYDp4spRA+Ibjm9cA1yX01Zb+akT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sv0xBNQT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id D27F120B743B; Fri,  6 Sep 2024 21:33:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D27F120B743B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725683597;
	bh=LSGH5ArQU9i6qGS5p5eKm1959+dLflyrPJc5xMD97uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sv0xBNQTx6hSDD//ocVpgXK6XWx2C9qPA2jfVT+bdPepjnhF40ozv1CT9/NQ1ul8J
	 6EV+xukjSxMxQdqq91iJBt4GLF5aIJ7Aq4HHaepbsddfe9DniPrrDFTwpj34qGIdNK
	 U/jHpUgaVJTR9eGy/xgSd4sTdAOhpe2RiVtbPcPs=
Date: Fri, 6 Sep 2024 21:33:17 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/hv: Add memory allocation check in
 hv_fcopy_start
Message-ID: <20240907043317.GA9735@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
 <SJ0PR21MB13241C31DBE2ED848F80E663BF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR21MB13241C31DBE2ED848F80E663BF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Sep 07, 2024 at 12:53:02AM +0000, Dexuan Cui wrote:
> > From: Zhu Jun <zhujun2@cmss.chinamobile.com>
> > Sent: Friday, September 6, 2024 2:14 AM
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh

