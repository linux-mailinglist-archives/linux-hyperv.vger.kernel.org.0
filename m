Return-Path: <linux-hyperv+bounces-3693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A567A13638
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716D0167895
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF31D89FA;
	Thu, 16 Jan 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="iixZQxxT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57209197A7F;
	Thu, 16 Jan 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018646; cv=none; b=oov87lq8F3ym83iakJ7JRIDVhfBywafv8V0R1mAbSAHQSYd2DheLaAS6oGkIev/70EtXEKtC2mvsAJB9XWy/E9kz2ZcsjpG6JPF6PUMB8oeN7sHqo5nVRVVVpIWBOsF1NmTKEvXlAvEvhZVMM1EiCOY6w/hJzUVjEgFcC2Quu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018646; c=relaxed/simple;
	bh=x6nfi/3Iuus576eqwWFa1dw33hv27F7i4Pw9XH08Swg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuWGd5fLNiyieWHXfz4QL0pi5hU7yUMufc+dWTdIG3xkUfyqFw68b9ppnpClM3B3bIpyokoEa3dSgE3bOdbPeLVuETSQA6H/OpWF/71XV40Huwrl+43d3BqBdLnoqeGROUYLFdZc+7z4+vMsqraqXXpw4aIrQmqWT4+XwNRQPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=iixZQxxT; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JHAST06Z1gLA+C6ASFe8NplFY09GQXQxZ6q0+Vjz5n0=; b=iixZQxxTib7iEQj2ewtECjpUTF
	UpK3ByikllVc2XeeU5xKqxLfmON1JbBj77alkb7HLJi47b/fhX8aCuufDTG1TG2BsEXmHaoauPN4R
	Qg/ic8pdwxxxyB/esS4MXGgLMziWNXBeW5bnypRB6wi+LGdvjZsL7KaUC9wH4fHes0LaPVl4udF7H
	ObPoeWQcqM9txtQDKTv28avdJ4Ou1ud6iNkOf4iLrgLz/7tW8UFeiPnQcSDvOl5jLnGHpwDl7kGH7
	L8w1oYtFw3VlfX4fnmrR2K4+nQ5BOZlaXJvSR/f3GQYvqoN/Y1c8tc6JyxWHiOJia2j2aJQagOCp2
	paTUdECg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tYLgL-009hDk-2e;
	Thu, 16 Jan 2025 17:10:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jan 2025 17:10:14 +0800
Date: Thu, 16 Jan 2025 17:10:14 +0800
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Message-ID: <Z4jM9iy4lShFeEYZ@gondor.apana.org.au>
References: <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4XWx5X0doetOJni@gondor.apana.org.au>
 <20250115-cordial-steadfast-perch-c4dfda@leitao>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-cordial-steadfast-perch-c4dfda@leitao>

On Wed, Jan 15, 2025 at 07:15:46AM -0800, Breno Leitao wrote:
>
> Something like the following (not tested):
> 
> 	diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> 	index 3e555d012ed60..5a0ec71e990ee 100644
> 	--- a/lib/rhashtable.c
> 	+++ b/lib/rhashtable.c
> 	@@ -554,7 +554,7 @@ static struct bucket_table *rhashtable_insert_one(
> 			return ERR_PTR(-EEXIST);
> 
> 		if (PTR_ERR(data) != -EAGAIN && PTR_ERR(data) != -ENOENT)
> 	-               return ERR_CAST(data);
> 	+               return ERR_PTR(-EINVAL);

But data == NULL is not an error, it is a successful return value
for rhltable.  It's when a key already exists in the rhltable
and we're simply appending the new object to it.  Thus the insertion
was successful but the hash table did not grow.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

