Return-Path: <linux-hyperv+bounces-981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB17F01BF
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6CE1F22448
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47436199DB;
	Sat, 18 Nov 2023 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UiwQtlTB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2067.outbound.protection.outlook.com [40.92.45.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE4D5;
	Sat, 18 Nov 2023 09:59:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX68roO08olGFWctPKgemyiL6kisgOKoJk2XYE1VAoSG/r48iPkt1C+DgWC/gOcUIGgIddlTnfOhaY4JUV0xJOkg9FG4CSCNnQ6nSnU7TOGMXaTkeXgFih7KzxYAolUtJubw7QoNmhnTioKM1scsE8mpC++M04UmFuvp739khlhjX8JNkHcgyBBb+O7P6Qwn1Xm9N/tNBVzwY5dEgH1YK0eczZrYq0ZWSu8Yx496W3XBwe3hHxU/g5iRd0u3db722goiZAJVrN3PWHEod/aau3WnaImfv6Jqw/JCr8hsT5YRzBV3zOxUZqowiQRGdyokF8Fa8LEO43eGsv/aCldTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ml6pIksZ2sNghy4zG/b29NchMSAFisaopUHKCu7F9A=;
 b=kZmTP4kV3ajV59txLSRe7qVfrOrr0rJGTCJsPKmLj4oVksAulKlf+ftFuuxZq+Ngf2Nb/2bglKkhQj4U/cLIq3zFY+8WFX8gjSFtGNy4SlN1eaCk4twooRIN1nTh+rfhxjoxDDQsNlBSOdiCom/OCU2chlxddxb0hOC67VaXuSSTvndrzNpzHlTHH3FBdLfwYAzVwmG2grQfVKx1h6F5cox5osrHo9TgVrlXAHVTqGmePYA4WXSOgnYNHDtBzSQgliBOf4I11Q3OTB7y0wTaXzvut937xi9201DDMB+GscxAgTtkTWj7gRfqPaYqvQNkoAbmxPjT3V3MDKkacvypKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ml6pIksZ2sNghy4zG/b29NchMSAFisaopUHKCu7F9A=;
 b=UiwQtlTB5lLZ/MxzFhUV2OiH/RhbF+9jDvT1o0r+5pNo9dRHwrFxTUH/X4NTabURORFXXDCszvmL9Y7j3avpgBwv30NAYzS3qJ6pL+Qykbpd2Gm1f+XB+MazvP1BSgFaaSuSQrIekvwCS50SMgooaD5eRlNAIyleI2etgI2sMgXFFzRy89OrbeRacXZSbGWDs1R88iYfVSxan32UUUNryjw/6HF2VbvhH4RLqxbTrdQ+lqTo3mp2P7jhJFDKvdrZm1TLnydPPPU68ZUT9+F+u2YB3VIF98+k2CLsmbucCeRqwnWKnVXW3GN15LbJ2ujRdhSeObY40XQpcxqaV6F0tw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9991.namprd02.prod.outlook.com (2603:10b6:510:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 17:59:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 17:59:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yury Norov <yury.norov@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Maxim Kuvyrkov
	<maxim.kuvyrkov@linaro.org>, Alexey Klimov <klimov.linux@gmail.com>
Subject: RE: [PATCH 14/34] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Thread-Topic: [PATCH 14/34] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Thread-Index: AQHaGjdbPNpOYvT26E6hoSGCJEBljLCAXSDw
Date: Sat, 18 Nov 2023 17:59:13 +0000
Message-ID:
 <SN6PR02MB4157D60D59F2461BB595F569D4B6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-15-yury.norov@gmail.com>
In-Reply-To: <20231118155105.25678-15-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [cyUizUd5K8hRXmXWaoO1XhzEA97Dn9k+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9991:EE_
x-ms-office365-filtering-correlation-id: b98a79cf-8c45-44a7-458c-08dbe860130a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7EosM/SG3hQCUzVu54fm0ck8gK6femYgEwh1J97OBI6OZM7IClP9XXR+nZcAR/wtQF9cI+ZqsROSaH2FGUIXcKw0ej2wJpYH2BuwdcMgLdr0NODje9c6NpZQGL7/awqatttd989iGm3dr1npLYogNmpMygggP1AvJiQY+Y3rammSmurlqQWoutRa0EYpZYFJuwmgO0famuhSmnRrfHr/4yI6bd3XrZt81u//PRYL4kZOFrJBbp4uugFVQQGTjryo1/vdVPcG9bSooLptvd7C2jMsw5ys/WmE4ayOEwQ2CJypVE97NW36DbnnTvfraJcAtxprWJuEcIkq4jK62nKBh5lXtFYePshOYAJW4fm2dq9lR9mF0n1E9eqQEuS9qSgdQ8KC93p2D8a6dIDv5YGVh12BQRObRY5D5wKdDldQOM28lsAPUfaqSqWPeLYCkvV4fHwYuQ0YZKa1XANfulVhYKiTlvp+1Ng9yJL8nYrRYjUABsMN7EZnWgTaTTOf+gPlfdXyhodwpZuUfPBJdaMvh8gkyTR7ApcLJIOEApwtJh1dFp2tHWUdhpzztBFk2aA+
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?QJGiquUd9/1XauZ2PQTzpTmcQxQVdiDMr2f0+nsjx4zNVbN6TaLmF0XFLI?=
 =?iso-8859-2?Q?MF+rsXAHT3DxxnlqeDfqF3gUzrLKlHxEAJUDKY0c0Ueq2uxcskIfat+dlU?=
 =?iso-8859-2?Q?7YFkjJ9nk8HKE2TmqrUFbSJiaJmokUewe2wf86DO1yq+3UnSE7WcRTU834?=
 =?iso-8859-2?Q?RbIPG276V4EYcRJnI5zdOFgybF6b8XBGC75+G3dWdZZ3FG9m5Vn/yCaKMf?=
 =?iso-8859-2?Q?DfaD/b9CRgi9ZK+8js0hTlTKH3Q5/FsjO7qFhpROUcBKKmYI1FyqXjBut2?=
 =?iso-8859-2?Q?2VKWgKEgmTcucFsIy9CG8J4SsyJVbq5MwYKONXubXZ6V/zHYtD5S5v7dXE?=
 =?iso-8859-2?Q?lEFxU9sG/8NepXBVSWpasWzTsqgbnkPdlkC0gMtkOD0QVqt6nx06jziITF?=
 =?iso-8859-2?Q?7Q7B84uUcL7ABwRjAGavADGfxwFJUo5dPJ22c8fbyO9M28TmUEM9sCiLvq?=
 =?iso-8859-2?Q?aMjrV1fbkVG66og5p7bSRGbFQw1fPM2F3r5BeXk28ffdGfJv7Caf9qOpQX?=
 =?iso-8859-2?Q?HzSONp0wRrQB9TtvRT/AB8HCUy0prEdzA2o576Sj7KnaIR4Z58Fiq4KN3c?=
 =?iso-8859-2?Q?L5C0F1V29UsBrJwI522TPdcmEMVnUicWp8g+B0cn0NlLDO12gMKKJmXD4V?=
 =?iso-8859-2?Q?u3fieIrWpZCvY7qPqhSaYMqDYoWYWYutae2lKWGm3FoeoQ3KvyiP3RqL6W?=
 =?iso-8859-2?Q?6xsIzi7FIjskkLjZVvi8OREhj28ZcX8JafVSkYtiMzyBoedOQ5DjCN+foB?=
 =?iso-8859-2?Q?suM9D0/2BRAqJBNFHWNhHRU0EmK3mas3NG2WVV6TMS0khgrIc1FPFzUmUr?=
 =?iso-8859-2?Q?00Yzx7cJXTBqSvzBizwTKM74xWRGcas1pFh0ncrc5kF3OoRVixwhsb20nL?=
 =?iso-8859-2?Q?7NHavGmFNjrddcPJ85oKau3j8PPpWsAJOmgu89dHq+VWIMnaXqbk66Nsw/?=
 =?iso-8859-2?Q?1kvdJhv7kc855/JayCNGZ5Z/49cLrV3JxQ+goY3ZUZJM7JLWtASZYEgcsU?=
 =?iso-8859-2?Q?c7jbZ+9E5nwKfCfa5x3L0heJn8X5Xnp7vDU/0RjR7M/pvspyW+oOQQTX9t?=
 =?iso-8859-2?Q?0TyfksyAy1PL5jkW/K7U9X9JbUzYRfvubWAfu4XF93zCMkOs+d6Mik8FT3?=
 =?iso-8859-2?Q?+ytlRrkSuLAA5neIS+S+Ecj2X2D2LV1AjNTvyaIC+sp2TBAj4Lh0J5qOTM?=
 =?iso-8859-2?Q?FfhC1ViTkAoLebLcXYfRlH7fynwC4aXnTtC0o4E9oxdC7U/3Sou1nf2nIf?=
 =?iso-8859-2?Q?A6kepRaMBh66XY0IUhFg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b98a79cf-8c45-44a7-458c-08dbe860130a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 17:59:13.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9991

From: Yury Norov <yury.norov@gmail.com> Sent: Saturday, November 18, 2023 7=
:51 AM
>=20
> The function traverses bitmap with for_each_clear_bit() just to allocate
> a bit atomically. We can do it better with a dedicated find_and_set_bit()=
.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index 30c7dfeccb16..033b1fb7f4eb 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3605,12 +3605,9 @@ static u16 hv_get_dom_num(u16 dom)
>  	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
>  		return dom;
>=20
> -	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> -		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
> -			return i;
> -	}
> +	i =3D find_and_set_bit(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
>=20
> -	return HVPCI_DOM_INVALID;
> +	return i < HVPCI_DOM_MAP_SIZE ? i : HVPCI_DOM_INVALID;
>  }
>=20
>  /**
> --
> 2.39.2

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

