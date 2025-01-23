Return-Path: <linux-hyperv+bounces-3759-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C8A19E3F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30401612D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDD1BFE05;
	Thu, 23 Jan 2025 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Uk4MYI60"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020138.outbound.protection.outlook.com [52.101.85.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8E1ADC75;
	Thu, 23 Jan 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611586; cv=fail; b=dyzQemcRXsYCBPvF0semZDUFbxOeIDRh9HVES9LGBsHESLSHgbE1iyLGe+VESg7cuQo+jNQRlSbZlXfBBfzFDC29B1UxteiTs4thbrR37CPBmGmYnMA5MeHOQMHtHZoymBuXOytLZmRsbtR0aHTT0v3a8LYNJx5Wozzy7SkhP2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611586; c=relaxed/simple;
	bh=7kyXORLxC/L1tmBRhOo7uJvmkI2vHMyfHj+ZIYxoF1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WllBxIzQI1VZfQChp9qzAdVuT6hya0f3qapgcreKWQ/Aa6ay1TWlOo3ea2CW3wBGgj3EJU+/r1Mp4+0A0bYV7kLbrNc8i63qpY/LkclBgodiznw5dNbFmsOpT+h1xGpNq+HJAl9V1x7b1gFaYzwELIrQE6v2AITr4OMa8WHz7W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Uk4MYI60; arc=fail smtp.client-ip=52.101.85.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwe0DnL17DiF2BVYsZcYuyd4dT22TAZJu/E3U/y3EnPYXDKwtmp6r0mOSSxvcweUYIPKU+Xx5jUKKwffeHv26392rCP2CArDj7Rv3R9Tf7kmRjK3wEv7nNuz/9qvrp7GA0aII+PAUqXFMakTyOY0FTEPGpq9WoaOevPmxjjiGzTYYuPtPa2GJcPgq/wBIk6jIqZvkjPyZjJsMWPrdNoXaeERKYRXIeLvOB7jM2orK3t5aaDdCrJ6rHH+TV6qdbdsW05kPhn17ImdEjn/j4pVcKnLYE9QlHz6hri4JKHYexcudiCqw2kEwjdfGHysGEYxo7NeKDdmV6Mkl/M/zMIniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV2RfFzyikF67NECTgcjzUDTM/b2hCejrqO21T3dGzE=;
 b=QTPsRAHVF/gQljAHXXXJk3MxTr26TRADJZv+AryRNhAQz7m5VI1/viqJ8sotHOC3NVGLCzF2NVv67+Hb18wqLmpMaHvvU99JdxJ7/gB9rDtGlQFmK+VffNEYdfNO4SqvWiYBG1AGFfZdxDURi2wsLtvO6vVqMqm7ICpmX+ea3YtQL/yMPVLuT9uaE2+SXK43CEB6yC3/asL5vW0F9TlOKehOGGZxCTd8g6Ah662UGM8/KK0IHYVXWbG09tNYWOYFfqqIxaoKFEsUFSHasVQXLYepuFRiRW4sYfL2RR/KFfjFB0vEf+5WVYW6VUppzNkJWW3KFo1x2ss9Wmcif/gzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV2RfFzyikF67NECTgcjzUDTM/b2hCejrqO21T3dGzE=;
 b=Uk4MYI60ePa8zLARO9auSGbckIMKOHtt5VFHMzKWTeuEm/xXthP4eo8Lg+6yUDbzun3zUzYShl5wYfh9yCxH9l/ugaelZ4+bDDsBD862qqqFCXbZ0PZQrDbvRvvXgSsT4vIM9AcKqsx5A6y6HspWPJJ7VAGK9R6r8pWL+mcqHUQ=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA0PR21MB1867.namprd21.prod.outlook.com (2603:10b6:806:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.8; Thu, 23 Jan
 2025 05:53:02 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:53:02 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 07/13] RDMA/mana_ib: create/destroy AH
Thread-Topic: [PATCH rdma-next 07/13] RDMA/mana_ib: create/destroy AH
Thread-Index: AQHba2CXw6B8TtYZkUyX362Vsp4/s7Mj31Fw
Date: Thu, 23 Jan 2025 05:53:01 +0000
Message-ID:
 <SA6PR21MB42310E90D6E91C458FE77D1BCEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-8-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-8-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=01c5a870-50cd-4e04-8a37-05860d6093cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:52:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA0PR21MB1867:EE_
x-ms-office365-filtering-correlation-id: fedf0899-3abd-4ef3-603c-08dd3b7232bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UmA5YZyfEEf9wUAcJ3GDTdd/Mc3LayzMmFh/Rgzqsws7w/FZbMFsv/YKQb3Q?=
 =?us-ascii?Q?pXxFNucVqUyGLykmCYrSKFe9llKZV59//rap2WKbE/kp2knwXTFatr8TiSiE?=
 =?us-ascii?Q?5zxA2W6vo7dWHc0uFOK5PtKpnKjf8oY/SVlu6pgImDXnpUx/IxNlUK7TnvBJ?=
 =?us-ascii?Q?/9raxIX6mzFrLfSP2nayywucMRoCnkUnsT/CaZN9vnI1y64YLzmmBGvKz+hE?=
 =?us-ascii?Q?ACnMo7YazX/JgrVkN4amEnmsCjAAJkPWfUbyq8pBWwxbMhLiyA8SmseazJOi?=
 =?us-ascii?Q?5uJvL7HbB04w8T/IYyt1pMIg/eh6esgvAnwPjMPoUfxUJhfXLDpDh7kDeKyn?=
 =?us-ascii?Q?OUl5Gsm1ShDtoJPPssvVzxxEgTaVD1g+sGtTxbRKRFDT/t2ehmCzJFyZPhB/?=
 =?us-ascii?Q?kv9FQpH22PJVOZZVapl3VduyVzgEYQhc/fFeFbuIYZiTpWdcogqAiO5VpO4i?=
 =?us-ascii?Q?nRuGIouf07oT1tPiMy72FOu0xByqfilIzxObO2cZQSGLME+jNh687qpaaZci?=
 =?us-ascii?Q?/t36z6zdb4zGAeux/v+OyQHIOCIA1S5X1Y1gvtBmEcYlcZjL4/5feZqVe+56?=
 =?us-ascii?Q?dYgBOWCF7nvIkJwzS3gwRhQGvZNwLoXml00/JzAEubN0TTtYK+ElFEpiBg9j?=
 =?us-ascii?Q?010CejwzSZPTNl+mMAjtcdqLJtpu2RpsE/Pdrs4B9s2ijPH2lS3ZecCGOxK6?=
 =?us-ascii?Q?TPvtc1X6QdvrjE3hGalpghxIks6jI1hYaIE8FfFKkYiB0Otm+LhiB/aJJ++V?=
 =?us-ascii?Q?L0E6VHQ4px5nUU+/TpFBIWfhTTEkLf3Erk7q3fGewecrWsGpr0VSxybpfwRX?=
 =?us-ascii?Q?GQF0Md4sx8e6SqCkAe2h7hCDgs4nJS6ispVYg5aaEfzg+msbr96d0rUjr6J8?=
 =?us-ascii?Q?nXcqKJVrvEKRndXibnq46tK6mceYQmK9uZMZSQ1eA3j/iQm0tJqD6zqwJlTJ?=
 =?us-ascii?Q?OoK3pHaZFsfW6uSfAxeFYICSB04uRFhHrQRC4ZC34oUHDh5i+IqDy5YVfo9q?=
 =?us-ascii?Q?s3cZQKjMJhLBQurY4/Tc5t6+eP0+JIyF2VuFR6Qkq1wvpsCacqOrezcwoxuT?=
 =?us-ascii?Q?Nkuot8XIkKI7cI8nKuAkcOLipU9Q0B8DGE88+0OGWCIhyxkfM8RW4pkYAtoc?=
 =?us-ascii?Q?O9lidgloK8prpFwU4ZEov5k/1KKIGnWY14+JHQinS9TXvR67bTUAmO0hnQLK?=
 =?us-ascii?Q?0WM20lTfn9K3VQfjqS2wmLJ1AJWQDUBcaYCzEKLBM1BOhI3kODPIKFRdD5s0?=
 =?us-ascii?Q?CKiw+jqmTdTfpLGEr9fnHmd28PJ7bBp0VL/bRChHWZOCN1qXHzLX4YPlXZhV?=
 =?us-ascii?Q?Wh/i/6o6E48yOUvDC+p0jCHe4u2OVCTOZoVxXw39tIh6M93m4Ha8lD/c6ZWZ?=
 =?us-ascii?Q?KCzFzSGjlvfaP4MlHgpsLVAULSIEEXKOUeUoSBCFbfyLGB8q6wrD8W5fwB7Q?=
 =?us-ascii?Q?w7kN+w1N2swVyvkiL1+w2UGoZVY3Hpqe/fmsHi4dY7Qe6k4G6VDzZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PU9LXp1WFesSDtC7gqpBITneZkZHQ76ez6U5eqSrmGcEM50+u+XmBfHSJYoA?=
 =?us-ascii?Q?qYZb63+WgVuQzHf3qMNQ6pdpq8tG63/yJG5ktLDgSXL3v7DJN1RbcZ87ukiE?=
 =?us-ascii?Q?0501QATIQL2N+NIdov3xl4/jlkmOPnR41RRQtt3zjjxcNfG4VxwHGQIuxQwr?=
 =?us-ascii?Q?HpYR4npnxl3b/vYfgxomuOxA3jeX26+Jfv1w3iTR0fFg9EntTDK/s7Rcwa3q?=
 =?us-ascii?Q?VUqU7SWbk+hmu/muuNE8eUGHIjcQL8ggr2aYtaNUDPu8WHdEsKFhIQzRfThb?=
 =?us-ascii?Q?fIPQ5IUI+9Ylgyk1eJm3N3HBxz6BhuqGFAqzJhCs/mPp9WDaUve3tJsgpnDA?=
 =?us-ascii?Q?2QSyjMri811h+ctPUSz5f6kybaI4M9scyP9hD3BSTDOOJT9UBu2RCqvT33lQ?=
 =?us-ascii?Q?T5kx5O9i7CrdIcuBLabAy5XnzmWbVozuy7wDlZalXqDPFFAOA6n5LT5ZKkT5?=
 =?us-ascii?Q?gJv0NydCKRH0YFQhMyMQGZtWggD2FpQiHoxraNK0LyglVAhetCHRTHB1INPn?=
 =?us-ascii?Q?km7rrkrl6l6n3EL4x6abKcQwjjoeRsy1FuUNKvOtNqh23qBssLSOncdnnaaK?=
 =?us-ascii?Q?JBe73hs+eZ2uC6SiMKjvt85oZlmILJ4YGgtdC4F9O1qkBL3a6Z58gVX4Nbso?=
 =?us-ascii?Q?3v5PeEu+/x4GvN94Uv6JXAwP9GBfBAgzKKQMB30fOuFkDTNR3pOsvq0dYs42?=
 =?us-ascii?Q?XVIrqH39ugXgcCxpeKpretnMHLAgM6bEhU5YCWBs86xTVhOSJSYcub9j4W2y?=
 =?us-ascii?Q?NMd+h3bJ5gIatQ7H2k5PuEguLQkNWbXw11Cr7EbkUzaKhmAwUxDVGC2RZacG?=
 =?us-ascii?Q?gb2kqe41NviCm4jyxIRQNo8kXtojYz2lrqiBAJ1mYKGcjUzw1FahYR2FpVmx?=
 =?us-ascii?Q?gEytmlePhzvjn9CmVf4r1hTreRxBAXWQR45pVW0xWaJfg95yFt4ijQxNeb7N?=
 =?us-ascii?Q?YCv8YeoVV3W8wZEx2KGV50kmjYUdmBpd+qULle6Ae3PyefjlDziK60X9c61M?=
 =?us-ascii?Q?FAGFcyf/xqAsVOE6k3bCfYXGiR6+DQaZwbPzOAJJJ86XW3gAbOfNJvykuSH0?=
 =?us-ascii?Q?Pb3O7pwCagtsD+dacB6D6ipc2Hg2bdQPs46f8PHKtaD+pkSePTbwyzOBvDcI?=
 =?us-ascii?Q?0Mn8yid0NhGMadYyytV600tVh61psstQKqzUXIoymGjELP/KYehkUO0h0vOe?=
 =?us-ascii?Q?75Ha0FJ77iLrAayr2DHBmqMAF/BldSPebSTL77CshU91Yu6Kpqh3dw3rm0Qq?=
 =?us-ascii?Q?jD5qaYre5FApwA29qf23pAuCi9v1P15OIbGWjGJhhVtsKqPhvLw2DsOBK+ol?=
 =?us-ascii?Q?li9EvyWN61icRamHHMvdJD24AMuSAL2ZXKDXRE1hiZi+s+pH/T0scMMeSUQI?=
 =?us-ascii?Q?aLEKYTdun8OJjr7RhBmpdwdubH1uhZQaXhRwwUQpBgoiDOiSKD9jiWXDC6NN?=
 =?us-ascii?Q?vgcDB9VWmoMwUQ1upOu43uKSBerFhIjgqvXv672zMU45viRyjEbt+C4ezmqh?=
 =?us-ascii?Q?CK0l4TyDmb6DOvU7pShik4JUnoF3nXUQgm3KFVCAiQcRnLnsPfmtlg80dtUe?=
 =?us-ascii?Q?qEkgqCGwzfIil/zReerfUJ1dyCGYOlPpI9euzqHI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fedf0899-3abd-4ef3-603c-08dd3b7232bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:53:01.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqSTSmVA1eiL7C4LYRvU1v2QTXbDCsXZKpbqo/U+AInR/aI6HP8ViXVh8WBU/zQEXoKwBn3UK6ZDqmxLZK4dgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1867

> Subject: [PATCH rdma-next 07/13] RDMA/mana_ib: create/destroy AH
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement create and destroy AH for kernel.
>=20
> In mana_ib, AV is passed as an sge in WQE.
> Allocate DMA memory and write an AV there.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/Makefile  |  2 +-
>  drivers/infiniband/hw/mana/ah.c      | 58 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/device.c  | 13 ++++++-
> drivers/infiniband/hw/mana/mana_ib.h | 30 ++++++++++++++
>  4 files changed, 101 insertions(+), 2 deletions(-)  create mode 100644
> drivers/infiniband/hw/mana/ah.c
>=20
> diff --git a/drivers/infiniband/hw/mana/Makefile
> b/drivers/infiniband/hw/mana/Makefile
> index 88655fe..6e56f77 100644
> --- a/drivers/infiniband/hw/mana/Makefile
> +++ b/drivers/infiniband/hw/mana/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MANA_INFINIBAND) +=3D mana_ib.o
>=20
> -mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o
> +mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o ah.o
> diff --git a/drivers/infiniband/hw/mana/ah.c b/drivers/infiniband/hw/mana=
/ah.c
> new file mode 100644 index 0000000..f56952e
> --- /dev/null
> +++ b/drivers/infiniband/hw/mana/ah.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
> + */
> +
> +#include "mana_ib.h"
> +
> +int mana_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr=
,
> +		      struct ib_udata *udata)
> +{
> +	struct mana_ib_dev *mdev =3D container_of(ibah->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_ah *ah =3D container_of(ibah, struct mana_ib_ah, ibah);
> +	struct rdma_ah_attr *ah_attr =3D attr->ah_attr;
> +	const struct ib_global_route *grh;
> +	enum rdma_network_type ntype;
> +
> +	if (ah_attr->type !=3D RDMA_AH_ATTR_TYPE_ROCE ||
> +	    !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
> +		return -EINVAL;
> +
> +	if (udata)
> +		return -EINVAL;
> +
> +	ah->av =3D dma_pool_zalloc(mdev->av_pool, GFP_ATOMIC, &ah-
> >dma_handle);
> +	if (!ah->av)
> +		return -ENOMEM;
> +
> +	grh =3D rdma_ah_read_grh(ah_attr);
> +	ntype =3D rdma_gid_attr_network_type(grh->sgid_attr);
> +
> +	copy_in_reverse(ah->av->dest_mac, ah_attr->roce.dmac, ETH_ALEN);
> +	ah->av->udp_src_port =3D rdma_flow_label_to_udp_sport(grh-
> >flow_label);
> +	ah->av->hop_limit =3D grh->hop_limit;
> +	ah->av->dscp =3D (grh->traffic_class >> 2) & 0x3f;
> +	ah->av->is_ipv6 =3D (ntype =3D=3D RDMA_NETWORK_IPV6);
> +
> +	if (ah->av->is_ipv6) {
> +		copy_in_reverse(ah->av->dest_ip, grh->dgid.raw, 16);
> +		copy_in_reverse(ah->av->src_ip, grh->sgid_attr->gid.raw, 16);
> +	} else {
> +		ah->av->dest_ip[10] =3D 0xFF;
> +		ah->av->dest_ip[11] =3D 0xFF;
> +		copy_in_reverse(&ah->av->dest_ip[12], &grh->dgid.raw[12], 4);
> +		copy_in_reverse(&ah->av->src_ip[12], &grh->sgid_attr-
> >gid.raw[12], 4);
> +	}
> +
> +	return 0;
> +}
> +
> +int mana_ib_destroy_ah(struct ib_ah *ibah, u32 flags) {
> +	struct mana_ib_dev *mdev =3D container_of(ibah->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_ah *ah =3D container_of(ibah, struct mana_ib_ah, ibah);
> +
> +	dma_pool_free(mdev->av_pool, ah->av, ah->dma_handle);
> +
> +	return 0;
> +}
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 215dbce..d534ef1 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -19,6 +19,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.add_gid =3D mana_ib_gd_add_gid,
>  	.alloc_pd =3D mana_ib_alloc_pd,
>  	.alloc_ucontext =3D mana_ib_alloc_ucontext,
> +	.create_ah =3D mana_ib_create_ah,
>  	.create_cq =3D mana_ib_create_cq,
>  	.create_qp =3D mana_ib_create_qp,
>  	.create_rwq_ind_table =3D mana_ib_create_rwq_ind_table, @@ -27,6
> +28,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.dealloc_ucontext =3D mana_ib_dealloc_ucontext,
>  	.del_gid =3D mana_ib_gd_del_gid,
>  	.dereg_mr =3D mana_ib_dereg_mr,
> +	.destroy_ah =3D mana_ib_destroy_ah,
>  	.destroy_cq =3D mana_ib_destroy_cq,
>  	.destroy_qp =3D mana_ib_destroy_qp,
>  	.destroy_rwq_ind_table =3D mana_ib_destroy_rwq_ind_table, @@ -44,6
> +46,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.query_port =3D mana_ib_query_port,
>  	.reg_user_mr =3D mana_ib_reg_user_mr,
>=20
> +	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mana_ib_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_qp, mana_ib_qp, ibqp), @@ -135,15 +138,22
> @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  		goto destroy_rnic;
>  	}
>=20
> +	dev->av_pool =3D dma_pool_create("mana_ib_av", mdev->gdma_context-
> >dev,
> +				       MANA_AV_BUFFER_SIZE,
> MANA_AV_BUFFER_SIZE, 0);
> +	if (!dev->av_pool)
> +		goto destroy_rnic;
> +
>  	ret =3D ib_register_device(&dev->ib_dev, "mana_%d",
>  				 mdev->gdma_context->dev);
>  	if (ret)
> -		goto destroy_rnic;
> +		goto deallocate_pool;
>=20
>  	dev_set_drvdata(&adev->dev, dev);
>=20
>  	return 0;
>=20
> +deallocate_pool:
> +	dma_pool_destroy(dev->av_pool);
>  destroy_rnic:
>  	xa_destroy(&dev->qp_table_wq);
>  	mana_ib_gd_destroy_rnic_adapter(dev);
> @@ -161,6 +171,7 @@ static void mana_ib_remove(struct auxiliary_device
> *adev)
>  	struct mana_ib_dev *dev =3D dev_get_drvdata(&adev->dev);
>=20
>  	ib_unregister_device(&dev->ib_dev);
> +	dma_pool_destroy(dev->av_pool);
>  	xa_destroy(&dev->qp_table_wq);
>  	mana_ib_gd_destroy_rnic_adapter(dev);
>  	mana_ib_destroy_eqs(dev);
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 5e470f1..7b079d8 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -11,6 +11,7 @@
>  #include <rdma/ib_umem.h>
>  #include <rdma/mana-abi.h>
>  #include <rdma/uverbs_ioctl.h>
> +#include <linux/dmapool.h>
>=20
>  #include <net/mana/mana.h>
>=20
> @@ -32,6 +33,11 @@
>   */
>  #define MANA_CA_ACK_DELAY	16
>=20
> +/*
> + * The buffer used for writing AV
> + */
> +#define MANA_AV_BUFFER_SIZE	64
> +
>  struct mana_ib_adapter_caps {
>  	u32 max_sq_id;
>  	u32 max_rq_id;
> @@ -65,6 +71,7 @@ struct mana_ib_dev {
>  	struct gdma_queue **eqs;
>  	struct xarray qp_table_wq;
>  	struct mana_ib_adapter_caps adapter_caps;
> +	struct dma_pool *av_pool;
>  };
>=20
>  struct mana_ib_wq {
> @@ -88,6 +95,25 @@ struct mana_ib_pd {
>  	u32 tx_vp_offset;
>  };
>=20
> +struct mana_ib_av {
> +	u8 dest_ip[16];
> +	u8 dest_mac[ETH_ALEN];
> +	u16 udp_src_port;
> +	u8 src_ip[16];
> +	u32 hop_limit	: 8;
> +	u32 reserved1	: 12;
> +	u32 dscp	: 6;
> +	u32 reserved2	: 5;
> +	u32 is_ipv6	: 1;
> +	u32 reserved3	: 32;
> +};
> +
> +struct mana_ib_ah {
> +	struct ib_ah ibah;
> +	struct mana_ib_av *av;
> +	dma_addr_t dma_handle;
> +};
> +
>  struct mana_ib_mr {
>  	struct ib_mr ibmr;
>  	struct ib_umem *umem;
> @@ -532,4 +558,8 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp);  int mana_ib_gd_create_ud_qp(struct
> mana_ib_dev *mdev, struct mana_ib_qp *qp,
>  			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type);
> int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp);
> +
> +int mana_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init=
_attr,
> +		      struct ib_udata *udata);
> +int mana_ib_destroy_ah(struct ib_ah *ah, u32 flags);
>  #endif
> --
> 2.43.0


