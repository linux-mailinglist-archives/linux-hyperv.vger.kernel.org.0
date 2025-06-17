Return-Path: <linux-hyperv+bounces-5937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D74ADD43B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7341942D44
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B452DFF2B;
	Tue, 17 Jun 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="adZxpdz9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021119.outbound.protection.outlook.com [40.93.199.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B942F234A;
	Tue, 17 Jun 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175695; cv=fail; b=E9A37hZYHL9kXvRVYYuCgqi4e0iTwajc7mfOV6uieDpFVugPiWcDJPKCypcjpo7NNCxZNPeG3CxebZ3SVSj/fTt4RDuaMr+njtoVgBaSvbgsJwsOH7BW5DwO99z5RV1JeFb7zipoeu0y0h9O2yujFXqhpw+yYkkud26uEa5Vz2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175695; c=relaxed/simple;
	bh=1w5xGHlouqvbCHA1pByANf0BbMKoQMlF0muA1GISNPY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tHa4VaonNLl5jV29E6kgnH6L6locPwdDbe3KQ3AO3e8ws8j9kshJoWYRYlNEIM88il5IYLNzRXS2Q7HQep4NK/rHhqEDLgKkraJycZ1tTEJjO+kXZUwxOHWX5aj+1pzzxGO+WzMdhNfmL8LmbpeZeA8kOwKAA/17jk+F5hCFl5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=adZxpdz9; arc=fail smtp.client-ip=40.93.199.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks5/LSGsXAvo5mdFFQPqHvnptEmau7Sep66oe8PQCrSHWNix3GOBA5k69brwMYzSvk2IanoiIy9DCb8qnfp8/LsC3+NCPSA8HdX/jw5FO5FxUMp4TwuImNZeV9swaVEUnfZQxG1/RM9VsWniVIjsF2ceH5K43pfh3A7IuvdTpOfG9tomL/AO+Jbg1PS1sCO/IzJotm6sgLEZIrbEadrDYgIeXu1Gvm+P6Q1Zuc3gin9g+qr07btPTHa8j99el/IU9flvea3E95FtHUFoDON0AbyhhS/bf858ZdhXxQcDiP+DSYKtt9FtL+vHA8QmCdSQ73aVp1bGV4BHHObYKuPQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8G9mD8BPdKNIjowEnopKzxsO+IxzE+1xDei1yuQ72M=;
 b=cobtHKJ7NuZ4SGDQUeRciQzUhp+mK5rRB6kmgXCS2/uwwVw6enxyvRw3mFwoQ9wqUHZLcA7SjJEdR3qJdPQzA/f5BNw8ITyzFun+kM7kYqYuPgeACr3WR6Y1pR7APChuhFtnj0wEzHEf9lYXbTMQyTGji8+YaIymcohcbsn1u57c0S4YK3xjZAaCujIhAexgb+y2MgKJSAA66BsSc00Lgr0GAQozr1W124L51Vcd6Ui6Rpmz0ofQkZhNFjqz//LsYC4OxyevkpbJSsTulCc2uhKV2V96Gd6vhVg2W8EOeqjm/wOT635/Vk/fSg0qKwMgAv4/tm2F7YgzANZ25aIGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8G9mD8BPdKNIjowEnopKzxsO+IxzE+1xDei1yuQ72M=;
 b=adZxpdz9B/GLVl6xCzoXlJigT0lPRWs0fGy0lFgR5G435bTnjpBScjaAB1sCJhj54GnkYsmC/536Y9JBiKMFnLBRCy19uFuZ3G6hOlotBQDrYtRo9XgKrXagmGLmBSSDH2oUSzp6H02DRARG2BX4DpY7FdgWN01AxBo3xCdjONs=
Received: from DS7PR21MB3102.namprd21.prod.outlook.com (2603:10b6:8:76::17) by
 DS7PR21MB3428.namprd21.prod.outlook.com (2603:10b6:8:93::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.17; Tue, 17 Jun 2025 15:54:47 +0000
Received: from DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f]) by DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f%3]) with mapi id 15.20.8880.004; Tue, 17 Jun 2025
 15:54:47 +0000
From: Long Li <longli@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "gerhard@engleder-embedded.com"
	<gerhard@engleder-embedded.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next v3 3/4] net: mana: Add speed support
 in mana_get_link_ksettings
Thread-Topic: [EXTERNAL] [PATCH net-next v3 3/4] net: mana: Add speed support
 in mana_get_link_ksettings
Thread-Index: AQHb31fuhL95mOtqekCQtB34Vu5SILQHgXcg
Date: Tue, 17 Jun 2025 15:54:47 +0000
Message-ID:
 <DS7PR21MB31024C9BF35A681628CC1DB5CE73A@DS7PR21MB3102.namprd21.prod.outlook.com>
References: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
 <1750144656-2021-4-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1750144656-2021-4-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=75c59bb2-d076-4c11-81cb-e186013c36a1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-17T15:54:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3102:EE_|DS7PR21MB3428:EE_
x-ms-office365-filtering-correlation-id: 3d5c5b2e-c4d2-4767-7a29-08ddadb7495b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EMBw2zKdqT1XSc1gVxDsoWsM7gGcCt3+v2EqZkXIiGIiSubcjN7FH3lrzXdC?=
 =?us-ascii?Q?XSpGrPDy33h6BTKpg4zG3SqWqN0GKm0ZquofVe1OgrNQviyxmiG7TsBtIekY?=
 =?us-ascii?Q?W3Pv3x7BFMhV8tbhNHWADTYYzNgxrLQy+gpomNYylFa+th2GMLXsjsUhf4M7?=
 =?us-ascii?Q?j0IB9GlrzXKw8tEi6mSGSUcnuMowaaoHBIvGaSGV7NUA57slC2wSRfqoUcqP?=
 =?us-ascii?Q?RDaQ0qXPaF4zzktfVYfkAG+jfg9YIFvAJKfhfl+jYOAxble76xiySqDdlcNv?=
 =?us-ascii?Q?UlYWn0D1leeF2H3QGGWG+WWUAYjUg9MenWIzO2yVHc5yr5/+5P6XsrS4BbKR?=
 =?us-ascii?Q?ZaUOBzBZme6O6NtRbspJKm54+2BaZBRTGF/4L7TeEldQWa2ZBvYoWaTX6vNu?=
 =?us-ascii?Q?sKSIkR0seNt08nCTJKXnGnv5Vrv4l43OD4Acrr3S9yrzxX3AJbE4AEqK5+st?=
 =?us-ascii?Q?k2F0WMtFL+G2RcrXVN6+VQUtinkIc5OZoiLe/f92+Rnzjjp4fwYpZO0uEa5C?=
 =?us-ascii?Q?2gim7//0o7/QmrJow5UUJjepFodAt/WQOwj+wlMN9XVwZqTwJVn8bB5v2ro8?=
 =?us-ascii?Q?RKqi3wGdJ5ZwcJ0khssuE0+FdxyR7yZQKJGxiGX91ISE4VqMuPIJSFFgmHPc?=
 =?us-ascii?Q?s15Q2lEnsPxTghqez7SvnCXUy8Kgy+cJvH10IO6bAJSojPl8sbRHzBSs9w38?=
 =?us-ascii?Q?ERo8aCXIVzs0wrFyaAq6KIcXvJc2SaN7H+/bWcW+/24uN7lGDHYxikpluiyO?=
 =?us-ascii?Q?eXm4kCmhUhw9+o0j2DzRwZ6bRQvjsI27FtpSNHL2mNtvWVOJlagSuBcsl6gh?=
 =?us-ascii?Q?1/Ci/Ck7ctycfMcCwoPGAA3NJHXR18F16IKFBYm8zszzCH5xF7K9BRfEQT+X?=
 =?us-ascii?Q?IR1M1I5owLNOyQ/E/EjpC/yBVn/be1KyVRWdrZZpdI7s9454Fq87WGY3hmE9?=
 =?us-ascii?Q?0QPlKP8Ui84dBJa/Cf8o5ytL9gy983xph8sHaptUo2plSRYbsVo62BV2zz8x?=
 =?us-ascii?Q?6iNU61CFstdM5o/n8LFFnkKpAJX0iJnG+WA8fpiRPSXYwb49ytEJeur6KXSt?=
 =?us-ascii?Q?sSV7zzy96JLbkVmA06DakLTrhvqi8NzWQeTGgIWbYHA+JzfOdNTbx2HjFE62?=
 =?us-ascii?Q?VajI6EdUZp+JHg3POZLeyljClirN3h0Cc7kHsoAVYIAzD1c903UmOiRTCsth?=
 =?us-ascii?Q?/vb48bwTcrgAJ409xn6ukfQflOgZCYUyOA2b6aFzxITHzJ2PrRSFZo6vxtVe?=
 =?us-ascii?Q?4qHNCLz1rTtDC4xDnZ4DiHER1/qeq61W2U+18gmbyRhpHMo7jGKBW+lsFlu7?=
 =?us-ascii?Q?5ji6gzhXaEkDJWPOLX3dooldwwuuPsOggtsu3j9/tSVVgfedOxOLXvrvbqBc?=
 =?us-ascii?Q?0cApwXEu9YyFpqlSoXV0UUuO0Tgew9YF5p0Th3N2A4N1hx+TvgGXC5Nahsa0?=
 =?us-ascii?Q?YFwowB2JHdVvO1SQoxYyqATr6uoD+w/MzO86K0u3dcYKLsWRB/+YyrgJwap/?=
 =?us-ascii?Q?lQf+Nrd+DngaCbw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3102.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XafIgBsoUTgLhKhgIQuf/SsfWCZTPQlWqeleGlSh5fYkP6LLB1Ys2yrGC1wX?=
 =?us-ascii?Q?L8lbI42Uv8nGdHE/jdvVzLBkXd69iV1euYfYUQ5N2AdnQ+HbKv8e0rcjYAZR?=
 =?us-ascii?Q?lGNY+2deL0R/tC3vaLLPnL5Di1gloKIlU7W84ZE1AHdW75T8Fd6ryPoT2lrD?=
 =?us-ascii?Q?uD1O6zTrJQbz/Kohm1ZMSvFn4L7uHC3jP4Es+Z4jeQCxYiUUBq5HlRAFckzz?=
 =?us-ascii?Q?zWGssmwBvQsrc65bylh3Ix1JToRDZkx/NXiSodBYFj2UthD795XsDe9U0Sdu?=
 =?us-ascii?Q?SeR5rQjnoMyRCpTwbZweHM4lhY8plR7kqHZIg6fVubnsNK2LFRbdt1Hns/H0?=
 =?us-ascii?Q?t8MCLRbOvzEjlyRYTPVTbiy1nie/bjjST40N1TaUdVsCwMzJ9ow6Gi/rntJQ?=
 =?us-ascii?Q?udo6QLHSMbRydILAM4rsWQQZWV3jauhqUxCxWg+15rrG7zdVs64m89XUT1Yx?=
 =?us-ascii?Q?oCQOGIiCOiGtNxehpDuwSXtUo/wR2N5e40JXPweOmHXuMhHA9UPFBKWdReqv?=
 =?us-ascii?Q?NUCFbBbEh5wxWYMfEouWf9NhFQsM8hvG329uYKluc+YJ0BnV1kj+CgHYFCTI?=
 =?us-ascii?Q?4KK6GVwTrsDEZJNLwEE8TXgGoXqQXpsP7lLKTzASRc99J8Q06jmvej1C19BN?=
 =?us-ascii?Q?uFAeXvMZzWzDdc+7dn+j0ospMTFjzFyCYE9gnbrFTcgWZU2xOp7gOEF76Mw1?=
 =?us-ascii?Q?HYM2fhsP3BSyBVNXQl5zY90MM/6Y+E8mMlRdjIrz43sDUXjpNlZrMKp5Y+Mi?=
 =?us-ascii?Q?ssvrlD2NDmYerFRqKy9aXcAw4vzHIJ/e7V2y/33DD/6Pr15fodvR23vihbMn?=
 =?us-ascii?Q?qAzTYeRYDgBo/9NtrIzDVpjYuhfOIDB2x2VJX7O4ZIktlMjeUeO81dd8TgZk?=
 =?us-ascii?Q?OCrhWImNAbzQTdtWoxIpxgx/Ng4d85yM45OBuSgRuzo2BZTEo5kBgHdqbZ5I?=
 =?us-ascii?Q?cxHph9MbJwMWrBFeKdpg1RwrfI/OIBmSHpTMkNNxtjBJ0vfKjfOQh7JCUH/r?=
 =?us-ascii?Q?Afn2nusPwP/+A2e/6iyVGR+1cEzvyG8Bq70E2ubS6j/kc8nI1iEHaHt3K1In?=
 =?us-ascii?Q?6zeMtav7Gc/IsDcQ1Zxh2gYaZO1CZz0J8H6QM8o+E30elgNfEpJR6U0/BWA7?=
 =?us-ascii?Q?EoZz0yVKVLZhY6hTE3OzJtQHOjfMyfNsTE6fZiYLN/TtvZ0vwmzdD+wOi0sO?=
 =?us-ascii?Q?0ujIh34S+47LTZsZP50f5iYaF+Xtc0NrQBVpw4wK6uyuvQM76QSPaoRU44It?=
 =?us-ascii?Q?WoTEsygk8lF5oxlfq9ScDf+DPDbFwClJ3czZNZh/z3yqo5EQ+UhN2aj4Sh33?=
 =?us-ascii?Q?Nk46q+0Trma/0clzMkzU7AJzg79G1a4pZDYBdx8trnuJUJ+OGGMS6AgSQOxu?=
 =?us-ascii?Q?wOP6fMI+weflH41SsVQtdV8BgpDroz6RKrFIeutYlMnAPPRkRzwkVide5bGL?=
 =?us-ascii?Q?6jUOkT8KrR7iO6NALDBDpuerYFdDOgoeqA1q+pOmpCGA4NzmFNijjMQbWQaV?=
 =?us-ascii?Q?yauf0s/2X0+tRb7Q0WyjvyPmWpKbil9iwryufP39Hds261XH3oPTLq89fckf?=
 =?us-ascii?Q?QZWkXkv+1svMHc+yGM+1LNCzo5iwlwznIt6JpsL1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3102.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c5b2e-c4d2-4767-7a29-08ddadb7495b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:54:47.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y83DuE1drWfoA8FATK+4CmBe4cDK6LvXkiIgriISBJ5m+Phy7oxaHo9cGoOB0VDTk0SP3mL5NsvnOcx9hGabCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3428

> Subject: [PATCH net-next v3 3/4] net: mana: Add speed support in
> mana_get_link_ksettings
>=20
> Allow mana ethtool get_link_ksettings operation to report the maximum spe=
ed
> supported by the SKU in mbps.
>=20
> The driver retrieves this information by issuing a HWC command to the har=
dware
> via mana_query_link_cfg(), which retrieves the SKU's maximum supported sp=
eed.
>=20
> These APIs when invoked on hardware that are older/do not support these A=
PIs,
> the speed would be reported as UNKNOWN.
>=20
> Before:
> $ethtool enP30832s1
> > Settings for enP30832s1:
>         Supported ports: [  ]
>         Supported link modes:   Not reported
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Other
>         PHYAD: 0
>         Transceiver: internal
>         Link detected: yes
>=20
> After:
> $ethtool enP30832s1
> > Settings for enP30832s1:
>         Supported ports: [  ]
>         Supported link modes:   Not reported
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 16000Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Other
>         PHYAD: 0
>         Transceiver: internal
>         Link detected: yes
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes in v3:
> * Rebase to latest net-next branch.
> Changes in v2:
> * No change.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c      | 1 +
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 6 ++++++
>  include/net/mana/mana.h                            | 2 ++
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 547dff450b6d..d7079e05dfb8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1272,6 +1272,7 @@ int mana_query_link_cfg(struct mana_port_context
> *apc)
>  		return err;
>  	}
>  	apc->speed =3D resp.link_speed_mbps;
> +	apc->max_speed =3D resp.qos_speed_mbps;
>  	return 0;
>  }
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 4fb3a04994a2..a1afa75a9463 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -495,6 +495,12 @@ static int mana_set_ringparam(struct net_device *nde=
v,
> static int mana_get_link_ksettings(struct net_device *ndev,
>  				   struct ethtool_link_ksettings *cmd)  {
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	int err;
> +
> +	err =3D mana_query_link_cfg(apc);
> +	cmd->base.speed =3D (err) ? SPEED_UNKNOWN : apc->max_speed;
> +
>  	cmd->base.duplex =3D DUPLEX_FULL;
>  	cmd->base.port =3D PORT_OTHER;
>=20
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> 038b18340e51..e1030a7d2daa 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -533,6 +533,8 @@ struct mana_port_context {
>  	u16 port_idx;
>  	/* Currently configured speed (mbps) */
>  	u32 speed;
> +	/* Maximum speed supported by the SKU (mbps) */
> +	u32 max_speed;
>=20
>  	bool port_is_up;
>  	bool port_st_save; /* Saved port state */
> --
> 2.34.1


