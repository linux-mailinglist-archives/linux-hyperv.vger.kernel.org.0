Return-Path: <linux-hyperv+bounces-10921-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP6sA4VmB2oF1wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10921-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:31:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9365563E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE0D1306FE78
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FCE3F9A1C;
	Fri, 15 May 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tu3bC963"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012077.outbound.protection.outlook.com [52.103.11.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EB3D6CB3;
	Fri, 15 May 2026 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868033; cv=fail; b=dZux11Ft+hMMMY87p/N+rQ5aIrdxt10MhMEWvI4X57rTLV29LjerAJRXjg9PBoFzM1IYNpeMDsC9O5qW8jtjmgAzytFNVpDQbm17j7WUmP7oHA8OVI66r6jZG2cwCjNh9Bect8l4cEWTpFxzu5i3VqFhJA1XgMnEJW7gxslVVwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868033; c=relaxed/simple;
	bh=ta7tGhP/FO59DOuHdR9O4Pf6C4Bn0nvOoO1IDRkn0iM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SqrKZLl8/+pAHDjLHkW8FOBW5M5xVFicic3Q/Sl0MoZcXyqhVaKL0RpMTykFPgPwjp2kTlg3AgC70vxmT7PovUE41c414N9IgIS2vHpaegGt5vv9nu0sxAI3qTri3nXsgweNCsOJa4Tlqueqi+c5CqX5TbY4A43YpAgbdfvyBDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tu3bC963; arc=fail smtp.client-ip=52.103.11.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GocC9IJOB1hxbD07IKLFXM+t7qaeIHB6GXXAfQU0nEh0UrMA9lXzAUVwSaJ6Z0tXs974ctG4LOK2/iLvpAJo2KGCRdVsYFUxCHzU2FogQ7uiV5ZQD9Si6PQ2S9/cPqWAzE/J6gs3OTz/+NfQ/11Ui7QsUbovSxgzN+Kfg2XZHoLPTEZvBwGmrS0+Kuy4LbGUFCkhNsOUO6EftTrwn0oWw2oaa73VigiOuFzMIgPBJtE39GAbvy1yGbk7PfHK7vKn1r8sY12Brje82/+R8mcgz6aHOqZezgRyqJPuaLEuXMLSTXAV2ntQh7E2pcixuRFGVAlBbTmMC0E+F6JtbaT6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cTlJbQsKhdefw1xgDia6NupIcbZr6L7WMKtvuMzbWY=;
 b=KKh2nemZ6a27N8PF7XbGCaY5ubsXrkz9OEMlmmxiFPmlttxmH84dPAfJiRDKVJAbznFnHnVgWfCUi0iz9tUvqGphaWMtrqogbIwujO7gnKOXp+HyimeRzIg0mlv5/K6TUXRC7PiuxOAJtl/MXy3E7HH+uyStCOnVHJ9MXaZbw1FdPbgblnn/mQYMaX/8t7pkvTSgmUtnRbU/92XdT0xslgdw6ZU8wb0k4BBFuvDydMYiHPhYIr/BL3HJdZr206xJ3coPi+efI+9uOJGoA+A2SEYOzixWR2KyVVb5doqYspaV43UBeN28sSbHGxHnrs4adnsRtCSsYWKruaKL5JiJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cTlJbQsKhdefw1xgDia6NupIcbZr6L7WMKtvuMzbWY=;
 b=tu3bC963lcOD6GKWvBdTzZjP5xsO4IIJCZnID0cw8wXEdI/xEeODn3MtT23nKHYmUdHVi0FFPZvbnZBwx/oymmk3bZn843RsWPgfgNN6Ngp8zTzl/TDaBkbYEk2nSw2284Lif+E15eGI/f99O0t5xYh5+ZlC403ig0hR6JiCxwBIyeLei7lO/whhGtUj9mAujIrAuU/DpMgXmCOHx7oEAAXy6gimFFAMyQWBnTH/RFafKytPSts9hjb4OGVkwBgr3qyhmxzKDIet5Xvyxph2AvgAqF3KiDUrRhnPy13u9F+4UTvbn7/0kO8dCh14c3R/31hW7Audzt25uC3P49dUZA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7617.namprd02.prod.outlook.com (2603:10b6:303:a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 18:00:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 18:00:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHc4WKquRiuLrUu+ESNYKKX1F+8PLYN2DNAgAFzewCAABr1EA==
Date: Fri, 15 May 2026 18:00:26 +0000
Message-ID:
 <SN6PR02MB4157F7758A127AA1E8096B6CD4042@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7wil6tzqp74gdvhyjvpv47zhfernncs42wnfoueznneluz5zrp@pzr63lhy7s5f>
In-Reply-To: <7wil6tzqp74gdvhyjvpv47zhfernncs42wnfoueznneluz5zrp@pzr63lhy7s5f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7617:EE_
x-ms-office365-filtering-correlation-id: 34edd241-99bd-4160-dee4-08deb2abd806
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|15080799012|8060799015|19110799012|55001999006|31061999003|37011999003|19101099003|51005399006|12121999013|13091999003|3412199025|440099028|12091999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fkyIbDiSANTiOnGAt6Jp4MFN2ZcUqynh9ArEpOKhZpUdiY7ajBn4/yLC1VJy?=
 =?us-ascii?Q?4qvKZUTJltG3oiK6poKRP9oMumupUvKBBpnq6Gx2FDUNf6FMRYtVE2pkaPFd?=
 =?us-ascii?Q?YWv+Js2Oxm+rbyh3PU3LPSUJ9kxotobFM7RX/SXq0OfYlEwxluFbsLxwGkJ7?=
 =?us-ascii?Q?AXxpudYuvtc4YivxNCN0THvPwfyq1+oc2i1l2qJhABc9+kDX7TtkV9WC+vhS?=
 =?us-ascii?Q?8PadYrjDpCo13UfjtKjIlocSTXKcHYlAllBVoMOZP4xKZxyWbE3ibGqYqimS?=
 =?us-ascii?Q?Or5XwF8x2cAQzoQh1tp1zWymvO4WPuwBx+r/sud79ZT93nfvWH6JWGZkge/a?=
 =?us-ascii?Q?s0pNa46wPNnS58gmSs6iGBLjnGGvhSA0nBMIONKJqU/OumYajREa1nus7asX?=
 =?us-ascii?Q?jdjxmZA+EIEWKTEDHbkjLfaprhIdT0tdpHWCxfwg+3eccWgW8t5E1LNc8G4F?=
 =?us-ascii?Q?V8aj4WsfAatgt6rc+Yi8gPS1s1h2Jzq+EkCb9mlfKqLa4pGmbd91AeWEFFl9?=
 =?us-ascii?Q?9AcDlpkpN5V+nRFbCnnhAmPQ6bb4kfSGX6QwqkXE/XGO45czBkBmAHvNcMqX?=
 =?us-ascii?Q?zEJ5UZS1THjbnXVNQw27aQRNn3kxC+5zZaMPeVIrwFF0asVG/Qfv8PmV0JSA?=
 =?us-ascii?Q?JKHs24TkVrdiEsUBQhrgmdrkH/X479UYMeOrbVhkWr1CQuNHcnC6fB2U7GiL?=
 =?us-ascii?Q?WHbvZBn/tQ6UYMR9WvShSB3uBWvHRhsJ4nsAp4+F54tCMQYgmju24Wb1BP8g?=
 =?us-ascii?Q?68V504REmBA/mdFsiAuEzdTgc98kUDVDuA6mv9P31W1ToHAGxMuX/Hcthj+y?=
 =?us-ascii?Q?j24nBq7ygxBDJUgUOkoxy3xwMDQiA8j5Vhg/LEVevf8rF7HOANogXJJyjD/q?=
 =?us-ascii?Q?OJCQ2d0mVPPhb4DkGX/Nz0dhRvPzwRgtQqx7gu0r/IGUta7LuTKgUYA4RPDz?=
 =?us-ascii?Q?hBgkiSEIKy+OPKolYzUzhguRzZGpJgzOXQ6/QpBHApeO92hahJ4AbLWDMBHy?=
 =?us-ascii?Q?0IoS8vcNQjSS/BqZL35V5BZkzYwytGOcVUqID2ZUC/ICQVVLSUSCx0wml1PY?=
 =?us-ascii?Q?7Lg8qYUh4hkz7oGS4I3b944SEBglllApQ6ARilkyZrO/MGFJoWROu8vqM7Tu?=
 =?us-ascii?Q?OFnJ1dv2C13K1CK9skwj5bI4uMiHklAGD7TehueSReh6ulqIKisTOdg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eIgifgb/Dm9k9tId/JPiEGxUUkVrslVJPNK3yZLXRJeMMUvU3Vh/Nwdh/V0R?=
 =?us-ascii?Q?HWPXYjApdgz3TDcTmCwO5HE+LU0DL9JBK5NeM4ToAS2MrSAE+N45ep1zftRg?=
 =?us-ascii?Q?0LMrOvlylQU6k1Xl1xUDtcHAfKBq/feEUL7yzGtSyyD7A0wifq3yAoYoXPBX?=
 =?us-ascii?Q?etwSs9GzlcLzgc7svkkBgmIRzu7hDrZiHVHeY7AqSiAer+ASr9LGGnnoGyHA?=
 =?us-ascii?Q?ck+GdDYsCtBcOm3PE/B4FkVw63i0wkVygigyndljlGlr5tmTm9hRbg285zO5?=
 =?us-ascii?Q?KwUpORsbpK0VuZ9Hq7nfHXlsOhtg8vAw6KEJBOzhcJ+zNGuMCO1IASpaCkxn?=
 =?us-ascii?Q?MxjsWMoJVXjzuJStDNEoUgMWzMmP09lXUqweTqWuW1ICyKl8m+A17EhFtmtM?=
 =?us-ascii?Q?LEGsPf+kbv5Pz/vTS8QWYZFGKmD1MxoaMfPpqxtCKnPXpXSquTwBDFWu8iOi?=
 =?us-ascii?Q?bB2SGowt8Ud5luUe+wTk25eGq2gb+ahLulNG+YXWp3Sxs6G9LCZ6Lglr2IpV?=
 =?us-ascii?Q?7XI9OPOUfMmQ615WWV9wS4VXxbCWFhEA7jRa6YMDpd+S8z5vScP9OnQ/cIiK?=
 =?us-ascii?Q?UHcDVEryVKtm5aiLq132srrVbBxV4n5aRDP/HzQiy913omgncnZUL/ZpwEtD?=
 =?us-ascii?Q?NpNhZwEIdpwjPbnMdkm0pvrLv385qHSsO8Sylbl/5BNx0+rMTKhPIND3QdU/?=
 =?us-ascii?Q?TP0jhIshbo6obpfiX+wePpqRTVLwbJyaZLc+2YYoLVQzLF/Eqe7bdhnxORI9?=
 =?us-ascii?Q?gLsIgZGicd/fJ8yYo5WXHI3A0ciDASZKkWKTn+lNpsmrvkpbkZMKfaukkp7Y?=
 =?us-ascii?Q?54EUJ3/VRjCZZWprs9HH9BciYMdy/FkzW+0DWDjdfnnRL80nC6oXNgkb1eg3?=
 =?us-ascii?Q?kS0yf1X2JtKpmvbblls7QxygSynHF9C+9Vu66Aumq6oJis+QbnNEZTEwtho5?=
 =?us-ascii?Q?kB/V+KH+8GID3ZkLT5P1F+ZcKPalLqHk1a1poZbEWNF5TYj9ZzVCC1tKb+py?=
 =?us-ascii?Q?TAaGya8w2n1cGvnQ69EEPW/CNcK1vgaG9EFYhdCWrjbqGmD1Y38LsKIIb1i5?=
 =?us-ascii?Q?kvKqbjxceE835r7Ch1McwlEU+c5byCLRKkJlDpAfepuNt1OSU8jvddWLyCwn?=
 =?us-ascii?Q?6dR95h+RCL2qxhD9H4sI4qoWNYEAFEgJBe9AF5VjmTsnuk1ioxH9Fzx1hsPm?=
 =?us-ascii?Q?xH7v8CXrPuLPKTR1SsOeWvwq53Vsz9XgIosfcvHHeBFwxkf4IA5fITzdCSFy?=
 =?us-ascii?Q?i6ILCJ2YHuD/o0aX+3iDrP6xbiTaTZO9IHPADLXnqNXmo92NM+7GkvDQ1F54?=
 =?us-ascii?Q?Ta6vOsTZ/Qg/IOBrAbe65rdEb46TZJuGNJgzu7OyFEU0JeIg4mhPKedP27Yz?=
 =?us-ascii?Q?9nYQ3UE=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34edd241-99bd-4160-dee4-08deb2abd806
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 18:00:26.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7617
X-Rspamd-Queue-Id: 7B9365563E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10921-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 9:=
24 AM
>=20
> On Thu, May 14, 2026 at 06:14:22PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 202=
6 9:24 AM
> > >

[....]
=20
> > > +	unsigned long nr_pages =3D end_pfn - start_pfn;
> > > +	u16 count =3D 0;
> > > +
> > > +	while (nr_pages > 0) {
> > > +		unsigned long flush_pages;
> > > +		int order;
> > > +		unsigned long pfn_align;
> > > +		unsigned long size_align;
> > > +
> > > +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > +			break;
> > > +		}
> > > +
> > > +		if (start_pfn)
> > > +			pfn_align =3D __ffs(start_pfn);
> >
> > I don't understand why __ffs() is correct here. I would expect
> > __fls() so it is consistent with the calculation of size_align. But I
> > can only surmise how the hypercall works since there's no
> > documentation, so maybe my understanding of the hypercall is
> > wrong.   If __ffs really is correct, a comment explaining why
> > would help. :-)
> >
>=20
> The use of __ffs() is intentional. Each flush entry invalidates a
> naturally aligned 2^N page block, and the hypervisor requires the
> page_number to be aligned to 2^page_mask_shift.
>=20
> Here __ffs() and __fls() serve different purposes:
> - __ffs(start_pfn) is about the alignment constraint, e.g.,  how
> large a block can this address support?
> - __fls(nr_pages) is about  the size constraint, e.g., how large
> a block can the remaining range hold?
>=20
> Taking min() of both ensures each entry is both properly aligned
> and within bounds.
>=20
> Thanks for raising this - it definitely deserves a comment. I had to
> stare at it for a while myself to remember why. :)

Hmmm. Something about this still nags at me. I'll run some
experiments to either convince myself that you are right, or to
come up with a counterexample.

A related thought occurred to me. If each flush entry that is passed
to Hyper-V describes a naturally aligned 2^N page block, I don't
think the HV_IOMMU_MAX_FLUSH_VA_COUNT can ever
be reached. The number of entries is limited by the number of
bits in a PFN and the pages count, both of which are 64. And with
52 bit physical addressing and 4KiB pages, the actual size of
a PFN and pages count is even smaller than 64.=20
HV_IOMMU_MAX_FLUSH_VA_COUNT is the number of 8 byte
union hv_iommu_flush_va entries that fit in a 4KiB page, so
it's ~500.

My statement applies to a single flush range. If multiple flush
ranges were strung together in a single hypercall, a larger count
could be reached, but hv_flush_device_domain_list() only does
a single range. So I don't think the overflow case in
hv_flush_device_domain_list() can ever happen. But let me
do my experiments, and I will also look at this aspect to confirm
if it's right.

>=20
> > > +		else
> > > +			pfn_align =3D BITS_PER_LONG - 1;
> > > +
> > > +		size_align =3D __fls(nr_pages);
> > > +		order =3D min(pfn_align, size_align);
> > > +		iova_list[count].page_mask_shift =3D order;
> > > +		iova_list[count].page_number =3D start_pfn;
> > > +
> > > +		flush_pages =3D 1UL << order;
> > > +		start_pfn +=3D flush_pages;
> > > +		nr_pages -=3D flush_pages;
> > > +		count++;
> > > +	}
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_d=
omain,
> > > +					struct iommu_iotlb_gather *iotlb_gather)
> > > +{
> > > +	u64 status;
> > > +	u16 count;
> > > +	unsigned long flags;
> > > +	struct hv_input_flush_device_domain_list *input;
> > > +
> > > +	local_irq_save(flags);
> > > +
> > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	memset(input, 0, sizeof(*input));
> > > +
> > > +	input->device_domain =3D hv_domain->device_domain;
> > > +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> >
> > I would suggest moving the memset() and setting the input fields down
> > under the "else" below so that they are parallel with the flush all cas=
e.
> >
>=20
> I agree the structure should be more symmetric. Yet I guess the memset an=
d
> hv_iommu_fill_iova_list() need to stay before the branch since the fill
> writes directly into input->iova_list[]. :)

Agreed.

>=20
> > > +	count =3D hv_iommu_fill_iova_list(input->iova_list,
> > > +					iotlb_gather->start,
> > > +					iotlb_gather->end);
> > > +	if (count =3D=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> > > +		/*
> > > +		 * Range exceeds hypercall page capacity. Fall back to a full
> > > +		 * domain flush.
> > > +		 */
> > > +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> > > +
> > > +		memset(flush_all, 0, sizeof(*flush_all));
> > > +		flush_all->device_domain =3D hv_domain->device_domain;
> > > +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> > > +					flush_all, NULL);
> > > +	} else {
> > > +		status =3D hv_do_rep_hypercall(
> > > +				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> > > +				count, 0, input, NULL);
> > > +	}
> > > +
> > > +	local_irq_restore(flags);
> > > +
> > > +	if (!hv_result_success(status))
> > > +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", st=
atus);
> >
> > As Sashiko pointed out, a failure here can lead to all kinds of trouble=
 because
> > of leaving unflushed entries. Maybe a WARN() is more appropriate? Also,=
 maybe
> > a failure in the list flush should try a flush all as a fallback, with =
the WARN()
> > only if the flush all fails.
> >
>=20
> Good idea. How about we restructure this routine to sth. like this:
>=20
>=20
> 	memset(input, 0, sizeof(*input));
> 	count =3D hv_iommu_fill_iova_list(...);
>=20
> 	if (count !=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> 		input->device_domain =3D ...;
> 		...
> 		status =3D hv_do_rep_hypercall(FLUSH_DEVICE_DOMAIN_LIST, ...);
> 		if (hv_result_success(status))
> 			goto out;
> 	}
>=20
> 	/* overflow or list flush failed: fallback to full domain flush */
> 	flush_all =3D (void *)input;
> 	memset(flush_all, 0, sizeof(*flush_all));
> 	flush_all->device_domain =3D ...;
> 	status =3D hv_do_hypercall(FLUSH_DEVICE_DOMAIN, ...);
> 	WARN(!hv_result_success(status), "IOTLB flush failed, status %lld\n", st=
atus);
>=20
> 	out:
> 		local_irq_restore(flags);
>=20

Yes, I think this works. But per my earlier comment, if I'm right that
the overflow case never occurs, it could be simplified further to just
do the list flush with the full flush as the error fallback. Then WARN
if the full flush fails.

Michael

