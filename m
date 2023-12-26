Return-Path: <linux-hyperv+bounces-1366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837581E922
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Dec 2023 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DFF2817ED
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Dec 2023 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC743643;
	Tue, 26 Dec 2023 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w6g8HZHE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98141845;
	Tue, 26 Dec 2023 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703617762; x=1704222562; i=markus.elfring@web.de;
	bh=e+tBrgtJfsdqXLShYcAxcZWtl8ArgkpUQb9HNhch+6M=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=w6g8HZHEkpbryK5BLDOeQWt+/lpBqoGxbDnbb6dN2GVLEfRNnSHi9bdFdPHFbkCa
	 QhWK+kIgXhjLVN6WqKbTGFrLpPIRDp9BybrEMyeb0i6/3kZsyKlNwHG/j/slAIhPQ
	 oOEJml/hef9AR9qqJv0XjqjwoPu9WUqQvIKObyp8VlnXT/LZL/TjwVkUyvgAtVer5
	 1yIUpVS/PO54spPLEyzKhqLauqEHGrCy4sjZSSwOx2tfgKDmL3Pr5Vx95ZbnzZ+rv
	 UnSzlSkjQt1fszmBObyacSzmqC0KiYFyHE3yN1Nui7flNR4QA1MVr5c37DwACObqn
	 1lGohnSUrYvql7oRlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8Wg-1reI1y1bJg-00MCdT; Tue, 26
 Dec 2023 20:09:22 +0100
Message-ID: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
Date: Tue, 26 Dec 2023 20:09:19 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wPOvhj5sZIFHtakgOhvLyjOxfuTw717tJTZVuzvrrqw47k7mvWx
 CyzpwGDn4gaBT1CJjpK9GVIIMWi/S+S+fIkUTwBRp1cLMH3aCcOGz/YfYnvNQb+99MMh8oI
 tB8wP2yHdAK21v+JUtEchHHOWMoILWeamZmQXeqoP4qlu2NabSKEM484Z3soOjX+jFhTJ4C
 aeh2fY1OkfpLpgsLxcGMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+GuqX/7+844=;mKtO/t28dF5Noz7+PWV5uyi6UzL
 7/31I3cEvXRYkQWA+hVKFQmOeWLyICCOmKCGX5QtKx+VQzGz5J+xCACsIPokktvmKoVBaUNOl
 xNZkdW643wiWYJnR4le5+YS25/scz34z2OIsXOdVCh2qons627KD1GqYZ3UcvHSZWavrvPYOc
 GrsvfGdSMZaoolsz3DLBivmTL5uaL2KCwkEbR+qHp7CTuvrP1Tdfr+I59JELsF7xpusF++GQ7
 IIEuf0UQDPAGvxV48JJ6ZOvpuBOTe2Lk7sbu8Y6BeD7XNxyU9pFSpLdqEoxfSmeYKakeKgBIJ
 mLkEkLA/hHZOtmywAxIOyCmJ6sMSNjh1DuLqQl14FHXGTs3ShtVGMk+eIaXOXgjhbGFS2bYfE
 wDaQKwDlzYRvw5b6b5oz1tIMVV6eYS/R3Zxjjng3IB/05hx0w8n8Y38G56pzoMi3Ol1ccfCVj
 7aV89aa0n6Wgq1vb2YT4QGcnFQQEY579fhcceHzZF+xl+vRGVYMWtqOUnJydIope45l1hcTjx
 Y6PKyXeU5EcnjGjqpvhSi5dr5l27OA7BYIN4/Lh0uJ6sTd5S+n923nrCs2vnVKmsoGSzMCEXb
 5ShpvJ9SNR8aYqW6E+hyPLSCD6qxZAtgbxrjR2umD4489dOR3+hsr57JNZMIqhqzNZ8/FdDiz
 Nludh6j1qcdUdb/4EnZAt36PhVW46UAD+5SkcfvbDYGl1CJIUkW/U7GDQd9qs5485X7xqbTm3
 DAdMQaJIES6dm3aBZtoKAtKF7LaKKj8n72SiZYMGgyhZtpZLAS0UsAO5DEslJ7mkpPy8ot9n4
 APzpn7lW5qWto/xov4OzKsFlsKOGypiVfz6kco8PRYqkkKsU/OjiQZ4HvOpGkOY2frbVDvkjw
 o7Pk8FS2Wocgqn8Im/UH49p0ICEv9pS6MxMBvLzErm/elfZjIzVD7ItR0pQzksE3Dio8aWDJ9
 x2Lvmw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 20:00:24 +0100

The kfree() function was called in two cases by
the create_gpadl_header() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hv/channel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..4d1bbda895d8 100644
=2D-- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -336,7 +336,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
 		msgheader =3D  kzalloc(msgsize, GFP_KERNEL);
 		if (!msgheader)
-			goto nomem;
+			goto free_body;

 		INIT_LIST_HEAD(&msgheader->submsglist);
 		msgheader->msgsize =3D msgsize;
@@ -417,7 +417,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
 		msgheader =3D kzalloc(msgsize, GFP_KERNEL);
 		if (msgheader =3D=3D NULL)
-			goto nomem;
+			goto free_body;

 		INIT_LIST_HEAD(&msgheader->submsglist);
 		msgheader->msgsize =3D msgsize;
@@ -439,6 +439,7 @@ static int create_gpadl_header(enum hv_gpadl_type type=
, void *kbuffer,
 	return 0;
 nomem:
 	kfree(msgheader);
+free_body:
 	kfree(msgbody);
 	return -ENOMEM;
 }
=2D-
2.43.0


