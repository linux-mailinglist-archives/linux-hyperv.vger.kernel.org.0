Return-Path: <linux-hyperv+bounces-4895-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E6A88D80
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Apr 2025 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437FD17BC77
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Apr 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9C1B425C;
	Mon, 14 Apr 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JSGHaH7/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022109.outbound.protection.outlook.com [40.93.195.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DD1E1E19;
	Mon, 14 Apr 2025 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664231; cv=fail; b=p+jUl1x8XwCiTIUJyM71Ok+4qWug5wRnS5sigqaJ2xgJOMG3KTfHJzkTXSTFETCGOShyyyO2X4xxgfbdyWRHMw1GWQc+wqrAQ/woLBhmUsUQE2cmHlpz/BcqhAtlJC1JpKORgP5RXfLvtP+gfOE6kKK9wD7ozB47S7lTMN1N0Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664231; c=relaxed/simple;
	bh=wBf6JyYW1FyLDgtWBH+kK2WSqK8iBvKBhifX0hTX5QY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glBXPkqXIPLXMhWwQo+BERBDr/gW1SA0PGBF2FTjLzb9lM/dhyLLZwxSIWZB8T3Zgj1lCRxn8YGAQpYgynHWTchwy96MTGVJGrEsuE8OFBWWQnVnTq205JQPppt16h2Okkw97H65y32dmt6iV+nQEezc1RghVrcR/qiOZhGBb4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JSGHaH7/; arc=fail smtp.client-ip=40.93.195.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O70UdcJ+giU26vIfudmsdPqOYDA14fkPwx9Ggu6aTQogrwDUNtq21CHAeUEtBljlSab8ld7FSgEy1gP0fGtGXDoFJgyrQirL8tdhTsIbBRuPMDQ/JRbCtntX3N8LDHBufIwf9RUR/ROtrBnUU/oZLfYv/XxIHpK+emUg5nv0dwFB6it5agfdnaNDWtpoY9JsxbKZMLJBldcccgcp56ZO4rb2XrpJnauk3/G32URc9jE3ITqr5KSarIzJxcQFhNCyP3iFQ/TyAebX7sCOY5kk6KZR75sdsM5WFeoNg7ACLfYxdk4dHi02PRVbv2AVxfkj3cY7nz+Qs3v7TTkPJM4l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2Hd5HP3TSc56gDaI6NvCgPUsrDJbFSX6nlJcsBSy1s=;
 b=YVK1vuxwQyucFHpI8D+WSt2oUBoXOKP10TH51LRFoMMDVbb7Jp0IznnM/VQN1DQqgoHW0ggQgSao2M84Hvthnva83OiuxQoVRnDYs4H81fk5Iqo3v2AfwaCYgvDEbd+afsZ0ZJm2Yrw1hICpvBhz0s54sCuSAbgagRxVS4COt+0C12Oatr9Ifx8Twwja1ORB0WRnnZ4S0+f3xShn1NVKYFXc8QpdrCtNsn0EM3//TPPY3ZUPAB62WwzIXRbo27PPbwhkYCDbZ3ZC2QiCSU1XaT9wqSVFMUYWXH1Rq/IwVpfUEV1E0LjY3C2VFQMz8jfoTSBKRBLvOFALZlkFczQF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2Hd5HP3TSc56gDaI6NvCgPUsrDJbFSX6nlJcsBSy1s=;
 b=JSGHaH7/wyow7ADTmTgFbmBSXCKBQJdMrVTdoS+JWqKR6fHUK0lNx0a/cCwWwsh1Xp+IcdaSIphGpP0+VVfyK1uxgl20IV9/TxRaA1w9OnaTotxy1/J8lnPUXqvICCG2uAfojUZwIDFLBxP8vq4xYmOvSd4BxJdiZrhiGk/T8Fc=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by IA1PR21MB4563.namprd21.prod.outlook.com (2603:10b6:208:588::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.8; Mon, 14 Apr
 2025 20:57:07 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8678.007; Mon, 14 Apr 2025
 20:57:07 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Topic: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Index: AQHbptCjjPJ/mPM/E0Kh2JXNt8dnUrOjrwvQ
Date: Mon, 14 Apr 2025 20:57:07 +0000
Message-ID:
 <BL4PR21MB46271A66420D9B03C2947360BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
References:
 <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4111885e-44a2-44a5-96d9-313acc668af7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-14T20:46:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|IA1PR21MB4563:EE_
x-ms-office365-filtering-correlation-id: 40631926-f636-40f1-0ca9-08dd7b96eaca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OwQ538NVlsomJbwPRy5YPRuoDE0HPDNjflYxl3LUVs8FeRol1BGJFlmvtZRG?=
 =?us-ascii?Q?cWM5UCT6xI4y0vipv5NdkB6DGYgaKVtEoLSxNBSjHn7D+mPNqlX5iPPnHWt/?=
 =?us-ascii?Q?oad1iNlgdRHPtbvp8sEGggLZcKHj1soPfZTNDYIP96YGEU7qUOBHEM2cH4/V?=
 =?us-ascii?Q?ON0o103c/OEwXk6DzpRI/eDCCeJY2WjbznYLW6sMcOrQgznExa5Fum2E/dpk?=
 =?us-ascii?Q?TYhX3WCOHBQHCDBdj1iRt4cDsZ28JlrW3XCb9ZMHFazLbIPrinRMfFYzUF5c?=
 =?us-ascii?Q?T7CInq07FohEsW6m6GWSUOCsHG/8Z1qESague4CZfRXoJ6PrZR+uDJN5BwpT?=
 =?us-ascii?Q?8iaF4wfgYsCSGTNi0pz79G/nWBdTjPNuNu6ORDh/05jhYMqFx0Xfe5dYWgUb?=
 =?us-ascii?Q?d0Hy3CT14G2n5QKse24IidHIOwy4s9hVSrY+LyIfC9ZV4S3PX4KhMsKdKHTe?=
 =?us-ascii?Q?zTZiMpZiI9OVMW/gQvYqdjcblSP8fmPq50t4jIuS8KHZA4CUz7bG48BIqT0s?=
 =?us-ascii?Q?VDxIAkOreMc4zJ1iX9ANw+iksIMLUzu9iX1CHgU/nV7BTrw6LRTtMAKLc2kQ?=
 =?us-ascii?Q?pPT+OfaHUMEksOddHC5CFM3E/Bx+IGylpv6FvoAIhCVUar+kfFIpRpHc7Ugc?=
 =?us-ascii?Q?XVJUvatUX2CdsFVboNCITxzwBN7NaxQskszO3OwgeGOf02PXkGM9501z4OPv?=
 =?us-ascii?Q?JgtS1Tk0/ZeJzXCqoxcK6Jj2SQgc7sM+JQgWK+APN+kCXpRE96Rd1a7oVacf?=
 =?us-ascii?Q?Dd9QEZc9n0YMaEOfjHAWNVaCjipvmpdbruY+GwUU8le813RFHao96tVCIUL3?=
 =?us-ascii?Q?fYZrfqDHUfm4rjCo+kKONbAf2w271/WBNRCBgyfzesJhe0+2hrMTSzy7eZTi?=
 =?us-ascii?Q?JedfcPiBKw2Nm60RIvQAH7zbv0jqO1kpBMn8kLxe5vsgIn4aqiICjrBVi+no?=
 =?us-ascii?Q?4SBVZtky/F9v355LouWsiWB1ryCH08M4njl80djSMlU3Tfw152ppv14LRIjR?=
 =?us-ascii?Q?dH0sfQ74l7ndmCNqaIjSW8QSc6WzFClfUiLERPzGadP/Ob9BnVn6utRs3Kbj?=
 =?us-ascii?Q?uzsKVkJMqdDzk0NkRqk3jISZmdQyyoib4x9KHMJhstkkFoHMSQut/qy8dtnV?=
 =?us-ascii?Q?dIcd0QABC3kQVn6OAyv1fWooGKpX2y0sZjJZGtexwZoft8MKboUepfSNUCt0?=
 =?us-ascii?Q?2CgKGCBJ/Ze0KeIYGAdzhgyEPOXYxoXiAD9xHy9hHkKRZVjrSvYPCi22B7/x?=
 =?us-ascii?Q?fwXMLMbskPM0UuIkYYX/kWcJBay2q/cEoig/F+52097vRwkMdgJteisvTnaF?=
 =?us-ascii?Q?v5nGiCCdra9hQc0I0IBiZ4CMCWQXL2KsNhvy/w0ocw8MkzpA0n4s6N6I7Z54?=
 =?us-ascii?Q?qdxczwGo4279gM7fTUM6oFbpOInHVcLKD1jtLbEonfQVh2iZ/S2XVxhKqqxm?=
 =?us-ascii?Q?/UZBdZUkwz5m02umlZbLRSdo1zG9TZD5fET1yCGXCzCGygUuRoiiygZ1msbK?=
 =?us-ascii?Q?YM1q1Dua6XiiIbA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PwelCR0Pg7ctR4uNvHXY+nha2W9nVMT2hy6FvnRjCC0vTX4ZUs6d5RnQIupy?=
 =?us-ascii?Q?2TwArWN6/KEgpCLSgpjwIbIwYjgEOM+hg2wK68z/XFsFkbSox3HN/bDVS/xp?=
 =?us-ascii?Q?EPO04/HH1zOOaPsLE9fyOQ9XkxkDNpTZI6+V7Bdd40r2ALQFR0f7R627vQYS?=
 =?us-ascii?Q?Wie/qx6as+4EvGCb3iWoMZ8hBd05zInSKkcIEZWBpm8qTL8SeB4spFYj+DOY?=
 =?us-ascii?Q?LbtmRQ0WJen5To98LX2+zth5xcliw4HzIDwb3mX/rpY8VqhzuKPfaK+Knye5?=
 =?us-ascii?Q?FqmGVMqPzn5FbdfZnpMVyvivEP7DiAD0VKNQ0JOtbdswezpNKhQRATETCYru?=
 =?us-ascii?Q?sEKsitK+nktGtirYDxkBiYYYqmtbCDCOa0j9uWTNttrOTtIkdN3vdRGQxbOy?=
 =?us-ascii?Q?HH7x4av+ZFw4HtF70Ey3A5MKOgSTZIz9GX1lJPBDq27Kgp4xhF99CiE6dGX2?=
 =?us-ascii?Q?X6JB0ZptncqoT7fS/yrXICPyZ9ioGSxFUjX/5UdIJ16e9m5Cbb3G4cJtFnU5?=
 =?us-ascii?Q?n3cE2FnYu5t2zHMvg30rHVm81TQA30Tt3ij3dpBLAFlvjbm9GpiaZi4BWko3?=
 =?us-ascii?Q?WYMAInaJAzjmx5cdnsbTqVSTVV2WCRYzE+y4XktFVmM081cTmmtknGRMEG2A?=
 =?us-ascii?Q?zyKC4YKj/VvFrBGTCkYc9Q/uqM343bNOjknlAIjYUMQQHDwwp7w/0R55Tl4m?=
 =?us-ascii?Q?r+dNhwHLkYvf6B/J9jKcuVMgmnPa2jeNY9okE2dVev0ni9GAip0qU9bmQK/6?=
 =?us-ascii?Q?WWylIUgzzT35vSMjPfhDPNqhlUbr0EXWOn2xpWaEVyd/uSzTYrsFRF4LY7OQ?=
 =?us-ascii?Q?76YCUNOb/vv7GXLnNvJyXuefGWYOey8WNJgmT/iBc9DNxnhdXEAVK6Iw03DA?=
 =?us-ascii?Q?EEiMicaUQ9V/bZiRUmpFlsp+KPW0zQ9l+IMuBpfT8wDC1D7EbPulxjqjRJx3?=
 =?us-ascii?Q?cRNuwkBZcwFrn4QPyFta9/LZpPwNew0AgrTgouum7vYQ0+VZ8CKYg3nxXR+P?=
 =?us-ascii?Q?LBiGmoG6cjyQwCi5kShpvqhW7DvfWjQTxwO+BAMuQlCNE+cjWGfeagSHDcM6?=
 =?us-ascii?Q?+BnvfVb+P8O4LcbIHOfefVjl6MoheiBMkSMbMsDehXq8gS5fkcii7qSYktLt?=
 =?us-ascii?Q?uPdp/0sqmdim7hXVEkd1Ml6og0VFJFVS1QtiZ5X8o1S6oFJ/05crYZMe/Qs/?=
 =?us-ascii?Q?4oTe5+cKdBcoA1XZ4QHGeu5As7C5A7QwCz9Bxtr5eRfeAcYwyrYP8uDJcDs3?=
 =?us-ascii?Q?PqugkLc1Wf3qgoWTcTWwenVvX3VjyKki1bkzILm8a3Ej4BF53dTE94s59L1V?=
 =?us-ascii?Q?OpgETy3v2BO3oVdI6+SlBgEhzEpgbM9FEC0CgPIukh9nAasPEgRUa6RI84hX?=
 =?us-ascii?Q?AFL+HdrqslGtVW7yObvMwmjkRk0WuObvSqii1fmB1959aUEOBtZogx/MKAMc?=
 =?us-ascii?Q?/y1RUuOeCTwvT3Wkmrdkrk6u527it5+cGTxCkBXPPBNtHuzjDDOMNK6q7Oi/?=
 =?us-ascii?Q?G9/HdJ4L5y2ZRck39Qagmlsah7F1Kv+Yzo8eHGu1QHIOlMdaLMwkmuwrKGCR?=
 =?us-ascii?Q?rzTglxlRjtO9eh803+KDQD0D4q+qVTFak+lIKoBsj2pUzIjT5oGMMUMPn0uF?=
 =?us-ascii?Q?JMqkmpgIjFG3zZd7bbb4kyg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40631926-f636-40f1-0ca9-08dd7b96eaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 20:57:07.0523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OMsYWfWSMZ5VnV7Sg6LR2+jHFpcSgMhvevzdYlvu8ONQZI1/eTrnNRgYGK83Z+sNBwFatbsxWyQZFQnIIC3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB4563

> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Sunday, April 6, 2025 1:48 AM
> [...]
> @@ -1662,6 +1708,7 @@ void print_usage(char *argv[])
>  	fprintf(stderr, "Usage: %s [options]\n"
>  		"Options are:\n"
>  		"  -n, --no-daemon        stay in foreground, don't
> daemonize\n"
> +		"  -d, --debug-enabled    Enable debug logs(syslog debug by

Maybe we can shorten --debug-enabled to --debug ? Just wanted to type
less characters :-)=20
IMO conventionally --debug already means "debugging is enabled".

> @@ -1681,12 +1728,13 @@ int main(int argc, char *argv[])
>  	static struct option long_options[] =3D {
> [...]
> +		{"debug-enabled",	no_argument,	   0,  'd' },

Ditto.

Otherwise, LGTM.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

