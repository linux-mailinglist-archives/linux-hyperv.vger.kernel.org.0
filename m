Return-Path: <linux-hyperv+bounces-10472-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEZfKgD68WmElwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10472-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 14:30:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE484941A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61F223006B58
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B53EB7FB;
	Wed, 29 Apr 2026 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="hRKI9ibj";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="CZAbca8/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F299A87;
	Wed, 29 Apr 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465849; cv=pass; b=aynJvptGtz/8duVa0qgtr3iz51FUCXauvs6E9WoNgGvG33PrWQPoE4oKI+xpgz4goqAx/WexRFQzxD+aag//cncaBpJ6BLFnGEXXlUmJC908HQGKegX0FMNjZH6IBfo8mObTjJWQYaXqiWpqpmYQ2GqRyu6RFvexQutx3zzhy58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465849; c=relaxed/simple;
	bh=EJXR65qhDAKudP2+vZ3Pwhpj0KDsnzSTV2XCWNJ8kzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjvuXgnOMKFP1K0sX9n5bB6+OpVOfU9WwJHp9hQ18Llwp9lScyl2ar690nJCTyDI9KoqERJupmC9OeR0b1+wdMzhNOfe2JzJxkow0fK6nRIk4owvIYZKWYilRzdRQI11epKlR9ZxBB+MGQjaJmdz6ces069OWBUiTtYGglbZ9B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=hRKI9ibj; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=CZAbca8/; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1777465659; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=otcAGfCFsIXy9xVvQreHJr3WeYLGXKF42cCDDVx+6PJFjcE+YeE80+QY0Od84b1Gib
    oWCclDWB7bAq3AhUGFyrTkaUgdC9h+EzCIRCWr2Lgb0TkRRH0XSLMBMK7twckyL1arZj
    QuAre+nis34xjaetU0k9xCvKU/AqVIdWE4c5QEcpz2LbjheTjE1le+mK0hdhE+2rjTtm
    Di5eGuX0g6XRph8DXEBMDjx7M+KNjWuJ8kAO1+W6b1A9DkjPc+IdhCsHmizQvc9TXO8q
    5CaY9lDo7yf0MjQWIBgMhUYwHq+rGJ9+e/KvzJKzA4l0tsfKc3buLlP0ruhvDqrOv7MN
    2lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777465659;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EJXR65qhDAKudP2+vZ3Pwhpj0KDsnzSTV2XCWNJ8kzI=;
    b=I0b9GZgtYmrm95nrGhzHTcJ19n5TO67z/LRvseQoRMOu78wQYSH1uQeS3ObV+2ZSE6
    VPk4apEOH4PmtxLww3isY1PwBpV8H9yUzwUp9ZR4zO97e05dF50AEGRaGxx6ZkxlDaIz
    4gokdNg+eLqwXFqeNQtzCA46Kifh0pDjurSjmbH3Lu5xqXuqfqM3c1bl1XuuQ3npQpEB
    TGq2vuERbJEkM1N+WyXjVhyWfvq+/TUetBrgR6Emdd21S/la0At1xxRsNqwOVvny+jM6
    vvCqejT9shCP0ohICFMDIhO/taFEvEmzGwIm2OvqVMG8u40EJ0T+JdORYmst+eQqC5UF
    M2rw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777465659;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EJXR65qhDAKudP2+vZ3Pwhpj0KDsnzSTV2XCWNJ8kzI=;
    b=hRKI9ibjBCjMe74LzcDlXJ13vlNH5pTVjdpeSpp9XZZHqzUgzCoDQr0RIo3PZLH1Ee
    gOEtXxfyT1WTwJsqt3Dfi44NYlYLC+DL9f2DtUAKyyyiPhr5PFyR1WWRjfToHF0ID2r8
    SGp781A7Cl8GyomK869cV5BeZw8dnkmBhKF8wzZUiWmwovy3Y9ZinvEVDggYV5C+Drtb
    Di5X3UvToXOQQUUAfpsknq9ui9XWWaetTee2wjMH6ywjGrTaSh1hIulOnD9MkpRg6E1v
    VLzDW0h9N2DXbBCD1c624ekmTofuENsnz0MYE530i0WOMO6zOtTC219KbcJm/Gjacevh
    sP3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777465659;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EJXR65qhDAKudP2+vZ3Pwhpj0KDsnzSTV2XCWNJ8kzI=;
    b=CZAbca8/inEMT2kGe1DeS7LrIxTDz4d5NW0OYDKtg6PV7K601ee/IHFGwjW5OIgOfN
    F8jafsk7DmALJRvT5UCw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fm0SoJ7/xK6yGaFsaWnaJwse7ii63+wjqP+qP1K"
Received: from sender
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id D7618223TCRc1m7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 29 Apr 2026 14:27:38 +0200 (CEST)
Date: Wed, 29 Apr 2026 14:27:24 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Greg Kroah-Hartman
 <gregkh@suse.de>, stable@vger.kernel.org, Ky Srinivasan
 <ksrinivasan@novell.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: utils: handle and propagate errors in kvp_register
Message-ID: <20260429142724.4d74641a.olaf@aepfle.de>
In-Reply-To: <20260414111008.307220-2-thorsten.blum@linux.dev>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail (olh) 20240610T104514.591ffb65 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9QPQHzLuDWUzzMAsondCt0X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DE484941A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[aepfle.de,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[aepfle.de:s=strato-dkim-0002,aepfle.de:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10472-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[aepfle.de:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olaf@aepfle.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,aepfle.de:dkim,aepfle.de:mid]

--Sig_/9QPQHzLuDWUzzMAsondCt0X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 14 Apr 2026 13:10:08 +0200 Thorsten Blum <thorsten.blum@linux.dev>:

> Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")

Please do not abuse the Fixes tag when it fact this change is "cosmetics".


Olaf

--Sig_/9QPQHzLuDWUzzMAsondCt0X
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmnx+SwACgkQ86SN7mm1
DoDOqw//QGH7JipvvKfUGAD0ya2ffmoGZ29i2a2jTl1YKx1dflByNsHdzJ8rSMZR
sDVp6r90A7Hp7T6wXqjr9LLfNktWlT2tWj3t4ElATm3B1LX0nqxpjeHepUm/qocP
RFdJOEQdkS8AtOUK15UoZz+V/N5FzhY2/tsdwxP1QNJ7fy3TwlHiOHlIXSCgZzY/
hiRJM+7lfOdZUBzTKYQsCzD0p5rf2jKQ71w+JuTohTKPrmwvXDOoDbZHP463ic8A
09f2cCS6ZuJyXm4RE+CXDUI4cZB76SBaYUEbBR2ozqAJNgq78VRHZsxC3jjt4yDd
VPQUIyFyBUtTe3+HMc/PGWuTxjd1GDQSdS/RwtwhICKhxPxD5mEWof4Z9MQmBIiu
DrhlhcCIDMrOI99qu5GfACy2wr5RuorIWYtopdSb7Jr/eb5GNxA7GzdUfSwdzyQv
KMX6gqcDOLPErjyYHQQbbYELhNX/WyHoCR2JJFoZ6GGh9QR+dSXJNPTMpvhaFQIX
G8c5meN/PEGciXUPpG3/fG+Bwn5YOibW2UFMkdC90HSMyJOmLkyxE0kSmIXtQGwk
EsQoc8mYBWP39fv+TtyCfE2WHYH10J3K2ToeaxSCJvMg2V0xLth2CMPaA65ovISB
Ijr/q7YQpgTdj78DfXJ0R2MS496kj1otKgXgdI5pRuGp6iUGxRg=
=cDGz
-----END PGP SIGNATURE-----

--Sig_/9QPQHzLuDWUzzMAsondCt0X--

