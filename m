Return-Path: <linux-hyperv+bounces-4398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FFFA5CCAC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3F03AD8A2
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921019E975;
	Tue, 11 Mar 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hfVo1lxo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023115.outbound.protection.outlook.com [40.93.201.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819081EBA1E;
	Tue, 11 Mar 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715316; cv=fail; b=RKgHUStCrusaN12VR4MVkr0HbnopsDJgdUtAVz0i7ZJDwf86a4klMkwlS8Egl5uWULuNfUqP225frLKbuw3wdXnQ+JCNwTBiLnxBxM55ROfZYXPtUBIPEdrkhracaNVpLNkss6cvD2newPRNosfeHROvWi6gtUoxfFTW6xX1q4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715316; c=relaxed/simple;
	bh=aPxGEgXu/yR1Nx8Iy9Hzmw3loD+hEvJnSZKL0I4dYR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdgREDrZkFRnS98in0tKHzlpF278ixmhC8KON3Dal09Dj2jnOf17kkFwK84jaQEBvfb872zI86YQuUJhzjFHV/ssuWho6QYul07hBmg0Iyf6ct8H5q3lbHzWjHS2PUGhsOMPeyLKxBFzBW1QcLrk67iFzje8IAzYZwtBs4XhNDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hfVo1lxo; arc=fail smtp.client-ip=40.93.201.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJPOtET6My5NGJfzhVyQq0xjVSJnbr3xJ/VMVJ1PZXWqAM6v1Lhnyrh/g9B+GYv78L+S3UCmNy45zu6TqajZreL4+ivCHMTztpk+RYoo9KXCOMdT1PbYxiDQwSYEagt/pL3o7TSOeDNlmJ2dSr/ZrkrcCk9YSwIN+TbVp15hLU40C1XMUzLJPMi6B0dBrKY+Htu7RufEJLU6pwdcIMpFJFPoe3mTcnGlqQeFljhfk4AbmEJ3A3FdEiEQTgSG83fPQQUCHlX7OSH0aGsHOm436UNfHkJAVxfABPWPzRQNPcyTbYLPuEg1F7Nkcx0VRJIhD6+EMvJAkmCND6duIllDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPxGEgXu/yR1Nx8Iy9Hzmw3loD+hEvJnSZKL0I4dYR8=;
 b=mXBjaqWmIAxpjN8oPDr6hOG3ipGBlzu3vofpjx85nsghc6IlKA0pu5NX2FUmW8/kbzEpF32iQSfD5V1+cvTCRwErYUUN/3R31JDRNxUyJoVHkYNu2jhKIBaHRSf82WQtVFbO+VuzFr5P+5czei0a2tFGIIWUOEslx3Vvden3JnshqVXXe9fOmj0apQovJhXn4Oh/Jsnqr7EtBMeBXMvPsaKVlZ5YMw6wT5dhe7Ig3EBPK4fNedKSQN9SzbUj0jqoDoBDABjvqEU2iQJrFipaaEL0jjlUJdicZuRi7kdmltUJeSlFU/8TX5ONXBMnC5DxGLGXdCqcunD0PB2R0/2uRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPxGEgXu/yR1Nx8Iy9Hzmw3loD+hEvJnSZKL0I4dYR8=;
 b=hfVo1lxoxJMbm8lOyPAbO+eFqFGbPA114lULGSsus/34A4gkDsOeSfPk6LKbdCFBKalh2xVH605h0ivyQPWf7TDIxqBEmgvIuWJ7N1zz5p4cad3Pv9XqvHNO71ra63KHc30H4KGHGARvMWa+haLk63GJ5QKBSLaGZRyIsDDvock=
Received: from CH3PR21MB4646.namprd21.prod.outlook.com (2603:10b6:610:268::7)
 by CH3PR21MB4039.namprd21.prod.outlook.com (2603:10b6:610:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.15; Tue, 11 Mar
 2025 17:48:31 +0000
Received: from CH3PR21MB4646.namprd21.prod.outlook.com
 ([fe80::bc24:fb88:9108:743d]) by CH3PR21MB4646.namprd21.prod.outlook.com
 ([fe80::bc24:fb88:9108:743d%4]) with mapi id 15.20.8534.010; Tue, 11 Mar 2025
 17:48:31 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, Long Li
	<longli@microsoft.com>
Subject: RE: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
Thread-Topic: [PATCH] uio_hv_generic: Fix sysfs creation path for ring buffer
Thread-Index: AQHbkkBxPKhpGdMcvE2H4dkP8Ep3XLNuLNHA
Date: Tue, 11 Mar 2025 17:48:31 +0000
Message-ID:
 <CH3PR21MB4646756CF7B6EF5205E88F27BFD12@CH3PR21MB4646.namprd21.prod.outlook.com>
References: <20250225052001.2225-1-namjain@linux.microsoft.com>
 <2025022504-diagnosis-outsell-684c@gregkh>
 <9ee65987-4353-42c6-b517-d6f52428f718@linux.microsoft.com>
 <2025022515-lasso-carrot-4e1d@gregkh>
 <541c63d6-8ae6-4a32-8a02-d86eea64827e@linux.microsoft.com>
 <2025022627-deflate-pliable-6da0@gregkh>
 <0a694947-809d-48b2-9138-d3f6175fe09d@linux.microsoft.com>
 <2025022643-predict-hedge-8c77@gregkh>
 <960501c2-5ab2-4c81-86ac-a4477c0f708a@linux.microsoft.com>
 <5709eac1-a828-4ab3-afc2-8f1790d5f61f@linux.microsoft.com>
 <a7716784-face-44ff-837d-50f7ca79f0e9@linux.microsoft.com>
In-Reply-To: <a7716784-face-44ff-837d-50f7ca79f0e9@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=83d29bfa-eace-404d-bd1c-3d61c209bc96;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-11T17:11:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR21MB4646:EE_|CH3PR21MB4039:EE_
x-ms-office365-filtering-correlation-id: 0a467168-6375-4352-c8b0-08dd60c4f05d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0NueTcvK0I3dmtnUS9QMGxWYmI1SHJoZENpT1ZzMzNiRkt1Zm9QQjhhcm1y?=
 =?utf-8?B?eHZGcUFoNEpaTHVTVTRBU1h3NnFOK0w1Z2ZoRVJmTkM1RVB2azVGUWZLbDlC?=
 =?utf-8?B?R2FVcURMWWZmWG9scGdtUTBHdThZdnFPbG0rUkc1UEIvS3V6L2NYRldTb3pp?=
 =?utf-8?B?U2VBZDBjenY2VlNCQU1yRW51ZmRqSkk3eFR6SnREU3lKRUkrUDhQK2wxNzZH?=
 =?utf-8?B?S040NmV5WUVpWmdjd200bWRqcGNIUnN1czFjK0pLcmx4Q3p4ZWZxclN6eW5Q?=
 =?utf-8?B?SjQ0QzhSdmJaQ29nOUJQb0JJVU16TkdjbTZOVVd1ZmdLQU15OVZhUllNMnZT?=
 =?utf-8?B?dXZRVzZQam1EM05rVTRJRWk2VGZ1M0xmOHFNWDUvTXdDWkxJL0xtdGJ2Sjdq?=
 =?utf-8?B?R2paL1p0ZXlpbndPc0IxLzRNd0ZjK0w2VWJaenBjZ2dDcDcrT2dQZ29XSUlC?=
 =?utf-8?B?ZG1waDNzOFpMaVBtUUtMTDNjYjl0Q1NWS2ViblpHMU0rcVM4b0hTbGJ2d0JZ?=
 =?utf-8?B?c2hwLzNtaFZpT2hpTFM0UHZiTERrQllEQkd5cFp1b2ppWDZVNXZ4QmZFRWtG?=
 =?utf-8?B?NzVnUUwvRTl5L2pUcWNtakdhSWM5SHZBdUFBZ1JuRm9jTUJGcldoTEJHeEpm?=
 =?utf-8?B?NEdQQktJTUk2OTFRUVVCaDRwNHY0L2lJQkIzOVVVVlR4YmxQK3RkVzZObEd0?=
 =?utf-8?B?OU1UOWdFNThCNVJmK2JQd2sraVU2TVNVVTNlbkJRRUhLNW5OTEJMTngrZzNy?=
 =?utf-8?B?bXpGRWY1cEFlQk4yaGFBTFJtc21lMWNxNE5kTStWelc1dDRSdytTdGZYNnh2?=
 =?utf-8?B?V1hXN3RIRTdLUHk4aC8wRldkenZOaWtyM2FSN2MzSDBhRVltcllNNENZV1pN?=
 =?utf-8?B?Q1B4dEdEbE5ING45OFNnZEtaemN4MzZQd3V1OFZVVGdrQ3NKVG5TNmNvc0hX?=
 =?utf-8?B?ZFowc3krMjhRaGNpSlhDWElLWFh4c2xCb3JwYTl6dE1LY3hQc2NXZmJPYkhT?=
 =?utf-8?B?aTZJanBqeDFZV3lMSldlN0VPZDQ5ODBhR0o0b3ZWNWg0blVPVW5SbTFPL3g4?=
 =?utf-8?B?NU5Tems2aUFrbG9TTkYrL3ArTW4vTjVseHBUeHhZNFZFamhWaE5MUWJlVm4r?=
 =?utf-8?B?WEVHYTBtNE5KTkp5VS9JRFM5MlRTTlJ6c1h4MjRYLzRVVng1TDVVd0IwcEEw?=
 =?utf-8?B?WDIxczBkN2FzSEpvWFBabk4zN3p0QS9OY1hjczNlZGIyNkF1R1NrOUpYQklh?=
 =?utf-8?B?bitQQjlzS2w4cjRuVFJ2WmtIaGRIUXkwODB5V1lrVWw2bWZvWmoyTWNkWk96?=
 =?utf-8?B?ckUzTHVYZEhSTVVyZWhmUjhtUDFSVG9zbDJwOWo5RUFRR2Fza0l3cDdqNVBY?=
 =?utf-8?B?TVEzN1c5MTNKS042U0hVN3lOU2gvUmo3ZDBpM1lMenppeVhTVFlMaysrcU9z?=
 =?utf-8?B?bmNFeWFYZTE5b0JkcVQ1QW9xOUlBTC9YV1YyaUV6WkJiaERZbU9Id0xzMWg3?=
 =?utf-8?B?Mkd3M204dmV1bC81YXhRSXZlaElUbEQwaDhXWll3T0c0YmlhL0NzRjVHbWw2?=
 =?utf-8?B?eU9RMnJTMENpcXM3QkoyaDB3WE8rSVkzTUtNL3NCL3JXWGo1VDdXUGVoRnFP?=
 =?utf-8?B?a29ySDNXekI2RFRnYTlsNlhhakc0ZEo3eEtwdkhhejgzRlY2MERDZ1IvRTV0?=
 =?utf-8?B?Y3ozTjZMdHRtNWRLNHdycXRoWDlQMWpOUnFNSi80MHorRFl6Mmw5RS9zY0dR?=
 =?utf-8?B?aUVQT2Joa0xOemlKN2RtYzYxSUU2aXd0NVNKbWFmZlp4dHBPcnpsbTRhY25n?=
 =?utf-8?B?ZVdxZXpRelROYThoS1EzUWVPNlFBNGR3dUxNSDU2enhlNGZud1FUdXBCbjdv?=
 =?utf-8?B?QnhVMlhtZWwwZVEyZ2Evb21mWDR2WFF3RGhpUW1Md3VBc25EWVBQeTB3Wldx?=
 =?utf-8?Q?PPYyogliqIg2/zDaMOe5KM1j+ERnlUIa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR21MB4646.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVdKZWMvQkI2YWtxYmFDMFBxb0NsV1VvSG9nT3pNZ1gwMnBlVzBLWVFHL1pD?=
 =?utf-8?B?cGtnbk1Qa2I3WFhwelB6akF5clhIVHQxUGEya0FhQ2dydVZvSWZwWGE4amMw?=
 =?utf-8?B?RE94YmRHNE5UOTErT0pORDN1SHc5NEMydGxJYzhJZEJvYlFhZW1qd1IvcFVj?=
 =?utf-8?B?MmxQZHBOTXhBRDBYbzgveDlSdWIrdTJWTldUNUkzbHpJYzJ1Z3dHb09NTDJM?=
 =?utf-8?B?L2FZYlh2eWcxUklnR2NObkF2N2ZqdlYrWWc3RFpQeDBCQVFhY1p6OTNHZ0lM?=
 =?utf-8?B?cGpyMG5DZlpjRTJjVEx0OTlGekxLQWpva2g2OVhQMDVQaEFWTEpWbGVvV0E4?=
 =?utf-8?B?STh4NlFDQ2dwcEhqYndnQXlaWjJnTitOYnlnVGVhK21MWHdFc0Q3bTlsa1dP?=
 =?utf-8?B?WWlNVUY1cW1LbjgwQ1hqL0hickxKSVVodGJNSDhyb0pRMFJkZnk0cVdHSmZa?=
 =?utf-8?B?cUxtSHdiSXZOcm96SnREZFM4bnQ1bTFScjEyZUxoUEIxcEZramlVWW01dmJY?=
 =?utf-8?B?WVBhdWRDTmtZaU1zUjNSWFRQWlVpdzUwVTFrVkFSVGhCMURRVnc2RFhGRDBl?=
 =?utf-8?B?UVFvN0N4bUF5N1cwMlEwZ1l3aWpoYVhMcUNVQXJqWHFMT1hxZGxYQnhtaUJQ?=
 =?utf-8?B?L1pUaDIxUDd0OGNob0tTcWxzbkdzT3kzL2RZMHNBWWtwbVBQVkRUVlNNTmVR?=
 =?utf-8?B?N3FOUlpWQk92NE1IdXIxSGRMSHBKUS9mMHRNM1VtS21ESmlzRkU2WUI3TXlB?=
 =?utf-8?B?TmRXK00yaDJxbXpQbzNUNkRNbXc0aVAyZkVhTUUwS3ZIbk9WVGpLUEZtQzJ0?=
 =?utf-8?B?Y2hwdFZwSGtqNEw2di9DTytWRTNPRlZVQ3dCVXkrVXI0Q29EOHU2K0liRGFF?=
 =?utf-8?B?MXhiblBINllFMVVNZUViWlFQTEZ2SWxoUm9nUVlwVmtDYnpTZkFYUVU2N3Ez?=
 =?utf-8?B?bkhZbVl4SFBtSGpzY28xaXBWdy9KOFArZ1ZTVGZHTmNmUFJsVGFKK2Rwc0Nj?=
 =?utf-8?B?cFNyTllSUWdRa2d0K0lsTndFTjI5VTdIK2REUXlwNVJ0RU1ob2ZVa3BwRkJa?=
 =?utf-8?B?N0VQRDNLYWRDRXJPZmU1Y0ZKdnExTHlibWp6QUZXTEl1a1RZR3V6Q0t6NFNS?=
 =?utf-8?B?V3JGL3NWemIrWThnWlpGRHdKejc5dVRmQkFiMk1HUmFGbHk2VFo5VjV3MG85?=
 =?utf-8?B?NkRIbDMrRjhvdjBnOVNZWmFCVVZSVHViM09QWThpSjNydW1TTXR3cjVZVUFn?=
 =?utf-8?B?MmowcjhXNE00d05VWTZMYVdHSFo0Z2hiUlhwRmZLak0rQVJjaGpBYzVJMWll?=
 =?utf-8?B?eGx1UGlDeG9INXNFZzg0TExkd0JRS1lOZDA0RHJISUlvMDBkTlZ1OXNJcGhZ?=
 =?utf-8?B?SUNkNndyUmRIZldDVzBHd3UxVWxWeWNBdW9GdGgyNk5PZ1BISk0vT3c2ZG5H?=
 =?utf-8?B?TjBpQzFjVmU1V2xOVER6cnRlVk13TmYxUUZWQkJjZjdpM0tQQkVmU0lYWWp4?=
 =?utf-8?B?SWk2b2VhZjA3N0g3ZmU4ekRKajR0OVZad2Y3YUYvWkpXb2t2UGJvdUM1dVRu?=
 =?utf-8?B?VHQ4TWNXME1HWEU5R3dRamNRK2tLUFBWelNPNU5KUlh1ZWttSWxiUlFySmUr?=
 =?utf-8?B?V0tmck1JcS9nRXZ3bEh0MHh6YVVYME1idUNDb1BVaWNyZnYrczU1M0R5SXFM?=
 =?utf-8?B?dTRqeW1zazVZcUR0MERjSUdSaUZlZmxGZnFZSHdGaHozNzVudjYrd0ZhaHdQ?=
 =?utf-8?B?bFQzV0RzNXIyYUpBNU1ISC9GNko4VVRJU0JnVFNHK1hlV21HNm13R1hUUFhm?=
 =?utf-8?B?eFU4TnhZSlFJbEtkRExzMklQVjN4V3NIM1QvL1hKZkNqdG13dnZqTTVjdkR5?=
 =?utf-8?B?SWpxSEdZWklVSDMxYVpXSDR5QytqL2VjNjRsTE94NFZJS0RvcTJqdlVVN0lQ?=
 =?utf-8?B?TW40RS90TUo2dlZTdkpkZmFFOGYyUytHbzhDYzg3c25mZE1zamVRTjBVQkpz?=
 =?utf-8?B?K1NxSEdaenJUc0lCa1VmNG9vd1FrMkdobWdJeU1qcE9uSC9BWUtEL0pQWWNL?=
 =?utf-8?B?RTdtWWJyMUpVN0NrUUJQSWhTZlNTbzhCOFFSSGZGby95NFN6K0F2cmRKMUlY?=
 =?utf-8?Q?0gy6z13lcnD1wawXKZViHHsOV?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR21MB4646.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a467168-6375-4352-c8b0-08dd60c4f05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 17:48:31.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTesLbpTwNcUjISGqCYnoTAYmlff8sIcQWK2N7qKrTKZQWOQAYlEFBNc7Tquq9dyCN0FHclBFMT6oqWbed5r2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4039

PiBGcm9tOiBOYW1hbiBKYWluIDxuYW1qYWluQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgTWFyY2ggMTAsIDIwMjUgOTo0NSBQTQ0KPiA+IFsuLi5dDQo+ID4gSGkgR3JlZywN
Cj4gPiBJIHVuZGVyc3RhbmQgdGhpcyBpcyBkZXZpYXRpbmcgZnJvbSB0aGUgZGlzY3Vzc2lvbnMg
dGhhdCB3ZSBoYXZlIGhhZA0KPiA+IHRpbGwgbm93LCBidXQgSSB3YW50ZWQgdG8ga2luZGx5IHJl
cXVlc3QgeW91ciBvcGluaW9uIG9uIHRoZSBmb2xsb3dpbmcNCj4gPiBhcHByb2FjaCwgd2hpY2gg
Y2FtZSB1cCBpbiBvbmUgb2Ygb3VyIGludGVybmFsIGRpc2N1c3Npb25zLg0KPiA+DQo+ID4gQnkg
bW92aW5nIHRoZSBzeXNmcyBjcmVhdGlvbiBsb2dpYyBmcm9tIGh2X3Vpb19wcm9iZSB0byBodl91
aW9fb3BlbiwgSQ0KPiA+IGJlbGlldmUgd2UgY2FuIGFkZHJlc3MgdGhpcyBwcm9ibGVtLiBIZXJl
IGFyZSBzb21lIG9mIHRoZSBiZW5lZml0cyBvZg0KPiA+IHRoaXMgYXBwcm9hY2g6DQo+ID4NCj4g
PiAqIFRoaXMgYXBwcm9hY2ggaW52b2x2ZXMgbWluaW1hbCBjaGFuZ2VzIGFuZCBwcm92aWRlcyBh
IGxvY2FsaXplZA0KPiA+IHNvbHV0aW9uLg0KDQpJIHByZWZlciB0aGUgIkFwcHJvYWNoIDEiIGJl
bG93LCB3aGljaCByZXF1aXJlcyBvbmx5IDEvMTAgb2YgdGhlIGNoYW5nZXMNCm9mICJBcHByb2Fj
aCAyIi4NCg0KPiA+ICogU2luY2UgdGhlIHVzZS1jYXNlIG9mIHJpbmcgc3lzZnMgaXMgc3BlY2lm
aWMgdG8gdWlvX2h2X2dlbmVyaWMgYW5kDQo+ID4gRFBESywgdGhpcyB3aWxsIGdpdmUgdXMgdGhl
IGZsZXhpYmlsaXR5IHRvIG1vZGlmeSBpdCBiYXNlZCBvbg0KPiA+IHJlcXVpcmVtZW50cy4gRm9y
IGV4YW1wbGUsIHJpbmdfYnVmZmVyX2Jpbl9hdHRyLnNpemUgc2hvdWxkIGRlcGVuZCBvbg0KPiA+
IHRoZSByaW5nIGJ1ZmZlcidzIGFsbG9jYXRlZCBzaXplLCB3aGljaCBpcyBlYXNpZXIgdG8gbWFu
YWdlIGlmIHRoZQ0KPiA+IGN1cnJlbnQgY29kZSByZXNpZGVzIGluIHVpb19odl9nZW5lcmljLg0K
DQpUaGUgJ3JpbmcnIHN5c2ZzIGZpbGUgaXMgdXNlZCBieSBEUERLLCB0aGUgdXNlci1tb2RlIGRy
aXZlciBmb3IgZmNvcHkNCih0b29scy9odi9odl9mY29weV91aW9fZGFlbW9uLmMpIGFuZCBvdGhl
ciBvdXQtb2YtdHJlZSB1c2VyLW1vZGUgZHJpdmVycy4NCg0KQmVmb3JlIHRoZSBodl91aW9fZ2Vu
ZXJpYyBkcml2ZXIgYW5kIHRoZSB1c2VyLW1vZGUgZHJpdmVyIGxvYWQsIHRoZQ0KaHZfdm1idXMg
ZHJpdmVyIGRvZXNuJ3Qga25vdyB0aGUgY29ycmVjdCBzaXplIG9mIHRoZSAncmluZyc7IGN1cnJl
bnRseSB0aGUNCnBhdGNoIG9mICJBcHByb2FjaCAyIiBoYXJkY29kZXMgcmluZ19idWZmZXJfYmlu
X2F0dHIuc2l6ZSB0byA0TUIsIHdoaWNoDQppcyBpbmNvcnJlY3QgZm9yIHRoZSBGY29weSBWTUJ1
cyBkZXZpY2UgYW5kIG90aGVyIFZNQnVzIGRldmljZXMuDQoNCiAiQXBwcm9hY2ggMSIgYWxzbyB1
c2VzIGEgaGFyZGNvZGVkIDRNQiwgYnV0IGl0IGNhbid0IGJlIGVhc2lseSBmaXhlZCBieQ0KYWRk
aW5nIG9uZSBsaW5lIGluIGh2X3Vpb19wcm9iZSgpLiBXaXRoICJBcHByb2FjaCAyIiwgdGhlIGZp
eCB3b3VsZCBiZQ0KZGlmZmljdWx0IGFzIHdlIHdvdWxkIG5lZWQgdG8gcGFzcyBvbmUgbW9yZSBw
YXJhbSAnc2l6ZScgZnJvbSB0aGUgZHJpdmVyDQpodl91aW9fZ2VuZXJpYyB0byBodl92bWJ1cy4N
Cg0KVGhlIHBhdGNoIG9mICJBcHByb2FjaCAyIiBhbHJlYWR5IHBhc3NlcyB0d28gcGFyYW1zIGZy
b20gaHZfdWlvX2dlbmVyaWMNCnRvIGh2X3ZtYnVzOiAncmluZ19zeXNmc192aXNpYmxlJyAgYW5k
ICdtbWFwX3JpbmdfYnVmZmVyJywgYW5kIGFkZHMgYW5kDQpleHBvcnRzIDIgQVBJcyB0byBodl91
aW9fZ2VuZXJpYy4NCg0KV2l0aCBBcHByb2FjaCAxLCB3ZSBjYW4gYXZvaWQgYWxsIHRoZSB0cm91
YmxlLg0KDQo+ID4gKiBUaGUgdXNlLWNhc2Ugb2YgRFBESyBpcyBzdWNoIHRoYXQgYXQgYW55IGdp
dmVuIHRpbWUsIGVpdGhlciB0aGUNCj4gPiBodl9uZXR2c2Mga2VybmVsIGRyaXZlciBvciB0aGUg
dXNlcnNwYWNlIChEUERLKSB3aWxsIGJlIGNvbnRyb2xsaW5nIHRoaXMNCj4gPiBIVl9OSUMgZGV2
aWNlLiBXZSBkbyBub3Qgd2FudCB0byBleHBvc2UgdGhlIHJpbmcgYnVmZmVyIHRvIHVzZXJzcGFj
ZQ0KPiA+IHdoZW4gaHZfbmV0dnNjIGlzIHVzaW5nIHRoZSBkZXZpY2UuIFRoaXMgaXMgd2hlcmUg
dGhlICJhd2FyZW5lc3MiIG9mIHRoZQ0KPiA+IGN1cnJlbnQgdXNlciBjb21lcyBpbnRvIHBsYXks
IGFuZCB3ZSBuZWVkIGEgd2F5IHRvIGNvbnRyb2wgdGhlDQo+ID4gdmlzaWJpbGl0eSBvZiB0aGUg
InJpbmciIHN5c2ZzIGZyb20gdWlvX2h2X2dlbmVyaWMuDQo+ID4NCj4gPg0KPiA+IEFsdGVybmF0
aXZlbHksIEkgY291bGQgZm9jdXMgb24gcmVzb2x2aW5nIHRoZSByYWNlIGNvbmRpdGlvbiB5b3UN
Cj4gPiBtZW50aW9uZWQgYW5kIHByb2NlZWQgd2l0aCByZWZpbmluZyB0aGUgcGF0Y2guIFRoaXMg
YXBwcm9hY2ggYWRkcmVzc2VzDQo+ID4gbW9zdCBvZiB0aGUgZ2VuZXJhbCBwcmFjdGljZSBjb25j
ZXJucyB5b3UgaGlnaGxpZ2h0ZWQuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IE5hbWFuDQo+IA0K
PiBIZWxsbyBHcmVnLA0KPiBIZXJlIGFyZSB0aGUgdHdvIGFwcHJvYWNoZXMgdGhhdCB3ZSBkaXNj
dXNzZWQuDQo+IENhbiB5b3UgcGxlYXNlIHN1Z2dlc3QgdGhlIGFwcHJvYWNoIHdoaWNoIGxvb2tz
IGJldHRlciB0byB5b3UNCj4gZm9yIG5leHQgdmVyc2lvbi4NCj4gDQo+ICoqQXBwcm9hY2ggMTog
bW92ZSBzeXNmcyBjcmVhdGlvbiB0byBodl91aW9fb3BlbioqDQo+ICBbLi4uXQ0KPiAqKkFwcHJv
YWNoIDI6IE1vdmUgc3lzZnMgY3JlYXRpb24gdG8gaHlwZXJ2IGRyaXZlcnMqKg0KDQpJbiBnZW5l
cmFsLCBpbmRlZWQgd2Ugd291bGQgd2FudCB0byBhdm9pZCBtYW5pcHVsYXRpbmcgc3lzZnMgYW5k
IGtvYmogZGlyZWN0bHksDQpidXQgaGVyZSBJTU8gY2FsbGluZyBzeXNmc19jcmVhdGVfYmluX2Zp
bGUoKSBpbiBodl91aW9fZ2VuZXJpYyBpcyByZWFzb25hYmxlIGFzDQpodl91aW9fZ2VuZXJpYyBp
cyB0aGUgb25seSB1c2VyIG9mIHRoZSAncmluZycgc3lzZnMgZmlsZSwgYW5kIGl0IGhhcyBtb3Jl
IGluZm8gYWJvdXQNCnRoZSAncmluZycgKGkuZS4gdGhlIGNvcnJlY3Qgc2l6ZTsgd2hlbiB0aGUg
J3JpbmcnIGlzIHVzZWQpOyBJIHByZWZlciAiQXBwcm9hY2ggMSINCiBzaW5jZSB0aGUgcGF0Y2gg
aXMgbXVjaCBzbWFsbGVyIGFuZCBjbGVhbmVyLg0KDQpHcmVnLCBjYW4gd2UgaGF2ZSB5b3VyIG9w
aW5pb25zPw0KDQpUaGFua3MsDQpEZXh1YW4NCg==

