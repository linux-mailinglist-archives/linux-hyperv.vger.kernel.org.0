Return-Path: <linux-hyperv+bounces-10474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJSLFUUE8mlYmgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10474-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 15:14:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC3494971
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 15:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620A2302D978
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E339768C;
	Wed, 29 Apr 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="q57JHCIJ";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="xhklDlmI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5E3A3E92;
	Wed, 29 Apr 2026 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468141; cv=pass; b=Y4WFAyEy/pA6sFfTZ27+YLUo+PlrD9TSZEmTyuWwdpUhYJrW0fEUj6l1YmYUmmvzA6HYPthyphC7LWy1Mkxxz2V9PblPbGzEtZMzh1MRWSBpwAkE3Y+FAcNWkN6d6SCc++wvvmAylYBpv3GxL1ryQXEtm2Syt3Alm5VbywPNqLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468141; c=relaxed/simple;
	bh=oynhWslJQeskAz/4hLcF/NYlovWN0Zk5YhscGyl8R6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGaf7gJftihWbbin5isxdIHj+QwPop9wJYcpS2c7osFCKv86b65FGQcZdO1oKm1hJu/xwHOag+rSwFXqMjPljeNKQwuug4J3ZNEo6umLCjK7TGQMnUMzwLGRhO3k5lBwSo/dtuTQscxerDjXOV6REEb6E5Qjp0ojoGj5t8N4AZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=q57JHCIJ; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=xhklDlmI; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1777466691; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hne6QhOdpoAPcYzgN/fQlYo6S3CEA8Qj+2rOAUurA3XQzWwGeAzay45DGej1LEc3N2
    sJMgoFBBOTcmr9YGKyuOw5AY0nv83tuh5i6sVIFCd9ED7lSS5P+dQi37BNlOXee0740w
    VPU5p3/GitDN1zUAtdLfRxUvfXNYJ9fE3Jd5vUTyg5H04PTOn5EL4gR32Sji6Pfx4Cw9
    1g+v97wb53ijRdN8iXSghHAjoSwHh6ZlxYlOohOlLNyRfiWCqhFiconzEjEU8iBRogMz
    xr7pdgpIqURlee1m1pDFmXEVuNpu7gaObiB1vx59dGbVs1Oiw2mClZjnRFHM+M8NHewo
    MivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777466691;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oynhWslJQeskAz/4hLcF/NYlovWN0Zk5YhscGyl8R6k=;
    b=bsidY5elD8ed5GRaxOmmCTGArtdC3QoVCgR1jUoUQaNrkIeUDfEYI5TJqoBDe2R7ZN
    pBTWOCM5siboLGuXlZSFUPjxOYqlRDZdiTwUj+/ZblzSlFWLM8VyF+yFiftxxxejMFoY
    Gq2+XgTeutLLDnFjno0MePIJdAh5CvtOnauBdtbbwU/7nbgb2lwuX+Bg8OwvZmyfIWVR
    mBtR2+xuoa0JdHcaF0j8Ih17TpqLlKU37LkjyrSy2wjVW3b1QQAqOLTMAjp+83d6wFvC
    BxUOP5JzTk8p5SCvC4s5ncfTdf2p98GItqepow8vXavl0FKLP7ePSZhFZSfb3hItG6b5
    7gvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777466691;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oynhWslJQeskAz/4hLcF/NYlovWN0Zk5YhscGyl8R6k=;
    b=q57JHCIJtEUgTHLBEzxckLju35TyJeHqUmC2HVP3JM3bYwLBzG56KbWPu9oIwWu3K2
    xhqsLEWY5bBJziRddVIfS8gsWCx81tCTc3w2fTXG2s6ZDgmjSfm76usvzg22L1AGcLDn
    CzgSTO5U2rpU7rSkwKWO+/nTNMhvHw+mRZqaEIyVzXGzByp6TvQWoavpCKJ9yVwjs+WO
    MJYrH3LHAFbHPeXS8SqknWC1PRdMYoRTrZiPDclLUrr3BU+St16ODEaw3vD0Uet8srFx
    5lqCRwc7MBi2fcA/Ta4h5XCxrEMT77pY1f3jfmlbndY1SXC7MW8ZLOSzGDOxyBDyjkOO
    65DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777466691;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oynhWslJQeskAz/4hLcF/NYlovWN0Zk5YhscGyl8R6k=;
    b=xhklDlmIPSOtYl7issP2sluCaq+cC3queaudIoW8Ygmo87Og19mNmGutfFfK78MGVS
    OnqHXAMClSotf6MsckAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fm0SoJ7/xK6yGaFsaWnaJwse7ii63+wjqP+qP1K"
Received: from sender
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id D7618223TCip1qa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 29 Apr 2026 14:44:51 +0200 (CEST)
Date: Wed, 29 Apr 2026 14:44:44 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Greg Kroah-Hartman
 <gregkh@suse.de>, stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: utils: handle and propagate errors in kvp_register
Message-ID: <20260429144444.18f6a79e.olaf@aepfle.de>
In-Reply-To: <afH7VELGgh8eGBUC@linux.dev>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
	<20260429142724.4d74641a.olaf@aepfle.de>
	<afH7VELGgh8eGBUC@linux.dev>
X-Mailer: Claws Mail (olh) 20240610T104514.591ffb65 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.IcAwIF2/DQXmegMO+WbAFP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CFEC3494971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[aepfle.de,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[aepfle.de:s=strato-dkim-0002,aepfle.de:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10474-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[aepfle.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olaf@aepfle.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aepfle.de:dkim,aepfle.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

--Sig_/.IcAwIF2/DQXmegMO+WbAFP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 29 Apr 2026 14:36:36 +0200 Thorsten Blum <thorsten.blum@linux.dev>:

> What makes you think this is just "cosmetics"?

It does fix an unlikely bug indeed, but it does not need to trigger the who=
le paperwork attached to a Fixes tag.


Olaf

--Sig_/.IcAwIF2/DQXmegMO+WbAFP
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmnx/TwACgkQ86SN7mm1
DoCmzg/+NKHVnuQD4opus2wyFCsoaP+85l3NcdlcMuXp6AFUVBuZV9MF89JeOkqp
oInjZdLcu8yxWL3tJHMi7mTb+GC+y6oj6rQxNCM1DWEJJ9mpDFqPpx1cjqnJJDmm
jSbF5OID5wZ7LLupupb+jinPfj4k9nxnhpJrjsM8z9V7eolHM90qOnPY5lBJc8Bw
JBXnWu1ZPdaAg7PhtbwmDrrxfUUdZxaIEkBY+qxkfciJJwlvXmHnFyJPrDtlGteQ
i8szVvmYA87Npb7mvTkszyAPByjQGLf4wZjtp5f87SldjCuxTnIedsxR7JjRleIv
zWP6u3zxbfNTgi3CCdxhWRwa8BiSWwqHoXWd8OBBkeaH7bA6Dz86b6iKF9s1sldm
y5d6BJUKOLsM2UkBLVDLy/rLp+QYFaQpdHLmHJejSML9bZ8Lpf3bY8n/Vr2lnbzc
8aNGsu+9JaLfbgC+M8ATaaQya0RxVPW9n1OD8H0tSWCwPUrUAuvDoPB9OTsNyhbB
Y9rJhTjLBpgq9RXHU2PIY7exUBX3Bm/lBrTIu90PHaErJ6VqTQru9YPCtkj7dDsS
OnUKku4oGa2eYl55O5tyY/Eto9E9zMIN8pxnbUprGHzJmKqFRXKfqjMz63QWBV+/
f46IBjY7vezywOlcKGobr6WRWAcPsrFtxu44gN2Evu6NZQrcM2c=
=7ScG
-----END PGP SIGNATURE-----

--Sig_/.IcAwIF2/DQXmegMO+WbAFP--

