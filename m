Return-Path: <linux-hyperv+bounces-7142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75ABC623A
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD103C7B8C
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856F2BE7A3;
	Wed,  8 Oct 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R+W8JFHL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022080.outbound.protection.outlook.com [52.101.48.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6C29BDA3;
	Wed,  8 Oct 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944035; cv=fail; b=LAoMYpSp9Q0S4FortJ3vuIrjiBFfBf7nNcJDfiC5JyExeR/qIgd0hv0QVbHUGAYJGf+7BWnyhXDU5oJTy5/hbrDhNCuTl+PGN/BapQHsLO81aL4gTHYD3/5cB831Ic/BLXNJA2LMWyiw/ZoNoWsPZlkRysczWLinX4oBUG16Uqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944035; c=relaxed/simple;
	bh=6pSUCKJitXI5RWp/RUX/USx+no+JQTAFRy0IYmpCSPs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFkaGuFsNfUr0yYojtxNm/UPnLQeiRyXGp3R2h7D2jNQefI/ZXl5MEruntogVjvhO87PWaOrg/fuoo3arUYt8dotSXNZ51KfT7vTOHxNjUtKf7svCZVfa1H/l6n+Qvnqu5IxiO3BMyWkEAvGXDBRmhC1PkxL8nyF8XpHAlob7sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R+W8JFHL; arc=fail smtp.client-ip=52.101.48.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1N5fGK4QZ/uE5E9xy07TyM+gUySKXc3/bLxWuyOM0DEuppcBQSEyauqKjo8rFj5qc0gQIdNRVvKodK3Mgt7sQ182An1tPYZdi86X6NllWF5bLeyd43/VkTos8ICLFgNDj++UCeBwo09fsmWwa0b4GSL/g+yjeynHUcM4RHSsLhxVNY0yAkUIQtvlIH7+hv9mZYtr+U9f1XEl2WmTZzIzS+1u3TBxbj4JNIGbkZkrVURfyHSvZVW0LlcGf7h+5uM843miLEwGKYHrlkW3nkV2uF1kuXN2EN271G68LV5Ot0IEGN5saGpfUwuZu/HuqhicX2V+cBD44xZvRM/MvAjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKggIdbm/alAbDUOnkOU/Z5nMsNKjdXwqdSZEr3vuc8=;
 b=jeC4eH7Tr5vZ6IlcwSPrnyEr+/XyF2fP3qeQ1cW9y1eOWNB5Yzkgzcq1GveoxVBrWXCY8VvpI6QVRM252Lu8ydEnvKhUSzej1EzMEOlC3Pq4vmq+VVE9Bi16XkIrJibpIrDrwB4WhyfNhrStlhc/e/FT2/ewFfPva2BCpM1rl6hIUjVozAStj6bm/BxgRmfcExMFIev9vv++wjmJsI7b2ZGj6GJWZNzY6ScA956gNFnU1EQ31N85hyvqp8deXAI8+ZtvgBNasZMPV4riOIH/N6m9xvdYvst19x3PILS7LQdMdL1nVPWAk/FMJsVxeQ3Hxqbinz3vKF5LaVw/hWmgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKggIdbm/alAbDUOnkOU/Z5nMsNKjdXwqdSZEr3vuc8=;
 b=R+W8JFHLgq3lwh4kv+Lli7ShiegSFUMe4m47bkBOsuOguMjpUNRSg84YljDxJSa60RbxRbznS0pxFr3AOztdG+psCrvTsr7ZcNus1Q/tiYadOnT5ky8vGXjvFYpYWBafTPRvSSxVVTxQkjvmL0qwmuN5lb4FneYmv+t93Bn249w=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS7PR21MB3316.namprd21.prod.outlook.com (2603:10b6:8:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.3; Wed, 8 Oct
 2025 17:20:28 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 17:20:28 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU
 as on the I/O issuing CPU
Thread-Topic: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
Thread-Index: AQHcM1o09s0JbTr1WEyxyj44s5hnfrS22w6AgACK7gCAAQRdgIAAG7JA
Date: Wed, 8 Oct 2025 17:20:28 +0000
Message-ID:
 <DS3PR21MB573597BFA650534306FCA5CACEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS3PR21MB573566DF7A81D555552DE8A7CEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
 <SN6PR02MB4157F816858A01D480FB203ED4E1A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157F816858A01D480FB203ED4E1A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1cf71a9b-5da0-4d36-8afb-a428d2ab4a7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-07T23:58:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS7PR21MB3316:EE_
x-ms-office365-filtering-correlation-id: 8064f2db-1be4-492a-b6a7-08de068efa58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bayDmmfz3BvFZOAzmXvamIJnI90gZbVDDU5fp9Py+7r5w6zTpkEzpKfiWr4X?=
 =?us-ascii?Q?fgXeN3DIliIu9fn/GUCEPNO/gdKysC+g8GldYnNzLSQg55XEzv2VpyVGxTlO?=
 =?us-ascii?Q?xGgq/ys8cbir8tzd8s9nEw4MvrhuE9MmXXbp0Y8DZ4St+i6QxFBwi8AJ+Bdj?=
 =?us-ascii?Q?E7RLuVly4P/M4eaw+FYNA8XU6YZH4LPdt8Ck+19xkuJz7776940DR7WAIijM?=
 =?us-ascii?Q?TFy4Q+0hqapqBY03DsJEqtEgakt32YS+ywoTH5tcRUZ1/MtjmzDFF3Nob2rn?=
 =?us-ascii?Q?nasn/i3GE2HtxdYVXqEIdaZbiIqYYUwE6PIk9O5H4gA4oIYCQrSOoRkiHQUW?=
 =?us-ascii?Q?DRqbp7hidqZOdp6taMg9Sq6F/uXm5IdpyK109R6REFMyyoPoBc9B4Afuu3Nr?=
 =?us-ascii?Q?AIZjqMIG3RpvRlNKqxxMH7u/X6JDiNpVl0LNqeKMo1i/hMy3JRLyunfUnDZf?=
 =?us-ascii?Q?LZAq/jHIqag3g8GoqNQ9oBeG7xZagxvDTPazKN/9DzsDRiGOF1fYRtfJA/Al?=
 =?us-ascii?Q?q4DxGw1u3Vzd2wv8pKk/mlNNgWIderICHESpiGnd5rVEjnEcP8UuijOWriTP?=
 =?us-ascii?Q?8vr0W8TPUr7ltQemfACYpuix6hgIy9zI+vCNKblnkHFjE+uLEHK8hh4x5V1w?=
 =?us-ascii?Q?J7ZcQ1GUpj1XtLKKxDGpoCKWCnAimbuxE5JYLXgPFWAObDenNcXVBUlYWv3A?=
 =?us-ascii?Q?6YoEO2BQW1WJncDcF264T1XUzebY5EMtSr4rfqNv1pKCZCOhEWgzLGzcDHKv?=
 =?us-ascii?Q?yV+QBejNw7TiId4MTEbBawfsImdoeIArV6SKcaSzXhXi4rfeEig+SGj7tYyw?=
 =?us-ascii?Q?EsV4E4c+DmRNYO1PusHfimRyM9kRPDDXp1IU2GB54vitvuELRtCJP3lSymFs?=
 =?us-ascii?Q?dxkE6aVwaK8WfgzdnUDt1iILJUA7fZ3UzaH6TjDEv6bL9yVH8Yok9vGrw3Vo?=
 =?us-ascii?Q?JwI0LO1CVeCG+mOCSaGb42vrG9Z7pMr6YSv33o9Jm0kskapKVRphfdAa0CTJ?=
 =?us-ascii?Q?I9EFZ+dqeE4im/8qWDDk1vKRvC8U0rITXfNUXny4HsFSFOhi6+f4bPCxKNCo?=
 =?us-ascii?Q?HCooVfd5i2WNhSPyXpdCLgJxcKIpgMNGSVNx511u5u/HLVX6V8T8mwKWPPTx?=
 =?us-ascii?Q?UI2bDx1yfPcxu2QgqOZJg0IR5eqlgmZyUmt0EUbNAeMX09gj9ZLyXpUaQaVe?=
 =?us-ascii?Q?E8gH42x+k/9LqiaNiBh5CjWTbraM+aKdeyn2ghNfL8duSSGdWXAKjPrCFNDk?=
 =?us-ascii?Q?tgV6fKtEWehg+kp/3uii4xksIDKWn0W4dtkPZHDT5KqQVUl+bHDGAADmCp9X?=
 =?us-ascii?Q?cqUTOAABV9m02kG6PRa2MKGBCKDqM7B6yJZeHRcgPLaTaGszL+vZz8CqWJUQ?=
 =?us-ascii?Q?2ik8Jm5gfqkpLM7Yr1OsYm/p1QfFbuOXOIVxPVpvY/HqPZSVgZoTvEYbJWaw?=
 =?us-ascii?Q?LC7lXWxuH/8VT9pBuYbbkmdTsP1ZV+IBDCL9C+wMF3+47pVRByY+oaPJlA5z?=
 =?us-ascii?Q?Xv5ruAnKfLVhwMupJ/c1RfSnA0mzjAasmn3UExHqzVcvcxQ4N+uhAFf+9A?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vrNW3x7dBCKJwiBdEYDWlNtMqMxmstE56WJUVCZ/aJJ7bYghaI97R6aVocKI?=
 =?us-ascii?Q?2wIWPlord/8s4y8Q54lpL/ja/WquA48l92VBfK0b7XLPduJ0xylkHsnJdU5Z?=
 =?us-ascii?Q?T40sbFnmw8zMYOrh3y1ptoKejTUrHVLYgl1XV2cKP89kFBnzpqP15prT9ar+?=
 =?us-ascii?Q?D+zlp9I+pPqr4G2hMMA8zwfWvJdKDF0OSQsb1qC+NqZHDEVLkc2aOxmWil+e?=
 =?us-ascii?Q?88Gfd26gkTefHZaUFe45hmy2ZJDKdnAyr+VEX76ixg3Iw/s0ffTKQDJBS34G?=
 =?us-ascii?Q?Rpf3SQcFNOZrFFeGlnhNT+Xe6Dit7kF6vhzYW5wqot/aNEjYMq//OrPZeKHz?=
 =?us-ascii?Q?Z0FAXgtLZeru54cRbRVfempw3pkbEwYx5xBJh+w6W9h0CIqyA2MDCXqApurw?=
 =?us-ascii?Q?Yv54rBd7fQTeJ7VD514I3cAaoTs/nIvl/cZIyfN4q5I70E0qOzr0HzY9qM5h?=
 =?us-ascii?Q?4WlofX9ODqNCOtygYz2YLq9rgf6LT/fgIkC4303hLZQdETugmm8FRbRwu6xg?=
 =?us-ascii?Q?gnFqYC/hZ8jACzvw+QfAIg1D+9/k6HlUSFAHShSKPIxIKol5XPMN8+/L9KPu?=
 =?us-ascii?Q?oDYG1Jq0pKxkhVDJlTi/fkR/EDbzOYUV3xcDLIeU6WXFaeMjp3Kj2rlH0RT/?=
 =?us-ascii?Q?reqiP+RDVieKuK1IktplDCoDe9Ge2Hq15Ar0muapTUzXRZczw7DieHBKS6UO?=
 =?us-ascii?Q?pUuieX4bFu/4/hF9luUhxRB3M0eo5BC9Js0/7mZ6pPZihfsVtYYW1fCoC/Xs?=
 =?us-ascii?Q?4ILNoyAD4JOOAYijpBRegCWbJRv856aIDk6kpEmJEI3oVVS0FVJBB8VSURii?=
 =?us-ascii?Q?S445uPuDCqiTTlCK+1ocRPMXdayCixgL0cE/la1jW1Ee/uyS4injhiVlrHEE?=
 =?us-ascii?Q?XO5OBCQT/CSfgzThnmxwutQfSR9oKj2pnTy5W2pZgXVU+iUpD4zY1TMQHcJ+?=
 =?us-ascii?Q?hFAlQoIYktTsg3IqlnkmWU3SbDl764MshRZIX13bGdQXuROdDdOzrMZLOndI?=
 =?us-ascii?Q?VNnylteISqX3+Lu6JF2BFBx4BW5DLT6a0HTNYAv6XHXtEXBCLw3IRcK7iJcO?=
 =?us-ascii?Q?HojX4B7xVGKUlEeiC7vu/MwMmeyXw0bv3e9rNvZ1kqdQRFQf3FfA8mc3mTEE?=
 =?us-ascii?Q?S47GoR+Vh+/gN/f44Ap2ZJUvWt2JVVD+lykTEGhLtyfFrZyamG8pSMPy2cul?=
 =?us-ascii?Q?8jgzrOMoEBQXrzgBOAUPCxN/Y6wQziRkyBxYABN7MkBv0X8uTAHhIzSwb0bX?=
 =?us-ascii?Q?S84txPi++KdJrs15PtGjY/iupY66w34Nw3SyZze9siTEr3PmKgYz3FjpXgIa?=
 =?us-ascii?Q?vkTeczx2cJJag2lY4HwXKEjBtyhCNhDy2pzRgYnE1/Lgao3mxZC984EhHoUK?=
 =?us-ascii?Q?cxdO84eL+hk1MB4mz9bDwPaXUjzKI6Ts/X9wjUJQ4AH7TUUjSUTdVdVh6VKH?=
 =?us-ascii?Q?A3S17RkrDHesQjXMGJQl6pf6LvVyCse2kDr9kR6Xt4PKc6ER0a32ml/WmWKQ?=
 =?us-ascii?Q?s5wguL57R02t/PdSbrE5ZzuUrY9A6CTOzxfeQ30zhsF9l9iBg8JIPtxS8BWU?=
 =?us-ascii?Q?ZF6wpc7SKMtE0tJIkIY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064f2db-1be4-492a-b6a7-08de068efa58
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:20:28.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMhtmQ07WhYFt+SUVhUGZA5KtCLXtjVvpiavKk9HZhhrwQ0QTD5d0va74XBUne/wSg9x/0vzv3ZPmON9nQ6HlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3316

> Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning channel w=
ith the
> same CPU as on the I/O issuing CPU
>=20
> From: Long Li <longli@microsoft.com> Sent: Tuesday, October 7, 2025 5:56 =
PM
> >
> > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Tuesday, October 7, 2025 8:42 AM
> > > To: longli@linux.microsoft.com; KY Srinivasan <kys@microsoft.com>;
> > > Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> > > <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; James E.J.
> > > Bottomley <James.Bottomley@HansenPartnership.com>; Martin K.
> > > Petersen <martin.petersen@oracle.com>; James Bottomley
> > > <JBottomley@Odin.com>; linux-hyperv@vger.kernel.org;
> > > linux-scsi@vger.kernel.org; linux- kernel@vger.kernel.org
> > > Cc: Long Li <longli@microsoft.com>
> > > Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning
> > > channel with the same CPU as on the I/O issuing CPU
> > >
> > > From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent:
> > > Wednesday, October 1, 2025 10:06 PM
> > > >
> > > > When selecting an outgoing channel for I/O, storvsc tries to
> > > > select a channel with a returning CPU that is not the same as
> > > > issuing CPU. This worked well in the past, however it doesn't work
> > > > well when the Hyper-V exposes a large number of channels (up to
> > > > the number of all CPUs). Use a different CPU for returning channel =
is not
> efficient on Hyper-V.
> > > >
> > > > Change this behavior by preferring to the channel with the same
> > > > CPU as the current I/O issuing CPU whenever possible.
> > > >
> > > > Tests have shown improvements in newer Hyper-V/Azure environment,
> > > > and no regression with older Hyper-V/Azure environments.
> > > >
> > > > Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  drivers/scsi/storvsc_drv.c | 96
> > > > ++++++++++++++++++--------------------
> > > >  1 file changed, 45 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/drivers/scsi/storvsc_drv.c
> > > > b/drivers/scsi/storvsc_drv.c index d9e59204a9c3..092939791ea0
> > > > 100644
> > > > --- a/drivers/scsi/storvsc_drv.c
> > > > +++ b/drivers/scsi/storvsc_drv.c
> > > > @@ -1406,14 +1406,19 @@ static struct vmbus_channel
> *get_og_chn(struct storvsc_device *stor_device,
> > > >  	}
> > > >
> > > >  	/*
> > > > -	 * Our channel array is sparsley populated and we
> > > > +	 * Our channel array could be sparsley populated and we
> > > >  	 * initiated I/O on a processor/hw-q that does not
> > > >  	 * currently have a designated channel. Fix this.
> > > >  	 * The strategy is simple:
> > > > -	 * I. Ensure NUMA locality
> > > > -	 * II. Distribute evenly (best effort)
> > > > +	 * I. Prefer the channel associated with the current CPU
> > > > +	 * II. Ensure NUMA locality
> > > > +	 * III. Distribute evenly (best effort)
> > > >  	 */
> > > >
> > > > +	/* Prefer the channel on the I/O issuing processor/hw-q */
> > > > +	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
> > > > +		return stor_device->stor_chns[q_num];
> > > > +
> > >
> > > Hmmm. When get_og_chn() is called, we know that stor_device-
> > > >stor_chns[q_num] is NULL since storvsc_do_io() has already handled
> > > >the non-
> > > NULL case. And the checks are all done with stor_device->lock held,
> > > so the stor_chns array can't change.
> > > Hence the above code will return NULL, which will cause a NULL
> > > reference when
> > > storvsc_do_io() sends out the VMBus packet.
> > >
> > > My recollection is that get_og_chan() is called when there is no
> > > channel that interrupts the current CPU (that's what it means for
> > > stor_device-
> > > >stor_chns[<current CPU>] to be NULL). So the algorithm must pick a
> > > >channel
> > > that interrupts some other CPU, preferably a CPU in the current NUMA =
node.
> > > Adding code to prefer the channel associated with the current CPU
> > > doesn't make sense in get_og_chn(), as get_og_chn() is only called
> > > when it is already known that there is no such channel.
> >
> > The initial values for stor_chns[] and alloced_cpus are set in
> > storvsc_channel_init() (for primary channel) and handle_sc_creation() (=
for
> subchannels).
>=20
> OK, I agree that if the CPU bit in alloced_cpus is set, then the correspo=
nding entry
> in stor_chns[] will not be NULL.  And if the entry in stor_chns[] is NULL=
, the CPU
> bit in alloced_cpus is *not* set. All the places that manipulate these fi=
elds update
> both so they are in sync with each other.  Hence I'll agree the code you'=
ve added
> in get_og_chn() will never return a NULL value.
>=20
> (However, FWIW the reverse is not true:  If the entry in stor_chns[] is n=
ot NULL,
> the corresponding CPU bit in alloced_cpus may or may not be set.)
>=20
> >
> > As a result, the check for cpumask_test_cpu(q_num,
> > &stor_device->alloced_cpus) will guarantee we are getting a channel.
> > If the check fails, the code follows the old behavior to find a channel=
.
> >
> > This check is needed because storvsc supports
> > change_target_cpu_callback() callback via vmbus.
>=20
> But look at the code in storvsc_do_io() where get_og_chn() is called. I'v=
e copied
> the code here for discussion purposes. This is the only place that get_og=
_chn() is
> called:
>=20
>                 spin_lock_irqsave(&stor_device->lock, flags);
>                 outgoing_channel =3D stor_device->stor_chns[q_num];
>                 if (outgoing_channel !=3D NULL) {
>                         spin_unlock_irqrestore(&stor_device->lock, flags)=
;
>                         goto found_channel;
>                 }
>                 outgoing_channel =3D get_og_chn(stor_device, q_num);
>                 spin_unlock_irqrestore(&stor_device->lock, flags);
>=20
> The code gets the spin lock, then reads the stor_chns[] entry. If the ent=
ry is non-
> NULL, then we've found a suitable channel and get_og_chn() is *not* calle=
d. The
> only time get_og_chan() is called is when the stor_chn[] entry
> *is* NULL, which also means that the CPU bit in alloced_cpus is *not* set=
.
> So the check you've added in get_og_chn() can never be true and the check=
 is not
> needed. You said the check is needed because of change_target_cpu_callbac=
k(),
> which will invoke storvsc_change_target_cpu(). But I don't see how that m=
atters
> given the checks done before get_og_chn() is called. The spin lock synchr=
onizes
> with any changes made by storvsc_change_target_cpu().

I agree this check may not be necessary. Given the current patch is correct=
, how about I
submit another patch to remove this check after more testing are done?

>=20
> Related, there are a couple of occurrences of code like this:
>=20
>                 for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
>                                   q_num + 1) {
>                         channel =3D READ_ONCE(stor_device->stor_chns[tgt_=
cpu]);
>                         if (!channel)
>                                 continue;
>=20
> Given your point that the alloced_cpus and stor_chns[] entries are always=
 in sync
> with each other, the check for channel being NULL is not necessary.

I don't' agree with removing the check for NULL. This code follows the exis=
ting storvsc behavior
on checking allocated CPUs. Looking at storvsc_change_target_cpu(), it chan=
ges stor_chns
before changing alloced_cpus. It can run at the same time as this code. I t=
hink we may need
to add some memory barriers in storvsc_change_target_cpu(), but that is for=
 another topic.
=20
Thanks,

Long

