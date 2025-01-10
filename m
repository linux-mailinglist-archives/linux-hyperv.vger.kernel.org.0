Return-Path: <linux-hyperv+bounces-3656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4724A08D5A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9838167B96
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDF209F53;
	Fri, 10 Jan 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="VgjKryuu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAB1C3BE7;
	Fri, 10 Jan 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503647; cv=none; b=rZqxJnnttJhYPE3i5vhVOzQHrC6Kxfsj5ny3n3oCh8jzbMULuerzBRk/MuY0PjH889uLTL5J/7bbkhIclWB+Zby2OgSfS1gnB0WdDEufbwUbfqdVecrxm1TAfcObwuCUCaZ78rnXnir0ccdSPOwQ0ruGeBGZZ0+2G+7rN2wU0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503647; c=relaxed/simple;
	bh=dt1AY/EUcI/LkiOeEd99oqFeirD8Z1p51c0VfYI7H9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKBNhF9egbjTScwkH1qCacCc8960RIbP8FQMUmWbm+Ven00vrn6OzlBzqz/gd28Ahq/fQqsh/MQBQI19Mow9QhPk7jVAwCy8p5Nj0KkvIB9hMD3eCDZwbSEP3+gUIZr8o2L9GNKoxFRcZI60qgSmIoT/YZd4kAduRxmRDwnnK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=VgjKryuu; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RU5zAhLpyIoTLltM8ke6eZyfJkNfQiidKNNojvVMs/A=; b=VgjKryuu9Xhvkvyn1AHQdUMgL0
	gI2ZCADj6KTOTd8eyPu5TLWcURpF0bcD1iOJig724a2FZdHwOVmK3K+qXoP1VXV+mXi6iqpcfN0Bj
	2rHng3zhevYuXw+T7MKzOK35jkMnlpG55SmsLDNL7hm4Z39KlmfnIMvV772LEovnLO1dVGpCHFszG
	xr9EHXUADB19MzN1rQ84NlsB6RX2R7kXUaoz6ZnmIW+2icLRPQi3GY+CmDH+u4C9QHuhSpUJsUO9v
	ch1LqAObHMgthiOAKGgOLTYinRRqcdC+TjcE6Or1mJqiPaNA9Ne5UeeLZhTLgKagLoqPYg6fqyQUu
	qTp3V6ZQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWBi7-007nyb-09;
	Fri, 10 Jan 2025 18:07:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 18:07:07 +0800
Date: Fri, 10 Jan 2025 18:07:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z4DxS37yJ2EfI_rS@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <20250110-diligent-woodpecker-of-promotion-3cbcb1@leitao>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-diligent-woodpecker-of-promotion-3cbcb1@leitao>

On Fri, Jan 10, 2025 at 01:49:44AM -0800, Breno Leitao wrote:
>
> That is what I though originally as well, but I was not convinced. While
> reading the code, I understood that, if new_tbl is not NULL, then
> PTR_ERR(data) will be -ENOENT.
> 
> In which case `net_tbl` will not be NULL, and PTR_ERR(data) != -ENOENT?

The bug arises when an insertion succeeds.  So new_tbl is NULL.
The original value of data should have been -ENOENT, however,
it gets overwritten after rhashtable_insert_one (data is now
NULL).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

