Return-Path: <linux-hyperv+bounces-113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327157A5A94
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321641C20BD7
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF24695;
	Tue, 19 Sep 2023 07:13:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8E23BC
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 07:13:01 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77F100;
	Tue, 19 Sep 2023 00:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695107558; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K0c/lNwc43QqEhZKJwRz0BrqpjojcgSUAFw1CyeQhsuE8JQ19W38hGgHI+RRkyRnxg
    7wUBhyx1l0m7syMlG3Io7akUS1YYYWLAR0xhmf80LQTJ7CRD6qWfZwJu0PCmKTG0iVYn
    cTQtjm9vRSBxBbuo+APkf2dSZb1Dgc4koEnfztSJNVbbpW4VNqtBiDUaJFzMR10RmgIJ
    GXsznZk61JBD/hhPnDYB7vGKnpJNYgpoC8RaEMINWOR6QVqOx/t1907+IUkD4lh1SunL
    IlfX3J0m4K56DYDutnoyQolSCQDeuxVuetOZi45CPfAcLAH1VZBusDvL0J97gDRukOOw
    ew/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695107558;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a/DrHazCbj9Q5p9zsv4+bBm6slb+Z/9JBTM/XT0CJVk=;
    b=NcPVI0hVGE3onG0Uqn0X9RmqJ787VrU8onKhmuiMkrnAgfzspW3RAUtIEQCiZoK6Jo
    9VuULLlikb4wvaockLdx75MEOgXPl2gbyxyGbYWE07wXuJlMfc32nfNwPLyBWosXxvaV
    Aq3hgnoggN0V0wt7HfXwty+q9Av9AAYAmKFAeMXU5DupFCxw3obLvI5AkKCcWiHJOuql
    M8ux6uly1QXhaoU22ISPNrTX5NGmT2mECoTpmuIMUODPT80fSYQDAoSsRekOAncQAH5G
    mwW6D8nreSqVwtt6/RYuYpk/tpfl3BRLmrDneaocXuR3zZz3OZOJE8nmO2dL/gAANxQi
    7a3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695107558;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a/DrHazCbj9Q5p9zsv4+bBm6slb+Z/9JBTM/XT0CJVk=;
    b=Ae8RQWVFdstV+miBrEspij+YnFvYaDi+0zP5K5Vtveo4lC3OKYrFHOzIKCSY32MA2X
    NU1I83HUCDQhXkwXtboTGXy/WwU0e03FpveJ3eCb/mSNQVY9pi9nsommT4BhWLOlOC0C
    8/3nvx98dBavZm8vGGPIsZKFeaJM4wznjouVIrLOQcgR14GhHDBgjUiv3791yVlIaljE
    tqEpynMU3EettweBdmr602iV4JlMYodxIkPtAGyK+j8NChv3QYdsQv7MpfeAjJq0+ZQR
    PgBdgAk6n8aUwqAWjrda6hlsZNTMMaaj/7wEAwccLb3ojlcN2xXkMrhAOufcJYMMNCpd
    opsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695107558;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a/DrHazCbj9Q5p9zsv4+bBm6slb+Z/9JBTM/XT0CJVk=;
    b=9T+0BUJLjpfdJ+5BKhMXUudVKGraafrNrqkB1SJ98V766ZWdb3g4dWscKS/MXiKmSo
    WY76fJx4tI6HuPrKuYCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4UBKIaBnsoyDI13OnZfZG1B1f38QQZMl4Xud1qQ=="
Received: from sender
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id C041b2z8J7Cc0Aa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 19 Sep 2023 09:12:38 +0200 (CEST)
Date: Tue, 19 Sep 2023 09:12:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] hyperv: reduce size of ms_hyperv_info
Message-ID: <20230919091230.160f1ca1.olaf@aepfle.de>
In-Reply-To: <SA1PR21MB133593AABC414CB427B84FABBFFAA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230918160141.23465-1-olaf@aepfle.de>
	<SA1PR21MB133593AABC414CB427B84FABBFFAA@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 20230817T113819.a897c59c hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t+efZ5sQKEsZEPRz4bLArlZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/t+efZ5sQKEsZEPRz4bLArlZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 19 Sep 2023 06:18:53 +0000 Dexuan Cui <decui@microsoft.com>:

> How about moving the 'vtl' field to an even earlier place:

I have not tried it, but I think this would just move the hole up.
The end result will likely be the same, pahole -E vmlinux will show it.


Olaf

--Sig_/t+efZ5sQKEsZEPRz4bLArlZ
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmUJSd4ACgkQ86SN7mm1
DoBDdw/+KPJXuPQ3wtJG5EkNT9WedJb6RyI5U79vDD5wQ8bLpsTe/eIpCcSk2JWK
Yp2TMqAJAHhPVjKM2wluyLLQIjPm7CZBJySC2ApzVTsOt1zdUhtbw5G7tMcRrAK3
x/TxT9Sy6gPoVoOxREF2iXcI9IH/QsZmbdxuOFl7eKBzTqSZ93fsRaZiXve73qz4
IH23phz8bE4tS89ODNJEWf5wBLWmEZrKOrv74MmUiGPyk3Dw+0VRLBohUeQiKM/A
d0OEyUjlU+pfj632q+/fr2kmevRaBIiuddzHXX1QkMD1IHvWB9Nyq7swTqyIU8b8
/RpTandtsjIplVfabCHOjF4ZrCmPwVhtNd3rkthwDGAtVyWA13W9tlRgVLy7Xeib
8UPNn86IIUrH8hSM7VvdfHG0xcVG7CTcSTWr9LICoguiAhHcp8g9PLDo/WwrUZ0f
FHCbHWEjZJX3CHhp4Y9v7zmb6qcv4/wQDy6NL4qWLgjou4bt1xwU1wE7uAKWyGUF
9CTCuIgKNfIQnUxYOyGohtlk/ih2Spu56aWmiyfEHN6/NkrjJDhWkiiJoAr64CW5
iafQrs0uIQGNyeBcc2peLeVI9cIx8YNNEdgPnQ8IU6MJ8qbFVvHpsVyygFgsYxub
MdNa9wmA/11Bkq+JvRNlfkVFSFM2LmM7Er0ABb1tEUvAmMEVyJM=
=AMRP
-----END PGP SIGNATURE-----

--Sig_/t+efZ5sQKEsZEPRz4bLArlZ--

