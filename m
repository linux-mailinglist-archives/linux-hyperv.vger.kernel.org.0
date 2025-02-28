Return-Path: <linux-hyperv+bounces-4167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BFFA4A3C6
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 21:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285D217A38B
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC120297C;
	Fri, 28 Feb 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CcUF+epx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022080.outbound.protection.outlook.com [40.93.200.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE226251788;
	Fri, 28 Feb 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773666; cv=fail; b=DXeAzHkNZkJ1xwgBMVxX0N5CWO9TDiwPNGnWjtMSO/lzIEsS96yE5I9Juzhs/oo118NbMOETOVu6NDmG3MGWAh5TurwDtD9bDBXC4P4zav8ulfuV38DWpPEhYSauDtLGE66wuAjk0rhBhWGjPQ2KwJO9rV80eYQb6arE1SmZ+9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773666; c=relaxed/simple;
	bh=Prf5KHFbjymGX5swJIVMXVHsX2scj1uSp6VhHE8k00I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GbUCIOzoEJa1AvKPkkEk7hlzbb2WdRc68lTgoIyYi6CrdPicv9HA0smZ1+f2tzu22CbO0Q204IFrDJTUYJCpauSlxlAWKShGWaGYX3cDJS8xtWuMqtSuSnXVWDvccLhikzBAC+OdrlFP3sZo8HRUIU79R+dmuw8i+CvSDhJYYgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CcUF+epx; arc=fail smtp.client-ip=40.93.200.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQn2ILOxrG4qoVEQyukbVpBDNqJWM3iTJL55s9h4K6zqlVLWN2nKoT+7ikb63hA0UFYSysCUaoYaGc4Y0o+XElXVec7wSdWUUDgvwUQfH06Ws2QttAISj+QAa7pd0NspI+26Eg9U3Yj52BwoqdJjzBLfGdOXmJZ+RsdTdcxtUpWYe5/45gFPd43xYwTD8sU4vuuo2vbkP2h/Li2yqpKXjS3VJ7XCJQPiTNmErL4fYaNU9TEZj8NXbRuqnd0v2/OAKYIe8GxTEk7os86Y00pml6FtE2k8In+zaQkMFfPKjPbI6tSfil9J1xv6TkTdofrY23InID6yTTAqdW7pyoNf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyxir8OR2I5vYMpIISP0e56rvh8OukSWlvO/O/aeJcs=;
 b=h+U2UFursAFp+dZcsBu7dNbRvarmS/OeVrZTm8gk92wRI6Ui3RCbMBe8bEi1fBunLpcSvRfh39DUGdZ5RFG4TVGRbiZaPuxijT1d7FopBrXhXxPlOCe4I6eKK55iIMxgTVC14KZY3jKy0kpUQUJRgbOv4PkhMD2cqhE/JJ7ET75CSdxyAv+qRgWkIrkfAaBb1l/+Dr0O39dp3MfGu6Zy2HJZCESsUTQRw1EH2CUlpkmcPv1ZXmpsY02xCTZM/1Em6KWTVNw5kEVLQV1ETm4Sjx8ry92KluBFCyJ+WQBVBJFCPaxI08i5kzyqq0mgYyuy3T/Kg44YVuBjmGkgcvRdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyxir8OR2I5vYMpIISP0e56rvh8OukSWlvO/O/aeJcs=;
 b=CcUF+epxVIQtJe4qsOteuZxDgAjF31BILPGIY+XQs15nsLXsWJAjm8pP7vMg5ZZSyneWBLIKhOU2qYEnW8PaBaW523vu2YEBH/nSisKTtiOCbWYxB72qMGzh7YeLmPOSjUXkMg31RKS8gK3lvMI7lEyBCZJteorC9LhsYNek038=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN3PEPF00013D7B.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.11; Fri, 28 Feb
 2025 20:14:22 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.011; Fri, 28 Feb 2025
 20:14:22 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] uio_hv_generic: Set event for all channels on the device
Thread-Topic: [PATCH] uio_hv_generic: Set event for all channels on the device
Thread-Index: AQHbihSe+yG3Y1IIqE6XfcvnwvPuBrNdIo5A
Date: Fri, 28 Feb 2025 20:14:22 +0000
Message-ID:
 <SA6PR21MB42317B235E4904DC253E27E4CECC2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740617158-15902-1-git-send-email-longli@linuxonhyperv.com>
 <SN6PR02MB4157E89BBF2C3707D52CD5DED4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157E89BBF2C3707D52CD5DED4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=31ae6385-656b-4d9f-bb41-02732ebf1699;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-28T20:00:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN3PEPF00013D7B:EE_
x-ms-office365-filtering-correlation-id: fce2bc05-600f-4495-9bb9-08dd58347d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yZVUadSrYuZshM0cCwRGBX9bcaaswEvqWWGjp3a5voqcM1dVKEh28IQXrJsY?=
 =?us-ascii?Q?2v2loFFqSKkgk2JLtc+y/DYGUSpEDM6p+iMBXw+IXCwGzbuYmMhWveSjZpXV?=
 =?us-ascii?Q?0bP4p54Oka9o6083OF4WbZlGNQqMZWL0PCJO8bUQVzOqyqlXEKVlRu27fVfP?=
 =?us-ascii?Q?NDj/ceOq9kRAoM/8txXD1pYDkJXPnSrbFGs0fupnE05xiIDOypBgDBAC21+B?=
 =?us-ascii?Q?QYQuCukteRX5fTGMqD2I4NBmURzoWEi1/0IxsLLCP5K7rkbMmGOcnCltlo/t?=
 =?us-ascii?Q?BEm2SKwMx3UF2nmAuRnlkZIAQNQiTQsc8MbU6ctUqE3JC02uXmf+pz5xDr7o?=
 =?us-ascii?Q?lyJDCNHRcFvb67biGWN37JV3yRbC504dc//8lhItNp3IkQgtphHri85ylpxq?=
 =?us-ascii?Q?Kq9A0tjeFw3allgiPrDwSlmPgtH5ZeyE07++6BihM5ylU4IOgUgsBtwcmtcM?=
 =?us-ascii?Q?Ezcu84LjqeG0oWIsRPkkiLshI3jztGY96GFJ6csuDFoDdHcBO/i2iscfhA9H?=
 =?us-ascii?Q?pMXxKYDVzwQ+6qNfzknIoLd1tSWMtaL7Ey83Nvg78Y8X9wIdyyQhP5/wx9NU?=
 =?us-ascii?Q?A6PG3M0IKY4TPJ5OZon7iBwY/9mQBRo1LHr87kGt+orD+lrspgvd1T3vmWzQ?=
 =?us-ascii?Q?rKkCpsAuxr3lH3cnqYIZykG7Skcd5VWtUL8kk5AodAaLeuvkGYlcd2CG7nUF?=
 =?us-ascii?Q?f0Mv9fJajgrbbvS2OEiXMOie+V0EwpKe3oPglZ0r+LzjLaSJq2M6uBqK2fyi?=
 =?us-ascii?Q?ZW63234SKAqYanSi0Xxo1XPTr17Zn+oiWMUTOQ7+cOpMO2yOcP4SXFTtD90P?=
 =?us-ascii?Q?H4vo1WuNrVumW3gTqrRQHCyms2NStSlYotMxq0WYu9r1xdoEWfPqvB4Kg3B5?=
 =?us-ascii?Q?OrOz4TRm9ib96Lej8xFmuh02M39qplYJL58wEaKwHHW1LX6weH6YRYyECaHU?=
 =?us-ascii?Q?g3c7hwY7oAxBWQ2zQY7H2kuAUIwbjSRW8BLl68im5xkS9Qj9YF0nTaoMZRao?=
 =?us-ascii?Q?kYIWpy4/x9EA9u71eqs5iyXyFpfHjl8suKtmpoRbLDJYunPxhlMSjYPaABZB?=
 =?us-ascii?Q?GbR5h3lL5LCYKYX239tAG01Wrx1jB+aXdrgFRatH+UgU1jUh98U/MiGrDKGx?=
 =?us-ascii?Q?gP9Mc4MaJxZQWG4CizaSg5+NLO2MzeiBGhFeSp9OImx7m+IFEae6ELLRCMgh?=
 =?us-ascii?Q?Ta0tmdzZWEKYLrG5BcIBlfhlHdloNMhZy1UkN0uBifFopIC1aId9b8fHotHS?=
 =?us-ascii?Q?g6NIrACWN+VUwgQgs287mVrE6csdtl52UpDckW3jXziRoS63xHXdoz4CzK4R?=
 =?us-ascii?Q?B1w4knGYhFBA4ig9DCtnJ14PLcXj6DPkl2w5H5q0ODVR86+cNFX7OG0VwSVJ?=
 =?us-ascii?Q?wIELMNRoBTnHOzqt9d8zGOoXES4rIz/m+nF8K1KXzj4/g0G8VnZOIkNXSXaF?=
 =?us-ascii?Q?nFgEZ72WT0k6SMyYBhf5BEZEABCjPyHW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dDZhHm2c42Oi88fp+Y9nDjBzB5jlrqW7Opib2UMGVXxYLVTL/2d4uE8OqgwF?=
 =?us-ascii?Q?FBL8D1zngX76DG47zWI0/Nv9CnletpW6jPtGquS6pRNPQDV7uJpRmVYASx1T?=
 =?us-ascii?Q?9dbSQbjnL6KNKf8M8tAnbo5mkai2i/5EI8QWD8C+bs+FuEb2dkOUJGqNB2OY?=
 =?us-ascii?Q?XNxk0Ctc1dWXOXrUIEywoFblPbIJMOW+YlljtkUUvVaZU5G4huwpytZCwu8m?=
 =?us-ascii?Q?RABGu42qmpYaxZT5hC09463wC/gS2cI/yXFE1LVHJReUEdZsesyAxWcq/jrl?=
 =?us-ascii?Q?Y8Vgea3ACp+qHCfvWiQ44JIaqZum9UIZVySoBGmxmI7hH0BW2q2Xsu5s4swT?=
 =?us-ascii?Q?nbvyFGjhrlN+SBii8cLoUNpIgcVvEYC7episaab6QVm4UNrSRiFyOn4NleA2?=
 =?us-ascii?Q?iW/VHcJu72ugcd9tffUEe0QI4SGstlSY+vlTH7CvjwTVpGHPPoHezbKuQBuy?=
 =?us-ascii?Q?l4AVoGbZo+ajKbSDHlXKZ5wFx2Vps5YQ21pFBdKJWOhRqCRmYmSKOvni7Ojr?=
 =?us-ascii?Q?29TkZEfsZm9t7Yk+Lh2Z0Oq7GoXi1J4H8+VStXMCjGBGSHzt0T6jxY2Gb2Ox?=
 =?us-ascii?Q?Af6NKE06I9NB68+dxvfJyM9ar20U45O5wP/V5SjLuKwMnMa/OW/KmW+TE8PC?=
 =?us-ascii?Q?4s63wJh5TN8Lldqc0UdJkRv9mMDZIWXpKVD6D4y/MxXsQ3eQU25aGI1T1Zix?=
 =?us-ascii?Q?LGCB0lzXYuUES++zR8gijQ+qOlav5f/wDCD0wGyfHo1f3BQvEgdpIZmP6JDh?=
 =?us-ascii?Q?8KyPYGdVyjlJFhEoI+KrNXUBSFwFy66nNFsoANeb3aI7EUlfTbyTFZIUY3pA?=
 =?us-ascii?Q?ZCDRZYM880oheUekVQnnKcAkvz5hlCTrC5zH7GHNDwRR24C7StElYysD8Huz?=
 =?us-ascii?Q?CvsOlR5PLiFgEnNrYtd/JOhxP4b6sPIY6RMAgh3KkqWq7VVnRuBjsR46v79t?=
 =?us-ascii?Q?NAPG8SVZNdz+z4on4VJIFUwNs17Gj4OoW4C0dxZNB/qfpL3OjHXtfOJv1V93?=
 =?us-ascii?Q?WHmlbEAtg9QzN4A0bXMdrqbqgnxuxaI4Hg2KL1SOsYWyUkxiIl7y/DWfWJ11?=
 =?us-ascii?Q?LBFJdZfYqrjvFLwWg7rpss0k57a4KAMkxiWVQkQueZ0ewIO9e4wAasRniZn4?=
 =?us-ascii?Q?kuHqtXfoMCRCHVKDVPzxh5F54nNXqRfHByBRbxMGMK29o31jiVvY2vI2wMG5?=
 =?us-ascii?Q?CYyMWMMki8g4Rn7EfF8MWlZbTW/TETyNjctNFFhgeF5cMD7w2hwadu1oVIrg?=
 =?us-ascii?Q?JchIbKS2O4W/N2K1tussHMyUU8t7I28PWdm9AlJyTnKd2C/O4P6peqoKqRdO?=
 =?us-ascii?Q?eqqeUWeohUU9d7hKJJvDTmCcfQUCgRZsT+Czdy7pyRs0eHrJ5wgWwLKkFKzr?=
 =?us-ascii?Q?b/5GPQGlgMH5vyoo0AegUMdRZmie4K8dliSdJ7kRxF865uygVMd4o3bnwuiy?=
 =?us-ascii?Q?NIf9nh9Eb8T4uwzoxr1h75lpHrtOeSbReQ4UwD6x1pMAEukTugDvJYgXRqcO?=
 =?us-ascii?Q?+BuhD+s1uKyaB1qIwN/wLOf8szLb19lROoiRR4W78idfYa/CXQyF9kZ+9aCy?=
 =?us-ascii?Q?ybZqtSvGCtSjUnou0GkcO2zstook3ORnyRcMFLE4mCWo7+Lyykxalo36erKl?=
 =?us-ascii?Q?+JVT/CnQDi49rvS04ygMkrhVOMA/UO9/ajA6S75mze83?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2bc05-600f-4495-9bb9-08dd58347d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 20:14:22.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbrxEc9O2gipyyMGiBesF1wwmGxR34qnhwePA+r2K28hecVg5xyGzGKugELChjk9KsRujBfljhfAFjc4HNc9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D7B

> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Wednesday, February 26, 2025 4:46 PM
> >
> > Hyper-V may offer a non latency sensitive device with subchannels
> > without monitor bit enabled. The decision is entirely on the Hyper-V
> > host not configurable within guest.
> >
> > When a device has subchannels, also signal events for the subchannel
> > if its monitor bit is disabled.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/uio/uio_hv_generic.c | 30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/uio/uio_hv_generic.c
> > b/drivers/uio/uio_hv_generic.c index 3976360d0096..8b6df598a728
> 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -65,6 +65,16 @@ struct hv_uio_private_data {
> >  	char	send_name[32];
> >  };
> >
> > +static void set_event(struct vmbus_channel *channel, s32 irq_state) {
> > +	channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> > +	if (!channel->offermsg.monitor_allocated && irq_state) {
> > +		/* MB is needed for host to see the interrupt mask first */
> > +		virt_mb();
> > +		vmbus_setevent(channel);
>=20
> A minor point, but vmbus_setevent() checks the "monitor_allocated"
> flag, and if not set, then calls vmbus_set_event().  Since
> monitor_allocated() is already checked here, couldn't vmbus_set_event() b=
e
> called directly?  The existing code calls vmbus_setevent() so keeping
> vmbus_setevent() is less of a change, but it is still doing a redundant c=
heck.

Will change it to vmbus_set_event().

>=20
> > +	}
> > +}
> > +
> >  /*
> >   * This is the irqcontrol callback to be registered to uio_info.
> >   * It can be used to disable/enable interrupt from user space processe=
s.
> > @@ -79,12 +89,13 @@ hv_uio_irqcontrol(struct uio_info *info, s32
> > irq_state)  {
> >  	struct hv_uio_private_data *pdata =3D info->priv;
> >  	struct hv_device *dev =3D pdata->device;
> > +	struct vmbus_channel *primary, *sc;
> >
> > -	dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> > -	virt_mb();
> > +	primary =3D dev->channel;
> > +	set_event(primary, irq_state);
> >
> > -	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> > -		vmbus_setevent(dev->channel);
> > +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> > +		set_event(sc, irq_state);
>=20
> Walking the sc_list usually requires holding
> vmbus_connection.channel_mutex.
> Is there a reason it's safe to walk the list here without the mutex?

You are right, we need a lock here. Will be adding it.

>=20
> >
> >  	return 0;
> >  }
> > @@ -95,12 +106,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32
> > irq_state)  static void hv_uio_channel_cb(void *context)  {
> >  	struct vmbus_channel *chan =3D context;
> > -	struct hv_device *hv_dev =3D chan->device_obj;
> > -	struct hv_uio_private_data *pdata =3D hv_get_drvdata(hv_dev);
> > +	struct hv_device *hv_dev;
> > +	struct hv_uio_private_data *pdata;
> >
> >  	chan->inbound.ring_buffer->interrupt_mask =3D 1;
> >  	virt_mb();
> >
> > +	/*
> > +	 * The callback may come from a subchannel, in which case look
> > +	 * for the hv device in the primary channel
> > +	 */
> > +	hv_dev =3D chan->primary_channel ?
> > +		 chan->primary_channel->device_obj : chan->device_obj;
>=20
> This certainly looks correct and necessary. But how did this work in the =
past?
> Wouldn't DPDK running on a synthetic NIC have gotten callbacks on a
> subchannel?  I'm just trying to understand whether this a bug fix, or if =
not,
> what new scenario requires this change. I'm not understanding how this
> change is related to the commit message.
>=20
> Michael

In the past, host always offers sub channels with monitor bit enabled, and =
the interrupt mask on the channel is always set so we never got callbacks.

This has changed in that the host may offer channels without monitoring. Th=
is change also requires patches at DPDK netvsc driver to work on unmonitore=
d channels. I think it's a new scenario that requires changes at both ends.

Long

>=20
> > +	pdata =3D hv_get_drvdata(hv_dev);
> >  	uio_event_notify(&pdata->info);
> >  }
> >
> > --
> > 2.34.1
> >


