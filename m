Return-Path: <linux-hyperv+bounces-3654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85465A08C23
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76263ADB25
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280520A5C8;
	Fri, 10 Jan 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="krSrSC4C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE36209F58;
	Fri, 10 Jan 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501302; cv=none; b=IzpBIHX0rAEIeO2yFCWAnbSE1PQJdCXxwK1OrjsJIMlS86xfZwg05/oxdNnAJFwSZTuKF2UpjMDLrwf48I4V126QCBKWbanuRRJ02msSlT9qksc5hyl3panDvVEmi1KdNUjMpDY7YtMR1onOl2wg8CYavDomgJJsk+ReyvQWc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501302; c=relaxed/simple;
	bh=312LM2sOolhqlP925LYeIE9hRO6OnsfKwYhz7M2cef0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpAKnufgAhS0Hty5Q81Uy29KQfY9+qh9iKpt5unHTAmitCCHDeec2NxLUQ+ILUcRsgthqMvq9hLEuMcUT+BZLQtlTGS8EXbPvtsh2wS7NqGfjoG0mN0aecmKAwyDMlbtOk0IhpagyFeU+iJ4HNbSplAEOvQ9ciUD/Vfq5PO7ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=krSrSC4C; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G8+TuLQOgs/0UAFvzlz1GPVAo9yjgLGEOUGTGADsSN0=; b=krSrSC4C66XvbbqPTj4+17rCSE
	HlaQnAk/3RfBnkGZ7LmstzlKnJvIEj2X+IBlKXLH6jloVr6rf9uD5WFe56FTPXhq/h5N0gc7pZ9si
	BD1p0VFPxzdqtlQkL1eZCP/BI4gWXFbixBsVif89DS3lMTPINAXqcic3mKiCbmzBY92A8wpW8ch9K
	Gvc6YgUo5nffD4soAf7HJpnFnfC8xKuYlAJQOfJ9SQKxlChHdUPDKCVpe2k8sL1VQRRPMjTupj/TP
	drhqDJAjh1t3u8upcKZlvAiqPRqRmroPMrHhDIM7VGXvkx6h3jaDpKwou4wv3R943V/5e3aQF7hYw
	S3cTAD2A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWB65-007mzq-0U;
	Fri, 10 Jan 2025 17:27:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 17:27:49 +0800
Date: Fri, 10 Jan 2025 17:27:49 +0800
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
Message-ID: <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>

On Thu, Jan 09, 2025 at 02:15:17AM -0800, Breno Leitao wrote:
>
> I would suggest we revert this patch until we investigate further. I'll
> prepare and send a revert patch shortly.

Sorry, I think it was my addition that broke things.  The condition
for checking whether an entry is inserted is incorrect, thus resulting
in an underflow of the number of entries after entry removal.

Please test this patch:

---8<---
The function rhashtable_insert_one only returns NULL iff the
insertion was successful, so that alone should be tested before
increment nelems.  Testing the variable data is redundant, and
buggy because we will have overwritten the original value of data
by this point.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index bf956b85455a..e196b6f0e35a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -621,7 +621,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 
 			rht_unlock(tbl, bkt, flags);
 
-			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
+			if (!new_tbl) {
 				atomic_inc(&ht->nelems);
 				if (rht_grow_above_75(ht, tbl))
 					schedule_work(&ht->run_work);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

