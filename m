Return-Path: <linux-hyperv+bounces-2466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F08E91163A
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C50E282870
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708A12FB26;
	Thu, 20 Jun 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B3TsUzFm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B47C6EB;
	Thu, 20 Jun 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924643; cv=fail; b=Mymk4egZXcQFieUFfbZnqlbBl7+8RJthYxI8cFAZxjQu4nTbE+F+1GwzmmziF1CLnZvzKSN2i99zArA5O9iiSnVin+fIozOYMrPe4oJJV8HO+pgW/NP3D5Z9S2wYvBKsCx0Fcwtg/+hcWVCImkSDUxTWRE+ja4/w+8DWERWFe1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924643; c=relaxed/simple;
	bh=q6ofxIDM7YHaa2eTiP/fStrRXvuDH9EVSr3RllnVQrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E46C8XBMYjdEVEP2ifBgniWb4OdK35M+4IVJW/2aylFfNxDEyIU0omiQl4CNoz0PwkJjJX3jXovgCzsbiRB8XkIAARb4yaHp4taOVWRYwyV2Q2fQ9ab+VNxk2bFGYGJj4aMKXNxlWu7kyc/0DnU4m1jLzpRSfKohW7ZhHjYMfcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=B3TsUzFm; arc=fail smtp.client-ip=40.107.223.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA0wkHcajHeOv9Mx+2iqouoSRWsgNLTgQbkNEl0i3P+eUxWzd+8JCmjWIJkyqa1ROahXft1ELpdulc7yygVNBRWh8JRr8E+R4kgJ+2WvRbEbneFkCMv2w8CiWQJYNcD3AE+5T1l1FOgomZi2P/qWGFiqVjB29kNVqCHvyfpUoSMn3t6vngQLGcNYpSEf9ONf953AfDgFZnaMRnDtiveDClhneuuYj6OE/xARjP/IiOqjWS6qrvji5E+Dr3gje9Y9KcxeDgP5u/tStPFPIRF4Yd68MOeqXyXzH0dhHpiMPmXSyYhY4LhqlyQa6ao6H8n6ycRyiuXDflqCpHtP/j3e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ofxIDM7YHaa2eTiP/fStrRXvuDH9EVSr3RllnVQrM=;
 b=n60nSh/b+CEZJ2nWQDd6bNm09/cEcBM0zW/h7Yk0aXFKhDpcS04Cnc8LYd0KW8GaipBy7OCPSCFup1ksTKJua9I/Il006306szBLuEqbcqbMfpHoU9cSiCnSeJn/z+gZTwba6nMZ/T8qKJ7dA21gduOI+WHP3elhMerNVdvAWUJQvdBiFQF5QUHUVtSj0hqzqwfkTHezDn3OBvU4h/zyMZM60p4tcKHBjkdjuU5PrnofTFvzcwxfAlOHMi/CuKsMBKDSE2Td16Tk8kc3boGK18NbAuDQHniJUWpRM6ln+fwEUE46lbZAwcmA0RXeuFZinyxszpJ23vdrAB4YgF0Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ofxIDM7YHaa2eTiP/fStrRXvuDH9EVSr3RllnVQrM=;
 b=B3TsUzFmR9cqG+v9neRQAHehHlZiwLnUG8hCCLbBH5TwbOuOw74dtza5uF1WCCP39Rx5MWaeu0HY+/7OTCY+SgiJspFxYONWiyjYL77wRn2tu89lxM1GO7zKkUBgxw8whIPU4txpI5VwOrxj21r+AcJftEtGb5W3lTWRcqJ92gI=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH3PR21MB4495.namprd21.prod.outlook.com (2603:10b6:610:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.9; Thu, 20 Jun
 2024 23:03:59 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7698.007; Thu, 20 Jun 2024
 23:03:59 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Rachel Menge <rachelmenge@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"chrco@linux.microsoft.com" <chrco@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Remove deprecated hv_fcopy declarations
Thread-Topic: [PATCH] Drivers: hv: Remove deprecated hv_fcopy declarations
Thread-Index: AQHaw2RKNOVliwEkuUuDERFITHsNWrHRRUbA
Date: Thu, 20 Jun 2024 23:03:59 +0000
Message-ID:
 <SA1PR21MB1317CAE93C786A5A0198EEA1BFC82@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
In-Reply-To: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9ebddada-9f80-444c-96e0-be6664948628;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-20T23:03:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH3PR21MB4495:EE_
x-ms-office365-filtering-correlation-id: 02d3620b-6658-428e-c9ed-08dc917d44ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lTSOJkzT+2fVBAlSUQjdTAVW0jndqPgxCrPs6l8bfWNouhjljWYIWpaZq8Tl?=
 =?us-ascii?Q?s6A6K0tklDk/Pe9oaXeBQEA1hcIewB0NZX1gNWPBhgk6cC/xMvTHpRvViZX6?=
 =?us-ascii?Q?g94J8epaffihei+H9u6APY3cOR99XR6pCWApcR2apUV7UU5/yCaBjOuXBuPG?=
 =?us-ascii?Q?oa+kZrDFSP1OhDYQCCxEFIKb5qZaVEevEAqDyVBvv6Cm4sWPYKBnyRouieJ/?=
 =?us-ascii?Q?IaUUDX3GxmOzMOtZXAts84XImrioh+J8DUbKl+RaDidrINznqC84G1q5k0QE?=
 =?us-ascii?Q?1W4UPaZagNF5QbnKXLgY0Plhyxr1jNaHoAkmf6yq4WktzoSEMOP3Erp40E/t?=
 =?us-ascii?Q?z4W1EHGvTFT5KeHa27gKfktiD3Gt8a35zCE9uF93B1DVCSSpH5MmrsxdDrSB?=
 =?us-ascii?Q?yiolTX7hnXjfxRPeT93UiqD50mlEy3VoXlUr2hBXazVVlxx9jLZfE2A37hMu?=
 =?us-ascii?Q?oiR3cLZMIqjxTwaq76exYwJaEw7CTiB0I+N/IPTO8XVcXOEdKB5TvvnjeSCE?=
 =?us-ascii?Q?8zhsNi+WLihlUwLgGL3+EFl9n+mn9rIp60brOJD3UxuxAz+nq9MKv15B/K4y?=
 =?us-ascii?Q?yONapIo+IWUpctrlEymHkxNDDLoV56R7IrwkNNhBp5+1LLjqa2Rk5iuKkUeL?=
 =?us-ascii?Q?EVrbmyU8QzdpMfwOsqt786eKPI2EKfAlRs1cGHXkKke0OdEAoltHDQ7EdOyD?=
 =?us-ascii?Q?A4LpH68W3Voztb7jLNSbgPjM/cIG3cHHGQAmu34FepamgGKVBaCIT8RtnaI7?=
 =?us-ascii?Q?ZnRa0WRKUsXKLyIuxi1woCWABNWM6yqsY1lSugBSsUNTzHBzC9kTPGlh+Tx5?=
 =?us-ascii?Q?3YJqSkD+D2B3GSGTOCvdfGYcR0R7ifZNMz2v33VoDyXFYjcFaLbWHtQdvhO2?=
 =?us-ascii?Q?ouem36YoTaH35ZRXjg5717PG/R/3dXMHWLYUDwAs8pJE7HG0XLqE5N8VzxoB?=
 =?us-ascii?Q?QEOcx+NleKsOUdnopu/N+z+BG8tMQAgJ/Od/fhVsvwQPtUhjl4JvAIQMCkLr?=
 =?us-ascii?Q?jKFEPt5qGjK30CR0PLQJsld1b2XUSVOtGke/wxDWFU0bPdtSSwFgf3LOXOC6?=
 =?us-ascii?Q?CTMwfHkOsSShYvl4kC82zlEPCd9SZy1Qw/zdqkYdB9DMvohAvvNzut0Ln1Jb?=
 =?us-ascii?Q?0I22+1cQTfkZFOqm3/giJtXGZ4f7WHVp5RBp8e1mPtOGfhzeHHBVe44LODGi?=
 =?us-ascii?Q?EIv3gEH2S7a+wSG9DMhvMSFysrh5AMyD6rkExhBRXh9JD6M3L/+kA3BaD2WN?=
 =?us-ascii?Q?+La4NSpWPZC2iSSJfpAjODi3Umxqzml3t8JF7IlCp270LUtYEytNQXmdece8?=
 =?us-ascii?Q?mJjnsgurNMk5Xij/VInjQuDkqBDwgJDTVMvqgi5LEPmKvojNDDgpYAWlEqdd?=
 =?us-ascii?Q?XsolPnsJv/Qg+h0f/sOcN6gC8XhNm4Cb6WVEYpN3qwx9Z/ucZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Df0crmQ3izPz1yBTbGbASYVAvAQFBSQpPlsNszTHAIjg1OxWTrOxcGbpAORN?=
 =?us-ascii?Q?x18bo8R/2OApsmf3fOvZlD2AGKFESRetF9BUsqZSz6zcYDU3fwpBQXsc/827?=
 =?us-ascii?Q?MMuicLuvDHcdkLLZVHZoFTxSOcbqrAe+eILIgeOm/c6oxHo998AJ3XDRK971?=
 =?us-ascii?Q?zMWXQEOlG6oUSvxuIpDJ6f3BxX9WFruo1GikNHPjYCvR8HDt5mbSTlZtrZTD?=
 =?us-ascii?Q?kIQihhSy/IVJqwBR2/+5OZP+yKNXWKPA5OuIeQ5yRLepYvNqm6J9f66AexLL?=
 =?us-ascii?Q?tj7kGX1wSVbKlaZK4eZ0/McspUatbsN2qsrQY+rvKkQEZMLVBXyfuU1kOiGW?=
 =?us-ascii?Q?YJ3BcI6hwOod0u5twmU89/Qg7UamUWdVA44frjhFz7VwyOiVUW/8DjGP/3Ff?=
 =?us-ascii?Q?Jr4r9d9YIZNwU6MOJMA0Mr2eRqBbkgWOfVZOTvGMGMhusxmmifJItMf/d5FD?=
 =?us-ascii?Q?SGledH6g3Huxc/Wztg2PQIkOZU8glNPqSQvycZ57mY6FhOs0JRH0S+E0sqQ6?=
 =?us-ascii?Q?PFDntvomAQ5JxJo62qe3DYYznASpzxJb8j8E7v8x2x8tQEHARQyIMKT8sWza?=
 =?us-ascii?Q?cTC+chGh+aUYpj04e7t+xQ0/BO0/6IYXB0p4FuxULnUD4tsxFHNQSaaopEH8?=
 =?us-ascii?Q?lB15wCHYAXgPtFt4dQFCRspyF4jQ5yBmxksMpuviYCjTA9l1v2fIRlCHGnCr?=
 =?us-ascii?Q?3zdBnr0RpztjGCMGezOQ49SLlcNUhnd0UmbT3d3fTt3TqMY4Dy+3i2MgWtbY?=
 =?us-ascii?Q?5Bgpph1G/3VHhmWg5HlWai3B30Om4za5MeKggG9pFyEBUN34Q3Z2yH6a1Nac?=
 =?us-ascii?Q?T+NqJUCmb8V71vkd6h7eRuPcXvaRLiHMm8Jro5c2Sbcq9JqzBBhlOc6n72LQ?=
 =?us-ascii?Q?V5ykbwghS6n7BkttVhsz3XP41ESPdwqEjTPDZvWKgV7LAXrnoOe7HyHxeE/U?=
 =?us-ascii?Q?tN+DUYsEhopxJmt22tkDKGgdIrlpxdn8n3BEyo4G90CU3uyjjVVKO985WkAy?=
 =?us-ascii?Q?0kSG4TrHhOBiz0fR3H+oJqWNQaYpFxwz1zdBKiXtwKl1Fvk2KBv74eIdTHDf?=
 =?us-ascii?Q?7WPFCWNmCvs+3mv/Y02sVL5fUk066n3dq0wRhyfA1cWA+SWo0hvN9PpafWub?=
 =?us-ascii?Q?fZuEDvIGRTdrK7a1vu7+xdIZs/OWcaJh5sSTP4Q2TBz0ROOT7Ye7YHgnM0es?=
 =?us-ascii?Q?jTesH7idYqjuc51PzRn7aPB/LrNiRXh0ZWqgINuyB3Zf8r3ZRJ2XAAuFWz6/?=
 =?us-ascii?Q?ssaaBcISyKqs/AZ75lTW01x5dp2jenP2BEGmuf+vEil2VICcmzdoF30Dw2rg?=
 =?us-ascii?Q?J9fIgAFh25yZ+zrXEybeEZVI5vfgSO4riihrfXTowhEB7PxVZf3bfGyHVM1R?=
 =?us-ascii?Q?FnwXA9A2ymGYryOflzClZShiT92z7rYSTbtUNWkt8mTevfnHmuaHSu2b1+T2?=
 =?us-ascii?Q?zI6dUAFap9q0uopFUnC6ZtYJwYjNGOLfLHxpPH2QzpZ3Wr0JFVgVhJiYVHwi?=
 =?us-ascii?Q?mtM9MqjakFzU9+KBb2upDNtBHY7YNPODhBSsvsIU90rrfQYTk6STaTNh6BAA?=
 =?us-ascii?Q?bNL8m0+e1L69Dq6+WhazM1D33yinBNDa5GkLG4EE?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d3620b-6658-428e-c9ed-08dc917d44ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:03:59.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpJ12dMril4OKRyrFSY3m+6o1CRxxW78gXg3zcIw8w42FfW5j9UIcCEJSwmUchqKyjJpBjNpjv0ReTZ7ODuHUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4495

> From: Rachel Menge <rachelmenge@linux.microsoft.com>
> Sent: Thursday, June 20, 2024 3:51 PM
> [...]
LGTM
Reviewed-by: Dexuan Cui <decui@microsoft.com>

