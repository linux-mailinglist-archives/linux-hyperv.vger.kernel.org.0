Return-Path: <linux-hyperv+bounces-3679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623FA0FF19
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 04:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9090F168A4D
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D95230980;
	Tue, 14 Jan 2025 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YcISjwvO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437D22FE18;
	Tue, 14 Jan 2025 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824556; cv=none; b=n/9MouDcpbZ6SGr4QjYY07y2n05Xi1uePjxityi/wOPzpFkA9gO725IRYEbpOUKENx+SFX2R+vbWNjKsfPvjVoCNS8LtHqzT+aNhGNReZrPnz4vAF/vml41SxKz8SxMOO0FIj7bEhN7dNB0U/prSZXpeuk2/bBAmEwiwUd66Lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824556; c=relaxed/simple;
	bh=4yc6DCaNOTYnsKJUos1Hkpf5XjS/EBMVKnw64Rx11WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef3h7dz0Cqe4CMkUfS+LQyCdp2IMR5Z2VhSXSPuJSDCjwL2ALEm3eiMtVoJHXgw+D//4TLzp/fSOm77UZpkUN2IWdG/qlbt7xrpVG+r+ZyswwoasI6d5/iY7AeGq+DEkn4gLLJXWyIEv+yyiQZjWPw5bEzGoJxLg+kbqsYQJLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YcISjwvO; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x89DqMLsnBNYRk0lxnHKXt48yEh+m9UWLjc0+56gCq4=; b=YcISjwvOnernJmKD4HEMkPBhej
	U3QrrKSNnMV4u7sszt2ZFd82BbrIsHKc+c8xtKrdPBLaElJzAC0/tUQS+xuqMhqQGNky2wD+w6dwD
	Gj/yllS0MREADT5G6mtaYEalxgtZw2yUvsN6YbxJ+DzIOyQXaAutNe49SCQ6Lw5zNrN0q+kHc2wIK
	0KhGhiYsWHEyTCcx20gHu+6aFgFJzi6uHT8mx5Nv8GokeO3Sxtsooe3BDCfE8H7coCwBsEFPVfnwN
	FugTfBETEtl7Rk75mrCSkGGXx/6tl/frtibc1hE5gp3sXlzoTNM4HltKhjXa2cTSMZmitNWAAR0qn
	4ECSpm0g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tXXBm-008x7z-1l;
	Tue, 14 Jan 2025 11:15:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Jan 2025 11:15:19 +0800
Date: Tue, 14 Jan 2025 11:15:19 +0800
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Message-ID: <Z4XWx5X0doetOJni@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jan 10, 2025 at 06:22:40PM +0000, Michael Kelley wrote:
>
> This patch passes my tests. I'm doing a narrow test to verify that
> the boot failure when opening the Mellanox NIC is no longer occurring.
> I also unloaded/reloaded the mlx5 driver a couple of times. For good
> measure, I then did a full Linux kernel build, and all is good. My testing
> does not broadly verify correct operation of rhashtable except as it
> gets exercised implicitly by these basic tests.

Thanks for testing! The patch needs one more change though as
moving the atomic_inc outside of the lock was a bad idea on my
part.  This could cause atomic_inc/atomic_dec to be reordered
thus resulting in an underflow.

Thanks,

---8<---
The test on whether rhashtable_insert_one did an insertion relies
on the value returned by rhashtable_lookup_one.  Unfortunately that
value is overwritten after rhashtable_insert_one returns.  Fix this
by moving the test before data gets overwritten.

Simplify the test as only data == NULL matters.

Finally move atomic_inc back within the lock as otherwise it may
be reordered with the atomic_dec on the removal side, potentially
leading to an underflow.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index bf956b85455a..0e9a1d4cf89b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -611,21 +611,23 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
+			bool inserted;
+
 			flags = rht_lock(tbl, bkt);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
 							hash, obj, data);
+			inserted = data && !new_tbl;
+			if (inserted)
+				atomic_inc(&ht->nelems);
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
 			rht_unlock(tbl, bkt, flags);
 
-			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
-				atomic_inc(&ht->nelems);
-				if (rht_grow_above_75(ht, tbl))
-					schedule_work(&ht->run_work);
-			}
+			if (inserted && rht_grow_above_75(ht, tbl))
+				schedule_work(&ht->run_work);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

