Return-Path: <linux-hyperv+bounces-2001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA48AA4B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 23:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCB3282D55
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F449194C87;
	Thu, 18 Apr 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E3QOA2uu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB9194C62;
	Thu, 18 Apr 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475761; cv=fail; b=miGjcK6zaXbEih5HPmukVvj/wuCA4ZZ/cjjSDAQZJUHBDXOZGz9Z4A2PipYqry+7jMEI9k60VgHcKM0pL8tysaKn7m7QgOMTZ9jK69jjmIVL+Jnf6dn7wD9IJd0E5FLO7pKMicIfsGbb2NxFZPGSNo/EQow3l/18xDjMTNeFVqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475761; c=relaxed/simple;
	bh=aiIlHxiqoy60LRthI52/jpReMFnXKgSDwlRfGwg8I9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XBrvJAFArXht5BTDm5jB+rhVlyxrMfcRd8XOJZcssbwHLwA8ZswxIDoGpvtYZulJXy4n/dnyGEDjHgxI7uF6Oweu/MNYeYoNhokvyjPO8dRu4fYvgBtVJ9v9H2oMwFqERCgclti6wU/dbmGZL0UZ0aqQtyctNQmCfCH9Fc0vw34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=E3QOA2uu; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoCUOceYiKpdtbLHGUk4+m1kj6D506gkCJezBkjjdWst53sWEzJGDNibG1y2xTqVapGj93f6vXqxHDjImZ/afozL2BDIzgkIk/IB7OM0AUCorSnDnZaVpTHRTRoJU4bF13FUQTAmDyyl9tnm0EpmbHZhNDGoXbFClJBoK9TaQOPevs+vFV832d6efxHcPs/RYFdimv7+6WYPZZ/Bm6riaevO5lC6DblDyskjsTxfyTIzCYe1wOSgSc4MhfYBRTFlxoKUzKj9DpwnxUcEKqcbTgXvmeS7zJlmPzLB2+C5dC8dCtS3PjhoBKIHBNHzGO8vcFMzCkjxfKZ739I+LnnDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSmI5kimU83Yn6MYwZfJy4efXEEM0a0ZoXGdELs0x7U=;
 b=SXU1M2gCfJEmnWsaOG42GGr2U2vYArZ0lMiL3JsbDKnaJGXhP/XMPgqsM1YevXiFAkoJ7a8qbd7mmwKLH19DoRDMzfR2oYi8muID49PAgFLCnh4xmkwPx4wSum5HOTi/wy2WWMaAUKf1OkZfINUlxwJB5QS4Kjg60Mo6Pmqnqi484AJ+i0bcOCAZ9lK/q7h8WWwkEpquFvcrkh0JLbPAQDXwSeU1LAvQBshf8PDc9ynmoY52hXLl5a8r18J4lZi1yf8OWvqmRVfQSPFOx2b9okFy4rsQ96aaYUayeAtHE/p/baTcGBik7Czj/WXc9ZjzeIHIInyKCn1fTVE32aE8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSmI5kimU83Yn6MYwZfJy4efXEEM0a0ZoXGdELs0x7U=;
 b=E3QOA2uu8RozBeHrfusOseS97EC1rH+pF0dWgBRBFQE+H1sk4whhad2+308b+L0ioZTewXE67lIKadDK4IgEBWrUo8a/KM/b8aiEN3iLftOOFiQfG9AU1XgZTn8psE3Bizp18/PbeNyF/dhj3K20JfqS4PBmEzBVoTokVNQ9/YI=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 SA3PR21MB3864.namprd21.prod.outlook.com (2603:10b6:806:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11; Thu, 18 Apr
 2024 21:29:14 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e%4]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 21:29:14 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Add new device attributes for mana
Thread-Topic: [PATCH net-next] net: mana: Add new device attributes for mana
Thread-Index: AQHajxpElOhYSgpXD0mPpMmQxX0tS7FugNnA
Date: Thu, 18 Apr 2024 21:29:14 +0000
Message-ID:
 <DM6PR21MB14818DF8870C725A46C09A0BCA0E2@DM6PR21MB1481.namprd21.prod.outlook.com>
References:
 <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d1e60117-6f45-44a5-8350-197fda9f97e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-18T20:32:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|SA3PR21MB3864:EE_
x-ms-office365-filtering-correlation-id: bf7fe0b2-faa8-4e75-14eb-08dc5fee983f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DAWTzBOYLoRmhdn4In/+5CXzPBKkSv76rKZJOe1aQpryGNCmSXbazmRgzeKs?=
 =?us-ascii?Q?iWBnHlpFWG8P1bAyf8GtMDK/8eMHgLpeqIu132NxDcrB6K6jokm/hhrhGUjw?=
 =?us-ascii?Q?DYzssneDdB0URzLrxffnsmCUnQZT0QhtcuRuN1hGf66iGmsiH2TFw4VZMUp8?=
 =?us-ascii?Q?mgBQ7G3N5biVb+iywozXWen5vJmukiKZLnXCgZyD2NqH81VKDOX0WAzHGNU7?=
 =?us-ascii?Q?DqdnB7cbD0aDb+jW8/PxnTA1EPMEoC9wQJQ8BfEZuYvMY5nTOEDIshEHeW/S?=
 =?us-ascii?Q?nUoJ1dgtJFDJK7GZZb47oXH0V6B7schNOn9u4PDHwbXKPQgZ+lPVSlIVJ4tX?=
 =?us-ascii?Q?hhWjQXwi9TgVRywz10UMrIXbmOwd8WyAAmxgsj/30NgF3Q+DPz3o2MvbC708?=
 =?us-ascii?Q?eicqzNEZiWP8XQuTkJ2dOcTilmRDbR/hiAk8Ru4e3hucU7eMZfFuqIht/bCH?=
 =?us-ascii?Q?QA2ND8qHhcCPfWu/oKrF8Mj6lqni7ZXVjj2G5Rj3zrMRxxArBPOpFSG/5PDs?=
 =?us-ascii?Q?1AbqHIhgcCLDK8xREnJBK9d4zgrWwgnaZC+NdOqo2Lc2Ewa3kgKIeoPFt51r?=
 =?us-ascii?Q?n0iIUX9yRafoH8uoygb9dsysmzrsjhfSiZiCwOgnLLxmQRteBlDYZGm3Nomz?=
 =?us-ascii?Q?auTG9eeEi2Qmjjg/YJYiuLeNdJnytk1FGJYmzKmrkR7Y/OkDEl2RsmD5thLt?=
 =?us-ascii?Q?Hj4pMLZSmfwRc/Dm4geuEbSktCrXkBFmQUIBxjfEF2OH6QuFhycLWVENxkIj?=
 =?us-ascii?Q?VcMHlLcjkefwYk/0ns2Jwnf7+OzMedIL4PwCam/TQwctmPNxhqobhNekieF8?=
 =?us-ascii?Q?HizXwztBB6uwCiipXqcqeP38S8WkpGbmCLNSiQs9ZQqyD+qN0p4SK9MQN3nJ?=
 =?us-ascii?Q?OYE80yqhFkNVDBfLKVIF2/9yE7vAWzzRnZkdBRfXm4bWzbzhscCVWHM1KRr9?=
 =?us-ascii?Q?0234q2Hnr3QLTBzNPRHW0WpZkIaVfbM9WNy1K3B0uuyre79/m7VVVKZ+BQuN?=
 =?us-ascii?Q?grt1A2jfmYKZbbDj8OhTFKPIHZLLHmLHPFOY9mRecC3qUXQk4FSZwLw5v12c?=
 =?us-ascii?Q?ytuormFGDK9ufIvtGR3rfqKzJGQZUA8anGynnEY+m8yleN4fQPwOcqgJLCyp?=
 =?us-ascii?Q?Dg9NLcx8zO5D9BUJFzNrvENZsK48lneh9MQ0zxLCN68becKdYXP7WujeicT6?=
 =?us-ascii?Q?cCMeikTWkdZbIXygXHuBhjpD0zPqtndY64Zh8cAW58UDbake3YgNubeYlEck?=
 =?us-ascii?Q?tEa8w4kAgTwXjO9JiG0KyDDEgZj75FoW8BnNVt+sD/MXDjzckFCDJKARq838?=
 =?us-ascii?Q?g/2UchZYcXDjsIquYVrGs6Ltb806OM3i+PwuEUsDPW3MVQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M03tj7pdGaAxEmh5w7iManmWyh0GtCdI2f9bo9DYhXzB+IvbP3ikbJB7Bsmz?=
 =?us-ascii?Q?otVHTqE5jZCAiTjLM0j4S7WDTV//Hs6mmzMNMn45e7FHraOfTzzi6wLNSjCO?=
 =?us-ascii?Q?VvNW6SyKM4dNG3h+qQfYpoZ6FHT2B10yZV6yZfFjtRT/46MEz2nfqLt0Gbkn?=
 =?us-ascii?Q?wgzgIUUbdbgXiyXFepFG9kNSbTAIbWZphZ76BmlxNUR1g2j1ThZKEnKDN3to?=
 =?us-ascii?Q?/0s/OPzN+JMRnF8sG7LNUweukHvWmxhFqKRYFs+frJofS+pcNGVAJOTo+xWK?=
 =?us-ascii?Q?/hKa9ggFQzNWBUH9N1Ng6IEEPBXWhvAQHfPzMVTRgBEUgl1HloYtErnfw4YS?=
 =?us-ascii?Q?+n9NpDddHAdlPuwRhJq4/NA2t/CWlB8GrelfofavdO5SDhWk9CVfSHuNb5S3?=
 =?us-ascii?Q?ZWCP2vzrK70cV6FS8X0VQNrSqzSXzUxgvze/Z26dhYLDnuyM2UykTJGzKwnZ?=
 =?us-ascii?Q?1NCDRqNCBRmja3uIC7y7igkiEtxXdE+3e/jDGnQs8pIpTm7RkPpGpGOsthOk?=
 =?us-ascii?Q?eapce6tGkB/Uy+QSoZaEmOx+nvbpiIKi8Q8aykuZD/r71hrKYevKDpgQZj7g?=
 =?us-ascii?Q?SmPoQyzgkp7JVwDdbVExuev2h5AU1vIUtgGOMbxs4u36wxpIyuUADYXdLXcE?=
 =?us-ascii?Q?Tj2bgp/awKSVKEDM+8RJJJxxiF6QkfggLcS8nNJ42/OtqAWvpaEnklE78n8P?=
 =?us-ascii?Q?usLiQtmd2Mzx244FK5H2BkPlJTfc08kNfBMB51MZqzjgD+5xbuCigVTur8ej?=
 =?us-ascii?Q?5XzGy6qAYL5ergR8O76K3f4XpXJIysnvqXlzUET+XtOArh70HG0X9bGsB6Py?=
 =?us-ascii?Q?jrvQr6EDAicaxHc2twtQUB3rkUOOXBoNEXJ0O7vrn6B2MW0qqrtQGtbINR+e?=
 =?us-ascii?Q?GRHSEnQbC8h73z4txmYmcInhqfx9wSu0Ab8QVk7OX6as9aI08uRjOpVIrgZW?=
 =?us-ascii?Q?aFs9I7RVlLz4SDswL3KRXI8c4o5PMpB7AqmHS5r96IuB79nJ2Zl+WUiggNHE?=
 =?us-ascii?Q?souQBu/HninMk/v3+cVGqnGqWcIx7rEAOpltvXggWsQzQ/I9kFaHgX/yXq1U?=
 =?us-ascii?Q?LkpsQEFZec06ma9hPB1W3SvA66IQIr5PVyimdRdgTQ7MyB6WrXq5WLt+6uLc?=
 =?us-ascii?Q?glN9chw252yogXEb6FrVmSJn1O6E7KL2bHlLrVn31ZaVFKERPla32yjVQp4V?=
 =?us-ascii?Q?wszB0DiwiNYZtPb/6hVPpn6tBTENCJ+FUVU894ps5xN5+uxQgMKLdX/DYO0t?=
 =?us-ascii?Q?yuwHdOU3KKlvPR62tkNR/HgyGvjHBmZWu+36CSeyA9cLCW969JMR8WYdC0Vk?=
 =?us-ascii?Q?4VE2kYQ0PNZkG+E8NB/bjRhQhd65PEbyAqIRRWOh0UauPuETzBvAs9dbX8wN?=
 =?us-ascii?Q?BEAXFiJBNgShw7CSOsm55NsrdaGtpNR7fo1X0e04+5liGkqBtQTJotVGz7CR?=
 =?us-ascii?Q?UbT7d6IO/+vfLk48fSx4+/Ph62j6dF1ZQc7tj/X02Y26GS77VILZTmP2M7Ug?=
 =?us-ascii?Q?8zcSQwA/2vTIQnNAedgZGRK+6p9IRPs+dNydsolMV3BVpS+xWwetBF7Ya/e1?=
 =?us-ascii?Q?DneT6A8mLIzr2AFSKfBJr+B5YXK0GgqctS66VG3O?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7fe0b2-faa8-4e75-14eb-08dc5fee983f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 21:29:14.0375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOEQfPSDNpYOAKTyJq4oNucDjl0HSrmPsK4vwCE2GKVjSsjEw0Xovl7ebj9HEnTzOOslrSGBGnKVYN6DIbOwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3864



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Monday, April 15, 2024 5:50 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Long Li
> <longli@microsoft.com>; Michael Kelley <mikelley@microsoft.com>; Shradha
> Gupta <shradhagupta@microsoft.com>; Yury Norov <yury.norov@gmail.com>;
> Konstantin Taranov <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> Subject: [PATCH net-next] net: mana: Add new device attributes for mana
>=20
> Add new device attributes to view multiport, msix, and adapter MTU
> setting for MANA device.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  9 +++
>  2 files changed, 83 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 1332db9a08eb..6674a02cff06 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id =3D=3D MANA_PF_DEVICE_ID;
>  }
>=20
> +static ssize_t mana_attr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	struct mana_context *ac =3D gc->mana.driver_data;
> +
> +	if (strcmp(attr->attr.name, "mport") =3D=3D 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> +	else if (strcmp(attr->attr.name, "adapter_mtu") =3D=3D 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> +	else if (strcmp(attr->attr.name, "msix") =3D=3D 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> +	else
> +		return -EINVAL;
> +}
> +
> +static int mana_gd_setup_sysfs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	int retval =3D 0;
> +
> +	gc->mana_attributes.mana_mport_attr.attr.name =3D "mport";
> +	gc->mana_attributes.mana_mport_attr.attr.mode =3D 0444;
> +	gc->mana_attributes.mana_mport_attr.show =3D mana_attr_show;
> +	sysfs_attr_init(&gc->mana_attributes.mana_mport_attr);
> +	retval =3D device_create_file(&pdev->dev,
> +				    &gc->mana_attributes.mana_mport_attr);
> +	if (retval < 0)
> +		return retval;
> +
> +	gc->mana_attributes.mana_adapter_mtu_attr.attr.name =3D
> "adapter_mtu";
> +	gc->mana_attributes.mana_adapter_mtu_attr.attr.mode =3D 0444;
> +	gc->mana_attributes.mana_adapter_mtu_attr.show =3D mana_attr_show;
> +	sysfs_attr_init(&gc->mana_attributes.mana_adapter_mtu_attr);
> +	retval =3D device_create_file(&pdev->dev,
> +				    &gc->mana_attributes.mana_adapter_mtu_attr);
> +	if (retval < 0)
> +		goto mtu_attr_error;
> +
> +	gc->mana_attributes.mana_msix_attr.attr.name =3D "msix";
> +	gc->mana_attributes.mana_msix_attr.attr.mode =3D 0444;
> +	gc->mana_attributes.mana_msix_attr.show =3D mana_attr_show;
> +	sysfs_attr_init(&gc->mana_attributes.mana_msix_attr);
> +	retval =3D device_create_file(&pdev->dev,
> +				    &gc->mana_attributes.mana_msix_attr);
> +	if (retval < 0)
> +		goto msix_attr_error;
> +
> +	return retval;
> +msix_attr_error:
> +	device_remove_file(&pdev->dev,
> +			   &gc->mana_attributes.mana_adapter_mtu_attr);
> +mtu_attr_error:
> +	device_remove_file(&pdev->dev,
> +			   &gc->mana_attributes.mana_mport_attr);
> +	return retval;
> +}
> +
>  static int mana_gd_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  {
>  	struct gdma_context *gc;
> @@ -1519,6 +1578,10 @@ static int mana_gd_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	gc->bar0_va =3D bar0_va;
>  	gc->dev =3D &pdev->dev;
>=20
> +	err =3D mana_gd_setup_sysfs(pdev);
> +	if (err < 0)
> +		goto free_gc;
> +

Regarding examples, vmbus_drv.c has a number of sysfs variables:

static ssize_t in_read_bytes_avail_show(struct device *dev,
                                        struct device_attribute *dev_attr,
                                        char *buf)
{
        struct hv_device *hv_dev =3D device_to_hv_device(dev);
        struct hv_ring_buffer_debug_info inbound;
        int ret;

        if (!hv_dev->channel)
                return -ENODEV;

        ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inb=
ound);
        if (ret < 0)
                return ret;

        return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
}
static DEVICE_ATTR_RO(in_read_bytes_avail);

Thanks,
- Haiyang

