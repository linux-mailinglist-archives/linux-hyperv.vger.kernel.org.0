Return-Path: <linux-hyperv+bounces-4940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2830AA90600
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2100F16A789
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D31AC42B;
	Wed, 16 Apr 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fle3XR/+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021086.outbound.protection.outlook.com [52.101.57.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADF1A76BC;
	Wed, 16 Apr 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812723; cv=fail; b=IBwS1LsHDxNKXLXSSGh2V08tT7fOJwYMGTZWCMOblRdHyaDGekoSEnm6FsS2zsNHK8JEx5skQvhVvMGYZGIirtIY8BUkRCe2KkmetXPSGNjBaRRpXe0ZCNLGL0a2iffLtBqHaaXvd9/7cdHC97RdbPoEE88NBnmsFbYE0PfkrDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812723; c=relaxed/simple;
	bh=SamCCfx1Phj67NcEJwrYI2G2O4lQasaISbexD5HI9Wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N76A6Dpsni00XVmhnE4uRKP+lnuQxSe5rL1Wkow14e6MJ2BpWmYj+5Im+M0eWbGR/E0Wi7zJug2KOb9SrfdtsfnPz5ky9tST54TsNq6C4R0kaap/vT5cKGYA0rpIx7SF8/u32paV0vVPIac8oYoDqeD/MoeWFotJPu8Rc1NjhAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Fle3XR/+; arc=fail smtp.client-ip=52.101.57.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebHhG0tyAtyR4s9+G0/MvRXNpD23TxXvvb4cuJYU73IAwxjBCIx7mS2rjMgXuZD+bKB6D8ZnxWYq9kbB9ya7c8J9p8Bz6/Y69LLjPCuDBhq60ikHnoU8G9XMVlwLSCUO/ar7ERhmiZRT9WLplRN7xSbLuGS/N3/TjvS4sBDesF7lm3dwtgP4Lxmcu2LUyHXpD4To8Tx5cFbEmxJh3M82Xilp4jIs/ewIpzM4rLjsbtMjlvsGqadEz0OKg8UUiOJyq8a6BdS18fP6wmhK0pUueLRGN9y3K7udpbtICgpYQAaIYEhiL5M2Bu7DT9XDmZrKYqBX+M1PDOp58ITs+J9AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SamCCfx1Phj67NcEJwrYI2G2O4lQasaISbexD5HI9Wc=;
 b=Nf9BPc0r6JdaO363pLH20vUgrvVHiLxACjqe3B0EewpjlO8XQZWV7DgUxbPDpad4Qk1h+R+EZKFkv30DXkeB/wR4v8KeuphazdPm/PfiVd2GtxAdZjNBy1deBB8HAbf1HFHOJ0DkM4zvEzy1KLwu15PtDMdMFgjlFBNFkkbvJXtrwiscZDh6jYhgs2xcV1livfVMJ+DvhiPwU3Fe+hZrCoKB07jIBgDYnCYCJogqfjori6xrVaPK7HcfxzvjIUyqAdSKzZi2kctbLWxWV7CdxEDUmQv0QSPHElfKvPqTrwYyPgPXUX2qcxGU/1zz6BuzLjaqiNxO2yn0b42WElntpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SamCCfx1Phj67NcEJwrYI2G2O4lQasaISbexD5HI9Wc=;
 b=Fle3XR/+fK/TQhEeJi8n4WZUX1QoZDI+5AUab/ANhAnmHNftKScsXh8xaD1ThXwG9CuG6TwGZrSzkOqte9dgW2J4L37LC68PJLfrz0MRxzM9ebxq+MLcZrRPV9hgqNucYXD1e4tovlS1/9AXBJ8Gf1QVw5pRQ7zNJP+TokQWHFQ=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL0PR2101MB1316.namprd21.prod.outlook.com (2603:10b6:208:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.10; Wed, 16 Apr
 2025 14:11:59 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%2]) with mapi id 15.20.8655.012; Wed, 16 Apr 2025
 14:11:59 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li
	<longli@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] mm: page_frag: Check fragsz at the
 beginning of __page_frag_alloc_align()
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] mm: page_frag: Check fragsz at the
 beginning of __page_frag_alloc_align()
Thread-Index: AQHbpN6SDtMNhEgoDkCdPx0m2cDKgbOl+x0AgABsycA=
Date: Wed, 16 Apr 2025 14:11:58 +0000
Message-ID:
 <MN0PR21MB3437AFFB3A7205C994F5551CCABD2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
 <1743715309-318-2-git-send-email-haiyangz@microsoft.com>
 <d06a75d7-c503-4aa1-a846-d23ef5c48d3c@huawei.com>
In-Reply-To: <d06a75d7-c503-4aa1-a846-d23ef5c48d3c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5b68d563-6e33-49e1-8234-4ced7d943d0b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-16T14:06:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL0PR2101MB1316:EE_
x-ms-office365-filtering-correlation-id: 143195f8-73db-498e-bd55-08dd7cf0a6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDVXVjQ1ZlBzSElZbVVUd2FpYjVqbERYQW1qUkFSNmR4U0pFVUs5dXFEQ0RV?=
 =?utf-8?B?T1QxMU9HY3pLV2hmRlV4T0dXNVROdjliMXVwMjJ3OCtWQVRZbWU5TExZRFVY?=
 =?utf-8?B?elltcGs5RkR2dFZFNm1ZclhTQUpqSmtFVDNnVjRnNmhHcjRlUlJMV1o3Qk1H?=
 =?utf-8?B?K3cxSExSNmVnS2lwSmZubGxuR25YVnBHMTdrWSs1NlZ5ZTBxZEJCSk12MGJN?=
 =?utf-8?B?YlhRajdpU2FNRFN4VzRlUytUNitPZWNtVEtVNTcwYnRxN25wYUh0ZHRSVy9s?=
 =?utf-8?B?bzdCT0pydUQ3NmFDUEtaVEFxUkRTZGh0ZldBNUMzZHFoT3BxOXJEUEF2QzBB?=
 =?utf-8?B?bnhNY1YwSjlvaWY1MEFFMTNrazBMTmhadlhHOU5yOE5DT0N1KzFaYVgrZTVX?=
 =?utf-8?B?WWpsQ21lelZtN0Q0bWpTY3ozWWFITzgyNkVEdU4xd25FVU9uSzFJRUVhRklT?=
 =?utf-8?B?UkVJNnBxc2VURzVxZm0wbnpyc1Q0Ui9XOTJ4cGxtaDdNSXdjL2diNzJ3U2JL?=
 =?utf-8?B?OW5tWk5CeUp0VStJVHpvU0U5Z1RUZ25ZRW93QVF4WjREZVFWREZPTlB0WVVh?=
 =?utf-8?B?Qm9jbVlkeHRjanZOemFMZVJUcTd3VTBTQ3RCSjVyTmtoZDFCU3l0WE9oeWFn?=
 =?utf-8?B?aHYyalpjWGp6aHoveXArcFp1SWVDVGRNWFJmV3owZHdtNWkwbWsxc2ZMMUZC?=
 =?utf-8?B?TURTRVlucFNXamN0cldiU01jTkVUVDNud3d5TkQ4eDdpZE4weTdsdmhGV2sw?=
 =?utf-8?B?TXFyeVJKckNPTkxqZ0RlQzlaQmtmek9GdTh4YTRodEdSM3NjTHM2RHdqYzNX?=
 =?utf-8?B?ZmtJakQzNWQ5Rk51Y1k1SmpZbmxNMjNLc3QwaHdCM1pqWVR0MTh6aXRtai9S?=
 =?utf-8?B?Y2wvZTkxUlYva0QrYWFkdnl1Rmozc243emd6ZTFaMW9MOFc2eXptaGwzL3cy?=
 =?utf-8?B?TUxmSXo2eklDbUVOdzN2TlVhNlRkZTRIcWFEYUUrTFVYZEQvbVY3d2JhMmV3?=
 =?utf-8?B?TmRtd2VhR1pBd1NYRU9pQ2cwMnY2ZFFNVzgwT3R2TDg4NWE5M3hVSWJvYWtz?=
 =?utf-8?B?d0N6VXd6aStrZTB5cXhkcWd2ZTVBdTM5eFZUNXRHelluSmttNld3SUwwUjFY?=
 =?utf-8?B?b1JCUWdUWktQR2ZSb1k5NmVtTXI2dTFxTm9NbGtmN3k5QitOMjFZVWg4RzMx?=
 =?utf-8?B?SFJRcXA1dml1UWYzL1RtQ0FpakZhMEl2cFlZQitMZWxNQVlHbVVBa2lOMWsv?=
 =?utf-8?B?UnFzV3gvcmxkcXI3bHQ3Mk1WZzVPRzRIekNzaGlVUU1Pd1lWMjVObTZnTC9l?=
 =?utf-8?B?WHBBaGlLNFgwbk5RWXdiR3pydk5OVi9LVWRMaXA1THJPOHIxV0NrT2xOWkx3?=
 =?utf-8?B?RDlwZ1Rkc0hmNTFXTG1Da2pMUXBjczNxRG9GWkZDcXdoZjZRYzZseFl4bk5w?=
 =?utf-8?B?R0pURE9wVFVOZmM1OUxzZzcrTUp6SDVsRC9OWFBnZE1VZzZERUhac25pT0Mv?=
 =?utf-8?B?djZpNTJKVmFVUFdPWVFRbEcrWHJtamdaSmpRNkJ4MjF2UnJoVE1HWmUwQk5V?=
 =?utf-8?B?aWhMY1p5TG43RDRhaTRsZTVIME0zZW5GaVZUd0p4WVFxS01JTzVVMW9zVTd6?=
 =?utf-8?B?N25nc3kwNlVvKzBhWGdudWZuSWtIWUhFdVdiUDhpWTZSa0k3NVNtRUh0MkVW?=
 =?utf-8?B?MHNPQVpsNWJ3d2kxTW1ibzFKdEVVcTRLaGJ2aWhoYWVLZ0RWdHk0ZDNKOVl5?=
 =?utf-8?B?cTd2RXh3SDd3bmkzaWVtK2RncmxoR3FTTUYwK3FFN1dQWGZyOTd0bU1qYS9Z?=
 =?utf-8?B?WnhVMURZWHVlZElVK21yL0xiMU1XeXA1OUM0MUV5TnpIbzJhZTBYUmo3c2dq?=
 =?utf-8?B?ZCtLVElCT1RFNm1wQXkwS2Jxb3c1Nm8wTlhOZGtHZENGRXlMRitqbnNDYWxy?=
 =?utf-8?B?WHNNajNrM0orUVYwSTU3NzdkQ1l5dTZsa0pwbkN6dE15ZkJ1Qm9FM2xMbkhJ?=
 =?utf-8?Q?qXK6ezgWvBQqZDzNoZf9Z/NgApJFoo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0sybXI4YmhVYVR0RWIwaWlEU3VFYzBxUktNQlVuTk8xUVlHNjJNdXExR2cr?=
 =?utf-8?B?WENtWi9Mc25SUGJ2TjM4TUVFMlpCMkR6a0RBQnBPaTQyTHprNmhTYlF4S1dz?=
 =?utf-8?B?dWtITEtjM3c2ZHVjMHRYZldFZjJBV2pTdVF2M0JFQnV2QTNWT0ZaNCtjY1lS?=
 =?utf-8?B?RGtEOHlGc1dmZ09zbTYyMVRmTmNqek4vMUNhcmJ6a1QyOGhZeGxoWlJ0Ykl1?=
 =?utf-8?B?aW9nUnJCRGtlV21lVzl0M3l5c0M1SytFY3N6TTNmVHNNY2x0ajQ1YzJaWGRv?=
 =?utf-8?B?WWxBOVdvSUVMTWFCUDZjRTdVamRackVmNFlTQXRFWFIvYStoelVIU2dTczZX?=
 =?utf-8?B?bWdpUURrVjkxT3dHQVBIK08xZDlnUk5EVGlqejdxSTlJZzBUU0dSVmVUYzBr?=
 =?utf-8?B?ckVRdnRTUVQxM3pSVFN1eHhpeGhRZ2ZhbFVNVWNsMVQ1MUdxUERkb3lYZXAr?=
 =?utf-8?B?ZlVEVEVLVExFTjM2QnVScENLTUJqSmVhTkxyczVBczZINHRHS1gwOUsvUEVm?=
 =?utf-8?B?eXFXQlU1Q3dCVjVta3U2cE90WW1BNURWeUs2WU1zNmxOODI2NmR0TG5kNVlL?=
 =?utf-8?B?MEVlRmNxMi9QSC9hTVZheGxNelFsWFFyNy9oNnRGaFg3eUF4TEg0dTZnY3Ev?=
 =?utf-8?B?bVF2bkFCVkVtcjZWYTRKSUpPcExKdVJqZFpRMDI4RVVXV21WZ1AxaDMybnVV?=
 =?utf-8?B?bjV3V3BJeUdHUFhvWng1SUZ5aXdJYWM4QVlaUVZDQ2JKVzllUDBWZjRrR01k?=
 =?utf-8?B?RWEzcERta0RlaG5pRitZejFKMzdNazJFMDNNYXdPY0grc1UzcEhvRWZGN2ZF?=
 =?utf-8?B?Mi90Ym9Vak9TbWJZNjd3UFZjWlpIQysvdUtXbldSSWhFazRBSUlaMG9vZnNv?=
 =?utf-8?B?TFdDNGJlZzBVeWJYREdQYm1WYVN1OEVTOHhadjQzM1g0REIzTndnVXc4MkFE?=
 =?utf-8?B?QkQrYTlLR0Zna2wvek15bTdpenk5eW50bXRzRDh0QlRlUTNmdVZwOXY2RXp5?=
 =?utf-8?B?eW1mRTNGZWNtYmZDYzBzQXhnZTBFbjBwM3ZGTmJSRDZKY1dibHdxSHI2aXl2?=
 =?utf-8?B?enczamdZRmVEK2l6MDUyWE1uWnhGQm1yYVdMQWU1OFZVUlV3MmhSUm1hSWZW?=
 =?utf-8?B?NlFHN1RSb29ja3pqTUtUUnJtOGVDVm80ZTlSTUtJTHpFRXVaN1UvZk8xeUZm?=
 =?utf-8?B?bS91Zms2T2U3WkNlQWJzVi9jOVlJbnYyczFhK3p5eTlsRXZnL0g5T0RKb3ND?=
 =?utf-8?B?a1V2UTlSS1BVaVFSWG5LeGpwRWFrcGkxVC9DOUpLZkMwWTljbXFWSG9Ma3dj?=
 =?utf-8?B?aUdOMU93VXpUZGQxTUNKdnl0MTluWkE2bDdocjNITDN0WEdtR09iaS9uZ3Zz?=
 =?utf-8?B?L3BwNlJyL2V5Y09DUUg0TCtSekcwdE1Edkt2Um1Vc1czQ1B1MmtKc2dHcC9j?=
 =?utf-8?B?a0c2Z2hjRzloUU1nRGMrTUZ0dDMycVh0QzkwOGNIVGtEVlVKbWFacGNLOGdT?=
 =?utf-8?B?ZDdmd0s1NXBJbUxWZ1FXSU9oanduRHJGc3BxYUNYdFh3VnZEMGFzSUZzc2Jt?=
 =?utf-8?B?R0tIZUR4QlB2TkUyVHBYTzU1alA2Qm1pOWlLaW4zUEFMZHk1Z1MvWUxja3Rk?=
 =?utf-8?B?dmJEL3AyaVZYZThsdzBrWDd0c2dFZUErUU5UYUd1UUR2MUZraFBpanJSeVRk?=
 =?utf-8?B?UlAzTVFJbVRiRllRaHN4bjZ5ZjEzOENFcTN3OGg1YTdHdVVrUGMzM1orYXhH?=
 =?utf-8?B?a0lhekdRQjVtbnVxZkY5UGZJMzB5SFdKYzBTdzdPT25tc1dnUWJkTS9oT09O?=
 =?utf-8?B?dnQ0S3gwTkdBOEdQZ0h4QjZrS3JRcFJZWjVPdzY5RFlpTjlQT21RYy9Cemxh?=
 =?utf-8?B?Y01FYTRXN0JsUHU0NVlMRnQ0R0xzcnRYc2xaQ3FBV01qVnFUNEFtdzkwbzN0?=
 =?utf-8?B?THkwWUNBVmQvYmkvQlUwVVNYUmV4MHhiRGw1QzZwb0VsL3RDb0JMbTd3Y2s0?=
 =?utf-8?B?V0o2OS8vd29TOFpXM3FUaFpsSXRRZjh3b29QQ1I0b0g5UEhXMld6UHhFdHQ5?=
 =?utf-8?B?OTRHRThpK21iR2FURjJLaENxTUgzWDdNYndid3hncmFMMXFqQktZWURxZnpK?=
 =?utf-8?Q?yXC5ZM19dhFE1Ujawi+dgsgZA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143195f8-73db-498e-bd55-08dd7cf0a6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:11:58.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goyayGcG6hwAK3qyYwytpmcuxQILmnAHDOjJLl1j+wk4FMwAc+b7z/xbzOK+7iWeO4pt6eG7+fb1hHhso4nR0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1316

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXVuc2hlbmcgTGluIDxs
aW55dW5zaGVuZ0BodWF3ZWkuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE2LCAyMDI1
IDM6MzggQU0NCj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOw0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
OyBjb3JiZXRAbHduLm5ldDsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0NCj4gZG9jQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IEtZIFNy
aW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4gUGF1bCBSb3Nzd3VybSA8cGF1bHJvc0Bt
aWNyb3NvZnQuY29tPjsgb2xhZkBhZXBmbGUuZGU7DQo+IHZrdXpuZXRzQHJlZGhhdC5jb207IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7IHdlaS5saXVAa2VybmVsLm9yZzsgTG9uZyBMaQ0KPiA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCAxLzJdIG1tOiBwYWdlX2ZyYWc6IENoZWNrIGZyYWdzeiBh
dCB0aGUNCj4gYmVnaW5uaW5nIG9mIF9fcGFnZV9mcmFnX2FsbG9jX2FsaWduKCkNCj4gDQo+IE9u
IDIwMjUvNC80IDU6MjEsIEhhaXlhbmcgWmhhbmcgd3JvdGU6DQo+ID4gRnJhZyBhbGxvY2F0b3Ig
aXMgbm90IGRlc2lnbmVkIGZvciBmcmFnc3ogPiBQQUdFX1NJWkUuIFNvLCBjaGVjayBhbmQNCj4g
cmV0dXJuDQo+ID4gdGhlIGVycm9yIGF0IHRoZSBiZWdpbm5pbmcgb2YgX19wYWdlX2ZyYWdfYWxs
b2NfYWxpZ24oKSwgaW5zdGVhZCBvZg0KPiA+IHN1Y2NlZWQgZm9yIGEgZmV3IHRpbWVzLCB0aGVu
IGZhaWwgZHVlIHRvIG5vdCByZWZpbGxpbmcgdGhlIGNhY2hlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4g
PiAgbW0vcGFnZV9mcmFnX2NhY2hlLmMgfCAyMiArKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfZnJhZ19jYWNoZS5jIGIvbW0vcGFnZV9mcmFnX2NhY2hl
LmMNCj4gPiBpbmRleCBkMjQyM2YzMDU3N2UuLmQ2YmYwMjIwODdlNyAxMDA2NDQNCj4gPiAtLS0g
YS9tbS9wYWdlX2ZyYWdfY2FjaGUuYw0KPiA+ICsrKyBiL21tL3BhZ2VfZnJhZ19jYWNoZS5jDQo+
ID4gQEAgLTk4LDYgKzk4LDE1IEBAIHZvaWQgKl9fcGFnZV9mcmFnX2FsbG9jX2FsaWduKHN0cnVj
dCBwYWdlX2ZyYWdfY2FjaGUNCj4gKm5jLA0KPiA+ICAJdW5zaWduZWQgaW50IHNpemUsIG9mZnNl
dDsNCj4gPiAgCXN0cnVjdCBwYWdlICpwYWdlOw0KPiA+DQo+ID4gKwlpZiAodW5saWtlbHkoZnJh
Z3N6ID4gUEFHRV9TSVpFKSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogVGhlIGNhbGxlciBpcyB0
cnlpbmcgdG8gYWxsb2NhdGUgYSBmcmFnbWVudA0KPiA+ICsJCSAqIHdpdGggZnJhZ3N6ID4gUEFH
RV9TSVpFIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQNCj4gPiArCQkgKiBieSBkZXNpZ24uIFNvIHdl
IHNpbXBseSByZXR1cm4gTlVMTCBoZXJlLg0KPiA+ICsJCSAqLw0KPiA+ICsJCXJldHVybiBOVUxM
Ow0KPiA+ICsJfQ0KPiANCj4gVGhlIGNoZWNraW5nIGlzIGRvbmUgYXQgYmVsb3cgdG8gYXZvaWQg
ZG9pbmcgdGhlIGNoZWNraW5nIGZvciB0aGUNCj4gbGlrZWx5IGNhc2Ugb2YgY2FjaGUgYmVpbmcg
ZW5vdWdoIGFzIHRoZSBmcmFnIEFQSSBpcyBtb3N0bHkgdXNlZA0KPiB0byBhbGxvY2F0ZSBzbWFs
bCBtZW1vcnkuDQo+IA0KPiBBbmQgaXQgc2VlbXMgbXkgcmVjZW50IHJlZmFjdG9yaW5nIHRvIGZy
YWcgQVBJIGhhdmUgbWFkZSB0d28NCj4gZnJhZyBBUEkgbWlzdXNlIG1vcmUgb2J2aW91cyBpZiBJ
IHJlY2FsbGVkIGl0IGNvcnJlY3RseS4gSWYgbW9yZQ0KPiBleHBsaWNpdCBhYm91dCB0aGF0IGZv
ciBhbGwgdGhlIGNvZGVwYXRoIGlzIHJlYWxseSBoZWxwZnVsLCBwZXJoYXBzDQo+IFZNX0JVR19P
TigpIGlzIGFuIG9wdGlvbiB0byBtYWtlIGl0IG1vcmUgZXhwbGljaXQgd2hpbGUgYXZvaWRpbmcN
Cj4gdGhlIGNoZWNraW5nIGFzIG11Y2ggYXMgcG9zc2libGUuDQoNClRoYW5rcywgSSB3aWxsIHVz
ZSBWTV9CVUdfT04oKSBpbnN0ZWFkIG9mIGEgY2hlY2tpbmcgaGVyZS4gQWxzbywgd2lsbA0Ka2Vl
cCB0aGUgY2hlY2tpbmcgYmVsb3cgdW5jaGFuZ2VkLg0KDQo+ID4gKw0KPiA+ICAJaWYgKHVubGlr
ZWx5KCFlbmNvZGVkX3BhZ2UpKSB7DQo+ID4gIHJlZmlsbDoNCj4gPiAgCQlwYWdlID0gX19wYWdl
X2ZyYWdfY2FjaGVfcmVmaWxsKG5jLCBnZnBfbWFzayk7DQo+ID4gQEAgLTExOSwxOSArMTI4LDYg
QEAgdm9pZCAqX19wYWdlX2ZyYWdfYWxsb2NfYWxpZ24oc3RydWN0DQo+IHBhZ2VfZnJhZ19jYWNo
ZSAqbmMsDQo+ID4gIAlzaXplID0gUEFHRV9TSVpFIDw8IGVuY29kZWRfcGFnZV9kZWNvZGVfb3Jk
ZXIoZW5jb2RlZF9wYWdlKTsNCj4gPiAgCW9mZnNldCA9IF9fQUxJR05fS0VSTkVMX01BU0sobmMt
Pm9mZnNldCwgfmFsaWduX21hc2spOw0KPiA+ICAJaWYgKHVubGlrZWx5KG9mZnNldCArIGZyYWdz
eiA+IHNpemUpKSB7DQo+ID4gLQkJaWYgKHVubGlrZWx5KGZyYWdzeiA+IFBBR0VfU0laRSkpIHsN
Cj4gPiAtCQkJLyoNCj4gPiAtCQkJICogVGhlIGNhbGxlciBpcyB0cnlpbmcgdG8gYWxsb2NhdGUg
YSBmcmFnbWVudA0KPiA+IC0JCQkgKiB3aXRoIGZyYWdzeiA+IFBBR0VfU0laRSBidXQgdGhlIGNh
Y2hlIGlzbid0IGJpZw0KPiA+IC0JCQkgKiBlbm91Z2ggdG8gc2F0aXNmeSB0aGUgcmVxdWVzdCwg
dGhpcyBtYXkNCj4gPiAtCQkJICogaGFwcGVuIGluIGxvdyBtZW1vcnkgY29uZGl0aW9ucy4NCj4g
PiAtCQkJICogV2UgZG9uJ3QgcmVsZWFzZSB0aGUgY2FjaGUgcGFnZSBiZWNhdXNlDQo+ID4gLQkJ
CSAqIGl0IGNvdWxkIG1ha2UgbWVtb3J5IHByZXNzdXJlIHdvcnNlDQo+ID4gLQkJCSAqIHNvIHdl
IHNpbXBseSByZXR1cm4gTlVMTCBoZXJlLg0KPiA+IC0JCQkgKi8NCj4gPiAtCQkJcmV0dXJuIE5V
TEw7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAgCQlwYWdlID0gZW5jb2RlZF9wYWdlX2RlY29kZV9w
YWdlKGVuY29kZWRfcGFnZSk7DQo+ID4NCj4gPiAgCQlpZiAoIXBhZ2VfcmVmX3N1Yl9hbmRfdGVz
dChwYWdlLCBuYy0+cGFnZWNudF9iaWFzKSkNCg==

