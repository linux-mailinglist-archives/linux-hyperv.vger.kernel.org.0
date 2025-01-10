Return-Path: <linux-hyperv+bounces-3661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77152A09863
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282A87A15DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98D213E60;
	Fri, 10 Jan 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MeFHJktL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088A212B38;
	Fri, 10 Jan 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529866; cv=none; b=kaQjk5DvcbnWqX3dGPPlOuyzFd2h3arhRh0sTzpICIuAtZp341jIMCrtgXF0siXG1mXbYifEjtBhlsQSa06oxfPShDMJyBtu24V+4uCPpBKci8WUk/pXLIPw0r5QoVNxMVQrkkK1E4+YIIIPALEc0E+d0tBlIB4AZv8UDhlIDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529866; c=relaxed/simple;
	bh=OswepRMcrJSSxmRNYxTaM/+fG6Zx5l6+HnBopmzdmy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO1BGj3MxdVO9tfziQByHzTrwYXYff+t6nLf0tGVj84JAY3F1F559hZMCDg6MlQLiiCJD8Z5KFNSZh9VUW2oCfo4GDFrYUaJhQ5fQXlN+sD7RATWdk92h3NHxDbU8wPr9Wwqdiu4/levqG/evabUZerE8fdR3XtSj8g3KV4oE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MeFHJktL; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RAZ22W760UfI2aICRfMf3Bvtw4l6/sg/OK0TEyz4Vv8=; b=MeFHJktL4b6YInQKsZwMlQnHP+
	tP+VJuCiN1RbWA/BXmQn1VF2m+ORIR0UO7nZYsjo0Bngl4i+BpT9yuqtANGGkRkrybGaANKzdftv2
	JVib2YMUw/K+A6pIcq5xbTOa0InKJ3XRTkdV9hwc4P2+8Of4cRDP/IqAaiXGd/lqhd96gOXC7HeMK
	Ig5iY6tO4AS4DMSYIjwfXDSAunlRsnPFxd2LwIkS4pL2imursc6aoddKabYJyG+6pHhP9wySRiSJ7
	7AQtibmPCo90Moc0VpK7j7oNJrz3X8KCjqNOlrIAp5Qy1WPhROtWYD37noR6CKx01nBYJaasplqFJ
	8B/tMq6Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWIWx-007uiJ-0d;
	Sat, 11 Jan 2025 01:24:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Jan 2025 01:24:03 +0800
Date: Sat, 11 Jan 2025 01:24:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Breno Leitao <leitao@debian.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [v2 PATCH] rhashtable: Fix rhashtable_try_insert test
Message-ID: <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jan 10, 2025 at 04:59:28PM +0000, Michael Kelley wrote:
>
> This patch fixes the problem I saw with VMs in the Azure cloud.  Thanks!

Sorry, but the test on data is needed after all (it was just
buggy).  Otherwise we will break rhlist.  So please test this
patch instead.

---8<---
The test on whether rhashtable_insert_one did an insertion relies
on the value returned by rhashtable_lookup_one.  Unfortunately that
value is overwritten after rhashtable_insert_one returns.  Fix this
by saving the old value.

Also simplify the test as only data == NULL matters.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index bf956b85455a..e36b36f3146d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -611,17 +611,20 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
+			void *odata;
+
 			flags = rht_lock(tbl, bkt);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
 							hash, obj, data);
+			odata = data;
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
 			rht_unlock(tbl, bkt, flags);
 
-			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
+			if (odata && !new_tbl) {
 				atomic_inc(&ht->nelems);
 				if (rht_grow_above_75(ht, tbl))
 					schedule_work(&ht->run_work);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

